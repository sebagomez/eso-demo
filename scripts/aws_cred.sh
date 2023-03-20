#aws iam create-access-key --user-name sebagomez > creds.json
#POLICY_ARN=arn:aws:iam::593565642335:policy/secrets-reader
ACCESS_KEY=$(cat creds.json | jq -r .AccessKey.AccessKeyId)
SECRET_KEY=$(cat creds.json | jq -r .AccessKey.SecretAccessKey)
kubectl create secret generic aws-credentials --namespace cred --from-literal=access-key=$ACCESS_KEY --from-literal=secret=$SECRET_KEY