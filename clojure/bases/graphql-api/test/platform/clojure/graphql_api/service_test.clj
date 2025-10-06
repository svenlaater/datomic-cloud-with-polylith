(ns platform.clojure.graphql-api.service-test
  (:require
   [clojure.test :refer :all]
   [platform.clojure.graphql-api.service :as sut]))

(deftest handler-test
  (is (= "OK!" (sut/handler {}))))
