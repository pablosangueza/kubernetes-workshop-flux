#!/usr/bin/env bash

set -e

if [[ ! -x "$(command -v kubectl)" ]]; then
    echo "kubectl not found"
    exit 1
fi

if [[ ! -x "$(command -v helm)" ]]; then
    echo "helm not found"
    exit 1
fi

REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_URL=${1:-git@github.com:jwenz723/kubernetes-workshop-flux}
GIT_PATH=${2:-k8s/}
REPO_BRANCH=master

helm repo add fluxcd https://charts.fluxcd.io

echo ">>> Installing Flux for ${REPO_URL}"
helm upgrade -i flux --wait \
--set git.url=${REPO_URL} \
--set git.branch=${REPO_BRANCH} \
--set git.path=${GIT_PATH} \
--set git.pollInterval=15s \
--set registry.pollInterval=15s \
--set helmOperator.chartsSyncInterval=15s \
--set syncGarbageCollection.enabled=true \
--namespace flux \
-f flux-values.yaml \
fluxcd/flux

kubectl -n flux rollout status deployment/flux
kubectl -n flux logs deployment/flux | grep identity.pub | cut -d '"' -f2

