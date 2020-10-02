./../basic/registry/create_registry.sh

kind create cluster --config cloud.yaml
kubectl create -f ns.yaml

kubectl label nodes kind-control-plane failure-domain.beta.kubernetes.io/zone=eu-central-1a

kubectl label nodes kind-worker failure-domain.beta.kubernetes.io/zone=eu-central-1a
kubectl label nodes kind-worker2 failure-domain.beta.kubernetes.io/zone=eu-central-1a
kubectl label nodes kind-worker3 failure-domain.beta.kubernetes.io/zone=eu-central-1a

kubectl label nodes kind-worker4 failure-domain.beta.kubernetes.io/zone=eu-central-1b
kubectl label nodes kind-worker5 failure-domain.beta.kubernetes.io/zone=eu-central-1b
kubectl label nodes kind-worker6 failure-domain.beta.kubernetes.io/zone=eu-central-1b

kubectl label nodes kind-worker7 failure-domain.beta.kubernetes.io/zone=eu-central-1c
kubectl label nodes kind-worker8 failure-domain.beta.kubernetes.io/zone=eu-central-1c
kubectl label nodes kind-worker9 failure-domain.beta.kubernetes.io/zone=eu-central-1c
