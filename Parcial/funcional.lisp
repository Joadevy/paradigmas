; Toma como entrada una lista L (con sublistas) y un numero M, devuelve una con la misma estructura de L pero con los resultados de sumar M a cada elemento de L.

; Ejemplo: L = (1 (2 3) (4 (5) 6) 7) M=5.
; Resultado: (6 (7 8) (9 (10) 11) 12)

(defun sumarLista (L M)
  (cond
   ((null L) L)
   ((listp (first L)) (cons (sumarLista (first L) M) (sumarLista (rest L) M)))
   ((numberp (first L)) (cons (+ M (first L)) (sumarLista (rest L) M)))
   (T (cons (first L) (sumarLista (rest L) M)))))

; _____________________________________________________________


; Toma como entrada lista L (con sublistas) y una posicion P.
; Devuelve la lista de todos los elementos que estan en la posicion P de cada sublista (incluyendo la lista principal).
; Si el elemento no existe (tiene menos elementos que la pos), se pone 0.
; Para el calculo de la posicion SOLO CUENTAN NUMEROS.

; Ejemplo: L = (6 (3 8) (3 (2) 1) 7) P=2
; Resultado: (7 8 1 0)

; P comenzara siendo para recorrer la lista L.
; Si no lo encuentra en la posicion devuelve NIL.
(defun elementoEnPosicion (L PE P)
  (cond
   ((null L) nil)
   ((listp (first L)) (elementoEnPosicion (rest L) PE P)) ; ya que no cuenta la posicion si es lista.
   ((= P PE) (first L))
   (T (elementoEnPosicion (rest L) PE (+ 1 P)))))

(defun listaElementosEnPos (L PE)
  (cond
   ((null L) nil)
   ((and (listp (first L)) (null (elementoEnPosicion L PE 1))) (append (cons 0 (listaElementosEnPos (first L) PE)) (listaSubElementosEnPos (rest L) PE)))
   ((and (listp (first L)) (not (null (elementoEnPosicion L PE 1)))) (append (cons (elementoEnPosicion L PE 1) (listaElementosEnPos (first L) PE)) (listaSubElementosEnPos (rest L) PE)))
   ((null (elementoEnPosicion L PE 1)) (cons 0 (listaSubElementosEnPos (rest L) PE)))
   (T (cons (elementoEnPosicion L PE 1) (listaSubElementosEnPos (rest L) PE)))))

(defun listaSubElementosEnPos (SL PE)
  (cond
   ((null SL) nil)
    ((listp (first SL)) (append (listaElementosEnPos (first SL) PE) (listaSubElementosEnPos (rest SL) PE)))
   (T (listaSubElementosEnPos (rest SL) PE))))

(defun main (L PE)
  (listaElementosEnPos L PE))



  
