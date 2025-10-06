(ns platform.clojure.utils.interface-test
  (:require
   [clojure.test :refer :all]
   [platform.clojure.utils.interface :as sut]))

(deftest update-if-exists-test
  (testing "Update an existing key in map"
    (is (= (sut/update-if-exists {:a 0} :a inc)
           {:a 1}))
    (is (= (sut/update-if-exists {"b" :a} "b" str)
           {"b" ":a"})))
  (testing "No matching key"
    (are [m] (= (sut/update-if-exists m :c inc) m)
      {} {:d 1})))
