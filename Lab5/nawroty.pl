b(1).
b(2).
%c(1).
c(2).
c(3).
d(1).
d(2).
d(3).

%a(X,Y) :-
%	c(X),
%	!,
%	d(Y).

a(X) :-
	b(X),
	!,
	c(X).
a(X) :-
	c(X).


nalezy1(X,[X|_]) :-
	write(X).
nalezy1(X,[_|O]) :-
	nalezy(X,O).

nalezy2(X,[X|_]) :-
	!,
	write(X).
nalezy2(X,[_|O]) :-
	nalezy2(X,O).


max1(X,Y,X) :-
	X >= Y.
max1(X,Y,Y) :-
	X < Y.

max2(X,Y,X) :-
	X >= Y,
	!.
max2(_,Y,Y).
