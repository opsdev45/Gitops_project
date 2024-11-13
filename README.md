# Gitops CI/CD Project
### Create vpc in AWS with Terraform
### Create eks cluster and ArgoCD with Terraform
### Jenkins pipeline for build test and trigger argocd (gitops)
#### NOTE: All the secret saved in Jenkins
#
<img src="migdal.jpg">

## Terraform - Terraform have 3 module:
* VPC
* EKS
* ArgoCD
#### NOTE: The state file saved in s3 bucket
Create all the resource
```
terraform init
terraform plan
terrafor apply -auto-approve
```

## ArgoCD - Login
```
export ARGOCD_SERVER=`kubectl get svc argocd-server -n argocd -o json | jq --raw-output '.status.loadBalancer.ingress[0].hostname'`

export ARGO_PWD=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

argocd login $ARGOCD_SERVER --username admin --password $ARGO_PWD --insecure

```

## Jenkins Pipeline
### CI pipeline
* PULL
* VERIFY
* BUILD
* PUSH
* TRIGGET CD PIPELINE
* MESSAGE
#### The pipeline will test all the branches but deploy only the main branch

### CD pipeline
* PULL
* CONNECT TO ARGOCD
* CHANGE MANIFEST
* CREATE THE APP IF NEEDED IN ARGOCD


# Advance- sealed secret

## Create secret with base64 for the dockerhub

* Install secret manager in k8s
```
# kubeseal
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.18.0/kubeseal-0.18.0-linux-amd64.tar.gz
tar xfz kubeseal-0.18.0-linux-amd64.tar.gz
sudo install -m 755 kubeseal /usr/local/bin/kubeseal

# secret manager controller (kube-system)
wget https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.18.0/controller.yaml
kubectl apply -f controller.yaml



* run secret without apply in k8s for create kubeseal secret

# kubeseal --format=yaml: Encrypts the secret using the Sealed Secrets public key from the controller in your cluster and outputs it in YAML format.

kubectl create -f secret.yaml --dry-run=client -o yaml | kubeseal --format=yaml > my-sealed-secret.yaml
```


