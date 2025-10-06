(ns platform.clojure.utils.interface
  (:require
   [platform.clojure.utils.impl :as impl]))

(def ^{:see-also ["clojure.core/update"]
       :arglists '([m k f])}
  update-if-exists
  "Same as clojure.core/update but performs update only if provided key `k` exists."
  impl/update-if-exists)
