(defun nl()(format t "~%"))

(defun	our_listp (x)
	(
		or (null x)(consp x);el predicado es cons?
	)
)

(print (our_listp 1))
(print (our_listp '()))
(print (our_listp '(1)))


(defun es_atom(x)
	(not (consp x))
)

(nl)
(print (es_atom 1))
(print (es_atom '()))
(print (es_atom '(1)))
;llamar 2 veces acons genera 2 espacios de memoria distintos
(eql (cons ' a nil ) (cons ' a nil ) )


(setf x(cons 'a nil))
;en common lisp eq es una funcion y eql es un comparador logico
(print (eql x x));eql es si son el mismo objeto
(print (equal x (cons 'a nil)));equal es si imprimen lo mismo

(defun our_equal (x y)
	(or (eql x y);
		(and(consp x)
			(consp y)
			(our_equal (car x )(car y))
			(our_equal(cdr x)(cdr y)) 
			)
		)

	)
(nl)
(print "equal")
(print (our_equal '(a b c) '(a b c) ))
(print (our_equal '(a b c) '( b c) ))
(print (our_equal 1 1))
(print (our_equal 1 2))

; cuando uno asocia una variable a otra
; lo unico que asocia son punteros
(setf x 	'( a b c )
	y (copy-list x));copy list crea nuevos cons
(print x )
(print y)

(defun our-copy-list(lst)
	(if (atom lst)
		lst
		(cons 	(car lst)
				(our-copy-list(cdr lst))
			)
		)
	)

(defun our-copy-tree(tr)
	(if (atom tr)
		tr
		(cons 	(our-copy-tree(car tr))
				(our-copy-tree(cdr tr)) 
			)
		)
	)


(setf x 	'( a b c )
	y (our-copy-list x));copy list crea nuevos cons
(print x )
(print y)
(print
(append '(a b) '(c d) '(e))
)

(print ( nth 0 '( a b c)));da el numero en esa posicion

(print (nthcdr 1 '(a b c)));da el cdr en esa pocision

(defun our-nthcdr (n lst)
	(
		if (zerop n);devuelve T si es igual a 0
		lst
		(our-nthcdr(- n 1)(cdr lst))
	)
)
(print (our-nthcdr 1 '( a b c)))

(print(last '(a b c)))
(print (car (last '(a b c))))
(print(second '(a b c)))
(print(nth 1 '(a b c)))
; (print(cadddr '(a b c ( a 1))))
;mapea la funcion en la lista y devuelve la lista
(print (mapcar #' (lambda (x)(+ x 10))'(1 2 3)))
(print
	(mapcar #' list '(a b c) '( 1 2 3 4))
	)
(print
(maplist #' (lambda (x)x)'(a b c) )
	)







