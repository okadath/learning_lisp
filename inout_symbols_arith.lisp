(defun nl() (format t "~%"))
(setf path (make-pathname :name "myfile.txt"))
(setf str (open path :direction :output :if-exists :supersede))

; y escribe en el archivo myfile.txt
(format str "algo~%")

; en algunas implementaciones no aparece nada hasta cerrar el stream
(close str)


(setf str (open path :direction :input))
(print
(read-line str)
)
(close str)

; este garantiza el cierre del stream
( with-open-file ( str path :direction :output
:if-exists :supersede)
(format str "Something~%"))

(defun pseudo-cat (file)
	(
		with-open-file (str file :direction :input)
		(
			do ((line (read-line str nil 'eof)
			(read-line str nil 'eof))
			)
			((eql line 'eof))
			(format t "~A~%" line)
		)
	)
)
; imprime el contenido de un archivo en la consola :O
(pseudo-cat path)


; lee una expresion completa ()
; (read)

(prin1 "hello")
(princ "hello")
; prin1 es salida para programas y princ para personas
; [1]> (prin1 "hello")
; "hello"
; "hello"
; [2]> (princ "hello")
; hello
; "hello"


; format
;  ~s imprime como prin1
(nl)
(format t "~s ~a " "z" "z")
; [3]> (format t 
; "~s ~a" "z" "z")
; "z" z
; NIL
(nl)
; format ~F:

; 1. The total number of characters to be printed. Defaults to the exact
; length of the number.
; 2. The number of digits to print after the decimal. Defaults to all of them.
; 3. The number of digits to shift the decimal point to the left (thereby
; effectively multiplying the number by 10). Defaults to none.
; 4. The character to print instead of the number if it is too long to fit in
; the space allowed by the first argument. If no character is specified, an
; over-long number will be printed using as much space as it needs.
; 5. The character to print to the left before the digits start. Defaults to a
; blank.

(format t " ~10,2,0,'*,' F" 26.21875)
(nl)
(format t " ~,2,,,F" 26.21875)
(nl)
(format t " ~,2F" 26.21875)

(print
(read-from-string '"a")
)


(nl)
(nl)
(nl)

; ===========================================================
; ===========================================================
; ===========================================================
; ===========================================================


; symbols

(print
(symbol-name 'abc)
	)
(print
(eql 'aBc 'AbC)
)
(print
; pueden usarse cualquier simbolo
( list ' |L i s p 1.5| '|| '|abe| '|ABC|)
	)

; las barras solo indican que es un simbolo
; por eso no aparecen en el ultimo

(print (symbol-name '|a b c| ))


; todos los simbolos tienen una  lista de propiedades plist
; casi no se usan
(print
(get 'alizarin 'color)
)
(setf (get 'alizarin 'color) 'red)

(print
(get 'alizarin 'color)
)

(print (symbol-plist 'alizarin))

; los simbolos por default se agregan al paquete common-lisp-user
; con intern los agregas al paquete X
; ( intern "RANDOM-SYMBOL")

; los simbolos uninterneds son gensyms

; paquetes, me parece que es como python o java
; los podemos llamar como math:fft
; (defpackage "MY-APPLICATION"
; (:use "COMMON-LISP"); "MY-UTILITIES"); usa estos dos
; (:nicknames "APP")
; (:export "WIN" "LOSE" "DRAW"));mis simbolos

; (in-package my-application)




; los simbolos en keywords siempre se evaluan a si mismos 
; y pueden ser accedidos como :x

; estos se usan para usar variables en paquetes con seguridad

(defun noise (animal)
(case animal
(:dog :woof)
(:cat :meow)
(:pig :oink)))

(print(noise :dog))




; ===========================================================
; ===========================================================
; ===========================================================
; ===========================================================
; Numbers

(print (mapcar #' float '(1 2/3 .5)))


; devuelve los restos pero aqui print no lo imprime
(print (truncate 1.3))
(print(floor 1.5))
(defun our-truncate (n)
(if (> n 0)
(floor n)
(ceiling n)))

; por default si esta en .5 la mayoria de los lenguajes no redondean
; devuelven el par mas cercano :O
(print
(mapcar #' round '(-2.5 -1.5 1.5 2.5))
)

; signum devuelve el signo del numero
; (* (abs x) (signum x)) =x

(print
	(mapcar #' signum '(-2 -0.0 0.0 0 .5 3))	
	)

(print (= 1 1.0))
(print (eql 1 1.0))


; < (less than) , <= (less than or equal), = (equal), 
; >= (greater than or equal), > (greater than), /= (different)


; (<= w x y z) es igual que (and (<= w x) (<= x y) (<= y z ) )


; expande las combinaciones por que compara si 2 son diferentes
; (/= w x y z) 
; =
; (and (/= w x) (/= w y) (/= w z)
; (/= x y) (/= x z) (/= y z ) )


(print ( list (minusp -0.0 ) (zerop -0.0 )(plusp 1.0) ))

(print ( list (max 1 2 3 4 5) (min 1 2 3 4 5)))

(setf  x 4)
(incf x 5)
(print x)
(setf x (+ x 3))
(print x)
(decf x 4)
(print x)
(setf x (- x 3))
(print x)

; * multiplica, si no hay argumentos devuelve 1

; (/ n ) es igual a (/ 1 n)
(print (/ 3))
; (- x y z) es igual a (- (- x y) z) x-y-z
; lo mismo con la divicion
(print (- 4 1 ));4-1
(print (/ 365 12));devuelve un ratio
; hay que castear para los decimales
(print (float 365/12))
(print (expt 2 5 ));x**n (expt x n)
(print (log 32 2 )); logn x (log n x)
(print (exp 2)); E**x (exp x )
(print (log 7.389056)) ;loge x
(print (expt 27 1/3))
(print (sqrt 4))
(print ( let ((x (/ pi 4 ) ) )
( list ( sin x) (cos x) ( tan x ) ) ))
; asin acos atan  entre -1 y 1 dan reales
; sinh cosh tanh y asinh acosh atanh

; al parecer la potencia se ha multiplicado 
; por un millon desde que se imprimio el libro a mayo/2020
; 536870911

(print (values most-positive-fixnum most-negative-fixnum))

(print 
(typep 1 'fixnum)
)

(print
(typep (1+ most-positive-fixnum) 'bignum)
	)
























