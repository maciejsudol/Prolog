start :-
	consult('blocks.pl'),
	write('Wczytane!'),
	nl.

on(a1,a2).
on(a2,a3).
on(a3,a4).
on(c1,c2).
on(c3,c4).

just_left(c2,c4).
just_left(a5,c2).
just_left(a4,a5).
