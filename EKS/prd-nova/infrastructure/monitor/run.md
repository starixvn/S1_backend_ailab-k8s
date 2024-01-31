`
helm upgrade -i prometheus -f prometheus_values.yml prometheus-community/prometheus --namespace prometheus --version 15 --set alertmanager.persistentVolume.storageClass="prometheus",server.persistentVolume.storageClass="prometheus"

helm install grafana grafana/grafana --namespace grafana --set persistence.storageClass='gp2' --set persistence.enabled=true --set adminPassword=8E2buopup21c21jyKFXV --values grafana.yaml --set service.type=NodePort
`
