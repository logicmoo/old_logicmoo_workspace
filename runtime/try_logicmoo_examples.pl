#!/usr/bin/env swipl

/**
The Prolog Technology Theorem Prover is an extension of Prolog that is complete for the full first�order predicate calculus (Stickel, 1988).   
It is invoked whenever the facts and rule are described in NNF or CNF into the knowledge base.
However, when the rules are in Prenix Normal Form (PNF) (thus have quantifiers) they are converted to NNF, SNF and finally CNF and handed back over to PTTP.
Whenever a formula whose leading quantifier is existential occurs, the formula obtained by removing that quantifier via Skolemization may be generated. 

kif_add/1: the file has a rule or fact, in the form of a predicate of FOPC (First Order Predicate Calculus).  The LogicMOO invokes the PTTP compiler (discussed later) to assert the form to the knowledge base. The
knowledge base represents the user''s beliefs. Thus, asserting the logical form to the knowledge base amounts to applying the Declarative rule and the Distributivity rule (Axiom B2).

kif_ask/1: the user types in a question, in the form of a predicate of FOPC (First Order Predicate Calculus). The PTTP inference system is then invoked to attempt to  prove the predicate, 
using the axioms and facts of the knowledge base. This amounts toassuming that the user''s beliefs are closed under logical consequence, i.e., the Closure rule (Axiom B1) is implicitly applied over and over.

LogicMOO/PTTP is unlike all other theorem provers today (except SNARK and CYC) and even the ones claiming to be PTTP''s decendants have been radically simplified to absurdium.
Here is how is LogicMOO/PTTP: If the proof succeeds, LogicMOO answers ``yes'', and prints out the predicate, instantiating all variables. If there are multiple answers, then it prints all of them. 
If the proof fails, LogicMOO invokes PTTP to prove the negation of the queried predicate.  If that NEGATED proof succeeds, then LogicMOO answers ``no''; otherwise, LogicMOO answers ``cannot tell, not enough information''.

LogicMOO, therefore, has a restricted capability for reasoning about negation, being able to distinguish between real negation (``P is false'') from negation by failure (``P is not provable'').
This allows the system to distinguish beliefs that are provably false from beliefs that cannot be proven because of insufficient information. 
This is an important feature that overcomes the supposed limitations of Prolog.   For example, without this added capability, if a user were to
ask whether LogicMOO believes that John intended to let the cat out, then LogicMOO would answer ``no''. 
This answer is misleading because LogicMOO would also answer ``no'' if it were asked if John did not intend to let the cat out.  This is why the system automaically Re-asks the negation.

THE CAVEAT:  Left hand side rules may actually need the same level of analysis?!

Another key feature of LogicMOO infering about what it doesnt yet know, is it can be set to "ask the user" or help guide the user into what types of knowledge it is missing.  That also provides a port through which
other modules (e.g., a plan recognition system or a modules for NL reference resolution) can enter information. When such modules are not available, the user may simulate this capacity.

is_entailed/1: Detects if an Horn Clause (or fact) is true.   if someone asserts a=>b. this will result in the following two is_entailed(( ~a :- ~b )) and   is_entailed((  b :- a ) ).
According to classically trained logicians horn clauses cannot start with a negated literal (so to not offend them)  PTTP papers claim we can store "( ~a :- ~b )" as "( not_a :- not_b )" 
If we obeyed the limitations set forth upon Horn clauses only being "positive" that would remove the unique ability for LogicMOO to deduce what things are impossible. (We couldn''t tell the difference between missing data and true negation)

*/

:- module(kb).
:- '$set_source_module'(_,kb).
:- '$module'(_,kb).


:- if(gethostname(ubuntu)).
:- user:ensure_loaded(logicmoo_repl).
:- else.
:- user:ensure_loaded(logicmoo_repl).
% :- load_files(logicmoo_repl, [if(not_loaded),qcompile(auto)]).
:- endif.

:- use_module(logicmoo(snark/common_logic_snark)).
:- ensure_loaded(logicmoo('snark/common_logic_clif.pfc')).

:- debug(mpred).
:- set_prolog_flag(gc,true).


show_call_test(G):- must(show_call(G)).

