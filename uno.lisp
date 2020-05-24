(list '(+ 2 1) (+ 2 1))
(cons 'a '(b c d))
(cdr  '   (a b c))
(listp '(a b c))

(defun sum(n)
	(let((s 0))
		(dotimes (i n s)
			(incf s i)
		)
	)
)
; (sum (1))

(defun addn(n )
	#'(lambda(x)
		(+ x n)
		)
	)

(print (addn  3 ))
(format t "~%")
;recursion, verifica si obj esta en lst 
(defun ourmem (obj lst)
  (if (null lst)
	nil
	(if (eql (car lst) obj)
	  lst
	  (ourmem obj (cdr lst)))))

(ourmem 'b '(a b c))
(format t "~a + ~a = ~a.~%" 2 3 (+ 2 3))

;escribe string y lee
(defun askem (string)
	(format t "~a" string)
	(read) 
	)

; (askem "edad?")

;asigna e imprime
(let ((x 1) (y 2))
	(+ x y)
	(format t "~a~%" (+ x y)) 
	)
;mi funcion de impresion
(defun print_num (a)
	(format t "~a~%" a))
;asignacion de variables
(let ((x 1) (y 2))
	(print_num (+ x y)))

;lee y asigna mas avanzado
(defun ask_number ()
	(format t "dame un numero. ")
	(format t "~%")
	(let ((val (read) ))
	(if (numberp val);el predicado es un numero?
		val;aqui va sin parentesis por que si no lo evalua
		(ask_number);-2; sin parentesis no evalua la funcion
		)
	)
	)
;imprime la llamada a la funcion
; (print_num (ask_number))

;variables globales


(defparameter *glob* 99)
(defconstant limit (+ *glob* 1))
(format t "~a" '*glob*)
(format t "~a~%" limit)
(format t "~a" (+ *glob* 2)) 

;imprime nueva linea
(defun nl()
	(format t "~%")
	)
(nl)
;bound imprime si es variable global o no
;(variables lexicas o especiales)
(print_num(boundp '*glob*))
(print_num(boundp 'a))

(format t "~a" (+ *glob* 1))

(print (+ *glob* 2))
(nl)

(let ((a 42)(b 89))
	(print '(a b))
	(print(list a b))
	)
(nl)
;asignacion
(let ((n 10))
	(setf n 2)
	n
	(print  n)
	)
(nl)
; si no es una variable local la convierte en global
;siempre es mejor usar defparameters
(setf x (list 'a 'b 'c))
(print x)
;el primer operador puede ser una funcion
;si este es el caso el segundo operador sera insertado en el primero
(setf (car x) 'n)
(print x)
(setf x 'n)
(print x)
; (setf a b
; 	c d 
; 	e f)
; es igual que 
; (setf a b) 
; (setf c  d) 
; (setf e f)








