helm del --purge flux
kubectl delete crd --all
kubectl delete ns flux
kubectl delete deploy --all -n default