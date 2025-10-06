(ns project.ions-graphql-api.ion-config-test
  (:require
   [clojure.java.io :as io]
   [clojure.test :as test :refer :all]
   [platform.clojure.graphql-api.service :as service]))

(deftest ion-config-test
  (testing "ion-config.edn"
    (testing "exists"
      (let [{:keys [app-name xforms http-direct] :as cfg}
            (-> "ions-graphql-api/datomic/ion-config.edn"
                io/resource
                slurp
                read-string)]
        (is (map? cfg))
        (testing "with"
          (testing "app-name `erp-api`"
            (is (= "platform" app-name)))
          (testing "http-direct entry point that resolves to correct handler"
            (is (= (->> http-direct
                        :handler-fn
                        symbol
                        requiring-resolve)
                   #'service/handler)))
          (testing ":xforms"
            (testing "in alphabetical order"
              (is (= (-> xforms sort vec) xforms)))
            (testing "that resolve"
              (is (= (->> xforms
                          (mapv symbol)
                          (mapv requiring-resolve)
                          (mapv class)
                          set)
                     #{clojure.lang.Var})))))))))
