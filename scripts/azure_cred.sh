TENANT_ID=$(az account show --query tenantId | tr -d \")
APP_ID=$(az ad app list --filter "startswith(displayName,'External Secret')" --query '[].appId' | jq first | tr -d \")
#APP_PASSWORD="DEn8Q~IIGuwkSbaQj.QJ9eNwfz3xQjOmWAFLYaQY"

kubectl create secret generic azure-credentials --namespace cred --from-literal=tenantid=$TENANT_ID --from-literal=clientid=$APP_ID --from-literal=clientsecret=$APP_PASSWORD