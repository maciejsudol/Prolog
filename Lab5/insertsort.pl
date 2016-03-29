% bratko 9.1

gt(X,Y) :- X>Y.
gt(X,Y) :- X@>Y.

insertsort([], []).
insertsort([Head|Tail], L2):-
        insertsort(Tail, L1),
        insert(Head, L1, L2).

insert(Element, [Head|Tail], [Head|Rest]):-
        gt(Element,Head),!,
        insert(Element, Tail, Rest).
insert(Element, List, [Element|List]).
