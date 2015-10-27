/** <module>
% =============================================
% File 'mpred_builtin.pfc'
% Purpose: Agent Reactivity for SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'interface' 1.0.0
% Revision: $Revision: 1.9 $
% Revised At: $Date: 2002/06/27 14:13:20 $
% =============================================
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
%
% props(Obj,[height(ObjHt)]) == t(height,Obj,ObjHt) == rdf(Obj,height,ObjHt) == t(height(Obj,ObjHt)).
% padd(Obj,[height(ObjHt)]) == prop_set(height,Obj,ObjHt,...) == ain(height(Obj,ObjHt))
% [pdel/pclr](Obj,[height(ObjHt)]) == [del/clr](height,Obj,ObjHt) == [del/clr]svo(Obj,height,ObjHt) == [del/clr](height(Obj,ObjHt))
% keraseall(AnyTerm).
%
%                      ANTECEEDANT                                   CONSEQUENT
%
%         P =         test nesc true                         assert(P),retract(~P) , enable(P).
%       ~ P =         test nesc false                        assert(~P),retract(P), disable(P)
%
%   ~ ~(P) =         test possible (via not impossible)      retract( ~(P)), enable(P).
%  \+ ~(P) =         test impossiblity is unknown            retract( ~(P))
%   ~ \+(P) =        same as P                               same as P
%     \+(P) =        test naf(P)                             retract(P)
%
% Dec 13, 2035
% Douglas Miles
*/



:- file_begin(pfc).

:- op(500,fx,'~').
:- op(1050,xfx,('=>')).
:- op(1050,xfx,'<=>').
:- op(1050,xfx,('<-')).
:- op(1100,fx,('==>')).
:- op(1150,xfx,('::::')).
:- was_dynamic(tCol/1).
:- op(1050,xfx,('<==')).

:- was_dynamic('<=='/2).

:- was_dynamic('pet'/2).


% Source http://www.iflscience.com/editors-blog/solving-einsteins-riddle

% There are five houses in a row.

house(house1).
house(house2).
house(house3).
house(house4).
house(house5).

nextto(HA, HB) <== (adj(HA, HB); adj(HB, HA)).

color(red).
color(green).
color(white).
color(yellow).

adj(house1, house2).
adj(house2, house3).
adj(house3, house4).
adj(house4, house5).

% In each house lives a person with a different nationality.

person(person1).
person(person2).
person(person3).
person(person4).
person(person5).

% Other facts:
% 
% 1. The Brit lives in the red house. 
lives(H, P) <== nationality(P, brit), colored(H, red).

% 2. The Swede keeps dogs as pets. 
nationality(P, swedish) <== pet(P, dog).

% 3. The Dane drinks tea. 
nationality(P, danish) <== drink(P, tea).

% 4. The green house is on the immediate left of the white house. 
colored(L, green) <== adj(L, R), colored(R, white).

% 5. The green house's owner drinks coffee. 
lives(H, P) <== colored(H, green), drink(P, coffee).

% 6. The owner who smokes Pall Mall rears birds. 
smoke(P, pallmall) <== pet(P, bird).

% 7. The owner of the yellow house smokes Dunhill. 
lives(H, P) <== colored(H, yellow), smoke(P, dunhill).

% 8. The owner living in the center house drinks milk. 
lives(house3, P) <== drink(P, milk).

% 9. The Norwegian lives in the first house. 
lives(house1, P) <== nationality(P, norwegian).

% 10. The owner who smokes Blends lives next to the one who keeps cats. 
lives(H, P) <== smoke(P, blend), nextto(H, N), lives(N, PB), pet(PB, cat).

% 11. The owner who keeps the horse lives next to the one who smokes Dunhill. 
lives(H, P) <== pet(P, horse), nextto(H, N), lives(N, PB), smoke(PB, dunhill).

% 12. The owner who smokes Bluemasters drinks beer. 
drink(P, beer) <== smoke(P, bluemasters).

% 13. The German smokes Prince. 
nationality(P, german) <== trait(P, smoke, prince).

% 14. The Norwegian lives next to the blue house. 
lives(H, P) <== nationality(P, norwegian), nextto(HA, HB), colored(HB, blue).

% 15. The owner who smokes Blends lives next to the one who drinks water. 
lives(H, P) <== smoke(P, blend), nextto(H, N), lives(N, PB), drink(PB, water).

% � five different colors

/*
colored(HA, CA) <==
    house(HA),
    %color(CA),
    writeln(abc(h(HA, CA))),
    \+ (house(HB),
        \+ HA = HB,
        colored(HB, CA)).
*/

% The five owners drink a certain type of beverage, smoke a certain brand of
% cigar and keep a certain pet. No owners have the same pet, smoke the same
% brand of cigar, or drink the same beverage.

/*
trait(PA, Type, WhatA) <==
    person(PA),
    \+ (trait(PB, Type, WhatB),
        WhatA = WhatB,
        \+ PA = PB).


nationality(PA, NA) <==
    person(PA),
    \+ (nationality(PB, NB),
        NA = NB,
        \+ (PA = PB).
*/

% The question is: who owns the fish?

:- forall((C <== A) ,  (dynamic(C),ain(A ==> C))).

:- prolog.
