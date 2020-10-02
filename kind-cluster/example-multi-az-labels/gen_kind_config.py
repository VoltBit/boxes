from enum import Enum
from colorama import init, Fore, Style
init(autoreset=True)

class ClusterParams:
    CONFIG_FILENAME = 'cloud.yaml'
    NODE_LAYOUT = [['zone1']*3, ['zone2']*3, ['zone3']*3]
    ZONE_KEY = 'failure-domain.beta.kubernetes.io'
    KIND_API_VERSION = 'apiVersion: kind.x-k8s.io/v1alpha4\n'
    KUBERNETES_VERSION = 'v1.15.9'

def get_node_count():
    return len([zone for group in ClusterParams.NODE_LAYOUT for zone in group])

def get_node_configs():
    layout = [zone for group in ClusterParams.NODE_LAYOUT for zone in group]
    configs = []
    for zone in layout:
        configs.append(f'''
  image: kindest/node:{ClusterParams.KUBERNETES_VERSION}
  kubeadmConfigPatches:
  - |
    kind: JoinConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "{ClusterParams.ZONE_KEY}={zone}"
''')
    return configs

def gen_kind_config():
    print('Generating the cluster kind config...', end='')
    with open(ClusterParams.CONFIG_FILENAME, 'w') as fh:
        fh.write('kind: Cluster\n')
        fh.write(ClusterParams.KIND_API_VERSION)
        fh.write('nodes:\n')
        fh.write('- role: control-plane\n')
        patches = get_node_configs()
        for i in range(get_node_count()):
            fh.write('- role: worker')
            fh.write(patches[i])
    print(Fore.GREEN + ' Done')


def main():
    gen_kind_config()


if __name__ == '__main__':
  main()



