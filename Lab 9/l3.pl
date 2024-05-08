podwojenie([],[]).

podwojenie([H1|T1],[H1,H1|T2]):-
    podwojenie(T1,T2).
