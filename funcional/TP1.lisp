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
(defun eliminarOcurrenciasDe (elemento lista)
  (cond
   ((null lista) nil)
   ((= elemento (first lista)) (eliminarOcurrenciasDe elemento (rest lista)))
   (T (cons (first lista) (eliminarOcurrenciasDe elemento (rest lista))))))

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

; 19) Calculo del i-esimo numero perfecto (igual a la suma de sus divisores)

; No incluye al numero en si mismo (no se usa en num perfecto)
(defun divisoresDelPerfecto (numero divisor)
  (cond
   ((= numero divisor) nil)
   ((= (mod numero divisor) 0) (cons divisor (divisoresDelPerfecto numero (+ divisor 1))))
   (T (divisoresDelPerfecto numero (+ divisor 1)))))

(defun sumaDivisoresDe (numero)
  (sumatoriaElementosLista (divisoresDelPerfecto numero 1)))

; El dominio son numeros > 0 (suma de los divisores = numero para ser perfecto).
(defun esNumeroPerfecto (numero)
   (= numero (sumaDivisoresDe numero)))

(defun numerosPerfectosHasta (desde hasta numeros)
  (cond
   ((= hasta (cantidad numeros)) numeros)
   ((esNumeroPerfecto desde) (numerosPerfectosHasta (+ desde 1) hasta (cons desde numeros)))
   (T (numerosPerfectosHasta (+ desde 1) hasta numeros))))

; Hasta I = 4 soporta (6, 28, 496, 8128) el 5 es 33550336
(defun I-numeroPerfecto (I) 
  (first (numerosPerfectosHasta 1 I nil)))

; 20) Lista de primeros N numeros primos

; Devuelve TODOS los divisores del num (a diferencia del divisores para perfectos)
(defun divisoresDe (numero divisor)
  (cond
   ((= numero divisor) (cons numero nil))
   ((= (mod numero divisor) 0) (cons divisor (divisoresDe numero (+ divisor 1))))
   (T (divisoresDe numero (+ divisor 1)))))
  
(defun tieneDosDivisores (numero)
  (= 2 (cantidad (divisoresDe numero 1))))

(defun son1yElMismoNumero (divisores numero)
  (and (= 1 (first divisores)) (= numero (first (rest divisores)))))

(defun esPrimo (numero)
  (and (tieneDosDivisores numero) (son1yElMismoNumero (divisoresDe numero 1) numero)))

(defun numerosPrimosHasta (desde cant primos)
  (cond
   ((= cant (cantidad primos)) primos)
   ((esPrimo desde) (numerosPrimosHasta (+ desde 1) cant (cons desde primos)))
   (T (numerosPrimosHasta (+ 1 desde) cant primos))))

(defun N-numerosPrimos (N)
 (numerosPrimosHasta 1 N nil))
  
; 21)  Varianza (muestral) de una lista de numeros
  
(defun varianzaDe (numeros media cantidad)
  (cond
   ((null numeros) 0)
   (T (+ (/ (cuadradoDe (- (first numeros) media)) (- cantidad 1)) (varianzaDe (rest numeros) media cantidad)))))

(defun Varianza (numeros)
  (varianzaDe numeros (media numeros) (cantidad numeros)))

; 22) Moda de una lista de numeros
; Devuelve el numero de repeticiones del elemento en la lista
(defun repeticionesDe (elemento lista)
  (cond
   ((null lista) 0)
   ((= elemento (first lista)) (+ 1 (repeticionesDe elemento (rest lista))))
   (T (repeticionesDe elemento (rest lista)))))

; Busca el numero de repeticiones maxima de un elemento en la lista
(defun repeticionesMaximaEn (lista)
  (cond
   ((null (rest lista)) (repeticionesDe (first lista) lista))
   ((> (repeticionesDe (first lista) lista) (repeticionesMaximaEn (eliminarOcurrenciasDe (first lista) lista))) (repeticionesDe (first lista) lista))
   (T (repeticionesMaximaEn (eliminarOcurrenciasDe (first lista) lista)))))

; Busca el elemento cuya repeticion = maxima cantidad de repeticiones.
(defun moda (lista)
  (cond 
   ((null (rest lista)) (first lista))
   ((= (repeticionesDe (first lista) lista) (repeticionesMaximaEn lista)) (first lista))
   (T (moda (eliminarOcurrenciasDe (first lista) lista)))))


; 23) Cantidad de numeros que contiene una lista
;(defun esNumero (elemento)
 ; Como se determina si un elemento es numero?

; 24) Funcion que transforma un numero binario (expresado como lista) a decimal.
(defun reverso (lista)
  (cond
   ((= (cantidad lista) 0) nil)
   (T (cons (elementoEn lista (cantidad lista)) (reverso (eliminarElemento lista (cantidad lista)))))))

(defun obtenerDecimal (listaReversed indice)
  (cond
   ((null (rest listaReversed)) (* (first listaReversed) (n-esimaPot 2 indice)))
   (T (+ (* (first listaReversed) (n-esimaPot 2 indice)) (obtenerDecimal (rest listaReversed) (+ 1 indice))))))
   
(defun binAdec (binario)
 (obtenerDecimal (reverso binario) 0))

; 25) Suma de binarios (convierte a decimal, los suma y los trae a binario)
(defun obtenerBinario (decimal)
  (cond
   ((= decimal 0) (cons 0 nil))
   ((> 2 decimal) (cons 1 nil))
   (T (cons (mod decimal 2) (obtenerBinario (floor (/ decimal 2)))))))

(defun decAbin (decimal)
  (reverso (obtenerBinario decimal)))

(defun +Binario (b1 b2)
  (decAbin (+ (binAdec b1) (binAdec b2))))

; 26) Transformar un entero decimal a binario
; Es la funcion decAbin definida para el punto anterior.

; 27) Determinar si una lista es palindromo => La lista debe ser igual a su reverso.
; Necesito una funcion que tomando como entrada la lista y su reversa valide posicion a posicion que sean iguales.

  



  

  
 
