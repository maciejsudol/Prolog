% Figure 9.2  Quicksort.


% quicksort( List, SortedList): sort List by the quicksort algorithm

gt(X,Y) :- X>Y.
gt(X,Y) :- X@>Y.

conc([],L,L).
conc([X|L1],L2,[X|L3]) :-
	conc(L1,L2,L3).

quicksort( [], []).

quicksort( [X|Tail], Sorted)  :-
   split( X, Tail, Small, Big),
   quicksort( Small, SortedSmall),
   quicksort( Big, SortedBig),
   conc( SortedSmall, [X|SortedBig], Sorted).

split( _, [], [], []).

split( X, [Y|Tail], [Y|Small], Big)  :-
   gt( X, Y), !,
   split( X, Tail, Small, Big).

split( X, [Y|Tail], Small, [Y|Big])  :-
   split( X, Tail, Small, Big).
