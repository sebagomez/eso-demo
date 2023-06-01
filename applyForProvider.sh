#!/bin/bash

provider="${1:-k8s}"

if [[ "$provider" != "awssm" && "$provider" != "awsps" && "$provider" != "azure" && "$provider" != "vault" && "$provider" != "k8s" ]]; then
    echo "Error: Provider must be one of awws , awsps, azure, valut or k8s (default)"
    exit 1
fi

echo "Applying templates for ${provider}"
for file in ./ExternalSecrets/*; do 
    if [ -f "$file" ]; then 
        eval "echo \"$(cat $file)\"" | kubectl apply -f -
    fi 
done
