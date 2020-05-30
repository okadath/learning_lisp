(defun nl() (format t "~%"))

(print
(eval '(+ 1 2 3))
)
(print (Eval '(format t "hello world")))

; en el shell interactivo todo esta en un read-eval-print loop
(defun out-toplevel()
	(
		do()
		(nil)
		(format t "~%> ")
		(print(eval(read)))
		)
	)

; (out-toplevel)
; eval es lento por que todo se le pasa como lista 
; internamente eval es el motor de lisp

; principalmente es un case 

; (defun eval (expr env)
; 	(cond ...
; 		((eql (car expr) 'quote) (cadr expr))
; 		...
; 		(t (apply (symbol-function (car expr))
; 			(
; 			mapcar #'(lambda (x)
; 				(eval x env))
; 				(cdr expr))
; 			)
; 		)
; 	)
; )

;los operadores especiales son para
; agregar condiciones al cond del eval

; coerce y compile pueden tambien pasar listas a codigo 


(print
(coerce '(lambda (x) x) 'function )
)
(print
(compile nil '(lambda (x)(+ x 2)))
)

; por lo general no se usan
; los tres convierten lineas a codigo en tiempo de ejecucion
; es costoso en ese momento, es facil en tiempo de compilacion


; uno define una macro diciendo como una llamada
; debe ser traducida, la traduccion es la macroexpancion
; la hace el compilador, el codigo creado por la macros
; se vuelve parte de tu programa como si lo hubieras tecleado


; en lugar de definir el valor de la llamada
; define su traduccion
(nl)
(defmacro nil! (x)
	(list 'setf x nil)
	)
; una llamada a nil! se traducira como  (setf a nil)
; antes de eluarse o compilarse
(print (nil! x))
(print x)

; para testear una amcro hay que ver su expancion
(print (macroexpand-1 '(nil! x)))

; una llamada a macros expande y llama mas macros hasta que no queden
; son solo funciones que transforman expresiones

; backquote ` (es la coma de segmentos de codigo de github)
(print
`(a b  c)
)
; usada sola son equivalentes 
; ` y ' protegen la lista de la evaluacion

; con backquote usar coma , o coma-arroba ,@ para reevaluar

(setf a  1 b 2)
(print
`(a is ,a b is ,b )
)

; coma permite reevaluarlos
(defmacro nil! (x)
	`(setf ,x nil)
	)

; ,@ separa los argumentos de la lista y los inserta

(Setf lst '(a b c))
(print
`(lst is ,lst)
)
(print
	`(sus elementos son ,@lst)
	)

; supongamos que queremos crear una macro while

(defmacro while (test &rest body)
	`(do ()
		((not , test))
		,@body
		)
	)
(nl)
; expandiendo se ve el comportamiento :=
(print (macroexpand-1 '(while x)))
(print (macroexpand-1 '(while (< x 10))))
(print (macroexpand-1 '(while (< x 10)
		(princ x)
		(incf x)
		)))
(nl)
(let ((x 0))
	(while (< x 10)
		(princ x)
		(incf x)
		)
	)

; problemas con macros

; macro mal definida
(defmacro ntimes (n &rest body)
	`(do ((x 0 (+ x 1)))
		((>= x ,n))
		,@body
		)

	)
(nl)

(print(macroexpand-1 '(ntimes 5)))

; si la macro es llamada en un lugar que usa sus variables internas
; puede haber errores
(print
(let ((x 10))
	(ntimes 5
		(setf x (+ x 1))
		)
	x
	)
)
; deberia incrementar 5 y devolver 15
;devuelve 10 por que existe x afuera y la macro lo usa
; la macro es equivalente a esto
(print
(let ((x 10))
	(DO ((X 0 (+ X 1))) ((>= X 5))
		(setf x (+ x 1))
		)
	x
	);devuelve 10
)

; incrementa a la x dentro del do, no la de let


; la solucion mas general es no usar simbolos
; que puedan ser capturados, mejor usamos gensyms
; al no estar registrados esto no puede pasar

(defmacro ntimes(n &rest body);mal
	(
		let ((g (gensym)))
		`(do ((,g 0 (+ ,g 1)))
			((>= ,g ,n))
			,@body
			)


		)

	)
; esta macro aun es suceptible a multiples evaluaciones
; como el primer argumento esta insertado en el do
; sera evaluado en cada iteracion
; esto se ve si hay side-effects
(print
(let ((x 10))
	(ntimes 5
		(setf x (+ x 1))
		)
	x
	)
);ya devuelve 15 pero aun esta mal escrita


(let ((v 10))
	(ntimes (setf v (- v 1))
		(princ ".")
		)
	)


(print (macroexpand-1 `(let ((v 10))
				(ntimes (setf v (- v 1))
					(princ ".")
					)
				)
	)
)

(print (macroexpand-1'(ntimes (setf v (- v 1))
					(princ ".")
					)
))


; (LET ((V 10)) 
; 	(
; 		DO ((#:G3236 0 (+ #:G3236 1))
; 			) 
; 		((>= #:G3236 (SETF V (- V 1))))
; 		 (PRINC "."))  
; 	) 
;

;en las iteraciones se comparan las variables  contra #:GXXXX
; no contra 9, 8,7...

; esto se previene pasando la variable a otro gensym

(defmacro ntimes (n &rest body)
	(let ( 	(g (gensym))
			(h (gensym))
			)
	`(
		let ((,h ,n))
		(do ((,g 0( +,g 1)))	
			((>= ,g ,h))
			,@body
			)


		)

		)
	)
(print
(let ((x 10))
	(ntimes 5
		(setf x (+ x 1))
		)
	x
	)
)

(print "ya funciona")
; siempre se deben usar gensyms en variables de side-effects
(pprint (macroexpand `(let ((v 10))
				(ntimes (setf v (- v 1))
					(princ ".")
					)
				) 
	)
)
(nl)
(pprint (macroexpand-1'(NTIMES (SETF V (- V 1)) (PRINC "."))
					
))
(nl)

; (LET ((V 10)) 
; 	(LET ((#:G3242 (SETF V (- V 1))))
; 		(DO ((#:G3241 0 (+ #:G3241 1))) 
; 			((>= #:G3241 #:G3242)) 
; 			(PRINC ".")
; 			)
; 		) 
; 	)

; (LET ((V 10)) 
; 	(
; 		DO ((#:G3236 0 (+ #:G3236 1))
; 			) 
; 		((>= #:G3236 (SETF V (- V 1))))
; 		 (PRINC "."))  
; 	) 
;

(pprint (macroexpand-1 '(cond (a b)
(c d e)
(t f))))

; en clisp solo hay macroexpand-1, hay que usar walkers(?)
; para construir un expansor multiple
; por el momento copypasteare


; setf!!!!
(defmacro cah (lst) 
	`(car ,lst)
	)


(print
(let ((x (list 'a 'b 'c)))
	(Setf (cah x) 44)
	x
	)
)
; es facil usar setf por fuera, pero por dentro de la macro
; es mas dificil

; (defmacro incff(x &optional (y 1))
; 	`(setf ,x (+ ,x ,y)); ni siquiera me lo permite
; 	)
; (pprint (macroexpand-1(incff 2 )))

(define-modify-macro our-incf (&optional (y 1))
	+
	)

; (pprint (macroexpand-1(our-incf 1)));? ni idea
; al parecer debe ir aqui el setf
; (our-incf 1 )
(define-modify-macro appendif (val)
	(lambda (lst val)
		(append lst (list val))
		)
	)
; (SETQ LST ((LAMBDA (LST VAL) (APPEND LST (LIST VAL))) LST 'D)) 



(print
(let ((lst '(a b c )))
	(appendif lst 'd)
	lst
	)
)

(print(macroexpand '(appendif lst 'd)))




(nl)
(nl)
(print(macroexpand '
; ( let ((x 1))
(our-incf x  22) 
; x)
)
)
; (SETQ X (+ X 22)) 


; define-modify-macro al parecer internamente genera un setq
; sin que nosotros lo debamos declarar
; supongo que necesito practica para comprenderlo
(nl)
(print
(loop for x = 8 then (/ x 2)
until (< x 1)
do (princ x))
)


(defmacro as (tag content)
	`(format t "<~(~a~)>~a</~(~a~)>" ',tag ,content ',tag)
	)
(print (as center "asd"));:O
; no se como define python las etiquetas
; pero si es mas dificil que una macro
; entonces lisp gana






