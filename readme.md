
## instalacion en ubuntu:
```bash
sudo apt-get install clisp
```

para la quotacion se usa el apostrofe que viene en el teclado en la tecla de signo de interrogacion
```lisp
'(lista quotada)
```

## ejecucion

para el entorno basta con ejecutar
```
$ clisp
```
y esto nos ingresa al entorno de clisp, al cometer un error o para salir se debe oprimir Ctrl+D
pero como no es un entorno eficaz para el desarrollo es mejor editar codigo desde un IDE y ejecutarlo

```shell
$ clisp myfile.lisp
```
no imprimira nada a menos que usemos `(print "asd")` o `(format ...)` si lo ejecutamos de esta manera, pero nos permite escribir funciones mas largas, lisp se parece mucho a python 

## configuracion en Sublime text

crear un nuevo build en `Tools>Build System>Build System`:

```js
{
	"shell_cmd": "clisp $file"
}
```
y guardarlo, elegirlo para build de lisp en sublime y mostrara una salida de shell en ST igual que ejecutar `$ clisp myfile.lisp`



```lisp 
'Asd
ASD
[2]> ASD

*** - SYSTEM::READ-EVAL-PRINT: variable ASD has no value
The following restarts are available:
USE-VALUE      :R1      Input a value to be used instead of ASD.
STORE-VALUE    :R2      Input a new value for ASD.
ABORT          :R3      Abort main loop
Break 1 [3]> 'ASD
ASD
Break 1 [3]> 
[4]> '
(my 3 "sons")
(MY 3 "sons")
[5]> '(the list(a b c ) has 3 elements)
(THE LIST (A B C) HAS 3 ELEMENTS)
[6]> (list 'my (+ 2 1 ) "Sons" )
(MY 3 "Sons")
[7]> (list '(+ 2 1) (+ 2 1))
((+ 2 1) 3)
[8]> (list (+ 2 1) (+ 2 1))
(3 3)
[9]> nil
NIL
[10]> ()
NIL
[11]> '()
NIL
[12]> (cons 'a '(b c d))
(A B C D)
[13]> (cons a '(b c d))

*** - SYSTEM::READ-EVAL-PRINT: variable A has no value
The following restarts are available:
USE-VALUE      :R1      Input a value to be used instead of A.
STORE-VALUE    :R2      Input a new value for A.
ABORT          :R3      Abort main loop
Break 1 [14]> (cons a (b c d))

*** - SYSTEM::READ-EVAL-PRINT: variable A has no value
The following restarts are available:
USE-VALUE      :R1      Input a value to be used instead of A.
STORE-VALUE    :R2      Input a new value for A.
ABORT          :R3      Abort debug loop
ABORT          :R4      Abort main loop
Break 2 [15]> (cons 'a '(b c d))
(A B C D)
Break 2 [15]> (cons 'a '(b c d))
(A B C D)
Break 2 [15]> 
Break 1 [14]> 
[16]> (cons 'a '(b c d))
(A B C D)
[17]> (cons 'a 'b)
(A . B)
[18]> (list 'a 'b)
(A B)
[19]> (cons 'a (cons 'b))

*** - EVAL: too few arguments given to CONS: (CONS 'B)
The following restarts are available:
ABORT          :R1      Abort main loop
Break 1 [20]> (cons 'a (cons 'b nil))
(A B)
Break 1 [20]> 
[21]> (car ' (a b c))
A
[22]> (car (a b c))

*** - EVAL: undefined function A
The following restarts are available:
USE-VALUE      :R1      Input a value to be used instead of (FDEFINITION 'A).
RETRY          :R2      Retry
STORE-VALUE    :R3      Input a new value for (FDEFINITION 'A).
ABORT          :R4      Abort main loop
Break 1 [23]> (car ' (a b c))
A
Break 1 [23]> 
[24]> (cdr  '   (a b c))
(B C)
[25]> (cdr  '(a b c))
(B C)
...
[29]> (car (cdr (cdr '(a b c d ))))
C
[31]> (third '(a b c d )
)
C
[32]> (listp '(a b c))
T
... 
[35]> (null nil)
T
[36]> (not nil)
T
...
[38]> (if (listp 2)
(+ 1 2)
(+ 5 6)
)
11

(if
(listp 27 )(+ 2 3 ))
NIL
Break 1 [2]> 
[3]> (if 27 1 2)
1
[4]> (and t (+ 1 2))
3
[5]> (and t (+ 1 2) nil)
NIL
[6]> (and t (+ 1 2) 2)
2
[7]> (or t (+ 1 2) 2)
T
[8]> (or t (+ 1 2) nil)
T
[9]> (or 2 (+ 1 2) nil)
2
[10]> (or nil (+ 1 2) nil)
3
[11]> (or nil  nil)
NIL



```
and se detiene si hay un falso, or se detiene si hay un true

