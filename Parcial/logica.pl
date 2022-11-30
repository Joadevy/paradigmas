% Toma como entrada una lista L (con sublistas) y un numero M, devuelve una con la misma estructura de L pero con los resultados de sumar M a cada elemento de L.

% Ejemplo: L = (1 (2 3) (4 (5) 6) 7) M=5.
% Resultado: (6 (7 8) (9 (10) 11) 12)

sumarLista([],_,[]).
sumarLista([P|R],M,[S|SR]):-number(P), S is P+M, sumarLista(R,M,SR). 
sumarLista([P|R],M,[SP|SR]):-is_list(P), (sumarLista(P,M,SP)), sumarLista(R,M,SR). 

% Toma como entrada lista L (con sublistas) y una posicion P.
% Devuelve la lista de todos los elementos que estan en la posicion P de cada sublista (incluyendo la lista principal).
% Si el elemento no existe (tiene menos elementos que la pos), se pone 0.
% Para el calculo de la posicion SOLO CUENTAN NUMEROS.

% Ejemplo: L = (6 (3 8) (3 (2) 1) 7) P=2
% Resultado: (7 8 1 0)

% Si un elemento es una sublista, no cuenta su posicion.
elementoEnPos([],_,_,[]).
elementoEnPos([P|_],PE,PE,P):- not(is_list(P)).
elementoEnPos([P|R],PE,Pos,E):- not(is_list(P)), Pos \= PE, Pos2 is Pos+1, elementoEnPos(R,PE,Pos2,E).
elementoEnPos([P|R],PE,Pos,E):- is_list(P), elementoEnPos(R,PE,Pos,E).

listaElementosEnPos([],_,[]).
listaElementosEnPos([P|R],Pos,[0|ET]):-is_list(P), elementoEnPos([P|R],Pos,1,E), E=[], listaElementosEnPos(P,Pos,EP), listaSubEnPos(R,Pos,ER), append(EP,ER,ET).
listaElementosEnPos([P|R],Pos,[E|ET]):-is_list(P), elementoEnPos([P|R],Pos,1,E), E\=[], listaElementosEnPos(P,Pos,EP), listaSubEnPos(R,Pos,ER), append(EP,ER,ET).
listaElementosEnPos([P|R],Pos,[0|ER]):-not(is_list(P)), elementoEnPos([P|R],Pos,1,E), E=[], listaSubEnPos(R,Pos,ER).
listaElementosEnPos([P|R],Pos,[E|ER]):-not(is_list(P)), elementoEnPos([P|R],Pos,1,E), E\=[], listaSubEnPos(R,Pos,ER).

listaSubEnPos([],_,[]).
listaSubEnPos([P|R],Pos,ET):- is_list(P), listaElementosEnPos(P,Pos,EP), listaSubEnPos(R,Pos,ER), append(EP,ER,ET).
listaSubEnPos([P|R],Pos,ER):- not(is_list(P)), listaSubEnPos(R,Pos,ER).

main(L,Pos,Resultado):- listaElementosEnPos(L,Pos,Resultado).