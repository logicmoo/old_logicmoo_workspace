% -*-Prolog-*-

:- use_module(library(logicmoo/logicmoo_user)).

:- shared_multifile otherGender/2.

% kinship domain example.

spouse(P1,P2) <==> spouse(P2,P1).

spouse(P1,P2), gender(P1,G1), {otherGender(G1,G2)} ==> gender(P2,G2).

otherGender(male,female).
otherGender(female,male).

gender(P,male) <==> male(P).

gender(P,female) <==> female(P).

parent(X,Y), female(X) <==> mother(X,Y).

parent(P1,P2), parent(P2,P3) ==> grandParent(P1,P3).

grandParent(P1,P2), male(P1) <==> grandFather(P1,P2).

grandParent(P1,P2), female(P1) <==> grandMother(P1,P2).

mother(Ma,Kid), parent(Kid,GrandKid) ==> grandMother(Ma,GrandKid).

parent(X,Y), male(X) <==> father(X,Y).

parent(Ma,P1), parent(Ma,P2), {P1\==P2} ==>  sibling(P1,P2).

spouse(P1,P2), spouse(P1,P3), {P2\==P3} ==> 
   bigamist(P1), 
   {format("~N~w is a bigamist, married to both ~w and ~w~n",[P1,P2,P3])}.

% here is an example of a default rule

parent(P1,X), 
  parent(P2,X)/(P1\==P2),
  \+ spouse(P1,P3)/(P3\==P2),
  \+ spouse(P2,P4)/(P4\==P1)
  ==>
  spouse(P1,P2).

uncle(U,P1), parent(U,P2) ==> cousin(P1,P2).

aunt(U,P1), parent(U,P2) ==> cousin(P1,P2).

parent(P,K), sibling(P,P2)

   ==>

   (female(P2) 
     ==> 
     aunt(P2,K),
     (spouse(P2,P3) ==> uncle(P3,K))),

   (male(P2) 
     ==> 
     uncle(P2,K),
     (spouse(P2,P3) ==> aunt(P3,K))).


