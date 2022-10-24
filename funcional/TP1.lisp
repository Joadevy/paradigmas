; ------------------- NIVEL 1 -------------------
; 1) Cuadrado de un numero
(defun cuadradoDe (x) (* x x))

; 2) Valor absoluto de un numero
(defun absDe (x) 
  (cond 
   ((< x 0)(- x))
   (T x)))

; 3) Calculo para el parametro n: F(n) = n * (n - 1) / 2 => Resolviendo primero el producto
(defun calcParam (n)
  (cond 
   ((= n 0) 0)
   (T (/ (* n (- n 1)) 2))))


; ------------------- NIVEL 2 -------------------

; 4) Enesima potencia de un numero (dominio pot es un num entero)
(defun n-esimaPot (num pot)
  (cond 
   ((= pot 0) 1)
   ((> pot 0) (* (* num (n-esimaPot num (- pot 1)))))
   ((< pot 0) (* (/ 1 num) (n-esimaPot num (+ pot 1))))))

;Ejemplo pot negativa:  1/2 * 1/2 * 1/2 * 1/2 = 2^-4 = 1/16

; 5) Cantidad de elementos de una lista (dominio todas las listas)
(defun cantidad (lista)
  (cond
   ((null lista) 0)
   (T (+ 1 (cantidad (rest lista))))))

; 6) Sumatoria de elementos de una lista (dominio listas numericas de profundidad 1)
(defun sumatoriaElementosLista (lista)
  (cond
   ((null lista) 0)
   (T (+ (first lista) (sumatoriaElementosLista (rest lista))))))

; 7) Devolver el i-esimo elemento de una lista (dominio listas no vacias y cargada en el index)
(defun elementoEn (lista index)
  (cond
   ((= index 1) (first lista))
   (T (elementoEn (rest lista) (- index 1)))))

; 8) Eliminar i-esimo elemento de una lista
(defun eliminarElemento (lista index)
  (cond 
   ((= index 1) (rest lista))
   (T (cons (first lista) (eliminarElemento (rest lista) (- index 1))))))

; 9) True o False si existe un elemento en una lista
(defun existe (lista elemento)
  (cond
   ((null lista) nil)
   ((= (first lista) elemento) T)
   (T (existe (rest lista) elemento))))

; 10) Media de una lista de numeros
(defun media (lista)
  (cond 
   ((null lista) 0)
   (T (/ (sumatoriaElementosLista lista) (cantidad lista)))))

; 11) Agregar elemento a lista en una posicion determinada (Dominio todas las listas, el index debe ser >= 1)
(defun agregarEnPosicion (lista index elemento)
  (cond 
   ((null lista) (cons elemento lista))
   ((= index 1) (cons elemento lista))
   (T (cons (first lista) (agregarEnPosicion (rest lista) (- index 1) elemento)))))

; Ejemplo para una llamada (agregarEnPosicion '(1 2 4) 3 3): la recursividad se aplica sobre el cons y el segundo parametro que siempre es una lista entonces se construye la lista output recursivamente.
; cons 1 (agregarEnPosicion '(2 4) 2 3)
; cons 1 cons 2 (agregarEnPosicion '(4) 1 3)
; cons 1 cons 2 '(3 4)
; cons 1 '(2 3 4)
; '(1 2 3 4)

; 12) Agregar elemento a una lista ordenada donde corresponda (dominio: listas numericas) - Se definio un orden de menor a mayor en los elementos
(defun agregarElementoEnOrden (lista elemento)
  (cond
   ((null lista) (cons elemento lista))
   ((<= elemento (first lista)) (cons elemento lista))
   (T (cons (first lista) (agregarElementoEnOrden (rest lista) elemento)))))

; 13) Sumatoria de las tres primeras potencias de un numero: (n + n^2 + n^3)
(defun sumatoriaTresPot (n)
  (+ (+ n (cuadradoDe n)) (n-esimaPot n 3)))

; 14) Eliminar todas las ocurrencias de un elemento en una lista
(defun eliminarOcurrencias (lista elemento)
  (cond
   ((null lista) nil)
   ((= elemento (first lista)) (eliminarOcurrencias (rest lista) elemento))
   (T (cons (first lista) (eliminarOcurrencias (rest lista) elemento)))))

; 15) Reemplaza en una lista un elemento por otro.
(defun reemplazar (lista elemento reemplazo)
  (cond
   ((null lista) nil)
   ((= elemento (first lista)) (cons reemplazo (reemplazar (rest lista) elemento reemplazo)))
   (T (cons (first lista) (reemplazar (rest lista) elemento reemplazo)))))

; 16) Minimo elemento de una lista
(defun minimo (lista)
  (cond
   ((null (rest lista)) (first lista))
   ((< (first lista) (minimo (rest lista))) (first lista))
   (T (minimo (rest lista)))))

; 17) Maximo elemento de una lista
(defun maximo (lista)
  (cond
   ((null (rest lista)) (first lista))
   ((> (first lista) (maximo (rest lista))) (first lista))
   (T (maximo (rest lista)))))

; 18) Dada una lista de numeros, devuelve promedio,maximo y minimo.
(defun proMaxMin (lista)
  (cons (media lista) (cons (maximo lista) (cons (minimo lista) nil))))

; Testeando las funciones reduce & mapcar

; Devuelve el producto de todos los elementos de la lista.
(defun productoLista (lista)
  (reduce '* lista))

; Mapea los elementos de la lista a una nueva lista multiplicandolos por dos. Lambda es una funcion anonima que recibe la funcion mapcar (seria una funcion de orden superior)
(defun listaX2 (lista)
  (mapcar (lambda (x) (* x 2)) lista))

; ------------------- NIVEL 3 -------------------




  

  
 
