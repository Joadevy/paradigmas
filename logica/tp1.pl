% Ejemplos introductorios

% Predicado padre_hijo => es un Hecho (siempre verdaderos) y definido por 3 clausulas.
padre_hijo(ricardo,juan).
padre_hijo(juan,matias).
padre_hijo(juan,maria).

% Predicado hermano => es una REGLA, sera verdadera si se cumplen las condiciones.
hermano(X,Y):- padre_hijo(Z,X), padre_hijo(Z,Y), X\=Y.
% Predicado abuelo = es una REGLA.
abuelo(Abuelo,Nieto):- padre_hijo(Abuelo,Padre), padre_hijo(Padre,Nieto).

% Predicado descendiente
descendiente(Desc,Ancestro):- padre_hijo(Ancestro,HijoAncestro), descendiente(Desc,HijoAncestro).
descendiente(Hijo, Padre):- padre_hijo(Padre,Hijo).

% Funcion a predicado
factorial(0,1).
factorial(N,F):- N>0, N1 is N-1, factorial(N1,F1), F is N*F1.

% ------------------ Nivel 1

% 1) Tendremos dos parametros, el primero representa el elemento a calcular el cuadrado y el segundo el cuadrado en si.
cuadrado(X,Y):- Y is X*X. % En lenguaje natural decimos que 'Y es cuadrado de X si Y es X*X'

% 2) Valor absoluto de un numero
valorAbs(X,X) :- X>=0.

% 3) Realiza el calculo n: F(n) = n * (n - 1) / 2.
calculo3(X,Y):- Y is X*(X-1)/2.


% ------------------ Nivel 2
% 4) N pot de un numero
nPot(_,0,Z):- Z is 1.
nPot(X,Y,Z):- Y>0, Y1 is Y-1, nPot(X,Y1,Z1), Z is Z1*X.

% 5) Cantidad de elementos de una lista
cantidad([],0).
cantidad([_|R],C):- cantidad(R,CR), C is CR+1.

% 6) Sumatoria elementos lista
sumL([],0).
sumL([P|R],Z):- sumL(R,Z1) , Z is P+Z1.

% 7) Devolver i-esimo elemento de una lista
iesimo([P|_],1,P).
iesimo([_|R],I,Elem):- I>1, I1 is I-1, iesimo(R,I1,Elem).

% 8) Eliminar elemento dada una posicion en una lista.
eliminar([_|R],1,R).
eliminar([P|R],I,[P|Z1]):- I>1, I1 is I-1, eliminar(R,I1,Z1).

% 9) Existe elemento en una lista
existe(E,[E|_]). 
existe(E,[_|R]):- existe(E,R).

% 10) Media de una lista de numeros =>  uso predicados cantidad y sumatoria de una lista.
media(L,M):- sumL(L,Sum), cantidad(L,Cant),Cant>0, M is Sum/Cant. % => Resuelve la operacion y la asigna a M.
% media(L,Sum/Cant):- sumL(L,Sum), cantidad(L,Cant), Cant>0. => Con una variable menos (no resuelve el resultado, lo deja en fraccion)

% 11) Agrega elemento a una lista en una posicion dada.
agregarEnPos(L,1,Elem,[Elem|L]).
agregarEnPos([P|R],Pos,Elem,[P|R1]):- Pos>1, P1 is Pos-1, agregarEnPos(R,P1,Elem,R1).

% 12) Agregar elemento a una lista ordenada.
agregarEnOrden([],Elem,[Elem]). % => Es necesario este caso para cuando todos en la lista son menores al elemento.
agregarEnOrden([P|R],Elem,[Elem,P|R]):- Elem =< P.
agregarEnOrden([P|R],Elem,[P|L1]):- Elem > P, agregarEnOrden(R,Elem,L1).

% 13) Sumatoria de tres primeras potencias
sum1eras3Pot(Numero,Sumatoria):- cuadrado(Numero,N2), N3 is Numero*N2, Sumatoria is (Numero + N2 + N3).

