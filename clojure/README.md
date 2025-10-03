# Clojure

Clojure application code using [Polylith][polylith] architecture.

## Prerequisites

- [Java][java]
- [Clojure][clojure]

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

[java]: https://www.oracle.com/java/technologies/downloads/
[clojure]: https://clojure.org/guides/install_clojure
[polylith]: https://polylith.gitbook.io/
