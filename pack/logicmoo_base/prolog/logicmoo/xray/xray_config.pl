%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                           %%
%%      Version:  1.00   Date: 15/03/98   File: xray_config.pl               %%
%% Last Version:                          File:                              %%
%% Changes:                                                                  %%
%% 15/03/98 Created                                                          %%
%%                                                                           %%
%% Purpose:                                                                  %%
%%                                                                           %%
%% Author:  Torsten Schaub                                                   %%
%%                                                                           %%
%% Usage:   prolog xray_config.pl                                            %%
%%                                                                           %%
%%                                                                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- ensure_loaded(hooks).
:- ensure_loaded(lemma).

show_call_value(N,V):- V -> dmsg(N=true) ; dmsg(N=false).
show_call_value(V):-show_call_value(V,V).
show_call_value1(N,V):- V -> dmsg(N=V) ; dmsg(N=false).


:- no_hook_handling,hook_configuration.     % indicated by {pred|body}_hook_flag

:- no_lemma_handling,lemma_configuration.   % indicated by lemma_handling_flag

:- dynamic(delta_ordering/1).
:- dynamic(verbose_flag/0).
:- dynamic(compile_complete_search/0).

%%% ----------------------------------------------------------------------
%%% PTTP CONFIGURATION

%%% complete search facilities are turned (during compile-time)
%%%  on by do_compile_complete_search,
%%% off by dont_compile_complete_search.
%%%
%%% do_compile_complete_search or dont_compile_complete_search *must* be
%%% executed before the problem is compiled.

do_compile_complete_search :-
        retract(compile_complete_search),
        fail.
do_compile_complete_search :-
        assert(compile_complete_search).

dont_compile_complete_search :-
        retract(compile_complete_search),
        fail.
dont_compile_complete_search.

:- do_compile_complete_search.            % default is to compile complete search

%%% Proof printing is (better) turned (during compile-time)
%%%  on by   do_compile_proof_printing (print_proof),
%%% off by dont_compile_proof_printing (dont_print_proof).
%%%
%%% do_compile_proof_printing or dont_compile_proof_printing *must* be
%%% executed before the problem is compiled.

do_compile_proof_printing   :- print_proof.
dont_compile_proof_printing :- dont_print_proof.

:- do_compile_proof_printing.            % default is to compile proof printing

%%% Inference counting is turned
%%%  on by   do_compile_count_inferences (count_inferences),
%%% off by dont_compile_count_inferences (dont_count_inferences).
%%%
%%% Inferences are counted by retracting the current count
%%% and asserting the incremented count, so inference counting
%%% is very slow.

do_compile_count_inferences   :- count_inferences.
dont_compile_count_inferences :- dont_count_inferences.

:- dont_compile_count_inferences.

pttp_configuration :-
	nl,dmsg('PTTP CONFIGURATION:'),nl,
	(count_inferences_pred(true) ->
	    dmsg('PTTP counts no inferences.');
	    dmsg('PTTP counts inferences!')),
        (trace_search_progress_pred(nop) ->
	    dmsg('PTTP does not trace search progress.');
	    dmsg('PTTP traces search progress!')),
	(compile_proof_printing ->
	    dmsg('PTTP compiles proof printing!');
	    dmsg('PTTP does not compile proof printing.')),
	(compile_complete_search ->
	    dmsg('PTTP compiles complete search!');
	    dmsg('PTTP does not compile complete search.')).

:- pttp_configuration.

%%% ----------------------------------------------------------------------
%%% XRay CONFIGURATION

xray_configuration :-
	nl,dmsg('XRay CONFIGURATION:'),nl,nl,
	
	dmsg(delta_ordering),
	dmsg(' = '),
	(delta_ordering(O), dmsg(O),dmsg(' '),fail ; dmsg('.')),
	nl,
	
	dmsg(verbose_mode),
	dmsg(' = '),
	(verbose_flag, dmsg("on") ; dmsg("off")),
	nl.

%%% delta_ordering stears the order of admissibility 
%%% and compatibility checking in delta rules
%%% at compile-time

switch_delta_ordering :-
	delta_ordering(compatibility>admissibility),
	admissibility_first.
switch_delta_ordering :-
	delta_ordering(admissibility>compatibility),
	compatibility_first.

compatibility_first :-                      % check compatibility first
        retract(delta_ordering(_)),
        fail.
compatibility_first :-
        assert(delta_ordering(compatibility>admissibility)).

admissibility_first :-                      % check admissibility first
        retract(delta_ordering(_)),
        fail.
admissibility_first :-
        assert(delta_ordering(admissibility>compatibility)).

:- admissibility_first.                     % default is to check admissibility first


%%% Verbose proof printing is turned on by verbose_mode,
%%% off by dont_verbose_mode.
%%% works during compile- and run-time

verbose_mode :-                          % enable proof printing
        retract(verbose_flag),
        fail.
verbose_mode :-
        assert(verbose_flag).

no_verbose_mode :-                     % disable proof printing
        retract(verbose_flag),
        fail.
no_verbose_mode.

:- verbose_mode.                         % default is to print proof

%%% verbose predicate, chatting if verbose_mode is turned on
verbose(X) :-
	verbose_flag ->
	        dmsg(X),nl;
	%true->
		true.

%%% PRINT CONFIGURATION
%%%

:- xray_configuration,nl.

configuration :-
	hook_configuration,
	lemma_configuration,
	pttp_configuration,
	xray_configuration.
