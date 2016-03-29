% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

rodzic(kasia,robert).
rodzic(tomek,robert).
rodzic(tomek,eliza).
rodzic(robert,anna).
rodzic(robert,magda).
rodzic(magda,jan).

kobieta(kasia).
kobieta(eliza).
kobieta(magda).
kobieta(anna).

mezczyzna(tomek).
mezczyzna(robert).
mezczyzna(jan).

tata(X,Y) :-
	rodzic(X,Y),
	mezczyzna(X).

mama(X,Y) :-
	rodzic(X,Y),
	kobieta(X).

brat(X,Y) :-
	mezczyzna(X),
	rodzic(Z,X),
	rodzic(Z,Y),
	X\=Y.

siostra(X,Y) :-
	kobieta(X),
	rodzic(Z,X),
	rodzic(Z,Y),
	X\=Y.

dziadek(X,Y) :-
	mezczyzna(X),
	rodzic(X,Z),
	rodzic(Z,Y).

babcia(X,Y) :-
	kobieta(X),
	rodzic(X,Z),
	rodzic(Z,Y).


przodek(X,Y) :-
	rodzic(X,Y).

przodek(X,Z) :-
	rodzic(X,Y),
	przodek(Y,Z).


potomek(X,Y) :-
	rodzic(Y,X).

potomek(X,Z) :-
	rodzic(Z,Y),
	potomek(X,Y).


potomek2(X,Y) :-
	przodek(Y,X).
