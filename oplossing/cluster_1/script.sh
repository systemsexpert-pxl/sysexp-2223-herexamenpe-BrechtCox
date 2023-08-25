k3d cluster create webappcluster --api-port 6550 -p "9999:80@loadbalancer" --agents 2
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f environments/PROD/application.yaml
helm repo add elastic https://helm.elastic.co
helm install elastic elastic/elasticsearch
sleep 300
helm install metricbeat elastic/metricbeat
helm install kibana elastic/kibana
sleep 30
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml
kubectl apply -f https://github.com/actions-runner-controller/actions-runner-controller/releases/download/v0.20.4/actions-runner-controller.yaml
kubectl apply -f runner.yaml
#Sleep a few minutes before next commands because sometimes slow download of docker images
kubectl port-forward svc/argocd-server -n argocd 8079:443 > /dev/null 2>&1 &
kubectl port-forward svc/kibana-kibana 5601:5601 > /dev/null 2>&1 &
echo ArgocdPassword:
echo $(kubectl get secret argocd-initial-admin-secret -n argocd -ojsonpath='{.data.password}') | base64 --decode
#kubectl get secrets elasticsearch-master-credentials -ojsonpath='{.data.password}'
echo ElasticPassword:
echo $(kubectl get secrets elasticsearch-master-credentials -ojsonpath='{.data.password}') | base64 --decode
