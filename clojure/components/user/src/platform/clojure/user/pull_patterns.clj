(ns platform.clojure.user.pull-patterns)

(def user
  [:user/id
   :user/given-name
   :user/family-name
   [:member/email+given-name+family-name
    :as :user/name
    :xform 'platform.clojure.user.xforms/full-name]
   :user/email])