%= define the example language
example_known_is_success(G):-  G.
example_impossible_is_success(G):- neg(G).
example_known_is_failure(G):-  \+ G.
example_impossible_is_failure(G):- \+ neg(G).

%= define the four truth values
example_proven_true(G):- example_known_is_success(G),example_impossible_is_failure(G).
example_proven_false(G):- example_impossible_is_success(G),example_known_is_failure(G).
example_inconsistent(G):- example_known_is_success(G),example_impossible_is_success(G).
example_unknown(G):- example_known_is_failure(G),example_impossible_is_failure(G).

:- multifile shared_hide_data/1.
%= shared_hide_data(hideMeta):- is_main_thread.
%= shared_hide_data(hideTriggers):- is_main_thread.

/* 
LogicMOO in operation :
In this section we provide a trace of LogicMOO in operation. Input from the user follows the
standard Prolog prompt (?�) or the LogicMOO prompt (?->); all other text is output from LogicMOO.
LogicMOO's responses to the questions that are asked illustrate the system's reasoning capabil�
ities, and demonstrate its ability to derive the beliefs listed that summarizes the results of our data analysis.
Comments are inserted with "%=" at the begginning and "reprinted".
We start by sending all axioms to the PTTP compiler, which, in turn, transforms them and prints them
out.
*/

:- process_this_script.

%=  setup pfc
:- file_begin(pfc).

%= save compiled clauses using forward chaining storage (by default)
%= we are using forward chaining just so any logical errors, performance and program bugs manefest
%= immediately
:- set_clause_compile(fwc).


:- mpred_trace_exec.

(ptSymmetric(Pred) ==> ({atom(Pred),G1=..[Pred,X,Y],G1=..[Pred,Y,X]}, (G1==>G2), (neg(G1)==> neg(G2)))).
% (isa(Pred, ptSymmetric)==> ((neg(t(Pred, X, Y))==>neg(t(Pred, Y, X))))).

ptSymmetric(love_compatible).

%= if two thing do like  each other then they are "love compatible"
:- kif_add(
 forall(a,forall(b,
    if( (likes(a,b)  & likes(b,a)),
     love_compatible(a,b))))).

%= will have the three side effects...

%= if A is not love compatible with B .. yet B likes A.. we show_call conclude A show_call not like B back.
:- is_entailed((not(likes(A, B)):- not(love_compatible(A, B)), likes(B, A))).

%= if A is not love compatible with B .. yet A likes B.. we show_call conclude B show_call not like A back.
:- is_entailed((not(likes(B, A)):- not(love_compatible(A, B)), likes(A, B))).

%= if A and B like each other both ways then they are love compatible
:- is_entailed((love_compatible(A, B):- likes(A, B), likes(B, A))).



%= if people are love compatible then they show_call like each other (variables my be in lower case for John Sowa''s CLIF compatibity)
:- kif_add(
  forall(a,forall(b,
   if(love_compatible(a,b),
    (likes(a,b)  & likes(b,a)))))).


%= will have the four side effects...

%= if A and B show_call not be love compatible since A does not like B
:- is_entailed((not(love_compatible(A, B)):- not(likes(A, B)))).
%= if A and B show_call not be love compatible since B does not like A
:- is_entailed((not(love_compatible(A, B)):- not(likes(B, A)))).
%= obviously A likes B .. since they are love compatible
:- is_entailed((likes(A, B):- love_compatible(A, B))).
%= obviously B likes A .. after all they are love compatible
:- is_entailed((likes(B, A):- love_compatible(A, B))).


%= this uses biconditional implicatature
:- kif_add(
 forall(a,forall(b,
  iff(might_altercate(a,b),
    (dislikes(a,b)  & dislikes(b,a)))))).

%=  canonicalizes to..

%= A and B will not fight becasue it takes two to tango and A doesnt dislike B
:- is_entailed((not(might_altercate(A, B)):- not(dislikes(A, B)))).
%= A and B will not fight becasue it takes B doent dislike A (like above)
:- is_entailed((not(might_altercate(A, B)):- not(dislikes(B, A)))).
%= Since we can prove A and B  dislike each other we can prove they are fight compatible
:- is_entailed((might_altercate(A, B):- dislikes(A, B), dislikes(B, A))).
%=  A dislikes B  when we prove A and B are fight compatible somehow  (this was due to the biconditional implicatature)
:- is_entailed((dislikes(A, B):- might_altercate(A, B))).
%=  B dislikes A  when we prove A and B are fight compatible
:- is_entailed((dislikes(B, A):- might_altercate(A, B))).


