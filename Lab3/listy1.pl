nalezy(X,[X|_]).
nalezy(X,[_|Yogon]) :-
	nalezy(X,Yogon).


dlugosc([],0).
dlugosc([_|Ogon],Dlugosc) :-
	dlugosc(Ogon,X),
	Dlugosc is X+1.

a2b([],[]).
a2b([a|Ta],[b|Tb]) :-
	a2b(Ta,Tb).


sklej([],X,X).
sklej([X|L1],L2,[X|L3]) :-
	sklej(L1,L2,L3).


nalezy2(X,L) :-
	sklej(_,[X|_],L).


ostatni([Element], Element).
ostatni([_|Ogon], Element) :-
	ostatni(Ogon, Element).


ostatni2(Lista, Element) :-
	sklej(_,[Element],Lista).


dodaj(X,L,[X|L]).


usun(X,[X|Reszta],Reszta).
usun(X,[Y|Ogon],[Y|Reszta]) :-
	usun(X,Ogon,Reszta).


wstaw(X,L,Duza) :-
	usun(X,Duza,L).

nalezy3(X,L) :-
	usun(X,L,_).


zawiera(S,L) :-
	sklej(_,L2,L),  %L2 zawiera mozliwe do przyklejenia listy
	sklej(S,_,L2).  %Czy da sie cos przykleic, aby powstalo L2


permutacja([],[]).
permutacja([X|L],P) :-
	permutacja(L,L1),
	wstaw(X,L1,P).


permutacja2([],[]).
permutacja2(L,[X|P]) :-
	usun(X,L,L1),
	permutacja(L1,P).


odwroc([],[]).
odwroc([H|T],L) :-
	odwroc(T,R),
	sklej(R,[H],L).


wypisz([]).
wypisz([H|T]) :-
	put(H),
	wypisz(T).


plural(Noun, PL) :-
	name(Noun, L),
	name(s,T),
	append(L,T,NL),
	name(PL,NL).
