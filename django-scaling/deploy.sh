#!/bin/bash
docker build -t django-scaling:dev .
kubectl delete -f app.yaml --ignore-not-found
kubectl apply -f app.yaml
