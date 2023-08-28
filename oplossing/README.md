# PE Opdracht documentatie/demo stappen 

# Praktisch

## Clusteromgeving

- Voor een lokale kubernetes mag je ook minikube gebruiken ipv k3d.
- Cloud providers: AWS, Google, Azure, Oracle.

## Applicatie

### frontend

- Angular 12

### Backend

- NodeJS + express + mongoose
- there is a `/health` endpoint available for health checking

### Database

- MongoDb

---

# Demo stappen

De oplossing directory bevat al de nodige scripts, YAML-files,... 
De setup gebeurt best ook in de volgorde die hieronder beschreven staat.

## Locust-cluster

Deze cluster bevat 1 locust master en 2 locust workers.

Om de locust-cluster/deployments op te starten voer je volgende stappen uit:
- Voer het script uit in "/oplossing/cluster_2/script.sh
- Navigeer naar "http://localhost:30080" om de locust UI te bekijken


## Webapp/Prometheus-cluster

Deze cluster bevat de todo-app, Prometheus, Argocd en Grafana.

Om de webapp/prometheus-cluster/deployments op te starten voer je volgende stappen uit:
- Voer het script uit in "/oplossing/cluster_1/script.sh
- Voer volgend commando uit voor Argocd wachtwoord: "kubectl get secret argocd-initial-admin-secret -n argocd -o yaml"
- Voer volgend commnado uit voor het decoden van Argocd wachtwoord: "echo yourpassword | base64 --decode"
- Voer volgend commando uit voor het forwarden van Argocd: "kubectl port-forward svc/argocd-server -n argocd 8080:443"
- Voer volgend commando uit voor het forwarden van Grafana: "kubectl port-forward svc/prometheus-grafana 3000:80"

* Grafana:  "http://localhost:3000"
* Todo-app: "http://localhost:9999"
* Argocd:   "http://localhost:8080"

---

# Github Actions

## Werking Github Actions 

#

**Github Actions screenshot**

![alt_text](herexamen-systems-expert-screenshots/picture1.png "image_tooltip")

#

Github Actions wordt uitgevoerd op een self-hosted Kubernetes pod. 
Eerst wordt Kustomize en Buildx opgezet zodat dit later kan gebruikt worden in het script.

#

**Github Actions screenshot**

![alt_text](herexamen-systems-expert-screenshots/picture2.png "image_tooltip")

#

Er worden tags aangemaakt, voor front- en backend, aan de hand van het label dat is meegeven.
Daarna wordt er ingelogd op Dockerhub zodat de aangemaakte Docker images kunnen worden gepusht.
Ook wordt de Dockerfile van de frontend gebuild en gepusht naar de Docker repository.

#

**Github Actions screenshot**

![alt_text](herexamen-systems-expert-screenshots/picture3.png "image_tooltip")

#

De Kustomization.yaml files worden aangepast (/oplossing/cluster_1/environments/PROD/kustomization.yaml en /oplossing/cluster_1/environments/TEST/kustomization.yaml). De nieuwe versies van de Docker images worden meegegeven zodat Argocd deze veranderingen kan
oppikken en deze kan deployen in de Kubernetes-cluster.
De veranderingen worden gecommit en gepusht naar de git repository.
Dit wordt voor zowel backend als frontend gedaan.

---

# Prometheus

Verzameld metrics over de Kubernetes-cluster, pods,...

---

# Grafana

Bevat de dashboards met metrics van Prometheus

---

# Todo app

De app, die gedeployed wordt. Deze is bereikbaar via een Ingress-object.

---

# ArgoCD 

Zorgt ervoor dat de todo app gedeployed wordt en altijd de laatste versie is. 
