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

; Implementacion de la varianza usando un MAP:
(defun calculaVarianza (numero media cantidad)
  (/ (cuadradoDe (- numero media)) (- cantidad 1)))

(defun varianzaMapeada (numeros media cantidad)
   (sumatoriaElementosLista (mapear numeros (Lambda (num) (calculaVarianza num media cantidad)))))

(defun varianzaMapDe (numeros)
  (varianzaMapeada numeros (media numeros) (cantidad numeros)))

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


; Moda bien hecho:
(defun frecuenciaDe (numero lista)
  (cond
   ((null lista) 0)
   ((= (first lista) numero) (+ 1 (frecuenciaDe numero (rest lista))))
   (T (frecuenciaDe numero (rest lista)))))

(defun adom (lista)
  (cond
   ((null (rest lista)) (first lista))
   ((> (frecuenciaDe (first lista) lista) (frecuenciaDe (adom (rest lista)) (rest lista))) (first lista))
   (T (adom (rest lista)))))


; 23) Cantidad de numeros que contiene una lista
;(defun esNumero (elemento)
(defun cantidadNumeros (lista)
  (cond
   ((null lista) 0)
   ((NUMBERP (first lista)) (+ 1 (cantidadNumeros (rest lista))))
   (T (cantidadNumeros (rest lista)))))

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

(defun =Contenido (lista1 lista2)
  (cond
   ((/= (cantidad lista1) (cantidad lista2)) nil)
   ((and (null lista1) (null lista2)) T)
   ((= (first lista1) (first lista2)) (=Contenido (rest lista1) (rest lista2)))
   (T nil)))

(defun esPalindromo (lista)
  (=Contenido lista (reverso lista)))



; ------------------- NIVEL 4 -------------------

; 39) Toma como parametro una lista y una funcion (condicion) y cuenta la cantidad que elementos de la lista que cumplen esa condicion.

(defun cantidadDe (lista condicion)
  (cond
   ((null lista) 0)
   ((funcall condicion (first lista)) (+ 1 (cantidadDe (rest lista) condicion)))
   (T (cantidadDe (rest lista) condicion))))

; 40) Funci�n que tome una lista de n�meros y una condici�n (funci�n) como par�metros y devuelva la sumatoria de los elementos que cumplen dicha condici�n.

; La funcion condicion tiene que ser un predicado (devuelve T/nil).
(defun sumatoriaCondicionada (lista condicion)
  (cond
   ((null lista) 0)
   ((funcall condicion (first lista)) (+ (first lista) (sumatoriacondicionada (rest lista) condicion)))
   (T (sumatoriaCondicionada (rest lista) condicion))))

; 41) Select => se aplica sobre una lista y devuelve otra lista con los elementos que cumplen una condicion.

(defun select (lista condicion)
  (cond
   ((null lista) nil)
   ((funcall condicion (first lista)) (cons (first lista) (select (rest lista) condicion)))
   (T (select (rest lista) condicion))))

; 42) Map => se aplica sobre una lista y devuelve una nueva lista con los resultados de aplicar la funcion que se le pasa como argumento en cada elemento.
(defun mapear (lista condicion)
  (cond
   ((null lista) nil)
   (T (cons (funcall condicion (first lista)) (mapear (rest lista) condicion)))))

; 43) Toma dos listas y una funci�n como entrada, devuelve una nueva lista resultado de intercalar las dos primeras en el orden establecido por la funci�n (la funci�n se aplica a los dos elementos que se comparan en cada momento para determinar cu�l es el mayor).

(defun intercalarSegun (l1 l2 ordenar) ; Dominio listas ordenadas segun el mismo criterio de la funcion ordenar.
  (cond 
   ((null l1) l2)
   ((null l2) l1)
   ((funcall ordenar (first l1) (first l2)) (cons (first l1) (intercalarSegun (rest l1) l2 ordenar)))
   (T (cons (first l2) (intercalarSegun l1 (rest l2) ordenar)))))

; Inputs test intercalarSegun: 
; (intercalarSegun '(10 9 5 4) '(23 11 10 8 7 1) (Lambda (x y) (> x y)))
; (intercalarSegun '(2 4 8) '(1 9) (lambda (x y) (< x y))) 



; ------------------- NIVEL 5 -------------------

; 44) Dada una lista de numeros y un numero N, devuelve la lista resultante de eliminar los N numeros mas cercanos al promedio de la lista.

; Calcula la distancia (cercania) entre un numero y un target
(defun distancia (numero target)
  (absDe (- target numero)))

; Devuelve el elemento mas cercano al target.
(defun elementoMasCercanoA (lista target)
  (cond
   ((null (rest lista)) (first lista))
   ((< (distancia (first lista) target) (distancia (elementoMasCercanoA (rest lista) target) target)) (first lista))
   (T (elementoMasCercanoA (rest lista) target))))

; Elimina el elemento mas cercano al target.
(defun eliminarMasCercanoA (lista target)
  (cond
   ((null lista) nil)
   ((= (first lista) (elementoMasCercanoA lista target)) (rest lista))
   (T (cons (first lista) (eliminarMasCercanoA (rest lista) target)))))

; Elimina los N elementos mas cercanos al target
(defun eliminar-N-CercanosA (lista N target) ; N < cantidad lista
  (cond
   ((= N 0) lista)
   (T (eliminar-N-CercanosA (eliminarMasCercanoA lista target) (- N 1) target))))

; Invoca el eliminar N cercanos pasandole la media de la lista como target para mantener la media de la lista como una constante.
(defun eliminar-N-CercanosALaMedia (lista N)
  (eliminar-N-CercanosA lista N (media lista)))


