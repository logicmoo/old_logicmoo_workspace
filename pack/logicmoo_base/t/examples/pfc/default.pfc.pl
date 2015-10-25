:- use_module(library(logicmoo/logicmoo_user)).

% -*-Prolog-*-
% here is an example which defines default facts and rules.  Will it work?

(default(P)/mpred_literal(P))  ==>  (~not(P) ==> P).

default((P ==> Q))/mpred_literal(Q) ==> (P, ~not(Q) ==> Q).

% birds fly by default.
==> default((bird(X) ==> fly(X))).

% here's one way to do an zisa hierarchy.
% zisa = subclass.

zisa(C1,C2) ==>
  {P1 =.. [C1,X],
    P2 =.. [C2,X]},
  (P1 ==> P2).

==> zisa(canary,bird).
==> zisa(penguin,bird).

% penguins do not fly.
penguin(X) ==> not(fly(X)).

% chilly is a penguin.
==> penguin(chilly).

% tweety is a canary.
==> canary(tweety).