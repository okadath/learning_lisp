(defun nl() (format t "~%"))
;bloques
(print 
		(progn 
			(format t "a")
			(format t " b")
			(+ 11 12)
			)
	)
;block tambien trae un return

(print
	(block head
	(format t "aqui")
	(return-from head 'idea)
	(format t "no se evalua")
		)
	)

(print 
	(block nil
		(return 27)
		)
	)
;los iteradores internamente hacen block's con nil
;asi que podemos usar retunr internamente
(print 
	(dolist(x '(a b c d e ))
		(format t "~a "x)
		(if (eql x 'c)
			(return 'done)
			)
		)
	)


(defun foo()
		(return-from foo 27)
		)
(print(	foo)
	)
(nl)
;;rara vez se usa tagbody, es como un goto
(tagbody 
	(setf x 0)
	top
	(setf x (+ x 1))
	(format t "~a " x)
	(if (< x 10)(go top))
	)
(nl)
(print
;;crea un nuevo contecto lexico
;; las variables de afuera no existen
(let ((x 7) (y 2))
	(
		format t "numero"
		)
	(+ x y)
	)
)
;; las lambdas pueden ser equivalentes a let
;; el let puede verse como un llamado a la lambda
(nl)

(print
	((lambda(x y)
		(format t "numeros")
		(+ x y )
		)
		7 2 
	)
)
;por default todo lo de un let lleva nil
(print
(let (x y)
	(list x y))
)
;bind esta raro, me aprece que los empareja
(print
( destructuring-bind (w (x y y) . z) ' ( a (b c c) d e)
( list w x y z))
	)
;condicionales
;;if es el mas sencillo, los siguientes se basan en el 
;;el contrario de when es unless
(print
	(when (oddp 5 );es equivalente a if()(progn ...)
(format t "Hmm, t h a t ' s odd.")
(+ 5 1)
	)
	)

;todos se basan en cond, el cual ya trae progn's
; ademas de multiples casos 


(defun our-member (obj 1st)
	(if (atom 1st)
		nil
		(if (eql (car 1st) obj)
			1st
			(our-member obj (cdr 1st))
		)
	)
)

(defun our-member (obj 1st)
	(cond 
		;;cond usa casos de condiciones
		;;y en base de ellas 
		;;se usa con multiples if's, como swich-case
		;;las evalua hasta que alguna devuelva true
		((atom 1st) nil)
		((eql (car 1st) obj) 1st)
		(
			t (our-member obj (cdr 1st))
		)
	)
)
;;tambien hay un case 
(defun month-length (mon)
	(case mon
		((jan mar may jul aug oct dec) 31)
		((apr jun sept nov) 30)
		(feb ( if (leap-year) 29 28))
		(otherwise "unknown month");debe ser t o otherwise
	)
)

;;do, es el mas basico, 
;tiene el mismo problema de let de multiples variables
;para eso hay do*
(nl)
;; valor inicial incremento

;;condicion 
;;update
(do* ((x 1 ( + x 1))(y x x))
	((> x 5))
	(format t " (~a ~a)" x y)

	)
(nl)
(dolist (x ' ( a b c e d ) 'done); 'done por default es nil
													; es evaluado al termianr el ciclo
(format t "~A " x))

(nl)
(dotimes (x 5 x)
(format t "~A " x))

(nl)
;;mapc es como mapcar pero con listas procesadas paralelamente
;; se le pasa una funcion y siempre devuelve el 2do elemento
;;esto es apra evitar side-effects
(print
	(mapc #' (lambda (x y)
		(format t " ~a ~a " x y)
		)
		'( hip flip slip)
		'(hop flop slop)

		)
	)



(defun fact(n)
	(do ( 
				(j n (- j 1))
				(f 1 (* j f )) 
			)
	((= j 0) f ) 
	) 
)

(print (fact 45))
;;regresa multiples valores
; (values 'a nil ( + 2 4))
;  regresa los valores no importa cuantas funciones lo llamen
; ((lambda () ((lambda () (values 1 2 ) ) ) ) )
;excepto si solo se espera un valor
; ( let ((x (values 1 2 ) ) )
; x)
; si no trae valore spor default devuelve nil

; para recibir multiples valores usamos:
(print
(multiple-value-bind (x y z) (values 1 2 3)
( list x y z))
)
(print
	;;si no hay valor devuelve nil
(multiple-value-bind (x y z) (values 1 2 )
( list x y z))
)
(print
(multiple-value-bind (s m h) (get-decoded-time)
(format nil "~A:~A:~A" h m s))
)

(print
	;;pasa muchos valores a otra funcion
	( multiple-value-call #' + (values 1 2 3))
	)
(print
	;es lo mismo que arriba pero pasandole #'list
( multiple-value-list (values ' a ' b ' c))
	)



; lanzar errores
; (progn
; ( error "Oops!")
; (format t "After the error."))



(defun super ()
(catch 'abort;us auna etiqueta y luego bloque como progn
(sub)
(format t "We'll never see t h i s . " ) ) )
(defun sub ()
(throw ' abort 99));ejecuta el codigo de la etiqueta

(print
(super)
)

( setf x 1)
(catch ' abort
(unwind-protect;protege del catch y sigue con el codigo
(throw 'abort 99)
(setf x 2)))

(print x)

