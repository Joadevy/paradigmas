% Toma como entrada una lista L (con sublistas) y un numero M, devuelve una con la misma estructura de L pero con los resultados de sumar M a cada elemento de L.

% Ejemplo: L = (1 (2 3) (4 (5) 6) 7) M=5.
% Resultado: (6 (7 8) (9 (10) 11) 12)

sumarLista([],_,[]).
sumarLista([P|R],M,[S|SR]):-number(P), S is P+M, sumarLista(R,M,SR). 
sumarLista([P|R],M,[SP|SR]):-is_list(P), (sumarLista(P,M,SP)), sumarLista(R,M,SR). 
