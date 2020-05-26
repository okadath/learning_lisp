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













