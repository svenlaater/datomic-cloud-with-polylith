(ns platform.clojure.user.xforms-test
  (:require
   [clojure.test :refer :all]
   [platform.clojure.user.xforms :as sut]))

(deftest full-name-test
  (testing "Name consists of given and family name"
    (is (= "Mika"
           (sut/full-name ["mika@.builderhead.fi" "Mika"])))
    (is (= "Mika-Jukka Saarinen"
           (sut/full-name ["mika@.builderhead.fi" "Mika-Jukka" "Saarinen"])))
    (is (= "Saarinen"
           (sut/full-name ["mika@.builderhead.fi" "Saarinen"])
           (sut/full-name ["mika@.builderhead.fi" "Saarinen" nil])
           (sut/full-name ["mika@.builderhead.fi" nil "Saarinen"])))
    (testing "that are trimmed"
      (is (= "Kusti"
             (sut/full-name ["mika@.builderhead.fi" "    Kusti"])))
      (is (= "Kusti Salm"
             (sut/full-name ["mika@.builderhead.fi" "   Kusti   " "  Salm  "])))))
  (testing "Fall back to email if givenName and familyName are missing or blank"
    (let [email "mika@.builderhead.fi"]
      (are [tuple] (is (= email (sut/full-name tuple)))
        [email "mika@.builderhead.fi" "" ""]
        [email "mika@.builderhead.fi" "   " "          "]
        [email]
        [email nil nil]
        [email nil]))))
