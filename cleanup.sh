#!/bin/bash

kubectl delete -n eso-demo externalsecret --all

kubectl delete -n eso-demo password --all

kubectl delete -n eso-demo fake --all

kubectl delete -n eso-demo pushsecret --all

kubectl delete clustersecretstore --all

kubectl delete ns eso-demo cred
