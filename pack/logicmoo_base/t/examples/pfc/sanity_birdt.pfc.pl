%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% props(Obj,[height(ObjHt)]) == t(height,Obj,ObjHt) == rdf(Obj,height,ObjHt) == t(height(Obj,ObjHt)).
% padd(Obj,[height(ObjHt)]) == prop_set(height,Obj,ObjHt,...) == ain(height(Obj,ObjHt))
% [pdel/pclr](Obj,[height(ObjHt)]) == [del/clr](height,Obj,ObjHt) == [del/clr]svo(Obj,height,ObjHt) == [del/clr](height(Obj,ObjHt))
% keraseall(AnyTerm).
%
%                      ANTECEEDANT                                   CONSEQUENT
%
%        P =         test nesc true                         assert(P),retract(~P) , enable(P).
%       ~P =         test nesc false                        assert(~P),retract(P), disable(P).
%
%   ~ ~(P) =        rewrite_to \+ ~(P)                      rewrite_to \+ ~(P) 
%  ~ \+(P) =        rewrite_to     (P)                      rewrite_to     (P) 
%  \+ ~(P) =        test impossiblity is unknown            retract(~P).
%    \+(P) =        test P is unknown                       retract(P)
%
% Dec 13, 2035
% Douglas Miles

:- module(sanity_birdt,[]).

:- use_module(library(logicmoo_user)).

:- file_begin(pfc).


tCol(tFly).
tCol(tCanary).
tCol(tPenguin).

tCol(tBird).


:- mpred_test(predicate_property(tBird(_),dynamic)).

genls(tCanary,tBird).
genls(tPenguin,tBird).



:- dmsg("chilly is a penguin.").
tPenguin(iChilly).

:- mpred_test((tBird(iChilly))).


:- dmsg("tweety is a canary.").
tCanary(iTweety).

:- mpred_test((tBird(iTweety))).


:- dmsg("birds fly by default.").
mdefault(( tBird(X) ==> tFly(X))).

:- dmsg("make sure chilly can fly").
:- mpred_test((isa(I,tFly),I=iChilly)).

:- dmsg("make sure tweety can fly (and again chilly)").
:- mpred_test((tFly(iTweety))).
:- mpred_test((tFly(iChilly))).


never_retract_u(tBird(iChilly)).


:- dmsg("penguins do not tFly.").
tPenguin(X) ==>  ~tFly(X). 

:- dmsg("confirm chilly now cant fly").
:- mpred_test((\+ tFly(iChilly))).
:- mpred_test(( ~ tFly(iChilly))).

%= repropigate that chilly was a bird again (actualy this asserts)

tBird(iChilly).

:- listing(tBird/1).

%= the dmsg explains the difference between \+ and ~
:- dmsg("confirm chilly still does not fly").
:- mpred_test(( \+ tFly(iChilly))).
:- dmsg("confirm chilly still cant fly").
:- mpred_test(( ~  tFly(iChilly))).

/*

% This wounld be a good TMS test it should throw.. but right now it passes wrongly
tFly(iChilly).

:- dmsg("confirm chilly is flying penguin").
:- mpred_test(( tFly(iChilly))).
:- mpred_test(( tPenguin(iChilly))).
:- mpred_test((\+ ~tFly(iChilly))).

\+ tFly(iChilly). 

:- dmsg("confirm chilly is a normal penguin who cant fly").
:- mpred_test((\+ tFly(iChilly))).

% fails rightly
:- mpred_test(( tPenguin(iChilly))).

*/

:- dmsg("chilly is no longer a penguin (hopefly the assertion above about him being a bird wont be removed)").


:- debug(_).
:- mpred_trace_exec.
:- debug(mpred).

:- mpred_test(tBird(iChilly)).

never_retract_u(tBird(iChilly)).


\+ tPenguin(iChilly).


:- mpred_test((tBird(iChilly))).

:- mpred_test(( \+ tPenguin(iChilly))).

:- dmsg("chilly is still a bird").
:- mpred_test((tBird(iChilly))).

:- repropagate(tBird(iChilly)).

:- dmsg("confirm chilly is flying bird").
:- mpred_test(( tFly(iChilly))).
:- mpred_test(( \+ tPenguin(iChilly))).
:- mpred_test(( \+ ~tFly(iChilly))).


