%%%% Program: kombajn.pl %%%%
%%%%     IDE: SWI-Prolog %%%%
%%%%  Wersja:      1.5.1 %%%%


%% Predykaty dynamiczne
:- dynamic pole/4.
:- dynamic kombajn/6.
:- dynamic magazyn/4.
:- dynamic pieniadze/1.


%% Predykaty statyczne

% osoba/1
osoba(piotr).
osoba(jan).
osoba(michal).
osoba(jakub).

% pole(NrPola, Uprawa, IloscPlonow, ProcentOdpadow)
pole(1, pszenica, 100, 12).
pole(2, kukurydza, 200, 9).
pole(3, owies, 150, 11).
pole(4, zyto, 180, 13).

% kombajn(NrKombajnu, Farmer, NrPola, Pojemnosc, Zaladunek, Cena)
kombajn(1, piotr, 1, 500, 0, 100000).
kombajn(2, jan, 2, 400, 0, 90000).
kombajn(3, michal, 3, 600, 0, 120000).
kombajn(4, jakub, 4, 550, 0, 110000).

% magazyn(NrMagazynu, Uprawa, Pojemnosc, Zaladunek)
magazyn(1, pszenica, 1000, 0).
magazyn(2, kukurydza, 800, 0).
magazyn(3, owies, 900, 0).
magazyn(4, zyto, 1200, 0).

% pieniadze(Ilosc)
pieniadze(100000).


%% Podstawowe definicje - Przypisywanie obiektów do siebie

% rolnik/2
rolnik(Osoba, NrPola) :-
    osoba(Osoba), pole(NrPola, _, _, _).

% przypisz_wlasciciela/3
przypisz_wlasciciela(NrKombajnu, Rolnik, NrPola) :-
    retract(kombajn(NrKombajnu, _, NrPola, Pojemnosc, Zaladunek, Cena)),
    asserta(kombajn(NrKombajnu, Rolnik, NrPola, Pojemnosc, Zaladunek, Cena)).

% przypisz_pole/3
przypisz_pole(NrKombajnu, Rolnik, NrPola) :-
    retract(kombajn(NrKombajnu, Rolnik, _, Pojemnosc, Zaladunek, Cena)),
    asserta(kombajn(NrKombajnu, Rolnik, NrPola, Pojemnosc, Zaladunek, Cena)).


%% Definicje logiczne - Sprawdzanie przynależności

% uzytkuje_kombajn/2
uzytkuje_kombajn(NrKombajnu, Rolnik) :-
    kombajn(NrKombajnu, Rolnik, _, _, _, _).

% uzytkuje_pole/2
uzytkuje_pole(NrPola, Rolnik) :-
    kombajn(_, Rolnik, NrPola, _, _, _).

% rosnie_na_polu/2
rosnie_na_polu(Uprawa, NrPola) :-
    pole(NrPola, Uprawa, _, _).

% jest_w_magazynie/2
jest_w_magazynie(Uprawa, NrMagazynu) :-
    magazyn(NrMagazynu, Uprawa, _, _).


%% Zaawansowane definicje - Akcje kombajnu

% zbieraj_zniwa/1
zbieraj_zniwa(NrKombajnu) :-
    kombajn(NrKombajnu, Rolnik, NrPola, Pojemnosc, Zaladunek, Cena),
    pole(NrPola, Uprawa, IloscPlonow, ProcentOdpadow),
    IloscPlonow > 0,
    DostepnaPojemnosc is Pojemnosc - Zaladunek,
    DostepnaPojemnosc > 0,                                             % Upewnienie się, że jest miejsce w kombajnie
    Zbior is min(DostepnaPojemnosc, IloscPlonow),
    Odpad is ProcentOdpadow / 100 * Zbior,
    NowaIloscPlonow is IloscPlonow - Zbior,
    NowyZaladunek is Zaladunek + Zbior - Odpad,
    retract(pole(NrPola, Uprawa, IloscPlonow, ProcentOdpadow)),
    asserta(pole(NrPola, Uprawa, NowaIloscPlonow, ProcentOdpadow)),
    retract(kombajn(NrKombajnu, Rolnik, NrPola, Pojemnosc, Zaladunek, Cena)),
    asserta(kombajn(NrKombajnu, Rolnik, NrPola, Pojemnosc, NowyZaladunek, Cena)),
    format('Kombajn nr ~w zebral ~w ton upraw ~w z pola nr ~w.~n', [NrKombajnu, Zbior, Uprawa, NrPola]),
    !.
