### Kind cluster example

Docs: https://kind.sigs.k8s.io/docs/user/quick-start/

Adding node labels

Docs: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/

`kubectl label nodes <node-name> <label-key>=<label-value>`

The install script uses [kubectx](https://github.com/ahmetb/kubectx).
Ideally the kubeconfigs should be kept in separate files and loaded in the KUBECONFIG env so the context change is persisted between different shell instances.

```
KCONF="$HOME/.kube/config"
configdirs=($HOME/.kube/kind-boxes)
for dir in ${configdirs[@]}; do
  for configfile in $(ls $dir); do
   KCONF=$KCONF:$dir/$configfile
  done
done

export KUBECONFIG=KUBECONFIG:$KCONF
```
