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
cantidad([_|T],N):- cantidad(T,N1), N is N1+1.

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

% ------------------Nivel 3

% 19) Calcule el i-esimo numero perfecto.

% Uso un predicado que encuentre los divisores de un numero.
divisores(N,[1|R]):- Div>=1, Div \= N, D2 is Div+1,  divisores(N,R).












