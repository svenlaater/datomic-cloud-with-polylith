#!/usr/bin/env bash
set -euo pipefail

export AWS_PAGER=""

echo "Checking for AWS CLI..."
if ! command -v aws &> /dev/null; then
    echo "ERROR: AWS CLI is not installed"
    echo "Install it from: https://aws.amazon.com/cli/"
    exit 1
fi
echo "AWS CLI found"

echo "Starting Datomic Cloud Infrastructure Teardown"
echo "Removing all resources created in setup.sh"

echo "Deleting query group stack '${STACK_NAME}-graphql-api'..."
aws cloudformation delete-stack \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}-graphql-api

echo "Waiting for query group stack deletion to complete..."
aws cloudformation wait stack-delete-complete \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}-graphql-api

echo "Deleting compute stack '${STACK_NAME}-compute'..."
aws cloudformation delete-stack \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}-compute

echo "Waiting for compute stack deletion to complete..."
aws cloudformation wait stack-delete-complete \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}-compute

echo "Deleting storage stack '${STACK_NAME}'..."
aws cloudformation delete-stack \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}

echo "Waiting for storage stack deletion to complete..."
aws cloudformation wait stack-delete-complete \
  --region ${AWS_REGION} \
  --stack-name ${STACK_NAME}

echo "Deleting EC2 key pair 'datomic'..."
aws ec2 delete-key-pair \
  --region ${AWS_REGION} \
  --key-name datomic

echo "Removing local key file datomic.pem..."
rm -f datomic.pem

echo "All resources deleted successfully"
