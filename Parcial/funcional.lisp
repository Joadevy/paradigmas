; Toma como entrada una lista L (con sublistas) y un numero M, devuelve una con la misma estructura de L pero con los resultados de sumar M a cada elemento de L.

; Ejemplo: L = (1 (2 3) (4 (5) 6) 7) M=5.
; Resultado: (6 (7 8) (9 (10) 11) 12)

(defun sumarLista (L M)
  (cond
   ((null L) L)
   ((listp (first L)) (cons (sumarLista (first L) M) (sumarLista (rest L) M)))
   ((numberp (first L)) (cons (+ M (first L)) (sumarLista (rest L) M)))
   (T (cons (first L) (sumarLista (rest L) M)))))