%= alice likes bill
:- kif_add(likes(alice,bill)).

%= dumbo does not exist
%= TODO :- kif_add(not(isa(dumbo,_))).

%= evertyting that exists is an instance of Thing
%= TODO :- kif_add(isa(_,tThing))).

%= also she likes ted
:- kif_add(likes(alice,ted)).

%= we take as a given that bill does not like alice (why?)
:- kif_add(not(likes(bill,alice))).

%= we take as a given that bill and ted dislike each other (dont blame the woman!)
% todo: perhaps make dislikes(bill,ted) and  dislikes(ted,bill) true only if the other is not categorically provable false
% some interdepancy is reasonable.. just what?)
:- kif_add((dislikes(bill,ted) & dislikes(ted,bill))).


%= we of course support SUO-KIF (SUMO)
%= thank you triska for showing off this neat hack for term reading
:- kif_add('

(<=>
  (dislikes ?A ?B)
  (not
      (likes ?A ?B)))

'
).

%= we of course supprt CLIF!
:- kif_add('

(forall (a b)
 (iif
  (dislikes a b)
  (not
      (likes a b))))

'
).

%= we support also CycL language
:- kif_add('

(equiv
  (dislikes ?A ?B)
  (not
      (likes ?A ?B)))

'
).

%= interestingly this canonicallizes to ...
%= A does not dislike B when A like B
:- is_entailed((not(dislikes(A, B)):- likes(A, B))).
%= A does not like B when A dislikes B
:- is_entailed((not(likes(A, B)):- dislikes(A, B))).
%= A does dislikes B when we can somehow prove A not liking B
:- is_entailed((dislikes(A, B):- not(likes(A, B)))).
%= A does likes B when we can somehow prove A not disliking B
:- is_entailed((likes(A,B) => not(dislikes(A,B)))).


%= The above assertions forward chain to these 4 side-effects
:- is_entailed((might_altercate(ted, bill))).
:- is_entailed((might_altercate(bill, ted))).
:- is_entailed((not(love_compatible(bill, alice)))).
:- is_entailed((not(love_compatible(alice, bill)))).

%= get a proof
:- sanity(call(mpred_get_support(not(love_compatible(bill, alice))   ,Why))).
%= O = (not(likes(bill, alice)), pt(not(likes(bill, alice)), rhs([not(love_compatible(bill, alice))]))) ;
%= TODO fix this error O = (u, u).




%= ````
%= logic tests...
%= ````
:- mpred_trace_exec.


prologBuiltin(otherGender/2).
otherGender(male,female).
otherGender(female,male).

breeder(X,Y) <=> breeder(Y,X).

(breeder(X,Y),gender(X,G1), otherGender(G1,G2))
     => gender(Y,G2).


gender(P,male) <=> male(P).
gender(P,female) <=> female(P).

male(P) <=> ~female(P).



((parent(X,Y) & female(X)) <=> mother(X,Y)).

:- is_entailed(((parent(X,Y) & female(X)) <=> mother(X,Y))).
:- is_entailed(((parent(X,Y) & female(X)) => mother(X,Y))).
:- is_entailed((mother(X,Y)=>(parent(X,Y) & female(X)))).
:- is_entailed((parent(A,B):- mother(A,B))).
:- is_entailed(not(mother(A,B)):- not(parent(A,B))).

((parent(X,Y) & female(X)) => mother(X,Y)).
((mother(X,Y) => parent(X,Y) & female(X))).

:- is_entailed((parent(A,B):- mother(A,B))).




parent(GRAND,PARENT),parent(PARENT,CHILD) => grandparent(GRAND,CHILD).

grandparent(X,Y),male(X) <=> grandfather(X,Y).
grandparent(X,Y),female(X) <=> grandmother(X,Y).
mother(Ma,Kid),parent(Kid,GrandKid)
      =>grandmother(Ma,GrandKid).
