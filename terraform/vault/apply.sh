terraform apply -auto-approve

sh kubectl port-forward svc/vault -n vault 8200:8200

cd secret

terraform apply -auto-approve