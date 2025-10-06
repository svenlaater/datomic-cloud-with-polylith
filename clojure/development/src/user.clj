(ns user)

(defn myns
  "Switch to developer specific namespace `dev.${GITHUB_USERNAME}` if such
  environment variable exists."
  []
  (let [sym (->> "GITHUB_USERNAME"
                 System/getenv
                 (format "dev.%s")
                 symbol)]
    (in-ns sym)
    (use sym :reload)))
