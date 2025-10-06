# Datomic Cloud with Polylith

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/svenlaater/datomic-cloud-with-polylith/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/svenlaater/datomic-cloud-with-polylith/tree/main)

Example [monorepo][monorepo] setup for a Clojure development stack. Its primary
purpose is to demonstrate how [Polylith][polylith] and CircleCI can be used to
set up and deploy a Datomic Cloud System in one or more AWS accounts. Includes
babashka project for tooling and infra project for deploying required
infrastructure.

## Structure

- [babashka](babashka/README.md) - Babashka-based tooling and scripts.
- [clojure](clojure/README.md) - Clojure application code.
- [infra](infra/README.md) - scripts for deploying infrastructure.

## Getting Started

Ensure that all prerequisites have been met and then head over to
[infra](infra/README.md) project to setup a Datomic Cloud System.

### Prerequisites

- [Java][java]
- [Clojure][clojure]
- [Babashka][babashka]
- [AWS CLI][aws-cli]
- [CircleCI account][circleci]
- [AWS account][aws]

## Development

### CLI

```sh
# Start Clojure MCP
clj -M:nrepl
```

### MCP

[Clojure MCP][clojure-mcp] provides AI assistance with direct access to your
REPL. Connect Claude to evaluate code, inspect data structures, and interact
with your running application.

## Deployment

The project uses CircleCI's [dynamic configuration][circleci-dynamic] with
path filtering to run only relevant workflows when code changes. The setup job
in `.circleci/config.yml` detects which project directories (babashka, clojure,
infra) have changes and generates a configuration that includes only the
affected project's workflow. Each project has its own `.circleci/config.yml`
that defines project-specific workflows, which reference shared jobs from
`.circleci/common/`. When no relevant changes are detected, CircleCI runs the
no-op workflow defined in `no-updates.yml`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file
for details.

## References

- https://circleci.com/docs/guides/orchestrate/using-dynamic-configuration/

[monorepo]: https://en.wikipedia.org/wiki/Monorepo
[polylith]: https://polylith.gitbook.io/
[aws]: https://aws.amazon.com/free/
[java]: https://www.oracle.com/java/technologies/downloads/
[clojure]: https://clojure.org/guides/install_clojure
[babashka]: https://github.com/babashka/babashka#installation
[aws-cli]: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
[sam-cli]: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html
[clojure-mcp]: https://github.com/bhauman/clojure-mcp
[circleci-dynamic]: https://circleci.com/docs/dynamic-config/
[circleci]: https://circleci.com/signup/
