#!/usr/bin/env bash
APP_REGION1=${1-"eu-central-1"}
APP_REGION2=${2-"eu-west-2"}
TESTS_REGION=${3-"eu-west-1"}

# Deploy ECS cluster in first region

# Create ECR Repo
# aws ecr create-repository --repository-name djangoscaling --region $APP_REGION1
ECR_REPO="103050589342.dkr.ecr.eu-central-1.amazonaws.com/djangoscaling"
# aws cloudformation create-stack --stack-name django-scaling-vpc \
#     --template-body file://vpc.yml \
#     --capabilities CAPABILITY_IAM \
#     --region $APP_REGION1 \
#     --parameters ParameterKey=Az1,ParameterValue="${APP_REGION1}a" \
#     ParameterKey=Az2,ParameterValue="${APP_REGION1}b"
# aws cloudformation wait stack-create-complete --stack-name django-scaling-vpc --region $APP_REGION1 --debug


# aws cloudformation create-stack --stack-name django-scaling-ecs \
#     --template-body file://ecs.yml \
#     --capabilities CAPABILITY_IAM \
#     --region $APP_REGION1 \
#     --parameters ParameterKey=Region,ParameterValue=$APP_REGION1 \
#     ParameterKey=Image,ParameterValue="$ECR_REPO:v6" \
#     ParameterKey=TaskCount,ParameterValue="1"
# aws cloudformation wait stack-create-complete --stack-name django-scaling-ecs --region $APP_REGION1



# Deploy ECS cluster in second region

# aws ecr create-repository --repository-name djangoscaling --region $APP_REGION2
# ECR login
ECR_REPO="103050589342.dkr.ecr.eu-west-2.amazonaws.com/djangoscaling"
# aws ecr get-login-password --region $APP_REGION2 | docker login --username AWS --password-stdin $ECR_REPO
# Move to django-scaling folder and run the following
# cd django-scaling
# sh deploy_aws.sh "$ECR_REPO" "v6"
# cd ..

# aws cloudformation create-stack --stack-name django-scaling-vpc \
#     --template-body file://vpc.yml \
#     --capabilities CAPABILITY_IAM \
#     --region $APP_REGION2 \
#     --parameters ParameterKey=Az1,ParameterValue="${APP_REGION2}a" \
#     ParameterKey=Az2,ParameterValue="${APP_REGION2}b"
# aws cloudformation wait stack-create-complete --stack-name django-scaling-vpc --region $APP_REGION2


# aws cloudformation create-stack --stack-name django-scaling-ecs \
#     --template-body file://ecs.yml \
#     --capabilities CAPABILITY_IAM \
#     --region $APP_REGION2 \
#     --parameters ParameterKey=Region,ParameterValue=$APP_REGION2 \
#     ParameterKey=Image,ParameterValue="$ECR_REPO:v6" \
#     ParameterKey=TaskCount,ParameterValue="1"
# aws cloudformation wait stack-create-complete --stack-name django-scaling-ecs --region $APP_REGION2

# aws ecr create-repository --repository-name djangoscalingtests --region $TESTS_REGION


ECR_REPO="103050589342.dkr.ecr.eu-west-1.amazonaws.com/djangoscalingtests"
# aws ecr get-login-password --region $TESTS_REGION | docker login --username AWS --password-stdin $ECR_REPO
# Move to django-scaling folder and run the following
# cd django-scaling-load-tests
# sh deploy_aws.sh "$ECR_REPO" "v4"
# cd ..

# aws cloudformation create-stack --stack-name django-scaling-vpc \
#     --template-body file://vpc.yml \
#     --capabilities CAPABILITY_IAM \
#     --region $TESTS_REGION \
#     --parameters ParameterKey=Az1,ParameterValue="${TESTS_REGION}a" \
#     ParameterKey=Az2,ParameterValue="${TESTS_REGION}b"
# aws cloudformation wait stack-create-complete --stack-name django-scaling-vpc --region $TESTS_REGION

# aws cloudformation create-stack --stack-name django-scaling-ecs-tests \
#     --template-body file://ecs-tests.yml \
#     --capabilities CAPABILITY_IAM \
#     --region $TESTS_REGION \
#     --parameters ParameterKey=Region,ParameterValue=$TESTS_REGION \
#     ParameterKey=MasterTaskCount,ParameterValue="1" \
#     ParameterKey=TaskCount,ParameterValue="0"
#
# aws cloudformation wait stack-create-complete --stack-name django-scaling-ecs-tests --region $TESTS_REGION
