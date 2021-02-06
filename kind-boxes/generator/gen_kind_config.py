import sys
import argparse
from enum import Enum

class ClusterParams:
    CONFIG_FILENAME = ''
    NODE_LAYOUT = [['eu-central-1a']*2, ['eu-central-1b']*2, ['eu-central-1c']*2]
    TOPOLOGY_KEY = 'topology.kubernetes.io'
    ZONE_KEY = TOPOLOGY_KEY + '/zone'
    KIND_API_VERSION = 'kind.x-k8s.io/v1alpha4'
    KUBERNETES_VERSION = 'v1.20.2'

    def __init__(self):
        pass

class KindConfigGenerator(object):
    @classmethod
    def get_node_count(cls):
        return len([zone for group in ClusterParams.NODE_LAYOUT for zone in group])

    @classmethod
    def get_node_configs(cls):
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

    @classmethod
    def get_config_header(cls):
        return f'''kind: Cluster
apiVersion: {ClusterParams.KIND_API_VERSION}
nodes:
- role: control-plane
  image: kindest/node:{ClusterParams.KUBERNETES_VERSION}
'''

    @classmethod
    def gen_kind_config(cls, params: ClusterParams):
        fh = open(params.CONFIG_FILENAME, 'w') if params.CONFIG_FILENAME else sys.stdout
        fh.write(cls.get_config_header())
        patches = cls.get_node_configs()
        for i in range(cls.get_node_count()):
            fh.write('- role: worker')
            fh.write(patches[i])


def parse_args() -> ClusterParams:
    # TODO
    cp = ClusterParams()
    parser = argparse.ArgumentParser(description='Process some integers.')


def main():
    params = parse_args()
    KindConfigGenerator.gen_kind_config(ClusterParams())


if __name__ == '__main__':
  main()

