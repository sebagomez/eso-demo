
echo "Tell the audience what you've done so far"
echo Minikube is running
read
echo Installed the External Secret Operator via helm
echo helm install external-secrets external-secrets/external-secrets -n external-secrets --create-namespace --set installCRDs=true
read
echo You also installed Vault locally, just or the sake of the demo
echo helm install vault -n vault --create-namespace hashicorp/vault --set "server.dev.enabled=true" --set "injector.enabled=false" --set "csi.enabled=false"
read
echo and lastly... show them there are no secrets in the default namespace
echo kubectl get secret

# Create the cred namespace


#k create namespace cred

# Get CRDs
#kubectl get crd

# Get ExternalSecret
#kubectl get externalsecret

# Add the helm repo
#helm repo add external-secrets https://charts.external-secrets.io

# Install the chart
#helm install external-secrets external-secrets/external-secrets -n external-secrets --create-namespace --set installCRDs=true

# Create my SecretStore and ExternalSercret
#kubectl apply -f demo

# Create cred secret
#./demo/cred.sh

# Get secrets
#kubectl get secrets

# Get the value
#kubectl get secret cncf-montreal-secret -o jsonpath='{ .data.dev-secret-test }' 

