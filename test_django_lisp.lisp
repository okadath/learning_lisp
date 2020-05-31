(defun nl() format "~%")
;;; lectura es el apth de donde se leera
;;; escritura donde creara el nuevo archivo
(defun copytextfile (lectura escritura )
	
		(setf cadena (open lectura :direction :input)) 
		(setf creado (open escritura :direction :output :if-exists :supersede))
		(format creado "~a" (read-line cadena))
		(close cadena)
		(close creado)
	)
(defmacro creapath (sim text)
	;;;era , solo evaluado, no ',
	;;;creo que lo que involucre solo , debe ser funcion
	;;; y lo que involucre ', macro 
	;olvidalo, no capcho al 100% como jalan
	`(setf ,sim (make-pathname :name ,text))
	)
; (defun creapath (sim text)
; 	(setf sim (make-pathname :name text))
; 	)

(print(macroexpand (creapath a "myfile.txt")))
(creapath lee "myfile.txt")
(creapath escribe "3.txt")
(copytextfile lee escribe)
