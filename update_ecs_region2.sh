#!/usr/bin/env bash
aws cloudformation update-stack --stack-name django-scaling-ecs \
    --template-body file://ecs.yml \
    --capabilities CAPABILITY_IAM \
    --region "eu-west-2" \
    --parameters ParameterKey=Region,ParameterValue="eu-west-2"\
    ParameterKey=Image,ParameterValue="103050589342.dkr.ecr.eu-west-2.amazonaws.com/djangoscaling:v7" \
    ParameterKey=TaskCount,ParameterValue=${1-"1"}
aws cloudformation wait stack-create-complete --stack-name django-scaling-ecs --region eu-west-2

