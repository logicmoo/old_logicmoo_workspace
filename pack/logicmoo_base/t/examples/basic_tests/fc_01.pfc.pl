#!/usr/bin/env swipl
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% Dec 13, 2035
% Douglas Miles


%  cls ; kill -9 %1 ; swipl -g "ensure_loaded(pack(logicmoo_base/t/examples/base/'sanity_abc.pfc'))."

:- module(sanity,[]).

:- use_module(library(logicmoo_base)).

:- dmsg(begin_abc).
              
:- file_begin(pfc).

:- abolish(a,0).
:- abolish(b,0).
:- dynamic((a/0,b/0)).

:- debug(mpred).
:- mpred_trace_exec.

a.
a ==> b.

:- mpred_test(a).
:- mpred_test(b).


