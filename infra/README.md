# Infrastructure

Infrastructure deployment for [clojure](../clojure/README.md) project.

This is specific to given example project with the goal of setting up and
tearing down a Datomic Cloud System with the least effort. It is probably not
how you'd want it to be set it up in production.

## Setup

### Set AWS Region and environment variables

```sh
# Set region and stack name
export AWS_REGION=eu-central-1

# Set AWS environment variables
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=..
export AWS_SESSION_TOKEN=...
```

###  Datomic Cloud System on AWS

Set up a Datomic Cloud System on AWS. This will take some time.

```sh
# Choose a stack name e.g. <env>-platform
export STACK_NAME=sandbox-platform

# Run setup script
# NB! This can take 15+ minutes
./scripts/datomic_setup.sh
```

### OIDC

This is needed for CircleCI to be able to push new code to AWS.

Get your CircleCI organization ID from:
https://app.circleci.com/settings/organization/github/{your-org}/overview

```sh
# Get CircleCI organization ID from Organization settings
export CIRCLECI_ORG_ID=...

# Run setup script
# NB! This can take 15+ minutes
./scripts/oidc_setup.sh
```

## Teardown

Clean up Datomic  and OIDC related AWS resources. This will also take some time.

```sh
./scripts/oidc_teardown.sh
./scripts/datomic_teardown.sh
```

## References

- https://docs.datomic.com/releases-cloud.html
- https://docs.datomic.com/setup-cloud/setup-cloud.html
- https://circleci.com/docs/guides/permissions-authentication/openid-connect-tokens/#aws
