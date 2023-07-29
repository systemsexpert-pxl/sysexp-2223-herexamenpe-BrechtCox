# Systems Expert 22-23 - HerexamenPE

- [Minimum Requirements (6 punten)](#minimum-requirements--6-punten-)
  * [minimum requirement: Kubernetes applicatie - CI/CD](#minimum-requirement--kubernetes-applicatie---ci-cd)
  * [minimum requirement: Kubernetes cluster 1 - applicatie PROD/TEST](#minimum-requirement--kubernetes-cluster-1---applicatie-prod-test)
  * [minimum requirement: Kubernetes cluster 2 - loadtesting](#minimum-requirement--kubernetes-cluster-2---loadtesting)
  * [minimum requirement: Namespaces](#minimum-requirement--namespaces)
  * [minimum requirement: Autoscaling](#minimum-requirement--autoscaling)
  * [minimum requirement: Infrastructure-as-Code](#minimum-requirement--infrastructure-as-code)
  * [minimum requirement: ElasticSearch / Kibana](#minimum-requirement--ElasticSearch-Kibana)
  * [minimum requirement: Documentatie](#minimum-requirement--documentatie)
- [Extra's (6 punten)](#extra-s--6-punten-)
  * [extra: ElasticSearch / Kibana (1 punt)](#extra--ElasticSearch-Kibana--1-punt-)
  * [extra: Infrastructure-as-Code (0.5 punt)](#extra--infrastructure-as-code--05-punt-)
  * [Kubernetes Role-based access control (0.5 punten)](#kubernetes-role-based-access-control--05-punten-)
  * [Cloud deployment (2 punten)](#cloud-deployment--2-punten-)
  * [Custom Metrics (2 punten)](#custom-metrics--2-punten-)
- [Deliverables in de github repository](#deliverables-in-de-github-repository)
- [Praktisch](#praktisch)
  * [Clusteromgeving](#clusteromgeving)
  * [Applicatie](#applicatie)
    + [frontend](#frontend)
    + [Backend](#backend)
    + [Database](#database)
- [Puntenverdeling](#puntenverdeling)
- [Individuele mondelinge verdediging](#individuele-mondelinge-verdediging)
- [Examenverloop](#examenverloop)
  * [VOOR HET EXAMEN (20’)](#voor-het-examen--20--)
  * [TIJDENS HET EXAMEN (20’)](#tijdens-het-examen--20--)
- [Demo](#demo)
  * [Demo Stappen](#demo-stappen)
- [Waarschuwing](#waarschuwing)


---
# Minimum Requirements (6 punten)

## minimum requirement: Kubernetes applicatie - CI/CD

- Maak automatisch dockerhub images aan bij creatie van een nieuw github release tag.
- Gebruik hiervoor GitLab CI/CD pipelines en een private gitlab runner in je kubernetes cluster.
- Het release label wordt gebruikt als tag in dockerhub.
- De images worden automatisch gepusht naar een registry.
- De nieuwe versies worden dan automatisch opgepikt en gedeployed op de cluster dmv GitOps CD.

## minimum requirement: Kubernetes cluster 1 - applicatie PROD/TEST

- Deploy frontend en backend van de applicatie in een Kubernetes cluster. Uiteraard werken die samen.
- Het verkeer komt de cluster binnen via een Ingress component.
- Gebruik kustomize voor het opzetten van een TEST en PROD environment.
  - TEST environment heeft geen autoscaling.
  - PROD: zorg voor een schaalbare backend, die kan groeien en krimpen tussen 2 en 4 instances met behulp van  autoscaling.

## minimum requirement: Kubernetes cluster 2 - loadtesting

- Deploy het loadtesting framework artillery in een aparte Kubernetes cluster dmv IaC.

## minimum requirement: Namespaces

- Alle logische componenten draaien in eigen namespaces.

## minimum requirement: Autoscaling
- Zorg, door de kunstmatige load te genereren en de scaling configuratie in Kubernetes te tweaken, dat er onder normale omstandigheden 2 backend pods draaien, en onder load dit snel groeit naar 4 instances.
- Deze load kan worden gedemonstreerd met de Artillery configuratie op de Artillery cluster, die netwerkload genereert naar de backend op de Kubernetes cluster, waardoor deze gaat schalen.

## minimum requirement: Infrastructure-as-Code
- Alle onderdelen zijn geschreven als IaC. Dat betekent dat het scripting gedeelte tot een minium beperkt is.
  - via scripts mag je de 2 clusters / gitops oplossing initialiseren.

## minimum requirement: ElasticSearch/Kibana
- Deploy ElasticSearch en Kibana.
- Bouw en deploy een ElasticSearch/Kibana dashboard dat specifiek is voor de applicatie.
- In dit aangepaste dashboard, dat je zelf bouwt, moeten onder andere de volgende elementen zichtbaar zijn:
  - Het aantal actieve backend pods
  - Frontend en backend resource load
  - Frontend en backend netwerk load
  - Inkomend netwerkverkeer op de Load Balancer

## minimum requirement: Documentatie
- De Demo zelf is ook _gedocumenteerd_ en bestaat uit 2 onderdelen:
  - korte, no-nonsense, exacte bulletpoints voor de demo stappen.
  - uitleg over de gedeployde componenten en hoe die samenwerken.

---

# Extra's (6 punten)

## extra: ElasticSearch/Kibana (1 punt)
- In je custom dashboard zijn onder de volgende onderdelen zichtbaar:
  - applicatie health dmv het `/health` endpoint

## extra: Infrastructure-as-Code (0.5 punt)
- Custom kibana dashboards worden gedeployed als infrastructure as code.

## Kubernetes Role-based access control (0.5 punten)
- Maak en gebruik rollen om access af te schermen voor je deployments.

## Cloud deployment (2 punten)
- Gebruik Terraform om de cluster set-up bij een cloud provider op te zetten, zoals: AWS, Google, Azure, Oracle.

## Custom Metrics (2 punten)
- Gebruik een extra custom metrics provider en toon informatie daaruit in een kibana dashboard.
- In je custom dashboard zijn de volgende onderdelen zichtbaar:
  - aantal binnenkomende requests frontend, successrate
  - aantal binnenkomende requests backend, successrate
  - aantal requests op de Ingress

---

# Deliverables in de github repository

- De oplossing moet testbaar zijn vanop een andere machine of cloudomgeving, dmv deze repo.
- Op te leveren via deze repo tegen de deadline
  - demo documentatie
  - alle IaC code
    - Kubernetes deployment(s)
    - Artillery script(s)
    - custom kibana dashboard(s)
  - eventuele kickstart scripts
- De deliverables worden beoordeeld tijdens de staat van de opleveringsdeadline.
- Als die ingeleverde oplossing niet werkt, of als tijdens de demo je clusters niet dezelfde zijn als de ingeleverde oplossing op het tijdstip van de demo, dan wordt dat expliciet vermeld, met een exhaustieve lijst van veranderingen. **Het niet vermelden resulteert in een '0' voor de examen PE**.
  - Je wordt gequoteerd op de inzending zoals die was op het tijdstip van de deadline.
  - Je kan alsnog een werkende oplossing opstarten, maar dat dient enkel om eventuele conceptvragen te beantwoorden.

---

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

# Puntenverdeling
Het examen staat op 20 punten.
- Werkende, correcte Deployment (zie minimum requirments): 6 punten

  Deze punten worden enkel toegekend als aan alle minimum requirements voldaan zijn. Er zijn geen deelpunten.
- Extra's: 6 punten.

  Deze extra punten kunnen _enkel_ worden toegekend als aan alle minimum requirements voldaan zijn.
- Mondelinge verdediging: 8 punten

# Individuele mondelinge verdediging

- Er wordt verwacht dat de gebruikte Kubernetes concepten en onderdelen kunnen worden uitgelegd. Enkele voorbeelden:
- Als je een NodePort gebruikt, kan je uitleggen wat een NodePort doet en hoe dat werkt.
- Als je een Kubernetes StatefulSet gebruikt, kan je conceptueel uitleggen hoe dat werkt en specifiek in jouw geval.
- Je kan uitleggen hoe de network flow in je applicatie gebeurt.
- Je begrijpt de architectuur van Kubernetes en kan die uitleggen.
- Je begrijpt networking en DNS in Kubernete en kan die concepten uitleggen.
- Als je extra technolgie gebruikt, begrijp je die zowel conceptueel als praktisch, en kan je die verklaren. Een voorbeelden van extra technologie zijn het gebruik van kustomize, gitlab ci/cd en argocd.
- Als je de minimum requirements niet haalt worden er ook vragen gesteld over niet-gebruikte Kubernetes concepten en onderdelen.

---

# Examenverloop

Er wordt NIET gecommuniceerd over/tijdens het examen met andere studenten! Dat wordt beschouwd als plagiaat.
Geef geen examenvragen door. Het delen van examenvragen, zowel schriftelijk als mondeling, wordt beschouwd als examenfraude.

## VOOR HET EXAMEN (20’)

- Demo voorbereiding - de demo is op voorhand ingeoefend
  - Je clusters zijn enabled en running.
  - Een browser-tab met de repo staat open.
  - Monitoring Dashboard GUI staat open.
  - gitops dashboard staat open.
  - Het Kibana dashboard is ingeladen en staat open.
  - eventueel demo kickstart script staat open.

## TIJDENS HET EXAMEN (20’)

- We gaan samen over je opgeleverde deliverables.
- Je toont je demo documentatie en je overloopt de stappen beschreven in het hoofdstukje "Demo" hieronder.
- Er worden gedetailleerde theorievragen gesteld over aspecten van de oplevering en gebruikte concepten.

---

# Demo

De demo neemt maximum 12 minuten in beslag.

1. Alles is beschreven als Infrastructure-as-Code.
2. Alles is deployable op een pristine systeem. **Geen manuele stappen.**

- De enige uitzondering hierop zijn kickstart scripts van hooguit enkele regels die nodig zijn om bv de deployment van de cluster zelf te starten.

## Demo Stappen

1. **De applicatie werkt** en wordt snel gedemonstreerd door 2 taken toe te voegen en de taken te tonen.
2. Het zelfgemaakte custom ElasticSearch/Kibana dashboard met de verplichte onderdelen wordt getoond.
3. De CI/CD pipeline wordt gedemonstreerd.
4. Een specifieke Artillery configuratie wordt gestart om load te genereren.
5. Het binnenkomend verkeer is zichtbaar op het applicatie dashboard. Op het dashboard kunnen we ook volgen hoe de load ervoor zorgt dat de autoscaling in werking treedt. De kubernetes cluster scalet de production backend van 2 naar 4 instances.

- Het activeren van autoscaling neemt maximum 10 minuten in beslag.

---

# Waarschuwing

- Plagiaat is niet toegestaan. (zie PXL examenregelement)
- Hier staan strenge straffen op, tot zelfs uitsluiting van alle examens.
- De persoon die eventuele oplossingen doorgeeft is eveneens schuldig aan plagiaat.
- Er wordt enkel individueel gewerkt.
- Op regelmatige tijdstippen wordt er gecommit naar github (minstens 1x per elk 1 uur werk). Het falen van deze verplichting heeft een '0' tot gevolg.
- Er wordt NIET gecommuniceerd over de PE met andere studenten! Dat wordt beschouwd als plagiaat.
