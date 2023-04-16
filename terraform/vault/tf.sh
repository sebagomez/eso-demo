#!/bin/bash

verb="${1:-apply}"

if [[ "$verb" != "apply" && "$verb" != "destroy" ]]; then
    echo "Error: action must be either apply or destroy"
    exit 1
fi

terraform init

terraform $verb -auto-approve

kubectl port-forward svc/vault -n vault 8200:8200 > /dev/null 2>&1 &

cd secret

terraform init

terraform $verb -auto-approve