zbieraj_zniwa(_) :-
    format('Blad: brak wystarczajacych plonow na polu lub brak miejsca w kombajnie.~n', []).

% rozladuj_kombajn/3
rozladuj_kombajn(NrKombajnu, Uprawa, NrMagazynu) :-
    kombajn(NrKombajnu, Rolnik, NrPola, PojemnoscK, ZaladunekK, Cena),
    ZaladunekK > 0,
    magazyn(NrMagazynu, Uprawa, PojemnoscM, ZaladunekM),
    DostepnaPojemnoscM is PojemnoscM - ZaladunekM,
    DostepnaPojemnoscM > 0, % Upewnij się, że jest miejsce w magazynie
    Przeladunek is min(ZaladunekK, DostepnaPojemnoscM),
    NowyZaladunekK is ZaladunekK - Przeladunek,
    NowyZaladunekM is ZaladunekM + Przeladunek,
    retract(kombajn(NrKombajnu, Rolnik, NrPola, PojemnoscK, ZaladunekK, Cena)),
    asserta(kombajn(NrKombajnu, Rolnik, NrPola, PojemnoscK, NowyZaladunekK, Cena)),
    retract(magazyn(NrMagazynu, Uprawa, PojemnoscM, ZaladunekM)),
    asserta(magazyn(NrMagazynu, Uprawa, PojemnoscM, NowyZaladunekM)),
    format('Kombajn nr ~w rozladowal ~w ton ~w do magazynu nr ~w.~n', [NrKombajnu, Przeladunek, Uprawa, NrMagazynu]),
    !.
rozladuj_kombajn(_, _, _) :-
    format('Blad: przeladowanie magazynu lub brak wystarczajacego zaladunku w kombajnie.~n', []).


%% Zaawansowane definicje - Zakup kombajnu

% kup_kombajn/2
kup_kombajn(NrKombajnu, Rolnik) :-
    kombajn(NrKombajnu, _, _, _, _, Cena),
    pieniadze(Pieniadze),
    Pieniadze >= Cena,
    NowePieniadze is Pieniadze - Cena,
    retract(pieniadze(Pieniadze)),
    asserta(pieniadze(NowePieniadze)),
    przypisz_wlasciciela(NrKombajnu, Rolnik, -1),
    format('Rolnik ~w kupil kombajn nr ~w za ~w pieniedzy.~n', [Rolnik, NrKombajnu, Cena]),
    !.
kup_kombajn(_, _) :-
    format('Blad: Niewystarczajaca ilosc pieniedzy na zakup kombajnu.~n', []).


%% Główna pętla programu
start :-
    format('
          Rozpoczynam dzialanie programu KOMBAJN
          Wersja programu: ~w
          Autorzy: Michal Kornatowski, Jakub Kosidowski ~n~n', ['1.5.1']),
    format('Start symulacji. ~n', []),
    zbieraj_zniwa(1),
    zbieraj_zniwa(2),
    zbieraj_zniwa(3),
    zbieraj_zniwa(4),
    rozladuj_kombajn(1, pszenica, 1),
    rozladuj_kombajn(2, kukurydza, 2),
    rozladuj_kombajn(3, owies, 3),
    rozladuj_kombajn(4, zyto, 4),
    format('Koniec symulacji. ~n', []),
    format('Dostepne kombajny do kupienia: ~n', []),
    forall(kombajn(NrKombajnu, _, _, _, _, Cena),
           format('  - Kombajn nr ~w (cena: ~w pieniedzy).~n', [NrKombajnu, Cena])).


%% Inicjalizacja programu
:- initialization(start).
