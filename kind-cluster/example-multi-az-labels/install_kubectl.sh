#!/bin/sh

# ./../basic/registry/create_registry.sh

# create the cluster
kind create cluster --name kind-redis-test --config cloud.yaml

cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
- role: worker
- role: worker
- role: worker
- role: worker
- role: worker
- role: worker

# create the target namespace
kubectl create -f ns.yaml

# simulate availability zone topology using node labels
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
