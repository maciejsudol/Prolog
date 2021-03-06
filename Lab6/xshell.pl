% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only


% XSHELL.PL

%
% An expert system consultation driver to be used
% with separately written knowledge bases.
%
% Procedures in the file include XSHELL, XSHELL_AUX,
% FINISH_XSHELL, PROP, PARM, PARMSET, PARMRANGE,
% EXPLAIN, MEMBER, and WAIT.
%
% Requires various procedures defined in the files
% READSTR.PL, READNUM.PL, and GETYESNO.PL from
% Chapter 5.
%

:- dynamic known/2.

:- ensure_loaded('readstr.pl').
:- ensure_loaded('readnum.pl').
:- ensure_loaded('writeln.pl').
:- ensure_loaded('getyesno.pl').

%
% xshell
%   The main program or procedure for the expert system
%   consultation driver. It always succeeds.
%

xshell :- xkb_intro(Statement),
          writeline(Statement), nl,
          wait,
          xkb_identify(RULE,TextList),
          asserta(known(identification,RULE)),
          append_list(TextList,Text),
          writeline(Text), nl,
          explain,
          xkb_unique(yes),
          !,
          xshell_aux.

xshell :- xshell_aux.

%
% xshell_aux
%   Prevents an abrupt end to a consultation that ends
% without an identification, or a consultation where
% multiple identifications are allowed.
%

xshell_aux :- \+ known(identification,_),
              writeline('I cannot reach a conclusion.'),
              !,
              finish_xshell.

xshell_aux :- xkb_unique(no),
              known(identification,_),
              writeline('I cannot reach any further conclusion.'),
              !,
              finish_xshell.

xshell_aux :- finish_xshell.

%
% finish_xshell
%   Erases the working database and asks if the user wants
%   to conduct another consultation. 
%

finish_xshell :-
     retractall(known(_,_)),
     writeline('Do you want to conduct another consultation?'),
     yes, nl, nl,
     !,
     xshell.

finish_xshell.

%
% prop(+Property)
%   Succeeds if it is remembered from an earlier call that
%   the subject has the Property.  Otherwise the user is
%   asked if the subject has the Property and the user's
%   answer is remembered. In this case, the procedure call
%   succeeds only if the user answers 'yes'.
%

prop(Property) :- known(Property,Value),
                  !,
                  Value == y.

prop(Property) :- xkb_question(Property,Question,_,_),
                  writeline(Question),
                  yes, nl, nl,
                  !,
                  assert(known(Property,y)).

prop(Property) :- assert(known(Property,n)),
                  nl, nl,
                  !,
                  fail.

%
% parm(+Parameter,+Type,+Value)
%   Type determines whether Value is to be a menu choice, an
%   atom, or a number.  Value becomes the remembered value
%   for the parameter if there is one. Otherwise the user is
%   asked for a value and that value is remembered. Calls to
%   this procedure are used as test conditions for identification
%   rules. Value is instantiated before the procedure is called 
%   and parm(Parameter,Type,Value) only succeeds if the remembered
%   value, or alternatively the value reported by the user, 
%   matches Value.
%

parm(Parameter,_,Value) :- known(Parameter,StoredValue),
                           !,
                           Value = StoredValue.

parm(Parameter,m,Value) :- xkb_menu(Parameter,Header,Choices,_),
                           length(Choices,L),
                           writeline(Header),nl,
                           enumerate(Choices,1),
                           readnumber_in_range(1,L,N), nl, nl,
                           assert(known(Parameter,N)),
                           !,
                           Value = N.

parm(Parameter,a,Value) :- xkb_question(Parameter,Question,_,_),
                           writeline(Question),
                           readatom(Response), nl, nl,
                           assert(known(Parameter,Response)),
                           !,
                           Value = Response.

parm(Parameter,n,Value) :- xkb_question(Parameter,Question,_,_),
                           writeline(Question),
                           readnumber(Response), nl, nl,
                           assert(known(Parameter,Response)),
                           !,
                           Value = Response.

%
% parmset(+Parameter,+Type,+Set)
%   Type indicates whether the Parameter takes a character,
%   an atom, or a number as value, and Set is a list of
%   possible values for Parameter.  A call to the procedure
%   succeeds if a value for Parameter is established that is
%   a member of Set.
%

