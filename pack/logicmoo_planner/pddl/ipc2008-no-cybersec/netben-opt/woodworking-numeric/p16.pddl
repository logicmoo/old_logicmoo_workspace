; woodworking 'choose one' task with 8 parts
; Machines:
;   1 grinder
;   1 glazer
;   1 immersion-varnisher
;   1 planer
;   1 highspeed-saw
;   1 spray-varnisher
;   1 saw
; random seed: 67997

(define (problem wood-prob)
  (:domain woodworking)
  (:objects
    grinder0 - grinder
    glazer0 - glazer
    immersion-varnisher0 - immersion-varnisher
    planer0 - planer
    highspeed-saw0 - highspeed-saw
    spray-varnisher0 - spray-varnisher
    saw0 - saw
    mauve red black green blue white - acolour
    pine teak - awood
    p0 p1 p2 p3 p4 p5 p6 p7 - part
    b0 b1 b2 b3 b4 b5 b6 - board
  )
  (:init
    (grind-treatment-change varnished colourfragments)
    (grind-treatment-change glazed untreated)
    (grind-treatment-change untreated untreated)
    (grind-treatment-change colourfragments untreated)
    (is-smooth smooth)
    (is-smooth verysmooth)
    (= (total-cost) 0)
    (has-colour glazer0 blue)
    (has-colour glazer0 natural)
    (has-colour glazer0 mauve)
    (has-colour glazer0 black)
    (has-colour glazer0 green)
    (has-colour glazer0 red)
    (has-colour immersion-varnisher0 blue)
    (has-colour immersion-varnisher0 natural)
    (has-colour immersion-varnisher0 mauve)
    (has-colour immersion-varnisher0 black)
    (has-colour immersion-varnisher0 green)
    (has-colour immersion-varnisher0 white)
    (has-colour immersion-varnisher0 red)
    (empty highspeed-saw0)
    (has-colour spray-varnisher0 blue)
    (has-colour spray-varnisher0 natural)
    (has-colour spray-varnisher0 mauve)
    (has-colour spray-varnisher0 black)
    (has-colour spray-varnisher0 green)
    (has-colour spray-varnisher0 white)
    (has-colour spray-varnisher0 red)
    (unused p0)
    (= (goal-size p0) 7)
    (= (glaze-cost p0) 12)
    (= (grind-cost p0) 21)
    (= (plane-cost p0) 14)
    (unused p1)
    (= (goal-size p1) 10)
    (= (glaze-cost p1) 15)
    (= (grind-cost p1) 30)
    (= (plane-cost p1) 20)
    (unused p2)
    (= (goal-size p2) 6)
    (= (glaze-cost p2) 11)
    (= (grind-cost p2) 18)
    (= (plane-cost p2) 12)
    (unused p3)
    (= (goal-size p3) 10)
    (= (glaze-cost p3) 15)
    (= (grind-cost p3) 30)
    (= (plane-cost p3) 20)
    (unused p4)
    (= (goal-size p4) 13)
    (= (glaze-cost p4) 18)
    (= (grind-cost p4) 39)
    (= (plane-cost p4) 26)
    (unused p5)
    (= (goal-size p5) 11)
    (= (glaze-cost p5) 16)
    (= (grind-cost p5) 33)
    (= (plane-cost p5) 22)
    (unused p6)
    (= (goal-size p6) 14)
    (= (glaze-cost p6) 19)
    (= (grind-cost p6) 42)
    (= (plane-cost p6) 28)
    (unused p7)
    (= (goal-size p7) 12)
    (= (glaze-cost p7) 17)
    (= (grind-cost p7) 36)
    (= (plane-cost p7) 24)
    (= (board-size b0) 33)
    (wood b0 teak)
    (surface-condition b0 rough)
    (available b0)
    (= (board-size b1) 48)
    (wood b1 teak)
    (surface-condition b1 rough)
    (available b1)
    (= (board-size b2) 54)
    (wood b2 teak)
    (surface-condition b2 smooth)
    (available b2)
    (= (board-size b3) 12)
    (wood b3 teak)
    (surface-condition b3 rough)
    (available b3)
    (= (board-size b4) 33)
    (wood b4 pine)
    (surface-condition b4 rough)
    (available b4)
    (= (board-size b5) 43)
    (wood b5 pine)
    (surface-condition b5 rough)
    (available b5)
    (= (board-size b6) 49)
    (wood b6 pine)
    (surface-condition b6 rough)
    (available b6)
  )
  (:goal
    (and
      (preference g_p0_0 (and
          (colour p0 white)
          (wood p0 teak)
          (surface-condition p0 verysmooth)
          (treatment p0 varnished)
          (available p0)
      ))
      (preference g_p0_1 (and
          (colour p0 red)
          (wood p0 pine)
          (surface-condition p0 verysmooth)
          (available p0)
      ))
      (preference g_p1_0 (and
          (colour p1 green)
          (wood p1 teak)
          (treatment p1 glazed)
          (available p1)
      ))
      (preference g_p1_1 (and
          (colour p1 blue)
          (wood p1 teak)
          (available p1)
      ))
      (preference g_p1_2 (and
          (wood p1 pine)
          (surface-condition p1 smooth)
          (treatment p1 glazed)
          (available p1)
      ))
      (preference g_p1_3 (and
          (wood p1 pine)
          (surface-condition p1 verysmooth)
          (treatment p1 varnished)
          (available p1)
      ))
      (preference g_p2_0 (and
          (colour p2 natural)
          (wood p2 teak)
          (surface-condition p2 smooth)
          (treatment p2 varnished)
          (available p2)
      ))
      (preference g_p2_1 (and
          (wood p2 pine)
          (surface-condition p2 verysmooth)
          (treatment p2 glazed)
          (available p2)
      ))
      (preference g_p3_0 (and
          (colour p3 mauve)
          (wood p3 pine)
          (surface-condition p3 smooth)
          (available p3)
      ))
      (preference g_p3_1 (and
          (colour p3 natural)
          (wood p3 pine)
          (surface-condition p3 smooth)
          (treatment p3 varnished)
          (available p3)
      ))
      (preference g_p3_2 (and
          (wood p3 pine)
          (surface-condition p3 verysmooth)
          (available p3)
      ))
      (preference g_p3_3 (and
          (colour p3 blue)
          (treatment p3 varnished)
          (available p3)
      ))
      (preference g_p4_0 (and
          (colour p4 black)
          (wood p4 teak)
          (surface-condition p4 verysmooth)
          (treatment p4 varnished)
          (available p4)
      ))
      (preference g_p4_1 (and
          (colour p4 white)
          (wood p4 teak)
          (surface-condition p4 verysmooth)
          (treatment p4 varnished)
          (available p4)
      ))
      (preference g_p4_2 (and
          (colour p4 blue)
          (wood p4 pine)
          (surface-condition p4 smooth)
          (available p4)
      ))
      (preference g_p5_0 (and
          (colour p5 natural)
          (wood p5 teak)
          (treatment p5 varnished)
          (available p5)
      ))
      (preference g_p5_1 (and
          (wood p5 pine)
          (surface-condition p5 smooth)
          (available p5)
      ))
      (preference g_p5_2 (and
          (colour p5 natural)
          (wood p5 teak)
          (surface-condition p5 verysmooth)
          (available p5)
      ))
      (preference g_p6_0 (and
          (wood p6 teak)
          (surface-condition p6 verysmooth)
          (treatment p6 glazed)
          (available p6)
      ))
      (preference g_p6_1 (and
          (colour p6 green)
          (wood p6 teak)
          (surface-condition p6 smooth)
          (available p6)
      ))
      (preference g_p6_2 (and
          (colour p6 natural)
          (wood p6 teak)
          (surface-condition p6 verysmooth)
          (treatment p6 varnished)
          (available p6)
      ))
      (preference g_p6_3 (and
          (colour p6 mauve)
          (wood p6 pine)
          (treatment p6 varnished)
          (available p6)
      ))
      (preference g_p7_0 (and
          (colour p7 green)
          (wood p7 pine)
          (available p7)
      ))
      (preference g_p7_1 (and
          (colour p7 mauve)
          (wood p7 teak)
          (surface-condition p7 smooth)
          (available p7)
      ))
      (preference g_p7_2 (and
          (colour p7 mauve)
          (wood p7 pine)
          (treatment p7 varnished)
          (available p7)
      ))
      (preference g_p7_3 (and
          (colour p7 black)
          (wood p7 teak)
          (surface-condition p7 verysmooth)
          (available p7)
      ))
    )
  )
  (:metric maximize
    (- 2329
      (+ (total-cost)
         (* (is-violated g_p0_0) 85)
         (* (is-violated g_p0_1) 79)
         (* (is-violated g_p1_0) 60)
         (* (is-violated g_p1_1) 54)
         (* (is-violated g_p1_2) 82)
         (* (is-violated g_p1_3) 93)
         (* (is-violated g_p2_0) 73)
         (* (is-violated g_p2_1) 70)
         (* (is-violated g_p3_0) 109)
         (* (is-violated g_p3_1) 104)
         (* (is-violated g_p3_2) 79)
         (* (is-violated g_p3_3) 56)
         (* (is-violated g_p4_0) 121)
         (* (is-violated g_p4_1) 128)
         (* (is-violated g_p4_2) 119)
         (* (is-violated g_p5_0) 66)
         (* (is-violated g_p5_1) 87)
         (* (is-violated g_p5_2) 109)
         (* (is-violated g_p6_0) 119)
         (* (is-violated g_p6_1) 122)
         (* (is-violated g_p6_2) 130)
         (* (is-violated g_p6_3) 52)
         (* (is-violated g_p7_0) 68)
         (* (is-violated g_p7_1) 100)
         (* (is-violated g_p7_2) 50)
         (* (is-violated g_p7_3) 114)
  )))
)