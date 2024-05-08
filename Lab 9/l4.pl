liczba_elem([],0).

liczba_elem([_|T],N):-
    liczba_elem(T,N1),
    N is N1+1.
