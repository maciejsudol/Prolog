move(1,Left,Right,_) :-  
    write('Move top disk from '), 
    write(Left), 
    write(' to '), 
    write(Right), 
    nl. 
move(N,Left,Right,Center):- 
    N>1, 
    M is N-1, 
    move(M,Left,Center,Right), 
    move(1,Left,Right,_), 
    move(M,Center,Right,Left). 
