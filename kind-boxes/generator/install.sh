GEN_PATH="$(git rev-parse --show-toplevel)/kind-boxes/generator/gen_kind_config.py"
CLUSTER_NAME=$1
CLUSTER_CONFIG="/tmp/$(date --rfc-3339=date)"

if [ $# -eq 0 ]; then
  CLUSTER_NAME="box-$(date --rfc-3339=date)"
fi

echo "Cluster name: $CLUSTER_NAME"

mkdir -p "$HOME/.kube/kind-boxes/"
KUBE_CONFIG="$HOME/.kube/kind-boxes/$CLUSTER_NAME.kubeconfig.yaml"

rm $CLUSTER_CONFIG
python $GEN_PATH > $CLUSTER_CONFIG
kind create cluster --name $CLUSTER_NAME --config $CLUSTER_CONFIG
kind --name $CLUSTER_NAME get kubeconfig > $KUBE_CONFIG

export KUBECONFIG=$KUBECONFIG:$KUBE_CONFIG

current_context=$(kubectl config current-context)
echo $current_context
if [ "$current_context" != "kind-$CLUSTER_NAME" ]; then
  kubectx kind-$CLUSTER_NAME
  # kubectl config --kubeconfig=$KUBE_CONFIG use-context kind-$CLUSTER_NAME
  # kubectl config set-context --cluster=$CLUSTER_NAME
fi
