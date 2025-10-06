(ns platform.clojure.user.interface
  (:require
   [platform.clojure.user.pull-patterns :as pull-patterns]))

(def pull-pattern
  "Datomic pull pattern for user (member).

  Conforms to GraphQL type `User`."
  pull-patterns/user)
