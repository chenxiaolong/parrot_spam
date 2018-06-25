#! /usr/bin/env clj

(def parrots
  (or (not-empty (remove empty? *command-line-args*))
      (do (.println *err* "Nothing to repeat")
          (System/exit 1))))

(defn spam [parrots char-limit]
  (let [all-spam (new StringBuilder)]
    (loop [ps (cycle parrots)]
      (let [p (first ps)]
        (if (<= (+ (count p) (count all-spam)) char-limit)
          (do (.append all-spam p)
              (recur (rest ps)))
          (.toString all-spam))))))

(println (spam parrots 4000))
