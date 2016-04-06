% From the book
% PROLOG PROGRAMMING IN DEPTH
% by Michael A. Covington, Donald Nute, and Andre Vellino
% (Prentice Hall, 1997).
% Copyright 1997 Prentice-Hall, Inc.
% For educational use only

% CICHLID.PL

% Contains an XSHELL knowledge base.
% Requires all procedures in XSHELL.PL.

:- ensure_loaded('xshell.pl').

%
% Any clauses for the predicates XKB_INTRO,
% XKB_REPORT, XKB_UNIQUE, XKB_EXPLAIN, XKB_IDENTIFY, and
% XKB_QUESTION should be removed from the knowledge base.
%

:- abolish(xkb_intro/1).
:- abolish(xkb_unique/1).
:- abolish(xkb_explain/1).
:- abolish(xkb_identify/2).
:- abolish(xkb_question/4).
:- abolish(xkb_menu/4).
:- abolish(xkb_text/2).

%
% XKB_IDENTIFY must be declared dynamic so the explanatory
% routine INTERPRET can access its clauses.
%

:- dynamic xkb_identify/2.

xkb_intro(
 ['',
  'CICHLID: An Expert System for Identifying Dwarf Cichlids',
  '',
  'The cichlids are a family of tropical fish.  Many of',
  'these fish are large and can only be kept in large',
  'aquariums. Others, called ''dwarf cichlids'', rarely',
  'exceed 3 inches and can be kept in smaller aquariums.',
  '',
  'This program will help you identify many of the more',
  'familiar species of dwarf cichlid.  Identification of',
  'these fish is not always easy, and the program may offer',
  'more than one possible identification.  Even then, you',
  'should consult photographs in an authoritative source',
  'such as Staek, AMERIKANISCHE CICHLIDEN I: KLEINE',
  'BUNTBARSCHE (Melle: Tetra Verlag, 1984), or Goldstein,',
  'CICHLIDS OF THE WORLD (Neptune City, New Jersey:',
  't.f.h. Publications, 1973) for positive identification.',
  '',
  'To use the program, simply describe the fish by',
  'answering the following questions.']).

xkb_unique(no).

xkb_explain(yes).

%
% xkb_identify(-Rule,-TextSet)
%   Each clause for this predicate provides a rule to be
%   used with the utility predicates in the XSHELL.PL file
%   to determine whether the fish to be identified is likely
%   to belong to the Species.
%

xkb_identify(1,[isa,agassizii]) :-
     parm(caudal,m,2),          % spear-shaped
     parm(body_shape,m,1),      % long and narrow
     parm(lateral_stripe,m,1),  % sharp, distinct
     prop(dorsal_streamer),
     prop(lateral_stripe_extends_into_tail).

xkb_identify(2,[isa,borelli]) :-
     parm(caudal,m,3),          % normal
     parm(body_shape,m,2),      % deep, heavy, short
     parm(lateral_stripe,m,2),  % irregular
     prop(dorsal_streamer),
     prop(ventral_streamer),
     prop(lateral_stripe_extends_into_tail),
     parm(color,m,5).    % yellow

xkb_identify(3,[isa,cockatoo]) :-
     parm(caudal,m,1),          % lyre-shaped
     parm(body_shape,m,2),      % deep, heavy, short
     parm(lateral_stripe,m,1),  % sharp, distinct
     prop(dorsal_crest),
     prop(dorsal_streamer),
     prop(anal_streamer),
     prop(stripes_in_lower_body),
     prop(lateral_stripe_extends_into_tail).

xkb_identify(4,[isa,trifasciata]) :-
     parm(caudal,m,3),          % normal
     parm(body_shape,m,3),      % normal
     parm(lateral_stripe,m,1),  % sharp, distinct
     prop(dorsal_crest),
     prop(dorsal_streamer),
     prop(anal_streamer),
     prop(ventral_streamer),
     prop(lateral_stripe_extends_into_tail),
     prop(angular_line_above_ventral).

xkb_identify(5,[isa,brichardi]) :-
     parm(caudal,m,1),          % lyre-shaped
     parm(body_shape,m,3),      % normal
     parm(lateral_stripe,m,3),  % not visible
     parm(color,m,2),           % pale gray
     prop(gill_spot),
     prop(fins_trimmed_white).

xkb_identify(6,[isa,krib]) :-
     parm(caudal,m,2),          % spear-shaped
     parm(body_shape,m,1),      % long and narrow
     prop(dorsal_streamer),
     prop(anal_streamer),
     prop(orange_spots_in_tail).

xkb_identify(7,[isa,ram]) :-
     parm(caudal,m,3),          % normal
     parm(body_shape,m,2),      % deep, heavy, short
     parm(lateral_stripe,m,3),  % not visible
     prop(dorsal_crest),
     parm(color,m,4).           % violet, yellow, claret

