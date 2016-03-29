
mkrandom(X,1,[Y]) :- Y is random(X),!.
mkrandom(X,L,[R1|R]) :-
	R1 is random(X),
	K is L-1,
	mkrandom(X,K,R).
