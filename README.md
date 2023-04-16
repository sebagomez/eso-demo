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

