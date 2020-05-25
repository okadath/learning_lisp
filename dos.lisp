(defun nl()
	(format t "~%")
	)

; programacion funcional
; se basa en devolver valores, mas que en modificar cosas
;son llamadas por los valores que devuelven
;no por los efectos colaterales


(setf lst '( c a r a t))
(print lst)
(remove 'a lst)
(print lst); no lo modifico :O

(setf x (remove 'a '( c a r a t)));asi se hace en lisp usualmente
(print x);ya modificado :O

; programacion funcional significa prevenir setf 
(nl)
(defun show_squares (start end)
	(do ((i start (+ i 1) ))
		((> i end) 'done);con esto termina
		(format t "~a ~a ~%" i (* i i))
		)
	)
(print(show_squares 2 5))


(defun show_squares2(i end)
	(if (> i end)
		'done;(+ 1 2);evalua esto
		(
			progn ;toma cualquier numero de expresiones
			; las evalua en orde y devuelve el valor de la ultima

			(format t "~a ~a ~%" i (* i i))
			(show_squares2 (+ i 1) end)
			)
		)
	)
(nl)
(print(show_squares2 1 5))
;itearaciones 
(defun our_length (lst)
	(let ((len 0))
		(dolist (obj lst);itera a traves de los elem. de la lista
			; 
			(setf len (+ len 1))
			)
		len
		)
	)



(print (our_length '(a b c d)))

(defun suma_en_lista(lst)
	(let ((len 0))
		(dolist (obj lst);obj es una referencia al elemento i
			;de la lista, como los iteradores en python
			(setf len (+ len obj))
			)
		len
		)
	)
(print (suma_en_lista '(1 2 3  4 5)))


; version iterativa
(defun our_length_recursive (lst)
	(if (null lst)
		0
		(+ (our_length_recursive (cdr lst)) 1)
		)
	)
; pero no es tail-recursive asi que no es eficiente
(print (our_length_recursive '(1 2 3 4)))



; funciones
; son de 1ra clase , 
; function fuciona como quote, son operadores especiales
; no tenemos que quotar el argumento
(print (function +))


; hasta aqui hemos manejado objetos que se muestran como son escritos
; las funciones no son asi,
; son codigo maquina y pueden tener cualquer representacion
; el simbolo de funcion es #' igual que el de quote es '
; sharp-quote
(print #' +)
; las funciones se pueden pasar como argumentos
(print
(apply #' + '(1 2 3 4.5)); apply aplica una funcion a una lista
)

; puede recibir cualquier numero de argumentos
(print(apply #' + 1 2 '(3 4 5.5)))

(print
(funcall #' + 1 2 3 ))
;lambdas
; lambda es un simbolo para definir funciones
(print
(lambda (x) (+ x 100))
)
(print
	(
		(lambda (x) (+ x 100) );definimos la lambda
		 2 ;la evaluamos con 2
	);se necesita este parentesis para evaluarla

)
; defun le define un nombre a una funcion pero no es necesario
; 
(print
	(
		(lambda (x y z)
			(+ x y)
		)
		2 3 5
	)
)
; es equivalente, permite usar funciones sin nombrarlas
(print
	(funcall #' (lambda(x) (+ x 100))
		10
	)
)
; tipos, es como python

(print(typep 27 'integer))



(defun sum(n)
	(let ((s 0))
		(dotimes (i n s )
			(incf s i)
			)
		)
	)
(print (sum 3))


; # ejercicios

(cons 'a (cons 'b '(c) ))
(cons 'a (cons 'b (cons 'c nil)))
(cons 'a '(b c))

(defun 4to (x)
	(car(cdr(cdr(cdr x ))))
	)
(print (4to '(a b c d )))


(defun mas_grande(a b)
	(if(> a b)
		(print a)
		(print b)
		)

	)
(mas_grande 5 5)

(defun enigma (x)
	(and 	(not (null x));siempre es nil
		; and se detiene con nil entonces cancela y regresa nil
				(or (null (car x))

						(enigma (cdr x))
				)
	)
)

(defun mystery (x y)
	(if (null y)
		nil
		(if (eql (car y) x);si la cabeza de y es x
			0
			(
				let ((z (mystery x (cdr y))))
				(print y)
				(+ z 1);siempre es true
			)
		)
	)
)
(print(mystery 3 '(1 2 1 1 2 3 1)))
(print

(car (car(cdr '(a (b c)d))))
)
(print(or 13 (/ 1 0)))

(print (if #' list 1 nil))
(nl)

(defun es_lista( x)
	(dolist (obj x)
		(if (listp obj) 
			(print obj) 
			0

			)
	)
 )
(print (es_lista '(1 (1) ((2)) ) ) )



(defun puntos_iter(x)
	(
		do( 
				(i 0 (+ i 1))
			)
			(( >= i x) 'done)
			(format t ".")
	)

)
(nl)
(puntos_iter 3)
(defun puntos_recur(x)
	(if (eq x 0)
		0
		(progn;con esto podemos hacer ifs :O
			(puntos_recur (- x 1))
			(format t ".")

		)
	)
)
(nl)
(puntos_recur 4)

(defun numero_veces_iter(  a x)
	
	(let ((countt 0)) 
		(
			dolist (obj x)
			; (print obj)
			(
				if(eql  a obj)
					(progn
						(setf countt (+ countt 1))
						; (print countt)
					) 
			)
		)
		countt
	)
)

(print (numero_veces_iter 1 '(1 1 3 1 2 4 1)))


(defun numero_veces_recur (x y)
	(if (null y)
		0 ;base de la recursion
		(
			let ((z (numero_veces_recur x (cdr y)))) 
			(if (eq (car y )x)
				(+ z 1) 
				z
			)
		)
	)
)
(nl)
(print (numero_veces_recur 1 '(1 1 3 1 2 4 1)))


(defun summit ( 1sst )

	(setf x (remove nil 1sst))
	; (print lsst)
	(apply #' +  x)
)
(setf asd '( 55 () 1  3 () 1) )
(print (summit  asd ))

(defun summit2 (lst)
	(
		let ((x 0))
		(progn
			(dolist (ob lst)
			(
				if  (not (null ob))
				(setf x (+ x ob))   
				)
			)
		)x
	)
)
(nl)
(print "ultimo")
(print (summit2  asd ))




