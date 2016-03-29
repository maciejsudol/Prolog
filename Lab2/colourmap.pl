kolor(czerwony).
kolor(zielony).
kolor(niebieski).

koloruj(A,B,C,D,E) :-
	kolor(A),  %Polska
	kolor(B),  %Bialorus
	kolor(C),  %Ukraina
	kolor(D),  %Slowacja
	kolor(E),  %Czechy
	A \= B,	A \= C,	A \= D,	A \= E,  %Dla Polski
        B \= C,  %Dla Bialorusi
	C \= D,  %Dla Ukrainy
	D \= E.  %Dla Slowacji

