#!/bin/bash
ECR=${1-"103050589342.dkr.ecr.eu-west-2.amazonaws.com/djangoscaling"}
VERSION=${2-"v6"}
docker build -t djangoscaling:$VERSION .
docker tag djangoscaling:$VERSION $ECR:$VERSION
docker push $ECR:$VERSION