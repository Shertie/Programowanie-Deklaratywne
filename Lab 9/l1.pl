wypisz_lista([]).

wypisz_lista([H|T]):-
    write(H),
    nl,
    wypisz_lista(T).
