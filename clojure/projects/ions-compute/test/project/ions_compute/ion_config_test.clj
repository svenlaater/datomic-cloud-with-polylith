(ns project.ions-compute.ion-config-test
  (:require
   [clojure.java.io :as io]
   [clojure.test :as test :refer :all]))

(deftest ion-config-test
  (testing "ion-config.edn"
    (testing "exists"
      (let [{:keys [allow app-name xforms]
             :as cfg} (-> "ions-compute/datomic/ion-config.edn"
                          io/resource
                          slurp
                          read-string)]
        (is (map? cfg))
        (testing "with"
          (testing "app-name `platform`"
            (is (= "platform" app-name)))
          (testing ":allow"
            (testing "that is not empty"
              (is (seq allow))))
          (testing ":xforms"
            (testing "that is empty"
              (is (empty? xforms)))))))))
