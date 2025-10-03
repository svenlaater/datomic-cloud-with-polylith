# Babashka

Babashka-based tooling and scripts for the monorepo.

## Prerequisites

- [Babashka][babashka]

## Development

### CLI

```sh
# Check for outdated dependencies
clj -M:antq

# Lint code with clj-kondo
clj -M:clj-kondo src

# Check code formatting
clj -M:cljfmt/check

# Fix code formatting
clj -M:cljfmt/fix

# Lint code style with splint
clj -M:splint
```

## References

[babashka]: https://github.com/babashka/babashka#installation
