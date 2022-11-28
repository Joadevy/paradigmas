; La media de una lista de numeros, es la sumatoria dividido la cantidad de numeros.

(defun cantidad (lista)
  (cond
   ((null lista) 0)
   (T (+ 1 (cantidad (rest lista))))))

(defun sumatoria (lista)
  (cond
   ((null lista) 0)
   (T (+ (first lista) (sumatoria (rest lista))))))


(defun media (lista)
  (cond
   ((null lista) 0)
   (T (/ (sumatoria lista) (cantidad lista))))) 

; Minimos de una lista con sublistas
;  NL=(2 (5 4 7 7) 5 (3 (4 9) 10) 6 (5 7) 4 9 2) Resultado: (2 4 3 4 5)

(defun minimo (lista)
  (cond
   ((null (rest lista)) (first lista))
   ((<= (first lista) (minimo (rest lista))) (first lista))
   (T (minimo (rest lista)))))

; No cuenta la lista principal
(defun cantSL (lista)
  (cond
   ((null lista) 0)
   ((listp (first lista)) (+ 1 (cantSL (first lista)) (cantSL (rest lista))))
   (T (cantSL (rest lista)))))

(defun eliminarNivel (lista)
  (cond
   ((null lista) lista)
   ((listp (first lista)) (cons (first lista) (eliminarNivel (rest lista))))
   (T (eliminarNivel (rest lista)))))

(defun soloNivelActual (lista)
  (cond
   ((null (first lista)) nil)
   ((listp (first lista)) (soloNivelActual (rest lista)))
   (T (cons (first lista) (soloNivelActual (rest lista))))))

;(defun minimoLySL (lista)
 ; (cond
  ; ((and (listp (first lista)) (= (cantSL (first lista)) 0)) (cons (minimo (first lista)) (minimoLySL (rest lista))))

