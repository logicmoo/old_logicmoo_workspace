#!/usr/bin/env swipl
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% Dec 13, 2035
% Douglas Miles

:- module(sanity_if_missing_02,[]).

:- use_module(library(logicmoo_base)).

:- dynamic((foob/1,good/0,if_missing/2)).

:- begin_pfc.

(if_missing(Missing,Create) ==> ( ( \+ Missing/(Missing\=@=Create)) ==> Create)).

good ==> if_missing(foob(_),foob(a)).

good.

:- mpred_test(foob(a)).

:- break.

\+ good.

:- mpred_test(\+foob(a)).

