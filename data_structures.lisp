(setf arr (make-array '(2 3) :initial-element nil))
(print arr)
; (setf arr2 (make-array '(16 2048) :initial-element nil))
; (print arr2)

(print
	(aref arr 0 0)
	)

(setf (aref arr 0 0) 'b)
(print arr)

(setf vec (make-array 4 :initial-element nil))
(print vec)

(print ( setf aaa ( vector "a" 'b 3) ))
(print (svref aaa 1))


(print (sort "elbow" #' char<))
(print(aref "abc" 1))
(print( char "abc " 1))

(print
(let ((str (copy-seq "merlin")))
	(setf (char str 3 ) #\k)
	str)
)
(print (string-equal "fred" "Fred")); ignora las mayusculas

(print
(format nil "~a or ~a" "asd" "zxc");genera cadenas
)
;;si le agregamos el tipo string a concatenate devuelve una cadena
(print (concatenate 'string "not " "to worry"))

; el tipo sequence incluye listas, vetores y strings
; y se pueden usar las mismas funciones sobre ellos
; remove length subseq reverse sort every some

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
(print (mirror "assa"))
; elt trabaja con todas las estructuras pero es lento
(print(elt '(a b c ) 1))
; los vectores permiten acceso aleatorio
; por eso son mas rapidos


(print (position #\a "fantasia"))
(print(position #\a "fantasia" :start 3 :end 5))
(print (position #\a "fantasia" :from-end t))
(print ( position ' a ' ( ( c d) (a b)) :key #' car ))
; si tratas de comparar una lista usa equal
(print ( position' ( a b) ' ( ( a b) (c d ) ) ))
(print ( position' ( a b) ' ( ( a b) (c d ) )  :test #' equal))
;;poscisicon del 1er elemento en el que el valor sea mayor que 3
(print (position 3 ' ( 1 0 7 5 ):test #'<))
(print (position-if #'oddp ' ( 2 3 4 5)));condiciinal
(print (find #\a "cat"))
(print ( find-if #' characterp "ham"))
; (print 
; 	(
; 		(find-if #' (lambda (x)(eql (car x) 'complete))
; 			'(a b c))
; 		)

; 	)


; (print (find 'complete '(complete a a a) :key #' car))

(print (remove-duplicates "abracadabra"))

; reduce toma una funcion de dos valores y la evalua con muchos

; (reduce # ' fn ' ( a b c d)) 
; (fn (fn (fn ' a 'b) ' c ) 'd)

(print (reduce #' intersection '(( b r a d s)( b a d) ( c a t))))

(defstruct point x y)
(setf p (make-point :x 0 :y 0))
(print (point-x p))
(setf (point-y p) 2)
(print p)
(print (point-p p))
(print (typep p 'point))

(defstruct polemic
	(type
		(progn 
			(format t "que tipo sera?")
			(read)
			)
		)
	(effect nil)
	)
; (make-polemic);solo corre bien desde clisp
(
	defstruct	(point (:conc-name p);en ves de usar point usas p
						; en las llamadas a funciones
						(:print-function print-point))
				(x 0)
				(y 0)
	)
(defun print-point (p stream depth)
	(format stream "#<~a, ~a>" (px p) (py p))
	)
(print
(make-point)
)
(defstruct 	
	(node (:print-function
				(lambda (n s d)
					(format s "#<~A ~a ~a >" (node-elt n)(node-r n) (node-l n) - )
				)
			)
	)
	elt (l nil) (r nil)
)

(print
(make-node :elt 'a :l 2 :r 3 )
)
;aqui va el resto de arboles binarios de bsuqueda :v

(print (setf ht (make-hash-table)))

(print (gethash 'color ht))

(setf (gethash 'color ht) 'red);asigna un valor a la clave color
(print (gethash 'color ht));obtiene el valor


(setf bugs (make-hash-table))
;;push es una abreviacion de setf ????????
(push "no toma keywords" (gethash #' member bugs))
(print bugs)

(setf fruit (make-hash-table))
(setf (gethash  'apricot fruit)t)
(print fruit)
(print (gethash 'apricot fruit ))

(remhash 'apricot fruit)
(print fruit)
(setf (gethash 'shape ht ) ' spher
			(gethash 'size ht ) ' giant
		)

(maphash #' (lambda (k v)  
							(format t " ~A =~a ~%" k v)
		)ht

)
(print
(make-hash-table :size 5)
)
;; podemos pasarle eq, equal, or equalp
(setf writers (make-hash-table :test #'equal))

(setf (gethash '(ralph waldo emerson) writers) t )

(print writers)








