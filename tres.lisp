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
;mapcar se lo aplica a la lista
;maplist genera sublistas desde esa lista
;como si las recortara,sucesivos cdr's
(print
(maplist #' (lambda (x) x) '(a b c) )
	)

;substitute no trabaja en arboles
;subt si
(print (substitute 'y 'x '(and (integerp x)(zerop (mod x 2)))))
(print (subst 'y 'x '(and (integerp x)(zerop (mod x 2)))  ))


(defun our-subst(new old tree)
	(
		if (eql tree old )
		new 
		(
			if (atom tree)
			tree
			(
				cons (our-subst new old (car tree))
						 (our-subst new old (cdr tree))
				)
			)
		)
	)
	
(print (our-subst 'y 'x '(and (integerp x)(zerop (mod x 2)))  ))

;cubre todos los casos?

(defun len (lst)
	(if (null lst);(null)
		0;caso base
			; > (null (cdr '(a)))
			; T
			;o tambien se puede usar
			; (atom (cdr'(a)))
			; T
		(+ (len(cdr lst)) 1)
		)
	)
(print (len '(1 2 3 4 5 6 6)))

;regresa la parte de la lista que lo tiene
(print 
(progn
	(member 'b '(a b c))
	(member '(a) '((a) (z)) )
;keyword arguments, usan :, no importa el orden si hay mas de 1
	(member '(a) '((a) (z)) :test #'equal)
;key aplica la funcion antes de evaluar
	(member 'a '((a b) (z d)) :key #'car)
	)
)


(print
( funcall #' cdr '(1 2 3 4.5)); apply aplica una funcion a una lista
) ;funcall y #' son inversos

(print
(apply #' + '(1 2 3 4.5)); apply aplica una funcion a una lista
)

(print(;si queremos evaluar un predicado usamos member-if
	member-if #'oddp '(2 3 4)
	))

(defun our-member-if ( lst fn)
	(and 	(consp lst)
				(if (funcall fn (car lst)) 
					lst
					(our-member-if fn (cdr lst))
					)
		)
	)
(print(
	our-member-if '(2 3 4)  #' oddp 
	)
)

;adjoin es un cons condicional, solo lo agrega si no esta
;mismos keywords que member
(print 
	(adjoin 'b '(a b c))
	)
(print 
	(adjoin 'z '(a b c))
	)

;operaciones con sets

(print

	(progn ; no funciona usar progn si devuelve valores
		;solo si los imprime
		(union '(a b c)'(c b s) )
		(intersection '(a b c ) '(b b c))
		(set-difference '(a b c d e ) '(b e))

		)
	)



(print
	
	(length '(a b c));longitud de la lista
	)
	;copia aprte de la secuencia
(print	(subseq '(a b c d ) 1));desde el elemento e[1]
(print	(subseq '(a b c d) 1 2); desde e[1] hasta e[2], como en python
	)
(print(reverse '(a b c)));los invierte


(defun mirror (s)
	(let ((len(length s)))
		(and (evenp len);no acepta los nones :v
			(let (( mid (/ len 2)))
				(equal 	(subseq s 0 mid)
								(reverse (subseq s mid))
					)
				)
			)
		)
	)


(print (mirror '( a b b a)))
;sort es destructivo, por eficiencia destruye el arreglo 
;si eso es peligroso pasarle solo una copia
(print (sort '(0 2 1 3 8 ) #'>));ordena


(defun nthmost (n lst)
	(nth (- n 1)(sort (copy-list lst) #'>)
		)
	)
(print (nthmost 2 '(0 2 1 3 8 )))

; evalua toda la cadena con una condicion
; devuelve true si toda la cumple
(print (every #' oddp '(1 3 4)))
; devuelve true si alguno cumple la condicion
(print (some #' evenp '(1 2 3)))
; si se le pasan dos argumentos evalua uno sobre otro
; segun una condicion y devielve T  si se cumple
(print (every #' > '( 1 3 5 ) '(0 2 4)))


(setf x '(b))
(push 'a x);push inserta un nuevo car en al lista
(print x)
(setf y x)
(pop x);el pop saca el car de la lista
(print x)
(print y)


(defun our-reverse(lst)
	(let ((acc nil))
		(
			dolist (elt lst)
			(push elt acc)
			)acc
		)

	)
(print (our-reverse '(a b c)))
; pushnew solo inserta si el elemento no existe
(print
(let (( x '(a b )))

	(pushnew 'c x)
	(pushnew 'a x)
	)
)
; todo lo anterios son lista propias 
(defun proper-list? (x)
	(or (null x)
			(and 	(consp x)
						(proper-list? (cdr x))
				)
		)
	)

; podemos usar cons para estructuras
(print
(setf pair (cons 'a 'b)));usan la notacion punto
; es una lista puntada 
; (a.b) es solo una estructura de dos partes

(print '( a . (b .( c . nil))))

(print (cons 'a (cons 'b(cons 'c 'd))))

(print '(a . (b . nil)) )
(print '(a b) )
(print '(a .(b)) )
(print '(a b . nil) )

; assoc-lists, son lentas
; luce como los diccionarios de python
(setf trans '((+ . "add ")(- . "substract")) )
(print trans)

(print (assoc '+ trans ))
(print (assoc '* trans ))

(defun our-assoc (key alist )
	(
		and (consp alist)
				(let ((pair (car alist)))
					(if (eql key (car pair ))
						pair 
						(our-assoc key (cdr alist))
						)
					)

		)
	)
; assoc tiene los mismos keywords que member
; tambien hay un assoc-if
(print (our-assoc '- trans))

(setf min '((a b c) (b c)(c d)))

(defun shortest-path(start end net)
	(bfs end (list (list start)) net)

	)

(defun bfs (end queue net )
	(if (null queue)
		nil
		(
			let ((path (car queue)))
			(
				let ((node (car path)))
				(
					if (eql node end)
					(reverse path)
					(
						bfs end 
								(append (cdr queue) (new-paths 	path 
																								node 
																								net))
								net
						)
					)
				)
			)
		)
	)

(defun new-paths (path node net )
	(
		mapcar #' (lambda (n) (cons n path))
							(cdr (assoc node net )) 
		)
	)

(print (shortest-path  'a 'd min)) 
; los nodos asociados a cada nodo
(print
(cdr (assoc 'a min))
)






















