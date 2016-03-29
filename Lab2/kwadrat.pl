% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

delta(A,B,C,W) :-
	W is B*B - 4*A*C.

kwadrat(A,B,C,Wynik) :-
	delta(A,B,C,W),
	W < 0,
	write('Brak rozwiazan!'),
	nl,
	Wynik = nan,
	!.

kwadrat(A,B,C,Wynik) :-
	delta(A,B,C,W),
	W =:= 0,
	write('Jedno rozwiazanie: '),
	nl,
	Wynik is -B/(2*A),
	!.

kwadrat(A,B,C,Wynik) :-
	delta(A,B,C,W),
	W > 0,
	write('Dwa rozwiazania: '),
	nl,
	SqDelta is sqrt(W),
	X1 is (-B+SqDelta)/(2*A),
	X2 is (-B-SqDelta)/(2*A),
	Wynik = [X1, X2],
	!.
