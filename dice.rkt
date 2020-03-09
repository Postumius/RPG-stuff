#lang racket

(define (part f . xs)
  (letrec
      ([merge-args
        (λ (xs ys)
          (cond [(empty? xs) ys]
                [(eq? (car xs) '_) (cons (car ys) (merge-args (cdr xs) (cdr ys)))]
                [else (cons (car xs) (merge-args (cdr xs) ys))]))])
    (λ ys (apply f (merge-args xs ys)))))


(define (dice n sides)
  (cond
    [(< n 1) 0]
    [(= n 1) (add1 (random sides))]
    [(+ (dice 1 sides) (dice (sub1 n) sides))]))

(define (d n sides)
  (let [(roll (dice n sides))]
    (begin
      (printf "~ad~a rolls ~a~n" n sides roll)
      roll)))

(define (sum-list ls)
  (foldl plus 0 ls))

(define (atk)
  (+ 10 (d 1 20)))

(define (per)
  (+ (d 1 20) 7))

(define (cure-light)
  (+ (dice 1 8) 5))

(define (stl)
  (+ (d 1 20) 28))

(define (kukri)
  (+ (d 1 3) 6))

(define (touch)
  (+ (d 1 20) 2))



(define (mm)
  (+ 3 (d 1 4)))

(define (scorching-ray)
  (multi-hit 2 (cons (+ (d 1 20) 9) (d 4 6))))


(define (frostbite)
  (cons 0 (+ (d 1 6) 9)))

(define (shock)
  (d 5 6))

(define (acro)
  (+ 10 (d 1 20)))

(define (buy n ls)
  (cond [(empty? ls) 0]
        [(< n (car ls)) 0]
        [else (add1 (buy (- n (car ls)) (cdr ls)))]))

(define (sum n ls)
  (cond [(empty? ls) 0]
        [(zero? n) 0]
        [else (+ (car ls) (sum (sub1 n) (cdr ls)))]))

(define cost-ls (list 1 1 1 2 2 3 3 5 5 5))

(define (skl-buy cost)
  (buy cost cost-ls))

(define (skl-cost ranks)
  (sum ranks cost-ls))

(define (hyp a b) (sqrt (+ (* a a) (* b b))))

(define (levi-claw)
  (cons (+ (d 1 20) 14)
        (+ (d 2 6) 8)))

(define (levi-bite)
  (cons (+ (d 1 20) 15)
        (+ (d 2 8) 12)))

(define-syntax-rule (spellstrike spell)
  (cons (+ (d 1 20) 10)
        (plus (kukri) (d 2 6) spell)))

(define-syntax multi-hit
  (syntax-rules ()
    [(multi-hit n roll)
     (let* ([thunk (λ () roll)]
            [ls (map (λ (f) (f))
                (vector->list (make-vector n thunk)))])
       (if (pair? (car ls))
           (cons ls (sum-list (map cdr ls)))
           ls))]))

(define (cons-roll r rs)
  (match (cons r rs)
    [(cons (cons hit dmg) (cons ls dmg-total))
     (cons (cons (cons hit dmg) ls) (plus dmg dmg-total))]))

(define null-rolls (cons null 0))


(define (sub-missed-dmg ac rolls)
 (let* ([ls (car rolls)]
        [pred (λ (pair) (>= pair ac))])
   (cons ls (sum-list (map cdr (filter pred ls))))))

(define (plus . rest)
  (define (inner n m)
    (match (cons n m)
      [(cons (cons x a) (cons y b)) (cons (+ x y) (+ a b))]
      [(cons (cons x a) y) (cons (+ x y) a)]
      [(cons x (cons y b)) (cons (+ x y) b)]
      [(cons x y) (+ x y)]))
  (foldl inner 0 rest))

(define-syntax add
  (syntax-rules ()
    [(add n ...) (+ n ...)]))

