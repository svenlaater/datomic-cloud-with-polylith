#!/usr/bin/env bash
set -euo pipefail

# CircleCI OIDC Setup for AWS

export AWS_PAGER=""

echo "Starting CircleCI OIDC setup..."

echo "Checking for AWS CLI..."
if ! command -v aws &> /dev/null; then
    echo "ERROR: AWS CLI is not installed"
    exit 1
fi
echo "AWS CLI found"

echo "Creating OIDC identity provider for CircleCI..."
aws iam create-open-id-connect-provider \
  --url "https://oidc.circleci.com/org/${CIRCLECI_ORG_ID}" \
  --client-id-list "${CIRCLECI_ORG_ID}" \
  --thumbprint-list "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"

echo "Creating IAM role for CircleCI..."
cat > circleci-trust-policy.json <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):oidc-provider/oidc.circleci.com/org/${CIRCLECI_ORG_ID}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringLike": {
          "oidc.circleci.com/org/${CIRCLECI_ORG_ID}:sub": "org/${CIRCLECI_ORG_ID}/project/*/user/*"
        }
      }
    }
  ]
}
EOF

aws iam create-role \
  --role-name CircleCIRole \
  --assume-role-policy-document file://circleci-trust-policy.json \
  --description "Role for CircleCI OIDC authentication"

echo "Attaching policies to CircleCI role..."
# Attach policies as needed, example:
aws iam attach-role-policy \
  --role-name CircleCIRole \
  --policy-arn arn:aws:iam::aws:policy/PowerUserAccess

echo "OIDC setup complete!"
echo "Role ARN: arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/CircleCIRole"
echo ""
echo "Add this to your CircleCI config.yml:"
echo "  - run:"
echo "      name: Configure AWS credentials"
echo "      command: |"
echo "        echo 'export AWS_ROLE_ARN=arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/CircleCIRole' >> \$BASH_ENV"
echo "        echo 'export AWS_WEB_IDENTITY_TOKEN_FILE=/tmp/web-identity-token' >> \$BASH_ENV"

rm circleci-trust-policy.json
