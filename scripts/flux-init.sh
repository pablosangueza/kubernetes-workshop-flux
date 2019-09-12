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
--namespace flux \
-f flux-values.yaml \
fluxcd/flux

kubectl -n flux rollout status deployment/flux

echo 'To grant flux access to pull your code, do the following:'
echo "1. Browse to https://github.com/jwenz723/kubernetes-workshop-flux/settings/keys/new to create a new deploy key"
echo "2. Set the title to 'kubernetes-workshop'"
echo "3. Set the key value to:"
kubectl -n flux logs deployment/flux | grep identity.pub | cut -d '"' -f2
echo "4. Check the box 'Allow write access' to allow flux to commit back to the repo"
echo "5. Click Add Key"
echo "6. Watch the flux logs to see if it is working using the command:"
echo "kubectl logs -n flux -l app=flux -f"

