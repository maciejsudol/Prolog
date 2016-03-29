% bratko, 9.1

gt(X,Y) :- X>Y.
gt(X,Y) :- X@>Y.

bubblesort(List, Sorted) :-
	swap(List, List1), !,
	bubblesort(List1, Sorted).
	% A useful swap in List ?

bubblesort(Sorted, Sorted).
	% Otherwise list is already sorted

swap([X,Y|Rest], [Y,X|Rest]) :- gt(X, Y).
	% swap first two elements

swap([Z|Rest], [Z|Rest1]) :- swap(Rest, Rest1).
	% swap elements in tail
