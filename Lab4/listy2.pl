merge([],X,X).
merge([X|L1],L2,[X|L3]) :-
	merge(L1,L2,L3).

odwroc([],[]).
odwroc([H|T],L) :-
	odwroc(T,R),
	merge(R,[H],L).

nalezy(X,[X|_]).
nalezy(X,[_|T]) :-
	nalezy(X,T).

usun(X,[X|Reszta],Reszta).
usun(X,[Y|Ogon],[Y|Reszta]) :-
	usun(X,Ogon,Reszta).

del3last(List,Result) :-  %usuwa 3 ostatnie elem
	merge(Result,[_,_,_],List),
	!.


del3first(List,Result) :-  %usuwa 3 pierwsze elem
	merge([_,_,_],Result,List),
	!.


del3and3(List,Result) :-  %usuwa 3 pier i 3 ost el
	merge([_,_,_],Tmp,List),
	merge(Result,[_,_,_],Tmp),
	!.


parzysta([]).
parzysta([_,_|Reszta]) :-
	parzysta(Reszta).


nieparzysta([_]).
nieparzysta([_,_|Reszta]) :-
	nieparzysta(Reszta).


palindrom(L) :-
	odwroc(L,L).


przesun([H|T],Result) :-
	merge(T,[H],Result).


znaczy(0,zero).
znaczy(1,jeden).
znaczy(2,dwa).
znaczy(3,trzy).
znaczy(4,cztery).
znaczy(5,piec).
znaczy(6,szesc).
znaczy(7,siedem).
znaczy(8,osiem).
znaczy(9,dziewiec).

przeloz([],[]).
przeloz([H|T],[What|Result]) :-
	znaczy(H,What),
	przeloz(T,Result).


podzbior([],_).
podzbior([H|T],L) :-
	nalezy(H,L),
	usun(H,L,Tmp),
	podzbior(T,Tmp).


subset([],[]).
subset([H|SetTail],[H|SubsetTail]) :-
	subset(SetTail,SubsetTail).
subset([_|SetTail],Subset) :-
	subset(SetTail,Subset).


podziel([],[],[]).
podziel([X],[X],[]).
podziel([X,Y|T],[X|L1],[Y|L2]) :-
	podziel(T,L1,L2),
	!.


splaszcz([],[]).
splaszcz([H|T],Result) :-
	splaszcz(H,Tmp1),
	splaszcz(T,Tmp2),
	merge(Tmp1,Tmp2,Result),
	!.
splaszcz(L,[L]).


moneta(0.01).
moneta(0.02).
moneta(0.05).
moneta(0.1).
moneta(0.2).
moneta(0.5).
moneta(1).
moneta(2).
moneta(5).

rozmien(Kwota,[Kwota]) :-
	moneta(Kwota).
rozmien(Kwota,[TmpK|[H|T]]) :-  %rozmien(Kwota,Lista) :-
	Kwota > 0,
	moneta(TmpK),
	K1 is Kwota - TmpK,
	rozmien(K1,[H|T]),
	H >= TmpK.
%	Lista = [TmpK|[H|T]].
