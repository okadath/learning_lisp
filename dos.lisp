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
			progn 
			(format t "~a ~a ~%" i (* i i))
			(show_squares2 (+ i 1) end)
			)
		)
	)
(nl)
(print(show_squares2 1 5))

(defun our_length (lst)
	(let ((len 0))
		(dolist (obj lst)
			(setf len (+ len 1))
			)
		len
		)
	)



(print (our_length '(a b c d)))

(
	

	)










