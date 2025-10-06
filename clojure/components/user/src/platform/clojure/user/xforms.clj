(ns platform.clojure.user.xforms
  (:require
   [clojure.string :as str]))

(defn full-name
  "Takes a tuple of `email+given-name+family-name` and returns:
  - full name as string if given and/or family name exist
  - email as a fallback"
  [email+given-name+family-name]
  (or (some->> email+given-name+family-name
               rest
               (remove nil?)
               (remove str/blank?)
               seq
               (map str/trim)
               (str/join " "))
      (first email+given-name+family-name)))
