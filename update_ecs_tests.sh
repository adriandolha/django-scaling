#!/usr/bin/env bash
aws cloudformation update-stack --stack-name django-scaling-ecs-tests \
    --template-body file://ecs-tests.yml \
    --capabilities CAPABILITY_IAM \
    --region eu-west-1 \
    --parameters ParameterKey=Region,ParameterValue="eu-west-1" \
    ParameterKey=MasterTaskCount,ParameterValue="1" \
    ParameterKey=TaskCount,ParameterValue=${1-"1"} \
    ParameterKey=MasterIp,ParameterValue="3.248.223.153" \
    ParameterKey=Image,ParameterValue="103050589342.dkr.ecr.eu-west-1.amazonaws.com/djangoscalingtests:v4"
# aws cloudformation wait stack-create-complete --stack-name django-scaling-ecs-tests --region eu-west-1


