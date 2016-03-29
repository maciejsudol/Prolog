:-dynamic(a/1), dynamic(b/2).

a(1). a(2).

addrule:- assert((b(X,Y):-a(X),a(Y))).

delrule:- retract((b(_,_):-_)).

start:- addrule, b(X,Y), write(X), write('  '), write(Y),nl,fail.
start.
