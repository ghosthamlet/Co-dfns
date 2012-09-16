(define (->string x) (with-output-to-string (lambda () (write x))))

(define-syntax test
  (syntax-rules ()
    [(_ apl tks ...) 
     (test-eq #t
       (array->boolean
         (test-read-eval-string (->string '(apl tks ...))
           (environment '(hpapl)))))]
    [(_ name tks ...) (string? (syntax->datum #'name))
     (test-eq name #t
       (array->boolean
         (test-read-eval-string (->string '(apl tks ...))
           (environment '(hpapl)))))]))


(test apl (1 ⍴ 0) ≡ ⍴ ⍴ 5)
(test apl (1 ⍴ 1) ≡ ⍴ ⍴ 0 1 2)
(test apl 1 1 ≡ ⍴ 1 1 ⍴ 0)
(test apl (1 ⍴ 1) ≡ ⍴ ⍴ ⍴ 5)
(test apl (1 ⍴ 1) ≡ ⍴ ⍴ ⍴ 0 1 2)
(test apl 0 1 2 3 ≡ ⍳ 4)
(test apl ⍬ ≡ ⍳ 0)
(test apl 10 ≡ + / ⍳ 5)
(test apl 20 ≡ + / (⍳ 5) + ⍳ 5)
(test apl 20 ≡ (+ / ⍳ 5) + + / ⍳ 5)
(test apl 20 ≡ + / (⍳ 5) + ¨ ⍳ 5)
(test apl (+ / (⍳ 5) + ¨ ⍳ 5) ≡ 20)
(test apl 10 11 12 13 14 ≡ (+ / ⍳ 5) + ⍳ 5)
(test apl F ← 5 ⋄ 10 ≡ + / ⍳ F)
(test apl 1 ⋄ 0)
(test apl F ← { ⍺ + ⍵ } ⋄ 10 ≡ F / ⍳ 5)
(test apl ⋄ 1)
(test apl F ← { + / ⍳ ⍵ } ⋄ 10 ≡ + / F ¨ ⍳ 5)
(test apl F ← { ⍵ : 3 ⋄ 4 } ⋄ 4 3 ≡ F ¨ 0 1)
(test apl F ← { ⍵ ≤ 1 : 1 ⋄ ⍵ × F ⍵ - 1 } ⋄ 120 ≡ F 5)