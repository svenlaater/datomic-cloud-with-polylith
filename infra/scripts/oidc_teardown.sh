#!/usr/bin/env bash
set -euo pipefail

# CircleCI OIDC Teardown for AWS
# Removes OIDC provider and IAM role

export AWS_PAGER=""

echo "Starting CircleCI OIDC teardown..."

echo "Detaching policies from CircleCIRole..."
# Get all attached policies
POLICIES=$(aws iam list-attached-role-policies \
  --role-name CircleCIRole \
  --query 'AttachedPolicies[*].PolicyArn' \
  --output text)

for POLICY in $POLICIES; do
  echo "Detaching policy: $POLICY"
  aws iam detach-role-policy \
    --role-name CircleCIRole \
    --policy-arn "$POLICY"
done

echo "Deleting CircleCI IAM role..."
aws iam delete-role \
  --role-name CircleCIRole

echo "Deleting OIDC identity provider..."
aws iam delete-open-id-connect-provider \
  --open-id-connect-provider-arn "arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):oidc-provider/oidc.circleci.com/org/${CIRCLECI_ORG_ID}"

echo "CircleCI OIDC teardown complete!"
