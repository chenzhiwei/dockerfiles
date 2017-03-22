#!/bin/sh

token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
kubernetes_service_url="https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT_HTTPS"

kubectl config set-credentials user --token=$token
kubectl config set-cluster kube-cluster --server=$kubernetes_service_url --insecure-skip-tls-verify=true

${@}
