#!/usr/bin/env swipl
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% Dec 13, 2035
% Douglas Miles
%  cls ; kill -9 %1 ; fg ; swipl -g "ensure_loaded(pack(logicmoo_base/t/examples/base/'sanity_abc.pfc'))."

% :- module(sanity,[]).

:- op(500,fx,'-').
:- op(300,fx,'~').
:- op(1050,xfx,('==>')).
:- op(1050,xfx,'<==>').
:- op(1050,xfx,('<-')).
:- op(1100,fx,('==>')).
:- op(1150,xfx,('::::')).


:- dynamic((foob/1,if_missing/2,good/1)).

:- use_module(library(logicmoo_user)).

:- mpred_reset.

:- mpred_trace.
:- mpred_watch.

:- dynamic((foob/1,if_missing/2)).

% :- begin_pfc.

% this should have been ok
% (if_missing(Missing,Create) ==> ((\+ Missing/(Missing\==Create), \+ Create , \+ ~(Create)) ==> Create)).

:- mpred_ain((if_missing(Missing,Create) ==> 
 ( ( \+ Missing/(Missing\=@=Create)) ==> Create))).

:- mpred_ain((good(X) ==> if_missing(foob(_),foob(X)))).

:- mpred_ain(good(az)).

:- mpred_why(foob(az)).

:- break.
:- ain(foob(b)).

:- call(\+foob(az)).

:- break.

:- trace.
:- ain(==> (\+ foob(b))).

:- break.

:- mpred_why(foob(az)).

:- rtrace(mpred_withdraw( good(az) )).

:- listing([foob,good]).

:- trace.
:- call( \+foob(az)).

:- mpred_ain(~ foob(b)).

% :- pp_DB_Current.

:- mpred_why(~foob(b)).

:- mpred_ain(good(az)).

:- mpred_why(foob(az)).

