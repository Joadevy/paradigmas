estaBalanceada([]).
estaBalanceada([0|R]) :- balanceada(R,[0]).

balanceada([],[]).
balanceada([0|R],Res) :- balanceada(R,[0|Res]).
balanceada([1|R],S) :- cantidad(S,CS), CS>0, pop(S,Res), balanceada(R,Res).

cantidad([],0).
cantidad([_|R],C):- cantidad(R,CR), C is 1+CR.

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

minimosLista([],[]).
minimosLista([P|R],[MP|MR]):-is_list(P), sinSL(P,PSSL), minimo(PSSL,MP), soloSL([P|R],SL), minimosLista(SL,MR).
minimosLista([P|R],MR):-not(is_list(P)), minimosLista(R,MR).

minimo([P],P).
minimo([P|R],P):- minimo(R,MR), P=<MR.
minimo([P|R],MR):-minimo(R,MR), P>MR.

sinSL([P],[P]).
sinSL([P|R],SSL):-is_list(P),sinSL(R,SSL).
sinSL([P|R],[P|SSL]):-not(is_list(P)),sinSL(R,SSL).

cantSL([],0).
cantSL([P|R],CSL):-is_list(P),cantSL(P,CSLP),cantSL(R,CSLR), CSL is 1 + CSLP + CSLR.
cantSL([P|R],CSL):-not(is_list(P)),cantSL(R,CSL).

soloSL([],[]).
soloSL([P|R],[P,SLR]):-is_list(P), soloSL(R,SLR), SLR\=[].
soloSL([P|R],P):-is_list(P), soloSL(R,SLR), SLR==[].
soloSL([P|R],SSL):-not(is_list(P)),soloSL(R,SSL).
