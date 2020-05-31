(defun nl() format "~%")
;;; lectura es el apth de donde se leera
;;; escritura donde creara el nuevo archivo
(defun copytextfile (lectura escritura )
	
		(setf cadena (open lectura :direction :input)) 
		(setf creado (open escritura :direction :output :if-exists :supersede))
		; fragmento de codigo del libro para leer todo
		(with-open-file (str lectura :direction :input)
			(
				do ((line (read-line str nil 'eof)
				(read-line str nil 'eof))
				)
				((eql line 'eof))
				(format creado "~a~%" line)
			)
		)
		(close cadena)
		(close creado)
	)
; (defmacro creapath (sim text)
; 	;;;era , solo evaluado, no ',
; 	;;;creo que lo que involucre solo , debe ser funcion
; 	;;; y lo que involucre ', macro 
; 	;olvidalo, no capcho al 100% como jalan
; 	`(setf ,sim (make-pathname :name ,text))
; 	)

; ============ con funciones
(defun creapath (sim text)
	(setf sim (make-pathname :name text))
	(print sim)
	(print text)
	)

; (print(macroexpand (creapath a "myfile.txt")))
(let (lee escribe)
; (creapath lee "myfile.txt")
; (creapath escribe "3.txt")
(copytextfile (creapath lee "myfile.txt") (creapath escribe "3.txt"))


	)


; ==================================
; con macros
(defmacro creapath (sim text)
	;;;era , solo evaluado, no ',
	;;;creo que lo que involucre solo , debe ser funcion
	;;; y lo que involucre ', macro 
	;olvidalo, no capcho al 100% como jalan
	`(setf ,sim (make-pathname :name ,text))
	)


(print(macroexpand (creapath a "myfile.txt"))) 
(creapath lee "myfile.txt")
(creapath escribe "3.txt")
(copytextfile lee escribe)


; crea folders o archivos
; (ensure-directories-exist "/home/okadath/Desktop/lisp/django/a/")
; path
; (print *default-pathname-defaults*)
; (print *load-truename*)
; (print *load-pathname*)

; (print
; (ext:cd)
; )



