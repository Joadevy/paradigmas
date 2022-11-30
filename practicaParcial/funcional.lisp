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

(defun listaNumeros (lista)
  (cond
   ((null lista) lista)
   ((numberp (first lista)) (cons (first lista) (listaNumeros (rest lista))))
   (T (listaNumeros (rest lista)))))

(defun minimosLista (lista)
  (cons (minimo (listaNumeros lista)) (minimosSublistas (rest lista))))

(defun minimosSublistas (lista)
  (cond
   ((null lista) nil)
   ((listp (first lista)) (append (cons (minimo (listaNumeros (first lista))) (minimosSublistas (first lista))) (minimosSublistas (rest lista))))
   (T (minimosSublistas (rest lista)))))

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
   (T (cons (sumatoriaDesdeHasta L 1 N 1) (sumatoriaLista (rest L) N)))))

 ;10.Escriba una función/predicado que tome como entrada una lista con sublistas y devuelva la sublista cuya sumatoria (considerando sólo los elementos numéricos) sea la máxima.
;Ej: L=(5 (9 ((3 7 4)  5  (6 (15 3)) 4) 10) 9 1), el resultado es (9 10)

(defun numerosDelNivel (lista)
  (cond
   ((null lista) lista)
   ((numberp (first lista)) (cons (first lista) (numerosDelNivel (rest lista))))
   (T (numerosDelNivel (rest lista)))))

(defun sumatoriaN (lista)
  (cond
   ((null lista) 0)
   (T (+ (first lista) (sumatoriaN (rest lista))))))

; Tengo que buscar la sumatoria mas grande en las sublistas y despues recorro y la que coincida con ese valor la muestro SIN LAS SUBLISTAS del medio.

(defun maximaSumatoria (lista)
  (cond
   ((null lista) 0)
   ((> (sumatoriaN (numerosDelNivel lista)) (maximaSumatoria (rest lista))) (sumatoriaN (numerosDelNivel lista)))
   ((and (listp (first lista)) (> (sumatoriaN (numerosDelNivel (first lista))) (maximaSumatoria (rest lista))) (>= (sumatoriaN (numerosDelNivel (first lista))) (maximaSumatoria (first lista)))) (sumatoriaN (numerosDelNivel (first lista))))
   ((and (listp (first lista)) (>= (sumatoriaN (numerosDelNivel (first lista))) (maximaSumatoria (rest lista))) (< (sumatoriaN (numerosDelNivel (first lista))) (maximaSumatoria (first lista)))) (maximaSumatoria (first lista)))
   (T (maximaSumatoria (rest lista)))))

(defun devuelveListaMaxSum (lista maxSum) 
  (cond
   ((= (sumatoriaN (numerosDelNivel lista)) maxSum) (numerosDelNivel lista))
   ((listp (first lista)) (devuelveListaMaxSum (first lista) maxSum))
   (T (devuelveListaMaxSum (rest lista) maxSum))))

(defun listaMaxSum (lista)
  (devuelveListaMaxSum lista (maximaSumatoria lista)))

; Escriba una función/predicado que tome una lista L donde todos sus elementos son sublistas de números ordenados de menor a mayor (sin sublistas) y devuelva la lista resultante de intercalar dichas sublistas, es decir, el resultado será una lista ordenada.

; L=((4 9 13) (3) (1 2 5 8 8 11) () (7 24)) , el resultado es (1 2 3 4 5 7 8 8 9 11 13 24) 

; Ire tomando de a dos listas y fusionandolas en orden.
(defun fusionListasSegunOrden (l1 l2)
  (cond
   ((null l1) l2)
   ((null l2) l1)
   ((<= (first l1) (first l2)) (cons (first l1) (fusionListasSegunOrden (rest l1) l2)))
   (T (cons (first l2) (fusionListasSegunOrden l1 (rest l2))))))

(defun ordenaListaConSL (lista)
  (cond
   ((null lista) nil)
   (T (fusionListasSegunOrden (fusionListasSegunOrden (first lista) (first (rest lista))) (ordenaListaConSL (rest (rest lista)))))))

; Otra estrategia: linealizar la lista y luego ordenarla de menor a mayor.
(defun linealizaLista (lista)
  (cond
   ((null lista) lista)
   ((listp (first lista)) (append (linealizaLista (first lista)) (linealizaLista (rest lista))))
   (T (cons (first lista) (linealizaLista (rest lista))))))

(defun minim (lista)
  (cond
   ((null (rest lista)) (first lista))
   ((<= (first lista) (minim (rest lista))) (first lista))
   (T (minim (rest lista)))))

(defun eliminarElemento (L X)
  (cond
   ((null L) L)
   ((= (first L) X) (rest L))
   (T (cons (first L) (eliminarElemento (rest L) X)))))

(defun menorAmayor (l)
  (cond
   ((null l) l)
   (T (cons (minimo l) (menorAmayor (eliminarElemento l (minimo l)))))))

(defun ordenarListas (listaConSL)
  (menorAmayor (linealizaLista listaConSL)))




; No se utilizo (ordena pero solo de a 'pares')
(defun ordenar (listaLineal ordenamiento)
  (cond
   ((null (rest listaLineal)) (cons (first listaLineal) nil))
   ((funcall ordenamiento (first listaLineal) (first (rest listaLineal))) (cons (first listaLineal) (ordenar (rest listaLineal) ordenamiento)))
   (T (cons (first (rest listaLineal)) (ordenar (cons (first listaLineal) (rest (rest listaLineal))) ordenamiento)))))

; Input: ordenar '(5 3 2 0 1 4) (lambda (x y) (> x y)) => NO LO HARIA BIEN
; Input: ordenar '(5 2 3 0 1) (lambda (x y) (> x y)) => (5 3 2 1 0)







