(define (problem sussman2)
    (:domain snlp-bw2)
  (:objects a b c)
  (:init (on c a) (on-table b) (on-table a) (clear c) (clear b))
  (:goal (AND (on a b) (on b c)))
  (:length (:serial 3) (:parallel 3)))