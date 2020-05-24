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
[26]> (car (cdr (cdr '(



*** - Ctrl-C: User break
The following restarts are available:
ABORT          :R1      Abort main loop
Break 1 [27]> (car (cdr (cdr '(

*** - Ctrl-C: User break
The following restarts are available:
ABORT          :R1      Abort debug loop
ABORT          :R2      Abort main loop
Break 2 [28]> 
Break 1 [27]> 
** - Continuable Error
PRINT: User break
If you continue (by typing 'continue'): Continue execution
The following restarts are also available:
ABORT          :R1      Abort main loop
Break 1 [30]> 
[29]> (car (cdr (cdr '(a b c d ))))
C
[31]> (third '(a b c d )
)
C
[32]> (listp '(a b c))
T
[33]> (listp 2%)

*** - SYSTEM::READ-EVAL-PRINT: variable 2% has no value
The following restarts are available:
USE-VALUE      :R1      Input a value to be used instead of 2%.
STORE-VALUE    :R2      Input a new value for 2%.
ABORT          :R3      Abort main loop
Break 1 [34]> (listp 2)
NIL
Break 1 [34]> 
[35]> (null nil)
T
[36]> (not nil)
T
[37]> (if (listp '(a b c))
You are in the top-level Read-Eval-Print loop.
Help (abbreviated :h) = this list
Use the usual editing capabilities.
(quit) or (exit) leaves CLISP.
(+ 1 2)
(+ 5 6)
)
3
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

and se detiene si hay un falso, or se detiene si hay un true

```