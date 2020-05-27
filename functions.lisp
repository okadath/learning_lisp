(defun nl() (format t "~%"))
(print
(fboundp '+)
)

(print (symbol-function '+))

(setf (symbol-function 'add2) #' (lambda (x) (+ x 2)))
(print (add2 1))

























