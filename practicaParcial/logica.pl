% Sumatoria de elementos de una lista
sumatoria([],0).
sumatoria([P|R],S):- sumatoria(R,SR),S is P+SR.

% Cantidad de elementos de una lista
cantidad([],0).
cantidad([_|R],C):- cantidad(R,CR), C is 1+CR. 

% Calculo de la media de una lista de numeros
media([],0).
media(L,M):- cantidad(L,Cant), sumatoria(L,Sum), M is Sum / Cant.

% Maximo de una lista
maximo([P],P).
maximo([P|R],P):- maximo(R,MR), P>=MR.
maximo([P|R],MR):- maximo(R,MR), P<MR.

% Reemplazo todas las apariciones de un elemento por otro en una lista.
reemplazo([],_,_,[]).
reemplazo([P|R],P,Rempl,[Rempl|RL]):-reemplazo(R,P,Rempl,RL).
reemplazo([X|R],P,Rempl,[X|RL]):-X\=P, reemplazo(R,P,Rempl,RL).

% Escriba una función que determine si una lista de {0,1}, 
% donde cada 0 representa un paréntesis que abre  y cada 1 un paréntesis que cierra,
% está balanceada (es decir, que cada 0 tiene su 1 correspondiente de acuerdo a las reglas que siguen los paréntesis). 
% Ej: (001101) está balanceada y (1001010) no lo está.
estaBalanceada([]).
estaBalanceada([0|R]) :- balanceada(R,[0]).

balanceada([],[]).
balanceada([0|R],Res) :- balanceada(R,[0|Res]).
balanceada([1|R],S) :- cantidad(S,CS), CS>0, pop(S,Res), balanceada(R,Res).

pop([],[]).
pop([_|R],R).


% Predicado que elimine repeticiones adyacentes de sus elementos.
eliminarRepeticionesAdyacentes([],[]).
eliminarRepeticionesAdyacentes([P],[P]).
eliminarRepeticionesAdyacentes([P,P|R],RR):-eliminarElementosHastaDistinto(P,R,Res), eliminarRepeticionesAdyacentes(Res,RR).
eliminarRepeticionesAdyacentes([P,S|R],[P,S|RR]):-P\=S, eliminarRepeticionesAdyacentes(R,RR).

eliminarElementosHastaDistinto(_,[],[]).
eliminarElementosHastaDistinto(P,[P|R],Res):-eliminarElementosHastaDistinto(P,R,Res).
eliminarElementosHastaDistinto(P,[X|R],[X|R]):- P\=X.

% Predicado tipo parcial
% Toma como entrada una lista de numeros (con sublistas) y devuelve una lista de minimos
% de cada sublista. Para calcular el minimo de una sublista solo tiene en cuenta los de su nivel.

% NL=(2 (5 4 7 7) 5 (3 (4 9) 10) 6 (5 7) 4 9 2) Resultado: (2 4 3 4 5) 

minimo([P],P).
minimo([P|R],P):- minimo(R,MR), P=<MR.
minimo([P|R],MR):-minimo(R,MR), P>MR.

minimosPrimerLista([],[]).
minimosPrimerLista([P],[P]).
minimosPrimerLista([P|R],[MP|Res]):- cantSL([P|R],C), C>0, sinSL([P|R],PSSL), minimo(PSSL,MP), soloSL([P|R],SL),minimosPrimerLista(SL,Res).
minimosPrimerLista([P|R],[MP]):- cantSL([P|R],C), C==0, minimo([P|R],MP).

minimosLista([],[]).
minimosLista([P|R],[MP|MR]):-is_list(P), sinSL(P,PSSL), minimo(PSSL,MP), soloSL([P|R],SL), minimosLista(SL,MR).
minimosLista([P|R],MR):-is_list(P), minimosLista(R,MR).

sinSL([P],[P]).
sinSL([P|R],SSL):-is_list(P),sinSL(R,SSL).
sinSL([P|R],[P|SSL]):-not(is_list(P)),sinSL(R,SSL).

soloSL([],[]).
soloSL([P|R],[P,SLR]):-is_list(P), soloSL(R,SLR), SLR\=[].
soloSL([P|R],P):-is_list(P), soloSL(R,SLR), SLR==[].
soloSL([P|R],SSL):-not(is_list(P)),soloSL(R,SSL).

cantSL([],0).
cantSL([P|R],CSL):-is_list(P),cantSL(P,CSLP),cantSL(R,CSLR), CSL is 1 + CSLP + CSLR.
cantSL([P|R],CSL):-not(is_list(P)),cantSL(R,CSL).

% Lista con mayor cantidad de elementos, incluye sublistas (y no cuentan como elemento)
contieneSL([P|_]):- is_list(P).
contieneSL([P|R]):- not(is_list(P)), contieneSL(R).

linealiza([],[]).
linealiza([P|R],LL):-is_list(P),linealiza(P,LP), linealiza(R,LR), append(LP,LR,LL).
linealiza([P|R],[P|LR]):-not(is_list(P)),linealiza(R,LR).

