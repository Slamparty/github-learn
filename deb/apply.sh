#!/bin/bash

secret="${secret:-'pre-defined-secret'}"
github_app_id="${github_app_id}"
github_app_installation_id="${github_app_installation_id}"
github_app_private_key="${github_app_private_key}"


#install cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade --install --namespace cert-manager cert-manager jetstack/cert-manager --create-namespace --set installCRDs=true --set prometheus.enable=false --version v1.6.0

#add actions-runner-system namespace
kubectl create ns actions-runner-system

#create secret
kubectl create secret generic ${secret} \
   --namespace=actions-runner-system \
   --from-literal=github_app_id=${github_app_id} \
   --from-literal=github_app_installation_id=${github_app_installation_id} \
   --from-literal=github_app_private_key=${github_app_private_key}

#install actions-runner-controller
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller
helm upgrade --install --namespace actions-runner-system --create-namespace --set=authSecret.create=true --set=authSecret.github_token=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 --wait actions-runner-controller actions-runner-controller/actions-runner-controller
kubectl create secret generic ${secret} --namespace=actions-runner-system --from-literal=github_app_id=634925 --from-literal=github_app_installation_id=44219242 --from-file=github_app_private_key=k8s-testgithub.2023-11-20.private-key.pem