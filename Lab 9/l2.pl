kwadrat_lista([],[]).

kwadrat_lista([H1|T1],[H2|T2]):-
    H2 is H1*H1,
    kwadrat_lista(T1,T2).