grandparent(X,Y),female(X) <=> grandmother(X,Y).
parent(X,Y),male(X) <=> father(X,Y).
(parent(Ma,X),parent(Ma,Y),different(X,Y) =>siblings(X,Y)).
parent(P1,P2) => ancestor(P1,P2).
(parent(P1,P2), ancestor(P2,P3)) => ancestor(P1,P3).
(ancestor(P1,P2), ancestor(P2,P3)) => ancestor(P1,P3).


mother(eileen,douglas).

%= trudy is human
human(trudy).

%= catch a regression bug that may couse trudy to lose human assertion
never_retract_u(human(trudy)).

:- kif_add(forall(p,exists([m,f], if(human(p), (mother(m,p) & father(f,p)))))).


:- doall(show_call(father(_,trudy))).


mother(trudy,eileen).
((human(P1),ancestor(P1,P2))=>human(P2)).
% :- listing([ancestor,human,parent]).
%=:- wdmsg("press Ctrl-D to resume.").
%=:- prolog.

is_entailed(grandmother(trudy,douglas)).

mother(trudy,robby).
mother(trudy,liana).
mother(liana,matt).
mother(liana,liz).
mother(trudy,pam).


%= human(trudy) supports anscesteral rule that her decendants are humans as well .. therefore ..
:- is_entailed(human(douglas)).

/*

?- mpred_why(human(douglas)).

Justifications for human(douglas):
    1.1 ancestor(trudy,douglas)
    1.2 human(trudy)
    1.3 human(trudy),ancestor(trudy,douglas),{vg(s(douglas))}==>human(douglas)
    2.1 ancestor(eileen,douglas)
    2.2 human(eileen)
    2.3 human(eileen),ancestor(eileen,douglas),{vg(s(douglas))}==>human(douglas)


:- mpred_why(grandparent(trudy,douglas)).

Justifications for grandparent(trudy,douglas):
    1.1 grandmother(trudy,douglas)
    1.2 grandmother(trudy,douglas),{vg(s(douglas,trudy))}==>grandparent(trudy,douglas)
    2.1 parent(eileen,douglas)
    2.2 parent(trudy,eileen)
    2.3 parent(trudy,eilee.),parent(eileen,douglas),{vg(s(douglas,trudy))}==>grandparent(trudy,douglas)

*/

%=:- wdmsg("press Ctrl-D to resume.").


:- style_check(-singleton).


%= so far no males "asserted" in the KB
:- doall(show_call(male(Who ))).
/*
OUTPUT WAS..
male(skArg1ofFatherFn(pam)).
male(skArg1ofFatherFn(liz)).
male(skArg1ofFatherFn(matt)).
male(skArg1ofFatherFn(liana)).
male(skArg1ofFatherFn(robby)).
male(skArg1ofFatherFn(eileen)).
male(skArg1ofFatherFn(douglas)).
male(skArg1ofFatherFn(trudy)).
*/

%= we can report the presence on non male though...
%=    the ~/1 is our negation hook into the inference engine
:- no_varnaming( mpred_no_chaining(doall((trace,show_call(~male(Who )))))).

%= we expect to see at least there mothers here
%=  succeed(user: ~male(liana)).
%=  succeed(user: ~male(trudy)).
%=            succeed(user: ~male(skArg1ofMotherFn(trudy))).
%=  succeed(user: ~male(eileen)).

%= thus ~/1 is tnot/1 of XSB ?!?

%= there ar explicly non females
:- doall(show_call(~ female(Who ))).

%= ensure skolems are made or destroyed

father(robert,eileen).
siblings(douglas,cassiopea).
father(douglas,sophiaWebb).
father(douglas,skylar).
father(douglas,sophiaWisdom).
father(douglas,zaltana).

:- is_entailed(human(douglas)).

:- mpred_why(human(douglas)).

:- mpred_why(grandparent(trudy,douglas)).

:- doall(show_call_test(mother(Female,Who))).

:- doall(show_call_test(father(Male,Who))).

% :- doall(show_call_test(male(Who))).

% :- doall(show_call_test(female(Who))).

:- doall(show_call_test(siblings(Who,AndWho))).

%= human(P) => (female(P) v male(P)).
:- kif_add(if(gendered_human(P), (female(P) v male(P)))).