parmset(Parameter,Type,Set) :- parm(Parameter,Type,Value),
                               member(Value,Set).

%
% parmrange(+Parameter,+Minimum,+Maximum)
%   Parameter must take numbers as values, and Minimum and
%   Maximum must be numbers. A call to the procedure succeeds
%   if a value for Parameter is established that is in the
%   closed interval [Minimum,Maximum].
%

parmrange(Parameter,Minimum,Maximum) :-
     parm(Parameter,n,Value),
     Minimum =< Value,
     Maximum >= Value.

%
% explain and explain_aux
%   Upon request, provide an explanation of how an 
%   identification was made.
%

explain :- xkb_explain(no), wait, !.

explain :- writeline(
           ['Do you want to see the rule that was used',
            'to reach the conclusion?']),
           \+ yes, nl, !.

explain :- known(identification,RULE),
           clause(xkb_identify(RULE,_),Condition),
           nl,nl,
           write('Rule '),
           write(RULE),
           write(': reach this conclusion IF'), nl,
           explain_aux(Condition), nl, 
           wait, nl, !.

explain_aux((Condition,RestOfConditions)) :-
        !,
        interpret(Condition),
        explain_aux(RestOfConditions).
explain_aux(Condition) :-
        interpret(Condition).

%
% interpret(+Condition).
%   Uses questions and menus associated with a condition of
%   and identification rule to display the condition in a 
%   format that makes sense to the user.
%

interpret(prop(Property)) :-
        !,
        xkb_question(Property,_,Text,_),
            % Text is a message that says the subject to be
            % identified has the Property.
        write(Text), nl.
interpret(\+(prop(Property))) :-
        !,
        xkb_question(Property,_,_,Text),
            % Text is a message that says the subject to be
            % identified does not have the Property.
        write(Text), nl.
interpret(parm(Parameter,m,N)) :-
        !,
        xkb_menu(Parameter,_,Choices,Prefix),
            % Prefix is a phrase that informs the user which
            % Parameter is involved.
        nth_member(N,Text,Choices),
            % nth_member is used to retrieve the user's choice
            % from the menu associated with the Parameter.
        write(Prefix), write(Text), write('.'), nl.

interpret(\+(parm(Parameter,m,N))) :-
        !,
        xkb_menu(Parameter,_,Choices,Prefix),
            % Prefix is a phrase that informs the user which
            % Parameter is involved.
        nth_member(N,Text,Choices),
            % nth_member is used to retrieve the user's choice
            % from the menu associated with the Parameter.
        write(Prefix), write('NOT '), write(Text), write('.'), nl.
interpret(parm(Parameter,_,Value)) :-
        !,    % For any Parameter whose Value is not obtained
              % by using a menu.
        xkb_question(Parameter,_,Prefix,_),
        write(Prefix), write(Value), write('.'), nl.
interpret(\+(parm(Parameter,_,Value))) :-
        !,    % For any Parameter whose Value is not obtained
              % by using a menu.
        xkb_question(Parameter,_,Prefix,_),
        write(Prefix), write('NOT '), write(Value), write('.'), nl.
interpret(parmset(Parameter,m,Set)) :-
        !,
        xkb_menu(Parameter,_,Choices,Prefix),
        write(Prefix), write('one of the following -'), nl,
           % Since parmset is involved, any value for Parameter
           % included in Set would have satisfied the condition.
        list_choices_in_set(Set,Choices,1).
interpret(\+(parmset(Parameter,m,Set))) :-
        !,
        xkb_menu(Parameter,_,Choices,Prefix),
        write(Prefix), write('NOT one of the following -'), nl,
           % Since parmset is involved, any value for Parameter
           % not in Set would have satisfied the condition.
        list_choices_in_set(Set,Choices,1).
interpret(parmset(Parameter,_,Set)) :-
        !,    % For any Parameter whose Value is not obtained
              % by using a menu.
        xkb_question(Parameter,_,Prefix,_),
        write(Prefix), write('one of the following - '), nl,
        enumerate(Set,1).
interpret(\+(parmset(Parameter,_,Set))) :-
        !,    % For any Parameter whose Value is not obtained
              % by using a menu.
        xkb_question(Parameter,_,Prefix,_),
        write(Prefix), write('NOT one of the following - '), nl,
        enumerate(Set,1).

