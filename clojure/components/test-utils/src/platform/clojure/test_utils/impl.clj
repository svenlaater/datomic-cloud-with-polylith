(ns platform.clojure.test-utils.impl
  (:require
   [clojure.spec.alpha :as s]
   [expound.alpha :as expound]
   [pjstadig.humane-test-output :refer [activate!]]))

(defn setup
  [_]
  (let [printer (expound/custom-printer {:show-valid-values? true
                                         :print-specs? true})]
    (try
      (set! s/*explain-out* printer)
      (catch Exception _
        (alter-var-root #'s/*explain-out* (constantly printer)))))
  (activate!))
