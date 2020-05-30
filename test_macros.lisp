
(defun nl()( format t "~%"))
(defmacro as(tag content)
	`( format t "<~(~a~)>~A</~(~a~)>" 
		',tag ,content ',tag)

	)
(as center "asd")

(defmacro with (tag &rest body)
	`(progn
		(format t "~&<~(~a~)>~%" ',tag)
		,@body
		(format t "~&</~(~a~)>~%"',tag)
		
	)
	)

(nl)
(nl)
(with center (as ahref "link"))


(defun brs (&optional (n 1))
	(fresh-line)
	(dotimes (i n)
		(princ "<br>")
		)
	(terpri)
	)

(brs 10)

(defun html-file(base)
	(format nil "~(~a~).html" base)
	)


(defmacro page(name title &rest body)
	(let ((ti( gensym)))
	`(with-open-file (*standard-output*
		(html-file , name)
		:direction :output
		:if-exists :supersede
		)
		(
			let ((,ti ,title))
			(as title ,ti)
			( with center 
				(as h2 (string-upcase ,ti))
				)
			(brs 3)
			,@body
			)
		)
	)
	
)
(page 'paren "asdasd" (princ "algo que escribir"))


(defmacro with-link (dest &rest body)
	`(progn 
		(format t "<a href=\'~a\'>" (html-file ,dest))
		,@body
		(princ "</a>")
		)
	)
(defun link-item (dest text)
	(princ "<li>")
	(with-link dest
	(princ text)
	)
	)

(defun button (dest text)
	(princ "[ ")
	(with-link dest 
		(princ text)
		)
	(format t " ]~%")
	)

(nl)
(nl)
(with-link 'capture (princ "variable capturada"))

(nl)
(button 'help "help")

(defun map3 (fn lst)
	(labels ((rec (curr prev next left)
		(funcall fn curr prev next)
		(when left
			(rec (car left)
				curr
				(cadr left)
				(cdr left)
				)
			)
		))
	(when lst (rec (Car lst) nil (cadr lst)(cdr lst)))
	)
)


(defparameter *sections* nil)
(defstruct item 
	id title text)
(defstruct section
	id title items)

(defmacro defitem (id title text)
	`(setf ,id 
		(make-item 	:id ',id
					:title ,title
					:text ,text
			)
		)
	)

(defmacro defsection (id title &rest items)
	`(
		setf ,id
		(make-section	:id ',id
						:title ,title
						:items (list ,@items)
			)
		)
	)

(defun defsite (&rest sections)
	(setf *sections* sections)
	)


(defconstant contents "contents")
(defconstant index "index")

(defun get-contents (&optional (sections *sections*))
	(page contents contents 
		(with ol 
			(dolist (s sections)
				(link-item (section-id s)(section-title s))
				(brs 2)
				)
			(link-item index (string-capitalize indexb))
			)
		)
	)

(defun gen-index (&optional (Sections *sections*))
	(page index index
		(with ol
			(dolist (i (all-items sections))
				(link-item (item-id i) (item-title i))
				(brs 2)
				)
			)
		)
	)
(defun all-items (sections)
	(let ((is nil))
		(dolist(s sections)
			(dolist (i (section-items s))
				(setf is (merge 'list (list i) is #'title<))
			)
		)
		is)
	)

(defun title< (x y)
	(string-lessp(item-title x) (item-title y))
	)

(defun gen-site ()
	(map3 #' gen-section *sections*)
	(gen-contents)
	; (gen-index)
	)
(defun gen-section (sect <sect sect>)
	(page (section-id sect)(section-title sect)
		(with ol
			(map3 #' (lambda (item <item item>)
				(link-item (item-id item)
					(item-title item)
					)
				(brs 2)
				 (gen-item sect item <item item>)
				)
			(Section-items sect)


				)

			)
		(brs 3)
		(gem-move-buttons(if <sect (section-id	<sect))
			contents
			(if sect> (section-id sect>))
			)
		)

	)

(defun gen-item (sect item <item item>)
	(page (item-id item)(item-title item)
		(princ (item-text item))
		(brs 3)
		(gen-move-buttons(if <item (item-id <item))
			(section-id sect)
			(if item> (item-id item>))
			)
		)

	)

(defun gen-move-buttons (back up forward)
	(if back (button back "back"))
	(if up (button up "up"))
	(if forward (button forward "forward"))

	)


; (print
(defitem des "fortune coockies asd" "...")

(defitem case "case pesim " "...")
(defsection position "pos pap" des case)
(defitem luck "dist bad lcuk" "...")
(defitem haz "health " "...")
(defsection abstract "research" luck haz)

(print
(defsite position abstract)
)