; Nivel 5.2

; 52) Contar cantidad listas (incluye sublistas)
(defun cantSL (lista)
  (cond
   ((null lista) 0)
   ((listp (first lista)) (+ 1 (cantSL (first lista)) (cantSL (rest lista))))
   (T (cantSL (rest lista)))))

; Ahora incluyendo la lista en si misma
(defun cantL (lista)
  (+ 1 (cantSL lista)))

; 54) Transforma una lista en una lineal
(defun linealiza (lista)
  (cond
   ((null lista) nil)
   ((listp (first lista)) (concat (linealiza (first lista)) (linealiza (rest lista))))
   (T (cons (first lista) (linealiza (rest lista))))))
  
; 55) Determina si de dos listas numericas todos los elementos de la primera estan en el rango de numeros de la segunda.

(defun rangoLinealizado (lisNumeros)
  (cons (minimo lisNumeros) (cons (maximo lisNumeros) nil)))

(defun rango (lisNumeros)
  (rangoLinealizado (linealiza lisNumeros)))

(defun l1EnRangoDeL2 (l1 l2)
   (l1LinealEnRango (linealiza l1) (rango l2)))

(defun l1LinealEnRango (l1 rango)
  (cond
   ((null (rest l1)) (estaEnRango (first l1) rango))
   (T (and (estaEnRango (first l1) rango) (l1LinealEnRango (rest l1) rango))))) 

(defun estaEnRango (elemento rango)
  (and (<= elemento (maximo rango)) (>= elemento (minimo rango))))


; 60) Escriba una funci�n que tome como entrada una lista L y un elemento N, y determine la Profundidad de la primera ocurrencia del elemento en la lista. Si el n�mero no existe, su profundidad es 0; si est� en el primer nivel es 1, y as� sucesivamente.
; Probando con elemento 1:
; (2 3 '(2 3 4 1)) => profundidad 2.
; (2 3) => prof 0
; (1 2 3) => prof 1

; Devuelve T si el elemento existe en la lista (o dentro de una sublista)
(defun existeElemento (elemento lista)
  (cond
   ((null lista) nil)
   ((listp (first lista)) (or (existeElemento elemento (first lista)) (existeElemento elemento (rest lista))))
   ((= elemento (first lista)) T)
   (T (existeElemento elemento (rest lista)))))

(defun profundidadDe (elemento lista)
  (cond
   ((null lista) 0)
   ((listP (first lista)) (cond 
                           ((existeElemento elemento (first lista)) (+ 1 (profundidadDe elemento (first lista))))
                           (T (profundidadDe elemento (rest lista)))))
   ((= elemento (first lista)) 1)
   (T (profundidadDe elemento (rest lista)))))


; ------------------- EXTRA -------------------

; Funcion que concatena dos listas
(defun concat (l1 l2)
  (cond
   ((null l1) l2)
   ((null l2) l1)
   (T (cons (first l1) (concat (rest l1) l2)))))


; Ejercicios de parcial

; Escriba la funci�n (predicado) que tome como entrada una lista L de pares ordenados y una lista M de n�meros, y devuelva otra lista Resultado que contenga una sublista por cada par, conteniendo los elementos de la segunda lista que est�n dentro del rango representado por dicho par.
; Ejemplo: L=((3 5) (2 4) (1 2)) y M=(2 8 3 1 2 2 9 1 4) Resultado: ((3 4) (2 3 2 2 4) (2 1 2 2 1))

(defun estaEnElRango (numero rango)
  (and (<= numero (maximo rango)) (>= numero (minimo rango)))) 

; Analiza un rango y una lista y devuelve una lista con los numeros dentro del rango.
(defun subDelRango (M rango)
  (cond
   ((null M) nil)
   ((estaEnElrango (first M) rango) (cons (first M) (subDelRango (rest M) rango)))
   (T (subDelRango (rest M) rango))))

; Construye la lista luego de procesar cada sublista (cada rango) con la lista de numeros M.
(defun subPorPar (L M)
  (cond
   ((null L) nil)
   (T (cons (subDelRango M (first L)) (subPorPar (rest L) M)))))



; Escriba una funci�n (predicado) que tome como entrada una lista L (sin sublistas) y una lista M (que puede contener sublistas), y  devuelva una lista con N sublistas, donde N es la cantidad de elementos de L. Cada sublista debe contener todas las posiciones del i-esimo elemento de L en M (como si M fuese lineal. Adem�s, si el elemento no existe se pondr� 0).

;Ejemplo: L=(6 3 2 4 8) M=(2 (5 4 7 7) 5 (3 (4 9) 10) 6 (5 7) 4 9 2)
;Resultado: ((11) (7) (1 16) (3 8 14) (0))

; Funcion auxiliar que devuelva las posiciones de un elemento en una lista y devuelve nil si no esta en la lista.
(defun posicionesDelElemento (elemento lista pos)
  (cond
   ((null lista) nil)
   ((= elemento (first lista)) (cons pos (posicionesDelElemento elemento (rest lista) (+ 1 pos))))
   (T (posicionesDelElemento elemento (rest lista) (+ 1 pos)))))

; Funcion que devuelve las posiciones del elemento en una lista, devuelve 0 si la auxiliar devuelve nil (no esta el elemento en la lista)
(defun posDelElem (elemento lista)
  (cond
   ((not (posicionesDelElemento elemento lista 1)) (cons 0 '()))
   (T (posicionesDelElemento elemento lista 1))))



   

