cantSinSL([],0).
cantSinSL([P|R],C):- not(is_list(P)), cantSinSL(R,CR), C is 1+CR.
cantSinSL([P|R],C):- is_list(P), cantSinSL(R,C).

mayorCantEl(L,C):- not(contieneSL(L)), cantSinSL(L,C).
mayorCantEl([P|R],C):-not(is_list(P)), contieneSL([P|R]), cantSinSL([P|R],C), mayorCantEl(R,CR), C >= CR.
mayorCantEl([P|R],C):-contieneSL([P|R]), is_list(P), cantSinSL([P|R],C), mayorCantEl(R,CR), C >= CR, mayorCantEl(P,CP), C >= CP.
mayorCantEl([P|R],CP):-contieneSL([P|R]), is_list(P), cantSinSL([P|R],C), mayorCantEl(R,CR), C >= CR, mayorCantEl(P,CP), C < CP.
mayorCantEl([P|R],CR):-not(is_list(P)), contieneSL([P|R]), cantSinSL([P|R],C), mayorCantEl(R,CR1), C < CR1, mayorCantEl(R,CR).

sublistaConCant([P|R],C,[P|R]):-cantSinSL([P|R],C).
sublistaConCant([P|_],C,P):-is_list(P),cantSinSL(P,C).
sublistaConCant([P|_],C,S):-is_list(P),cantSinSL(P,X), X\=C, contieneSL(P), sublistaConCant(P,C,S).
sublistaConCant([P|R],C,S):-is_list(P),cantSinSL(P,X), X\=C, not(contieneSL(P)), sublistaConCant(R,C,S).
sublistaConCant([P|R],C,S):-not(is_list(P)), sublistaConCant(R,C,S).

listaSinSL([],[]).
listaSinSL([P|R],S):- is_list(P), listaSinSL(R,S).
listaSinSL([P|R],[P|S]):- not(is_list(P)), listaSinSL(R,S).

listamayor([],[]).
listamayor([P|R],L):- mayorCantEl([P|R],MC), sublistaConCant([P|R],MC,LMC), listaSinSL(LMC,L).


% Ej: para L=(5 3 7 5 4 4 8 9) y N=3, el resultado es (15 15 16 13 16 21)

% (1 2 3 4) N = 2 => 1 + (2 3 4) N = 1 => 1 + 2 (3 4) N = 0.
largo([],0).
largo([_|R],C):- largo(R,LR), C is 1+LR.

sumatoriaHasta(_,0,0).
sumatoriaHasta([P|R],N,S):- N>0, N1 is N-1, sumatoriaHasta(R,N1,SR), S is P + SR.

sumatoriasDeAN([P|R],N,[S1|S2]):- largo([P|R],L), L>=N, sumatoriaHasta([P|R],N,S1), sumatoriasDeAN(R,N,S2).
sumatoriasDeAN([P|R],N,[]):- largo([P|R],L), L<N.

% Encontrar la lista con mayor sumatoria de sus elementos numericos dentro de una lista.
% Ej: L=(5 (9 ((3 7 4)  5  (6 (15 3)) 4) 10) 9 1), el resultado es (9 10)

sumN([],0).
sumN([P|R],S):- number(P), sumN(R,SR), S is P + SR.
sumN([P|R],S):- not(number(P)), sumN(R,S).

maxSumatoria([],0).
maxSumatoria([P|R],SPR):- sumN([P|R],SPR), maxSumatoria(R,SR), SPR > SR.
maxSumatoria([P|R],SR):- sumN([P|R],SPR), maxSumatoria(R,SR), SPR < SR.
maxSumatoria([P|R],SP):- is_list(P), sumN(P,SP), maxSumatoria(R,SR), SP >= SR, maxSumatoria(P,MSP), SP >= MSP.
maxSumatoria([P|R],MSP):- is_list(P), sumN(P,SP), maxSumatoria(R,SR), SP >= SR, maxSumatoria(P,MSP), SP < MSP.
maxSumatoria([P|R],SR):- is_list(P), sumN(P,SP), maxSumatoria(R,SR), SP < SR.

listaPorSumatoria(L,S,LSSL):- is_list(L), sumN(L,S), listaNumericaSinSL(L,LSSL).
listaPorSumatoria([P|_],S,PSSL):- is_list(P), sumN(P,S), listaNumericaSinSL(P,PSSL).
listaPorSumatoria([P|R],S,L):- is_list(P), sumN(P,X), X\=S, listaPorSumatoria(R,S,L).
listaPorSumatoria([P|R],S,L):- not(is_list(P)), listaPorSumatoria(R,S,L).

listaNumericaSinSL([],[]).
listaNumericaSinSL([P|R],[P|RSSL]):-number(P),listaNumericaSinSL(R,RSSL).
listaNumericaSinSL([P|R],RSSL):-not(number(P)),listaNumericaSinSL(R,RSSL).

listaMaxSumatoria(L,LM):-is_list(L), maxSumatoria(L,MS), listaPorSumatoria(L,MS,LM).












