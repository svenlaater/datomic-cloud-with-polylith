# Clojure

Clojure application code using [Polylith][polylith] architecture deployed as
[Datomic Ions][ions].

## Prerequisites

- [Java][java]
- [Clojure][clojure]

### Emacs

```clojure
{
 :aliases
 {:cider-clj {:extra-deps {cider/cider-nrepl {:mvn/version "0.57.0"}
                           refactor-nrepl/refactor-nrepl {:mvn/version "3.10.0"}}
              :main-opts ["-m" "nrepl.cmdline"
                          "--middleware" "[cider.nrepl/cider-middleware]"]}}}
```

## Development

### Emacs

```sh
export GITHUB_USERNAME=svenlaater
$ clj -M:dev:cider-clj
nREPL server started on port 59405 on host localhost - nrepl://localhost:59405
```

1. `cider-connect-clj` <kbd>(C-c M-c)</kbd>
2. `localhost`
3. `clojure:59405`

```clojure
user> (myns)
Loaded `dev.svenlaater` development namespace
nil
dev.svenlaater>
```

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

# Start Poly tool
clj -M:poly
```

### Testing


Start the poly tool `clj -M:poly`

```sh
# Run tests for development project
clojure$ test :dev

# Run all tests for all the projects.
clojure$ test :project :all

# Run tests for an individual project
clojure$ test :project project:ions-compute
clojure$ test :project project:ions-graphql-api
```

## References

[java]: https://www.oracle.com/java/technologies/downloads/
[clojure]: https://clojure.org/guides/install_clojure
[polylith]: https://polylith.gitbook.io/
[ions]: https://docs.datomic.com/ions/ions.html
