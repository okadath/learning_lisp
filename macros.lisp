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























