#!/usr/bin/env swipl
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% Dec 13, 2035
% Douglas Miles


:- module(sanity,[]).

:- use_module(library(logicmoo_base)).

%:- dmsg(begin_abc123).
              
%:- dynamic(tCol/1).
%:- dynamic(singleValuedInArg/2).
%:- dynamic(baseKB:ptReformulatorDirectivePredicate/1).

% :- mpred_trace_exec.

:- abolish(c,0).
:- abolish(a,1).
:- abolish(b,1).
:- dynamic((a/1,b/1,c/0,f/1)).

:- file_begin(pfc).

:- mpred_test(ain(a(z))).

:- mpred_test(ain(==> a(z))).
:- mpred_test(a(z)).

:- mpred_test(ain(a(z) ==> z(a))).
:- mpred_test(z(a)).

:- mpred_test(a(_)).



~ a(z).

:- mpred_test(  ~(a(_))).
:- mpred_test(\+ a(_)).

~(~(a(z))).

:- dmsg('�'(a)).

'�'(a).

:- op(666,fx,('�\\_(?)_/�')).


% :- xlisting(a).

% :-mpred_test(\+  ~(a(_))).
% :-mpred_test(\+ a(_)).

% U=nt(A,B,C),basePFC:spft('$ABOX',X,Y,Z),\+ \+

(a(B),d(B),f(B)) ==> b(B).
(a(B),d(B),e(B)) ==> b(B).
(a(B),e(B),d(B)) ==> b(B).

d(q).
% ?- nl,ZU=nt(_,_,_),ZU,basePFC:spft(UMT,X,Y,Z),\+ \+ ZU=Z,nl.

(b(_),e(q)) ==> c.
(~a(B),~e(B)) ==> q.

a(B)==>d(B).

:- mpred_test(\+c).

==> e(q).
==> b(q).
==> a(q).

:- mpred_test(c).

?- mpred_why(c).