interpret(parmrange(Parameter,Min,Max)) :-
        !,
        xkb_question(Parameter,_,Prefix,_),
        write(Prefix), write('between '),
        write(Min), write(' and '), write(Max),
        write('.'), nl.
interpret(\+(parmrange(Parameter,Min,Max))) :-
        !,
        xkb_question(Parameter,_,Prefix,_),
        write(Prefix), write('NOT between '),
        write(Min), write(' and '), write(Max),
        write('.'), nl.
interpret(\+(Condition)) :-
        clause(Condition,Conditions),
             % Any condition that does not have prop, parm,
             % parmset, or parmrange as its functor must corres-
             % pond to some Prolog rule with conditions of its
             % own. Eventually, all conditions must terminate in
             % conditions using prop, parm, parmset, or parmrange.
        write('A condition between here and "end" is NOT satisfied -'),
        nl,
        explain_aux(Conditions),
        write('    end'), nl.
interpret(Condition) :-
        clause(Condition,Conditions),
             % Any condition that does not have prop, parm,
             % parmset, or parmrange as its functor must corres-
             % pond to some Prolog rule with conditions of its
             % own. Eventually, all conditions must terminate in
             % conditions using prop, parm, parmset, or parmrange.
        explain_aux(Conditions).


%
% enumerate(+N,+X)
%   Prints each atom in list X on a separate line, numbering
%   the atoms beginning with the number N. Used to enumerate
%   menu choices.
%

enumerate([],_).
enumerate([H|T],N) :- write(N),write('. '),write(H),nl,
                      M is N + 1,
                      enumerate(T,M).

%
% list_choices_in_set(+X,+Y,+N)
%   The members of the list of atoms Y corresponding to the
%   positions in the list indicated by the members of the list
%   of integers X are printed on separate lines and numbered 
%   beginning with the number N.
%

list_choices_in_set([],_,_).
list_choices_in_set([N|Tail],Choices,M) :-
        nth_member(N,Choice,Choices),
        write(M), write('. '), write(Choice), nl,
        K is M + 1,
        list_choices_in_set(Tail,Choices,K).

%
% readnumber_in_range(+Min,+Max,-Response)
%   Evokes a numerical input from the user which must be
%   between Min and Max inclusively.
%

readnumber_in_range(Min,Max,Response) :-
        readnumber(Num),
        testnumber_in_range(Min,Max,Num,Response).

%
% testnumber_in_range(+Min,+Max,+Input,-Response)
%   Tests user Input to insure that it is a number between
%   Min and Max inclusively. If it is not, instructions for
%   the user are printed and readnum/1 is called to accept
%   another numerical input from the user.
%

testnumber_in_range(Min,Max,Num,Num) :-
        Min =< Num,
        Num =< Max,
        !.
testnumber_in_range(Min,Max,_,Num) :-
        write('Number between '),
        write(Min),
        write(' and '),
        write(Max),
        write(' expected. Try again. '),
        readnumber_in_range(Min,Max,Num).

%
% wait
%   Stops execution until the user presses a key. Used to 
%   prevent information from scrolling off the screen before
%   the user can read it.
%

wait :- write('Press Return when ready to continue. '),
        get0(_), nl, nl.

%
% yes
%   Prompts the user for a response and succeeds if the
%   user enters 'y' or 'Y'.
%

yes :-  write('|: '),
        get_yes_or_no(Response),
        !,
        Response == yes.

member(X,[X|_]).
member(X,[_|Y]) :- member(X,Y).

%
% nth_member(+N,-X,+Y)
%   X is the nth element of list Y.
%

nth_member(1,X,[X|_]).
nth_member(N,X,[_|Y]) :- nth_member(M,X,Y),
                         N is M + 1.

append_list([],[]).
append_list([N|Tail],Text) :- append_list(Tail,Text1),
                              xkb_text(N,Text2),
                              append(Text2,Text1,Text).

%
% writeline(+Text)
%   Prints Text consisting of a string or a list of
%   strings, with each string followed by a new line.
%

%writeline([]) :- !.
%writeline([First|Rest]) :-
%        !,
%        write(First),
%        nl,
%        writeline(Rest).
%writeline(String) :-
%        write(String),
%        nl.


