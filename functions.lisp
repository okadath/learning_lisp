(defun nl() (format t "~%"))
(print
(fboundp '+)
)

(print (symbol-function '+))

(setf (symbol-function 'add2) #' (lambda (x) (+ x 2)))
(print (add2 1))


(defun primo ( lst) (car lst ) )
(defun (setf primo) (val lst)
(setf (car lst) val)

)

(print (primo '(a b c )))

;; al definir una funcion la primera linea es documentacion
(defun foo()
	"documentacion bonita"
	x
	)
(print
(documentation 'foo 'function)
)


; las funciones con defun son globales, las locales usan label

;para funciones multiparametro hay que agregar &rest

(defun our-funcall(fn &rest args)
(aply fn args)
	)
; tambien hay parametros opcionales
(defun philos (thing &optional prop)
	(list thing 'is prop)
	)
; los argumentos por default son nil
(print (philos 'death))

; se le pueden agregar valores por default
(defun philos (thing &optional (property 'fun))
	(list thing 'is property)
	)

(print (philos 'death))


; los key parameters son mejores
 ; permiten mas valores opcionales

(defun keylist (a &key x y z)
	(list a x y z)
	)

(print (keylist 1 :y 2))
(print (keylist 1 :y 3 :x 2))


(defun single? (1st)
(and (consp 1st) (null (cdr 1st))))

(defun appendl (1st obj)
(append 1st (list obj)))

(defun map-int (fn n)
(let ((acc nil))
(dotimes (i n)
(push (funcall fn i) acc))
(nreverse acc)));nreverse es igual que reverse pero eficiente

(defun filter (fn 1st)
(let ((ace nil))
(dolist (x 1st)
(let ((val (funcall fn x)))
(if val (push val ace))))
(nreverse ace)))

(defun most (fn 1st)
(if (null 1st)
(values nil nil)
(let* ((wins (car 1st))
(max (funcall fn wins)))
(dolist (obj (cdr 1st))
(let ((score (funcall fn obj)))
(when (> score max)
(setf wins obj
max score))))
(values wins max))))

(print
(map-int #' identity 10)
)

(print
(map-int #'(lambda (x) (random 100))
10)
)


; filter retorna todos los no nil
(print
(filter #' (lambda (x)
(and (evenp x) (+ x 10)))
' ( 1 2 3 4 5 6 7))
)

(print
	(most #'length ' ( ( a b) (a b c) ( a ) ) ))
; closures

; When a function refers to a variable defined outside it, it's called a free
; variable. A function that refers to a free lexical variable is called a closure

; los closures pueden devolver diferente valor

(defun make-adder (n)
#'(lambda (x)
(+ x n)))

(setf add3 (make-adder 3))

(print (funcall add3 2))

(setf add27 (make-adder 27))

(print (funcall add27 2))

; los closures pueden compartir variables
(let ((counter 0))
	(
		defun reset ()
		(setf counter 0)
		)
	(defun stamp ()
		(Setf counter (+ counter 1))
		)

)
(print
	(list (stamp) (stamp) (reset) (stamp))
	)


(print (mapcar (complement #'   oddp)
'(1 2 3 4 5 6)))


(defun our-complement (f)
#'(lambda (&rest args)
(not (apply f args))))


(print (mapcar (our-complement #'   oddp)
'(1 2 3 4 5 6)))


; scope

; local variables - lexical scope
; special variables - dinamic scope

; Under lexical scope, a symbol refers to the variable that has that name in
; the context where the symbol appears. Local variables have lexical scope by
; default.
; local
( let ((x 10))
	(defun foo ()
		x
	)
)
(print (let ((x 20)) (foo)))

; en esta funcion x ya no es variable lexica
; con el scope dinamico 
(let ((x 20))
	(
		defun foo()
		(declare (special x))
		x
		)
	)

(print
	(let ((x 30))
		(declare (special x))
		(foo)
		)
	)
(setf x 90)
(print (foo))
; el scope dinamico es como varibles locales,
; se usa para setear valores temporalmente

; puede imprimir en cualquier base :OOOOOO
( let ( ( *print-base* 13))
(princ 12))
( let ( ( *print-base* 13))
(princ 10))



; compilacion
; permite compilar las funciones(+ rapidas?)
; la funcion sigue siendo exactamente igual excepto por este predicado
(defun foo(x)
	(+ x 1)
	)
(print (compiled-function-p #' foo))
(compile 'foo)
(print (compiled-function-p #' foo))

; solo no le podemos pasar a compile funciones con distinto
; contexto lexico, stamp o reset o let 
; en esos casos se deben poner las funciones en archivos, compilarlas
; y cargarlas, es mas por la implementacion, podria ser posible hacerlo


; The usual way to compile Lisp code is not to compile functions individ-
; ually, but to compile whole files with compile-f i l e . This function takes a
; filename and creates a compiled version of the source file—typically with the
; same base name but a different extension. When the compiled file is loaded,
; compiled-f u n c t i o n - p should return true for all the functions defined in
; the file


; al compilar, regresa funciones compiladas

(compile 'make-adder)


(print (compiled-function-p (make-adder 2)))
(setf add3 (make-adder 3))
(print (funcall add3 2))
(setf add27 (make-adder 27))
(print (funcall add27 2))
(print (compiled-function-p (make-adder 27))) 

