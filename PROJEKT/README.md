# Wstęp

Ten dokument zawiera szczegółowy opis projektu Kombajn, oprogramowania symulującego pracę kombajnów. Projekt jest napisany w języku Prolog i wykorzystuje dynamiczne predykaty do zarządzania stanem symulacji.

# Cel projektu

Celem projektu Kombajn jest stworzenie realistycznej symulacji pracy kombajnów. Symulacja obejmuje następujące elementy:

* Przypisywanie kombajnów do pól i rolników
* Zbieranie plonów z pól
* Rozładowywanie kombajnów do magazynów
* Zarządzanie stanem pól, kombajnów i magazynów
* Struktura programu

# Program składa się z następujących głównych części:

## 1. Predykaty dynamiczne:

- `pole/4`: Przechowuje informacje o polu, takie jak: numer pola, uprawę, ilość plonów i procent odpadów.
- `kombajn/6`: Przechowuje informacje o kombajnie, takie jak: numer kombajnu, rolnika, numer pola, pojemność, poziom załadunku i cenę.
- `magazyn/4`: Przechowuje informacje o magazynie, takie jak: numer magazynu, uprawę, pojemność i poziom załadunku.

## 2. Predykaty statyczne:

- `osoba/1`: Definiuje listę osób (rolników) biorących udział w symulacji.
- `pole/4`: Definiuje statyczne informacje o polach, takie jak numer pola, uprawa, ilość plonów i procent odpadów.
- `kombajn/6`: Definiuje statyczne informacje o kombajnach, takie jak numer kombajnu, rolnik, numer pola, pojemność, poziom załadunku i cena.
- `magazyn/4`: Definiuje statyczne informacje o magazynach, takie jak numer magazynu, uprawa, pojemność i poziom załadunku.

## 3. Definicje podstawowe:

- `rolnik/2`: Przypisuje kombajn do pola i rolnika.
- `przypisz_wlasciciela/3`: Przypisuje kombajn do rolnika.
- `przypisz_pole/3`: Przypisuje kombajn do pola.

## 4. Definicje logiczne:

- `uzytkuje_kombajn/2`: Sprawdza, czy rolnik użytkuje dany kombajn.
- `uzytkuje_pole/2`: Sprawdza, czy rolnik użytkuje dane pole.
- `rosnie_na_polu/2`: Sprawdza, jaka uprawa rośnie na danym polu.
- `jest_w_magazynie/2`: Sprawdza, czy dana uprawa znajduje się w danym magazynie.

## 5. Definicje zaawansowane:

- `zbieraj_zniwa/1`: Zbiera plony z pola za pomocą kombajnu.
- `rozladuj_kombajn/3`: Rozładowuje kombajn do magazynu.

## 6. Główna pętla programu:

`start/0`: Inicjuje symulację, wykonuje zbiór plonów z pól i rozładowanie kombajnów.
Przykład użycia

# Program można uruchomić, wpisując w konsoli SWI Prolog:

`?- start.` - Spowoduje to zainicjowanie symulacji, zebranie plonów z pól i rozładowanie kombajnów do magazynów.

# Podsumowanie

Projekt Kombajn jest udaną symulacją pracy kombajnów. Program wykorzystuje dynamiczne predykaty i definicje logiczne do realistycznego modelowania interakcji między kombajnami, polami i magazynami.

# Autorzy

***Michał Kornatowski***

***Jakub Kosidowski***