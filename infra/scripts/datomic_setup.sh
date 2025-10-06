#!/usr/bin/env bash
set -euo pipefail

# Datomic Cloud Infrastructure Setup.
# Description: Creates Datomic compute and storage stacks and an
# EC2 key pair.

echo "Starting Datomic Cloud Infrastructure Setup"

export AWS_PAGER=""

echo "Checking for AWS CLI..."
if ! command -v aws &> /dev/null; then
    echo "ERROR: AWS CLI is not installed"
    echo "Install it from: https://aws.amazon.com/cli/"
    exit 1
fi
echo "AWS CLI found"

echo "Creating EC2 key pair 'datomic'..."
aws ec2 create-key-pair \
    --region ${AWS_REGION} \
    --key-name datomic \
    --query 'KeyMaterial' \
    --output text > datomic.pem

echo "Setting permissions on datomic.pem..."
chmod 400 datomic.pem

echo "Creating storage stack '${STACK_NAME}'..."
aws cloudformation create-stack \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME} \
  --template-url https://s3.amazonaws.com/datomic-cloud-1/cft/1172/storage-template-9392-1172.json \
  --capabilities CAPABILITY_NAMED_IAM

echo "Waiting for storage stack creation to complete..."
aws cloudformation wait stack-create-complete \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}

echo "Updating storage stack with Restart=true..."
aws cloudformation update-stack \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME} \
  --capabilities CAPABILITY_IAM \
  --use-previous-template \
  --parameters \
    ParameterKey=Restart,ParameterValue="true"

echo "Waiting for storage stack update to complete..."
aws cloudformation wait stack-update-complete \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}

echo "Creating primary compute stack '${STACK_NAME}-compute'..."
aws cloudformation create-stack \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}-compute \
  --template-url https://s3.amazonaws.com/datomic-cloud-1/cft/1172/compute-template-9392-1172.json \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameters \
    ParameterKey=SystemName,ParameterValue="${STACK_NAME}" \
    ParameterKey=InstanceType,ParameterValue="t3.small" \
    ParameterKey=KeyName,ParameterValue="datomic" \
    ParameterKey=ApplicationName,ParameterValue="platform" \
    ParameterKey=EnvironmentMap,ParameterValue='"{}"' \
    ParameterKey=MetricsLevel,ParameterValue="None"

echo "Waiting for compute stack creation to complete..."
aws cloudformation wait stack-create-complete \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}-compute

echo "Creating query group stack '${STACK_NAME}-graphql-api'..."
aws cloudformation create-stack \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}-graphql-api \
  --template-url https://s3.amazonaws.com/datomic-cloud-1/cft/1172/query-group-template-9392-1172.json \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameters \
    ParameterKey=SystemName,ParameterValue="${STACK_NAME}" \
    ParameterKey=InstanceType,ParameterValue="t3.small" \
    ParameterKey=KeyName,ParameterValue="datomic" \
    ParameterKey=ApplicationName,ParameterValue="platform" \
    ParameterKey=EnvironmentMap,ParameterValue='"{}"' \
    ParameterKey=MetricsLevel,ParameterValue="None"

echo "Waiting for query group stack creation to complete..."
aws cloudformation wait stack-create-complete \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}-graphql-api

echo "All resources created successfully"
