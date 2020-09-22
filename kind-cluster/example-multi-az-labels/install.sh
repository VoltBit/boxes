kind create cluster --config cloud.yaml
kubectl create -f ns.yaml

kubectl label nodes kind-control-plane failure-domain.beta.kubernetes.io/zone=eu-central-1a
kubectl label nodes kind-worker failure-domain.beta.kubernetes.io/zone=eu-central-1a
kubectl label nodes kind-worker2 failure-domain.beta.kubernetes.io/zone=eu-central-1a
# kubectl label nodes kind-worker2 kubernetes.io/hostname=host2
kubectl label nodes kind-worker3 failure-domain.beta.kubernetes.io/zone=eu-central-1b
# kubectl label nodes kind-worker3 kubernetes.io/hostname=host3
kubectl label nodes kind-worker4 failure-domain.beta.kubernetes.io/zone=eu-central-1c
# kubectl label nodes kind-worker4 kubernetes.io/hostname=host4
# kubectl label nodes kind-worker5 failure-domain.beta.kubernetes.io/zone=eu-central-1a
# kubectl label nodes kind-worker5 kubernetes.io/hostname=host5
# kubectl label nodes kind-worker6 failure-domain.beta.kubernetes.io/zone=eu-central-1c
# kubectl label nodes kind-worker6 kubernetes.io/hostname=host6
# kubectl label nodes kind-worker7 failure-domain.beta.kubernetes.io/zone=eu-central-1c
# kubectl label nodes kind-worker7 kubernetes.io/hostname=host7
