(ns dev.svenlaater
  "Development namespace for GitHub user svenlaater"
  (:require
   [clj-reload.core :as reload :refer [reload]]
   [clojure.pprint :as pp :refer [pprint print-table]]
   [clojure.test :refer :all]
   [criterium.core :as criterium :refer [quick-bench]]
   [platform.clojure.test-utils.interface :as tu]
   [platform.clojure.utils.interface :as u]))

(printf "Loaded `%s` development namespace\n" *ns*)

(defonce setup
  (memoize (fn []
             ;; Use (clj-reload.core/reload) from REPL to reload all changed ns
             ;; anywhere in the app.
             (reload/init
              {:dirs ["bases" "components" "development" "projects"]
               :no-reload '#{user svenlaater}}))))

(setup)
