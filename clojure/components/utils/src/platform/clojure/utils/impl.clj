(ns platform.clojure.utils.impl)

(defn update-if-exists
  [m k f]
  (if (contains? m k)
    (update m k f)
    m))
