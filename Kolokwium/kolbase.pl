:- dynamic(kobieta/1).

kobieta(ala).
kobieta(czarek).
kobieta(szymon).
kobieta(monika).

start :-
	write('Podaj imie zenskie lub \'stop\' w celu zakonczenia:'),
	nl,
	read(Name),
	answer(Name).

answer(stop) :-
	true,
	!.

answer(Name) :-
	kobieta(Name),
	write('Podane imie znajduje sie w bazie'),
	nl,
	!,
	start.

answer(Name) :-
	write('Podane imie nie znajduje sie w bazie'),
	nl,
	write('Dodaje imie do bazy'),
	nl,
	assert(kobieta(Name)),
	write('Aktualna baza wiedzy:'),
	nl,nl,
	listing(kobieta),
	start.


