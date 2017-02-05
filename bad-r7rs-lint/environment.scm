#lang racket

(require racket/match)

(define make-environment
  (lambda()
    (let ((env '()))
      (letrec ((get-field 
                (lambda(field data)
                  (match data
                    ('() '())
                    ((list fname (list values) rest) 
                     (if (eq? fname field)
                         values
                         (get-field field rest)))
                    (else
                     (get-field field (cdr data))))))
               (set-field
                (lambda(field new-value acc data)
                  (match data
                    ('() (set! env (cons (list field new-value) env)))
                    ((list fname (list values) rest) 
                     (if (eq? fname field)
                         (set! env ((cons field new-value) acc rest))
                         (set-field field '((cons field new-value) acc) rest)))
                    (else
                     (set-field field new-value acc (cdr data)))
                    ))))

        (lambda(operation field value)
          (let ((field-values (get-field field env)))
            (case operation
              ('get field-values)
              ('all env)
              ('set (set-field field value '() env))
              ('add (set-field field (cons value field-values) '() env)))))))))

(define ee (make-environment))
(ee 'add 'filename '(pipo.scm))
(ee 'add 'filename '(env.scm))
(let ((filename (ee 'get 'filename 'filename)))
  (display "Filename : ") (display (ee 'all #f #f)) (display "\n"))