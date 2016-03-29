trzeci([_,_,C|_],C).


porownaj([_,_,T,C|_]) :-
	 T = C,
	 write('Yes'),
	 nl,
	 !.
porownaj([_,_,T,C|_]) :-
	 T \= C,
	 write('No'),
	 nl,
	 !.

zamien([P,D,T,C|R],Result) :-
	Result = [P,D,C,T|R].
