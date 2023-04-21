# eso-demo
Demo for the [External Secrets Operator](https://external-secrets.io)


## Introduction

This repo holds the needed yaml to perform a demo on ESO. The purpose of the demo is to show how a single `ExternalSecret` can be hooked to different `ClusterSecretStore` and it will sync the date from the appropiate provider.

![](./res/architecture.png)

## Set up

I'm using a local minikube cluster but obviously any K8s cluster works. I'm also using Helm to install the External Secret Operator and Vault for local testings.

I took the instructions from the ESO site, but as the moment of this writing it was as easy as adding the repo 

```bash
helm repo add external-secrets https://charts.external-secrets.io && helm repo update
```

and install the ESO Helm chart

```bash
helm install external-secrets external-secrets/external-secrets --create-namespace --namespace external-secrets
```

and that's it!, ESO is not up & running

I'm also using Terraform to create some secrets in the differen providers. If you want to do the same make sure you have [Terraform installed](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) in your machine

## Accessing the provider

In this example I'll use [AWS Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html), [Azure Key Vault](https://azure.microsoft.com/en-us/products/key-vault/) and a local (dev) installation of [Hashicorp Vault](https://www.hashicorp.com/products/vault).


### Hashicorp Vault

To install a dev instance of Hashicorp Vault in your cluster go to the [terraform/vault](./terraform/vault) folder and run `terraform apply`. 

If you also want to create a secret in Vault you'll need to port-forward the vault service as follows. 

```bash
kubectl port-forward svc/vault -n vault 8200:8200
```

And then access the [terrafom/vault/secret](./terraform/vault/secret/) folder and `terraform apply` again.

The [tf.sh](./terraform/vault/tf.sh) script will do everything for you. Just execute 

```bash
./tf.sh
```

to create everything and 

```bash
./tf.sh destroy
```

to destroy it

Now you can apply the SecretStore for Vault

```bash
kubectl apply -f secret-stores/hashicorp-vault/vault-secretstore.yaml
```

### AWS

To create a few secrets and the user to access them in AWS Secrets Manager and AWS Parameter Store you can `terraform apply` from [terraform/aws](./terraform/aws/).

```bash
cd terraform/aws || return 1
terraform apply
export AWS_KEY=$(cat ./terraform.tfstate | jq '.resources[1].instances[0].attributes.id' --raw-output)
export AWS_SECRET=$(cat ./terraform.tfstate | jq '.resources[1].instances[0].attributes.secret' --raw-output)
# Create the Secret with AWS credentials
kubectl create secret generic aws-credentials --namespace cred --from-literal=access-key=$AWS_KEY --from-literal=secret=$AWS_SECRET
export AWS_REGION=$(aws configure get region)
# Create the ClusterSecretStore for AWS Secret Manager
eval "echo \"$(cat ../../secret-stores/aws/awssm_secretstore.template.yaml)\"" | kubectl apply -f -
# And/Or create the ClusterSecretStore for AWS Parameter Store
eval "echo \"$(cat ../../secret-stores/aws/awsps_secretstore.template.yaml)\"" | kubectl apply -f -
```

### Azure Key Vault

To create a few secrets and the user to access them in Azure Key Vault you can `terraform apply` from [terraform/azure](./terraform/azure/).

```bash
cd terraform/azure || return 1
terraform apply
export APP_ID=$(cat ./terraform.tfstate | jq '.resources | .[] | select(.type=="azuread_application") | .instances[0].attributes.application_id' --raw-output)
export APP_PASSWORD=$(cat ./terraform.tfstate | jq '.resources | .[] | select(.type=="azuread_application_password") | .instances[0].attributes.value' --raw-output)
# Generate the Secret with credentials
kubectl create secret generic azure-credentials --namespace cred --from-literal=clientid=$APP_ID --from-literal=clientsecret=$APP_PASSWORD

export VAULT_URL=$(cat ./terraform.tfstate | jq '.resources | .[] | select(.type=="azurerm_key_vault") | .instances[0].attributes.vault_uri' --raw-output)
export TENANT_ID=$(cat ./terraform.tfstate | jq '.resources | .[] | select(.type=="azurerm_client_config") | .instances[0].attributes.tenant_id' --raw-output)
# Generate the ClusterSecretStore
eval "echo \"$(cat ../../secret-stores/azure-key-vault/azure_secretstore.template.yaml)\"" | kubectl apply -f -
```

### Kubernetes

We're also using Terraform to deploy the Roles, RoleBinding and ServiceAccount needed to use the Kubernetes provider. In this example I'm creating a namespace called `remote-cluster` and I want to sync in the default namespace some of the secrets created in the remote namespace. In this example the remotes namespace acts as another cluster.

So again, follow this steps to apply the infra and create the ClusterSecretStore for Kubernetes.

```bash
cd terraform/k8s || return 1
terraform apply
export CLUSTER_IP=$(minikube ip)
eval "echo \"$(cat ../../secret-stores/kubernetes/k8s-secretstore.template.yaml)\"" | kubectl apply -f -
```
