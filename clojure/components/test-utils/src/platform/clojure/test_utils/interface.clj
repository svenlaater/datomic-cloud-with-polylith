(ns platform.clojure.test-utils.interface
  (:require
   [platform.clojure.test-utils.impl :as impl]))

(defn setup
  "Test setup.

  - Activates Humane test output for clojure.test
  - Uses expound to format clojure.spec error messages"
  ([] (setup {}))
  ([opts] (impl/setup opts)))
