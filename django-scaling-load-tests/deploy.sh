#!/usr/bin/env bash
docker build -t django-scaling-load-tests:dev .
kubectl delete -f app.yaml --ignore-not-found
kubectl apply -f app.yaml