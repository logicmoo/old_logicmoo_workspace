/** <module> logicmoo_plarkc - special module hooks into the logicmoo engine allow
%   clif syntax to be recocogized via our CycL/KIF handlers 
% 
% Logicmoo Project: A LarKC Server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/

:- ensure_loaded(logicmoo_engine).
:- ensure_loaded(plarkc/logicmoo_i_cyc_kb).

:- meta_predicate cwtdl(0,+,+).
:- meta_predicate transfer_predicate(?,0,0).
:- meta_predicate transTiny(?,0).

:- dynamic(cwtdl_failed/1).

cwtdl(Goal,DL,TL):- cwc,
  notrace((ignore((stop_rtrace,
   (show_call_failure(catch(call_with_time_limit(TL,(((call_with_depth_limit(Goal,DL,DLE),DLE\==depth_limit_exceeded)))),E,(dmsg(E:cwtdl(Goal,DL,TL)),fail)))
     ->true;
    assert(cwtdl_failed(Goal))))))).

%:-in_cmt(listing(cwtdl/3)).
:- ltkb1.
% :- dmsg("Loading tinyKB should take under a minute").

%:- in_cmt(doall((filematch(logicmoo('plarkc/logicmoo_i_cyc_kb_tinykb.pl'),F),source_file(X,F),predicate_property(X,static),X\='$pldoc'(_G8428,_G8429,_G8430,_G8431),listing(X)))).

:- file_begin(pfc).

:- must_det(argIsa(genlPreds,2,_)).

transfer_predicate(C,If,Q):-doall((clause(C,true,Ref),If,Q,logOnError(erase(Ref)))).
transTiny(Template,If):-transfer_predicate(tinyK8(Template),If,once(pfc_add(Template))).

:- pfc_no_trace.


reallyLoadTiny:- transTiny(tCol(X),ground(X)).
reallyLoadTiny:- transTiny(arity(X,Y),ground((X,Y))).
reallyLoadTiny:- transTiny(genls(X,Y),((X\=ftAtomicTerm,ground((X,Y))))).
reallyLoadTiny:- pfc_trace.
reallyLoadTiny:- transTiny(genls(X,Y),((ground((X,Y))))).
%TODO_VERIFY_STILL_UNNEEDED :- retract_all((ftClosedAtomicTerm(A) :- ftAtomicTerm(A))).
%TODO_VERIFY_STILL_UNNEEDED :- pfc_rem1(genls(ftAtomicTerm,ftClosedAtomicTerm)).
reallyLoadTiny:- transTiny(genlMt(X,Y),writeq((X,Y))).
reallyLoadTiny:- transTiny(ttFormatType(X),ground(X)).

%TODO_VERIFY_STILL_UNNEEDED :-pfc_rem1(genls(ftAtomicTerm,ftClosedAtomicTerm)).

%TODO_VERIFY_STILL_UNNEEDED :-retract_all((ftClosedAtomicTerm(A) :- ftAtomicTerm(A))).
reallyLoadTiny:- pfc_no_trace.


:- if(false).
:- doall(reallyLoadTiny).
:- endif.


%TODO FIX :-pfc_add((((cycl(X),{must(cyc_to_clif(X,Y))}) ==> clif(Y)))).

:- pfc_no_trace.
:- pfc_add((((cycl('$VAR'('X')),{must(cyc_to_clif('$VAR'('X'),'$VAR'('Y')))}) ==> clif('$VAR'('Y'))))).

% ?-listing(cycl).

%TODO FIX :- must(isa(iExplorer2,tHominid)).
%TODO FIX :- must(tHominid(iExplorer2)).

tHominid(iExplorer2).

:- must((mudSubPart(iExplorer2,Inst),isa(Inst,tHumanNeck))).
:- must((mudSubPart(iExplorer2,Inst),isa(Inst,tHumanHair))).


/*
:- transTiny(Form,(ground(Form),functor(Form,F,1),F\==neg)).

:- set_gui_debug(false).
:- set_no_debug.
:- set_no_debug_thread.

:- transfer_predicate(tinyK8(Form), ( \+ contains_term('$VAR'(_),Form)) , pfc_add((Form))).

:- pfc_trace.

:- set_clause_compile(fwc).

load_later:- notrace((transfer_predicate(tinyK8(Form),writeq(Form),ignore(logOnError(cwtdl(pfc_add(clif(Form)),500,10)))))).

:- pfc_no_trace.

:- in_cmt(listing(cwtdl_failed/1)).

*/
