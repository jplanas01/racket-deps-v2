#lang racket
(require graph)

(define deps-file 
  (command-line #:args (filename) filename))
;(define deps-file "chicken.txt")
(define infile (open-input-file deps-file))

(define deps-graph (weighted-graph/directed '()))

(define (add-depends dep-graph dep-package)
  (define item (car dep-package))
  (define deps-list (cadr dep-package))
  (map (lambda (dep)
         (let ([dep (car dep)]
               [weight (cadr dep)])
           (add-directed-edge! dep-graph dep item weight)))
       deps-list))

(define (get-comp-str symbol)
  (if (> (string-length (symbol->string symbol)) 5)
      (substring (symbol->string symbol) 0 5)
      (symbol->string symbol)))

(define (cutlery? symbol)
  (or
   (string=? "clean" (get-comp-str symbol))
   (string=? "dirty" (get-comp-str symbol))))

(define (raw-ingredient? graph symbol)
  (and
   (andmap
    (lambda (vert) (not (has-edge? graph vert symbol)))
    (get-vertices graph))
   (not (cutlery? symbol))))

(define (final-product? graph symbol)
 (null? (get-neighbors deps-graph symbol)))

(for ([(dep) (in-port read infile)])
  (add-depends deps-graph dep))
(define vert-list (get-vertices deps-graph))

(define cutlery-list
  (filter cutlery? vert-list))
(define raw-list
  (filter
   (lambda (vert) (raw-ingredient? deps-graph vert))
   vert-list))
(define final-list
  (filter
   (lambda (vert) (final-product? deps-graph vert))
   vert-list))
(define final-result (car final-list))

(define (greater-than-cons a b)
  (> (cdr a) (cdr b)))

(define time-list
  (sort
   (map (lambda (ingredient)
     (match-let*-values ([(distance-hash _) (dijkstra deps-graph ingredient)]
                         [(ingredient-distance) (hash-ref distance-hash final-result)])
                        (cons ingredient ingredient-distance)))
        raw-list)
   greater-than-cons))

(graphviz deps-graph #:output (open-output-file "deps-graph.dot" #:exists 'replace))
(printf "List of cutlery needed: ~a~n" (string-join (map symbol->string cutlery-list) ", "))
(printf "List of raw ingredient: ~a~n" (string-join (map symbol->string raw-list) ", "))
(printf "List of final products: ~a~n" (string-join (map symbol->string final-list) ", "))
(cond [(> (length final-list) 1)
       (displayln "You're supposed to have only 1 final product, so I picked one.")])
(printf "Ingredient with longest cook time is ~a with cooking time ~a~n" (caar time-list) (cdar time-list))
