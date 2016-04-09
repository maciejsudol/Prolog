ksiazka(16, 'Finlandia', autor('Michau', 1838-1919), wydanie('Sowa', 1884)).
ksiazka(17, 'Chrobry', autor('Kichau', 1820-1938), wydanie('Sowa', 2002)).
ksiazka(18, 'Krupnik', autor('Prychau', 1924-1993), wydanie('Sowa', 2007)).
ksiazka(19, 'Zubrowka', autor('Smichau', 1893-1924), wydanie('Sowa', 2001)).

po_smierci(Tytul) :-
	ksiazka(_,Tytul,autor(_,_-RokSmierci),wydanie(_,RokWydania)),
	RokSmierci < RokWydania.


mogl_spotkac(X,Y) :-
	ksiazka(_,_,autor(X,UrX-_),_),  %mlodszy
	ksiazka(_,_,autor(Y,UrY-SmY),_),  %starszy
	UrX =< SmY,
	UrY < UrX,
	X \= Y.


autor(X) :-
	ksiazka(_,_,autor(X,_),_).
autorzy(Autorzy) :-
	bagof(X,autor(X,_,_),Autorzy).


zyje(X,Rok) :-
	ksiazka(_,_,autor(X,Ur-Sm),_),
	Rok > Ur,
	Rok < Sm.
autorzy_zyjacy(Autorzy,Rok) :-
	bagof(X,zyje(X,Rok),Autorzy).


kocha(marcellus,mia).
kocha(vincent,mia).
zazdrosny(X,Y) :-
	kocha(X,Z),
	kocha(Y,Z).


merge([],X,X).
merge([X|L1],L2,[X|L3]) :-
	merge(L1,L2,L3).


mergeSort([],[],[]).  %sorts and merges two already sorted lists
mergeSort([X],[],[X]).
mergeSort([],[Y],[Y]).
mergeSort([X|L1],[Y|L2],[X|List]) :-
	X =< Y,
	!,
	mergeSort(L1,[Y|L2],List).
mergeSort([X|L1],[Y|L2],[Y|List]) :-
	mergeSort([X|L1],L2,List).


student(szymon,agh).
student(krzysiek,agh).
student(weronika,agh).
student(kasia,agh).

fajni_studenci :-
	student(X,agh),write(X),write(' nie jest fajny'),
	!.
fajni_studenci :- write('Oni sa fajni!').


:- op(80,xfx,jest).
jest(sokrates,czlowiekiem).

