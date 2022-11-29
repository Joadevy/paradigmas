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

; Determina si una lista tiene o no sublitas.
(defun sinSL (lista)
  (cond
   ((null lista) T)
   ((listp (first lista)) nil)
   (T (sinSL (rest lista)))))

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


; Una funcion que devuelva la lista con mayor cantidad de elementos que no sean sublistas, por ejemplo: L=(2 (3 (4 2) 9 (2) 8) (1 (3) 5) 6), y el resultado es (3 9 8)

(defun cantSinSL (lista)
  (cond
   ((null lista) 0)
   ((listp (first lista)) (cantSinSL (rest lista)))
   (T (+ 1 (cantSinSL (rest lista))))))

(defun cantMaxEl (lista)
  (cond
   ((sinSL lista) (cantSinSL lista))
   ((> (cantSinSL lista) (cantMaxEl (rest lista))) (cantSinSL lista))
   ((and (listp (first lista)) (>= (cantSinSL (first lista)) (cantMaxEl (rest lista))) (>= (cantSinSl (first lista)) (cantMaxEl (first lista)))) (cantSinSL (first lista)))
   ((and (listp (first lista)) (>= (cantSinSL (first lista)) (cantMaxEl (rest lista))) (< (cantSinSl (first lista)) (cantMaxEl (first lista)))) (cantMaxEl (first lista)))
   (T (cantMaxEl (rest lista)))))

(defun linealizaSinSL (lista)
  (cond
   ((null lista) nil)
   ((listp (first lista)) (linealizaSinSL (rest lista)))
   (T (cons (first lista) (linealizaSinSL (rest lista))))))

(defun listaMax (lista cant)
  (cond
   ((null lista) nil)
   ((listp (first lista)) (listaMax (first lista) cant))
   ((= (cantSinSL lista) cant) lista)
   (T (listaMax (rest lista) cant))))

(defun listaMaxCant (lista)
  (linealizaSinSL (listaMax lista (cantMaxEl lista))))

; Escriba una función/predicado que tome una lista L sin sublistas y número N, y devuelva la lista de las sumatorias de los elementos de L tomados de a N, es decir, el primer valor de la lista resultante será la sumatoria de los elemento de L desde el 1 al N, el segundo valor la sumatoria desde el 2 al N+1, y así sucesivamente. Si la cantidad de elementos de L es menor a N, se devuelve lista vacía. 
; Ej: para L=(5 3 7 5 4 4 8 9) y N=3, el resultado es (15 15 16 13 16 21)

(defun largo (lista)
  (cond
   ((null lista) 0)
   (T (+ 1 (largo (rest lista))))))

; Debe recibir una lista donde haya valores desde y hasta.
(defun sumatoriaDesdeHasta (L D H Pos)
  (cond
   ((= D (+ 1 H)) 0)
   ((< Pos D) (sumatoriaDesdeHasta (rest L) D H (+ 1 Pos)))
   (T (+ (first L) (sumatoriaDesdeHasta (rest L) 1 (- H D) Pos)))))

(defun eliminarElementosHasta (L H)
  (cond
   ((= 0 H) L)
   (T (eliminarElementosHasta (rest L) (- H 1)))))

(defun sumatoriaLista (L N)
  (cond
   ((< (- (largo L) N) 0) nil)
   ((null L) L)
   (T (cons (sumatoriaDesdeHasta L 1 N 1) (sumatoriaLista (rest L) N)))))