% 14) Elimina ocurrencias de un elemento en una lista.
eliminarOcurrencias(_,[],[]).
eliminarOcurrencias(Elem,[Elem|R],L1):- eliminarOcurrencias(R,Elem,L1).
eliminarOcurrencias(Elem,[P|R],[P|L1]):- P\=Elem, eliminarOcurrencias(R,Elem,L1).

% 15) Reemplaza un elemento de una lista por otro.
reemplazar(_,_,[],[]).
reemplazar(Old, New,[P|R],[P|Res]):- P\=Old, reemplazar(Old, New,R,Res).
reemplazar(Old, New, [Old|R], [New|Res]):-reemplazar(Old, New, R, Res).

% 16) Minimo elemento de una lista
minimo([P|[]],P).
minimo([P|R],P):- minimo(R,S), P=<S.
minimo([P|R],S):- minimo(R,S), P>S.

% 17) Maximo elemento de una lista.
maximo([P|[]],P).
maximo([P|R],P):- maximo(R,S), P>=S.
maximo([P|R],S):- maximo(R,S), P<S.

% 18) Devuelve una 3-upla con promedio, maximo y minimo de una lista.
promMaxMin(L,[Prom,Max,Min]):- minimo(L,Min), maximo(L,Max), media(L,Prom).

% ------------------ Nivel 3

% 19) Calcule el i-esimo numero perfecto.
% Regla si un numero D es divisor de N.
divisor(N,D):- D\=N, D>=1, R is mod(N,D), R is 0.

% Divisores desde para usarse en el calculo de los divisores de un numero.
divisoresPerfectoDesde(N,N,[]).
divisoresPerfectoDesde(N,D,[D|R]):- D<N, divisor(N,D), D1 is D+1, divisoresPerfectoDesde(N,D1,R).
divisoresPerfectoDesde(N,D,R):- D<N, D1 is D+1, not(divisor(N,D)),divisoresPerfectoDesde(N,D1,R).

% Regla divisores para un perfecto.
divisoresPerfecto(N,R):-divisoresPerfectoDesde(N,1,R).

% Regla que determina si un numero es perfecto o no.
esPerfecto(N):- divisoresPerfecto(N,D), sumL(D,Sum), Sum==N.

% Predcado aux que calcula n perfectos desde el valor D.
nPerfectosDesde(0,_,[]).
nPerfectosDesde(N,D,[D|RP]):-N>0, esPerfecto(D), N1 is N-1, D1 is D+1, nPerfectosDesde(N1,D1,RP).
nPerfectosDesde(N,D,RP):-N>0, not(esPerfecto(D)), D1 is D+1, nPerfectosDesde(N,D1,RP).

% Predicado general que consulta los perfectos empezando desde el 1.
nPerfectos(N,R):- nPerfectosDesde(N,1,R).

% 20) N primeros numeros primos

% Predicado divisores de un numero N desde D.
divisoresDesde(N,N,[N]).
divisoresDesde(N,D,[D|R]):- D<N, divisor(N,D), D1 is D+1, divisoresDesde(N,D1,R).
divisoresDesde(N,D,R):- D<N, D1 is D+1, not(divisor(N,D)),divisoresDesde(N,D1,R).

% Regla divisores para un numero N.
divisores(N,R):-divisoresDesde(N,1,R).

esPrimo(N):-divisores(N,[P,S|_]), P==1, S==N.

nPrimosDesde(0,_,[]).
nPrimosDesde(N,D,[D|PR]):-N>0, esPrimo(D), D1 is D+1, N1 is N-1, nPrimosDesde(N1,D1,PR).
nPrimosDesde(N,D,PR):-N>0, not(esPrimo(D)), D1 is D+1,nPrimosDesde(N,D1,PR).

nPrimos(N,P):- nPrimosDesde(N,1,P).

% 21) Calculo de la varianza de una lista de numeros.
varianza(L,Var):- media(L,M), cantidad(L,C), varianzaDe(L,M,C,Var).

varianzaDe([],_,_,0).
varianzaDe([P|R],M,C,Var):-  varianzaDe(R,M,C,VarR), Var is (((P-M)^2)/(C-1)) + VarR.