xkb_identify(8,[isa,nannacara]) :-
     parm(caudal,m,3),          % normal
     parm(body_shape,m,2),      % deep, heavy, short
     parm(lateral_stripe,m,3),  % not visible
     parm(color,m,3).           % metallic bronze, green

xkb_identify(9,[isa,nudiceps]) :-
     parm(caudal,m,3),          % normal
     parm(body_shape,m,1),      % long and narrow
     parm(lateral_stripe,m,3),  % not visible
     parm(color,m,1).           % pale blue

xkb_question(dorsal_crest,
     ['Are any fin rays at the front of the dorsal fin',
      'clearly extended above the rest of the fin?'],
      'Front rays of dorsal fin are extended.',
      'Front rays of dorsal fin are not extended.').

xkb_question(dorsal_streamer,
     ['Are any fin rays at the back of the dorsal fin',
      'clearly extended into a long streamer?'],
      'Rear rays of dorsal fin are extended.',
      'Rear rays of dorsal fin are not extended.').

xkb_question(anal_streamer,
     ['Are any fin rays at the back of the anal fin',
      'clearly extended into a long streamer?'],
      'Rear rays of anal fin are extended.',
      'Rear rays of anal fin are not extended.').

xkb_question(ventral_streamer,
     ['Are any fin rays at the bottom of the ventral',
      'fins clearly extended into streamers?'],
      'Rays of anal fin are extended.',
      'Rays of anal fin are not extended.').

xkb_question(lateral_stripe_extends_into_tail,
     ['Does the stripe down the side extend into the base',
      'of the tail?'],
     'The lateral stripe extends into the tail.',
     'The lateral stripe does not extend into the tail.').

xkb_question(stripes_in_lower_body,
      ['Are there horizontal stripes in the lower part',
       'of the body?'],
      'Horizontal stripes present in the lower body.',
      'There are no horizontal stripes in the lower body.').

xkb_question(angular_line_above_ventral,
     ['Is there an angular line above the ventral fin',
      'slanting from the pectoral downward toward the',
      'stomach region?'],
     'Slanting body line is present.',
     'Slanting body line is absent.').

xkb_question(orange_spots_in_tail,
      ['Are there black spots trimmed in orange in',
       'the tail fin?'],
      'Orange-trimmed black spots present in tail.',
      'There are no orange trimmed black spots in the tail.').

xkb_question(gill_spot,'Is there a dark spot on the gill?',
      'Dark spot present on gill.',
      'There is no dark spot on the gill.').

xkb_question(fins_trimmed_white,
      'Are the unpaired fins trimmed with a white edge?',
      'Unpaired fins are trimmed with white edge.',
      'The unpaired fins do not have a white edge.').

xkb_menu(caudal,
     ['What is the shape of the tail-fin?'],
     ['lyre-shaped',
      'spear-shaped',
      'normal, i.e, round or fan-shaped'],
     'Tail fin is ').

xkb_menu(body_shape,
     ['What is the shape of the body?'],
     ['long and narrow',
      'deep, heavy and short',
      'normal fish shape'],
     'Body is ').

xkb_menu(lateral_stripe,
     ['Describe the line running the length of the body.'],
     ['sharp and distinct from eye to base of tail',
      'irregular, indistinct or incomplete',
      'not visible or barely visible'],
     'Lateral body stripe is ').

xkb_menu(color,
     ['What is the basic color of the body?'],
     ['pale blue',
      'pale gray',
      'metallic bronze or green',
      'violet, yellow and claret highlights',
      'yellow',
      'not listed'],
     'The basic body color is ').

xkb_text(isa,
['Possible identification: ']).

xkb_text(agassizii,
['Apistogramma agassizii ',
 '(Agassiz''s dwarf cichlid)']).

xkb_text(borelli,
['Apistogramma borelli ',
 '(Borell''s dwarf cichlid)']).

xkb_text(cockatoo,
['Apistogramma cacatuoides ',
 '(cockatoo dwarf cichlid)']).

xkb_text(trifasciata,
['Apistogramma trifasciata ',
 '(three-striped dwarf cichlid']).

xkb_text(brichardi,
['Lamprologus brichardi']).

xkb_text(krib,
['Pelvicachromis pulcher ',
 '(krib or kribensis)']).

xkb_text(ram,
['Microgeophagus ramirezi ',
 '(Ram, or butterfly dwarf cichlid)']).

xkb_text(nannacara,
['Nannacara anomala']).

xkb_text(nudiceps,
['Nanochromis nudiceps']).

:- write('Type  xshell.  to start.'), nl.