con los ifs adentro solo se le pueden apsar expresiones a evaluar, no codigo normal, en todo caso se le pasan lambdas o funciones, esta extraño
```lisp
(defun mystery (x y)
	(if (null y)
		(...
		)
		; nil	;al parecer hay que pasarle funciones internamente
		(
			
			let((x 0));aqui ya permite mas codigo
			(+ x 1)
		)

		
	)
)
```
```lisp
(defun mystery (x y)
	(if (null y)
		(...
		)
		(
			(lambda(x)
			 	(print(+ x y))
			 	(- x y)
			)
			1
		)

		
	)
)
```
si forzosamente necesitamos ejecutar mas codigo hay que usar progn
```lisp
(defun puntos_recur(x)
	(if (eq x 0)
		0
		(progn;con esto podemos hacer ifs :O
			(puntos_recur (- x 1))
			(format t ".")

		)
	)
)
```


estructura de la asignacion let:
```lisp
(defun numero_veces(  a x)
	
	(let ((countt 0)) 
		(
			;... operaciones
		)
		countt;el valor de la ultima expresion es el que se devuelve  a let, podriamos quitar el count
	)
)
```



hay que tener cuidado con los nombres de las  variables por que cuando hay errores de asignacion al aprecer dentro de las funciones si ese nombre exisita anteriormente asignara ese valor (no deberia pasar por que se supone que sabes lo que haces pero podria dar dolores de cabeza en el testing)


### recursion

Students learning about recursion are sometimes encouraged to trace all the invocations of a recursive function on a piece of paper. (A trace of a recursive function can be seen on page 288.) This exercise could be misleading: a programmer defining a recursive function usually does not think explicitly
about the sequence of invocations that results from calling it.
If one always had to think of a program in such terms, recursion would be burdensome, not helpful. The advantage of recursion is precisely that it lets us view algorithms in a more abstract way. You can judge whether or not a recursive function is correct without considering all the invocations that result when the function is actually called.
To see if a recursive function does what it's supposed to, all you have to ask is, does it cover all the cases?

This is all we need to know. The secret to understanding recursion is a lot like the secret for dealing with parentheses. How do you see which parenthesis matches which? You don't have to. 
How do you visualize all those invocations? You don't have to.

## control 

hay que tener cuidado al crear un let de no usar una variable en la defincion que estemos creando:

```lisp
( let ((x 2) (y (+ x 1))); mal, esa x se redefine usando  ( + x y)
	(+ x y)

	)
```
es equivalente a esta, la x ya no es una x externa
```lisp
((lambda (x y)
	 (+ x y)
	 ) 2 (+ x 1)
)
```
si se necesita una variable definida por alguna otra en los parametros se usa let*
```lisp
( let * ((x 1) (y (+ x 1)))
(+ x y)
)

```

eso anida los lets:
``` lisp 
( let ((x 1))
	( let ((y (+ x 1)))
		(+ x y ) 
	) 

)

```
 traen nil por default


