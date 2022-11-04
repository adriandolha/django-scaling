#!/bin/bash
ECR=${1-"103050589342.dkr.ecr.eu-west-2.amazonaws.com/djangoscalingtests"}
VERSION=${2-"v4"}

docker build -t djangoscalingtests:$VERSION .
docker tag djangoscalingtests:$VERSION $ECR:$VERSION
docker push $ECR:$VERSION