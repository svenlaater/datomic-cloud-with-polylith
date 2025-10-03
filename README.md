# Datomic Cloud with Polylith

Example [monorepo][monorepo] setup for a Clojure development stack. It's primary
purpose is to demonstrate how [Polylith][polylith] and CircleCI can be used to
set up and deploy a Datomic Cloud System in one or more AWS accounts. Includes
babashka project for tooling and infra project for deploying
[Infrastructure as Code][iac] using [AWS SAM CLI][sam-cli].

> **Disclaimer**: This is not THE WAY to setup a project. It is an opinionated
approach implemented at [Builderhead][builderhead] using tools that the author
is familiar and comfortable with.

## Structure

- [babashka](babashka/README.md) - Babashka-based tooling and scripts.
- [clojure](clojure/README.md) - Clojure application code.
-  - Infrastructure as code.

## Getting Started

### Prerequisites

- [Java][java]
- [Clojure][clojure]
- [Babashka][babashka]
- [AWS CLI][aws-cli]
- [AWS SAM CLI][sam-cli]

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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file
for details.

## References

[monorepo]: https://en.wikipedia.org/wiki/Monorepo
[polylith]: https://polylith.gitbook.io/
[iac]: https://en.wikipedia.org/wiki/Infrastructure_as_code
[builderhead]: https://www.builderhead.com
[java]: https://www.oracle.com/java/technologies/downloads/
[clojure]: https://clojure.org/guides/install_clojure
[babashka]: https://github.com/babashka/babashka#installation
[aws-cli]: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
[sam-cli]: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/install-sam-cli.html
[clojure-mcp]: https://github.com/bhauman/clojure-mcp