% 22) Moda de una lista de numeros
cantidadRepeticionesDe(_,[],0).
cantidadRepeticionesDe(E,[E|R],Cant):- cantidadRepeticionesDe(E,R,C1), Cant is 1+C1. 
cantidadRepeticionesDe(E,[P|R],Cant):- P\=E, cantidadRepeticionesDe(E,R,Cant).

moda([P],P).
moda([P,S|R],P):- cantidadRepeticionesDe(P,[P,S|R],C1), moda([S|R],MR), cantidadRepeticionesDe(MR,[S|R],C2), C1 >= C2.
moda([P,S|R],MR):- cantidadRepeticionesDe(P,[P,S|R],C1), moda([S|R],MR), cantidadRepeticionesDe(MR,[S|R],C2), C1 < C2.

% Otra forma menos eficiente:
% moda([P],P).
% moda([P,S|R],M):- cantidadRepeticionesDe(P,[P,S|R],C1), cantidadRepeticionesDe(S,[S|R],C2), C1 >= C2, moda([P|R],M).
% moda([P,S|R],M):- cantidadRepeticionesDe(P,[P,S|R],C1), cantidadRepeticionesDe(S,[S|R],C2), C1 < C2, moda([S|R],M).

% 23) Cantidad de numeros que contiene una lista, uso el predicado number(5) => True, number('5')=> False
cantidadNumeros([],0).
cantidadNumeros([P|R],C):- number(P), cantidadNumeros(R,CR), C is 1+CR.
cantidadNumeros([P|R],C):- not(number(P)), cantidadNumeros(R,C).

% 27) Determina si una lista es un palindromo (chequea si la lista es igual al reverso de la lista, uso el predicado REVERSE).
esIgual(E,E).

% Controla si la lista L es igual a su reverso RL.
esPalindromo([P|R],RL,Cant):- iesimo(RL,Cant,UR) ,esIgual(P,UR), eliminar(RL,Cant,RL1), C1 is Cant-1, esPalindromo(R,RL1,C1).
esPalindromo([],[],0).

palindromo(L,RL):- cantidad(L,C), reverse(L,RL), esPalindromo(L,RL,C).

% ------------------ Nivel 5

% 52) Determina la cantidad de listas que que contiene una lista (incluyendo principal).
cantidadSL([],0).
cantidadSL([P|R],C):-is_list(P), cantidadSL(P,CP), C1 is 1+CP, cantidadSL(R,CR), C is C1+CR.
cantidadSL([P|R],C):- not(is_list(P)), cantidadSL(R,C).

cantidadL(L,C):- cantidadSL(L,CL), C is 1 + CL.

% 54) Transformacion de una lista en una lista lineal.
% [1,2,3,[4,5,6]] => [1,2,3,4,5,6]
listaLineal([],[]).
listaLineal([P|R],[P|LR]):- not(is_list(P)), listaLineal(R,LR).
listaLineal([P|R],LL):- is_list(P), listaLineal(P,LP), listaLineal(R,LR), append(LP,LR,LL).

% 57) Cantidad de numeros en una lista con sublistas

% [1,2,3,'a',[4,5,6]]
cantidadNumerosL(L,C):- listaLineal(L,LL), cantidadNumerosLL(LL,C).

% [1,2,3,'a',4,5,6]
cantidadNumerosLL([],0).
cantidadNumerosLL([P|R],C):- number(P), cantidadNumerosLL(R,CR), C is CR+1.
cantidadNumerosLL([P|R],C):- not(number(P)), cantidadNumerosLL(R,C).

% Sin llamar a listaLinealiza
cantidadNumerosLSL([],0).
cantidadNumerosLSL([P|R],C):- not(is_list(P)), number(P),cantidadNumerosLSL(R,CR), C is 1+CR.
cantidadNumerosLSL([P|R],C):- is_list(P), cantidadNumerosLSL(P,CP), cantidadNumerosLSL(R,CR), C is CP+CR.
cantidadNumerosLSL([P|R],C):- not(is_list(P)), not(number(P)),cantidadNumerosLSL(R,C).

% 58) Calcula media de una lista con sublistas.
% Primero linealiza la lista y le calcula la media a esa lista una vez linealizada.
mediaL(L,ML):- listaLineal(L,LL), media(LL,ML).









