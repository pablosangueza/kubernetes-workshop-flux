helm upgrade -i flux --wait --set git.url=git@github.com:jwenz723/kubernetes-workshop-flux --set git.branch=master --set git.path=k8s/ --set git.pollInterval=15s --set registry.pollInterval=15s --set helmOperator.chartsSyncInterval=15s --set syncGarbageCollection.enabled=true --namespace flux -f flux-values.yaml fluxcd/flux

kubectl -n flux rollout status deployment/flux
kubectl -n flux logs deployment/flux | grep identity.pub | cut -d '"' -f2