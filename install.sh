#!/usr/bin/env bash
echo "Installing $1"

#RABBITMQ_ERLANG_COOKIE=$(kubectl get secret --namespace customers frontend-$1-rabbitmq -o jsonpath="{.data.rabbitmq-erlang-cookie}" | base64 --decode)

#echo $RABBITMQ_ERLANG_COOKIE

helm install -n customers frontend-$1 helm/
