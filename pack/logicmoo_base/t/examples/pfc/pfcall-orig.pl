%   File   : pfc
%   Author : Tim Finin, finin@umbc.edu
%   Updated: 10/11/87, ...
%   Purpose: consult system file for ensure

user:file_search_path(pack,'/devel/PrologMUD/packs').
:- attach_packs.

:-  'lmbase':ensure_loaded(library(logicmoo/logicmoo_utils)).

% not(P):- \+ P.


:- kill_term_expansion.
%:- include(prologmud(mud_header)).
:- thread_local t_l:pfcExpansion.
:- thread_local t_l:pfcExpansionWas.

:- dynamic p.
:- dynamic x.
:- dynamic q.
:- dynamic fly/1.

:- dynamic old_clausedb/0.
:- dynamic old_assert/0.
:- dynamic old_call/0.
:- dynamic bugger_assert/0.

% old_clausedb.
% old_assert.
old_call.
% bugger_assert:- current_predicate(ain/1).


db_retractall(X):-old_assert,!,retractall(X).
db_retractall(X):-invoke_modify(retract(all),X).
db_retract(X):- old_assert,!,retract(X).
db_retract(X):-invoke_modify(retract(one),X).
db_assertz(X):-old_assert,!,assertz(X).
db_assertz(X):-invoke_modify(assert(z),X).
db_asserta(X):-old_assert,!,asserta(X).
db_asserta(X):-invoke_modify(assert(a),X).
db_assert(X):-old_assert,!,assert(X).
db_assert(X):-invoke_modify(assert(z),X).

db_clause(X,Y,Ref):-old_clausedb,!,clause(X,Y,Ref).
db_clause(X,Y,Ref):-invoke_check(clause(_),clause_asserted(X,Y,Ref)).
db_clause(X,Y):-old_clausedb,!,clause(X,Y).
db_clause(X,Y):-invoke_check(clause(_),clause_asserted(X,Y)).


db_call(Y):-db_call(nonPfc,Y).
db_call(_,Y):-old_call,!,predicate_property(Y,_),!, call(Y).
db_call(What,X):-invoke_call(call(What),X).


rem(X):-pfcRem(X).


invoke_call(_,      B ):- var(B),!,fail.
invoke_call(A,  not(B)):- !, not(invoke_call(A,B)).
invoke_call(A,\+(B)):- !, not(invoke_call(A,B)).
invoke_call(A, call(B)):- !, invoke_call(A,B).
invoke_call(_A,      X ):- !, current_predicate(_,X),!,call(X).
invoke_call(A,      B ):- (invoke_op0(A,B)).

invoke_modify(A,B):-(invoke_op0(A,B)).
invoke_check(A,B):-(invoke_op0(A,B)).



invoke_op0(assert(z),X):- bugger_assert,!,ainz(X).
invoke_op0(assert(a),X):- bugger_assert,!,ain(X).
invoke_op0(assert(_),X):- bugger_assert,!,ain(X).
invoke_op0(assert(z),X):-!,assertz(X).
invoke_op0(assert(a),X):-!,asserta(X).
invoke_op0(assert(_),X):-!,assert(X).
invoke_op0(retract(all),X):-!,retractall(X).
invoke_op0(retract(_),X):-!,retract(X).
invoke_op0(clause(_),(X)):-clause(X,true).
invoke_op0(clause(_),clause_asserted(X,Y)):-!,clause(X,Y).
invoke_op0(clause(_),clause_asserted(X,Y,Ref)):-!,clause(X,Y,Ref).
invoke_op0(_,X):-nonvar(X),current_predicate(_,X),!,call(X).


% :- set_prolog_flag(unknown,fail).
:- dynamic(go/0).

pfcVersion(1.2).

% pfcFile('pfcsyntax').	% operator declarations.

%   File   : pfcsyntax.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Purpose: syntactic sugar for Pfc - operator definitions and term expansions.

:- op(500,fx,'~').
:- op(1050,xfx,('=>')).
:- op(1050,xfx,'<=>').
:- op(1050,xfx,('<=')).
:- op(1100,fx,('=>')).
:- op(1150,xfx,('::::')).

:- multifile('mpred_term_expansion'/2).

mpred_term_expansion((P=>Q),(:- ain((P=>Q)))).
%mpred_term_expansion((P=>Q),(:- ain(('<='(Q,P))))).  % speed-up attempt
mpred_term_expansion(('<='(P,Q)),(:- ain(('<='(P,Q))))).
mpred_term_expansion((P<=>Q),(:- ain((P<=>Q)))).
mpred_term_expansion((RuleName :::: Rule),(:- ain((RuleName :::: Rule)))).
mpred_term_expansion((=>P),(:- ain(P))).

:- multifile(term_expansion/2).
term_expansion(A,B):- once(true ; t_l:pfcExpansion), once(mpred_term_expansion(A,B)),A\=@=B.

:- asserta(t_l:pfcExpansion).

% pfcFile('pfccore').	% core of Pfc.

%   File   : pfccore.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Updated: 10/11/87, ...
%            4/2/91 by R. McEntire: added calls to valid_dbref as a
%                                   workaround for the Quintus 3.1
%                                   bug in the recorded database.
%   Purpose: core Pfc predicates.

:- use_module(library(lists)).

:- dynamic ('=>')/2.
:- dynamic ('::::')/2.
:- dynamic '<=>'/2.
:- dynamic '<='/2.
:- dynamic 'pt'/2.
:- dynamic 'nt'/3.
:- dynamic 'bt'/2.
:- dynamic pfcUndoMethod/2.
:- dynamic (mpred_action)/1.
%:- dynamic pfcTmsMode/1.
:- dynamic mpred_queue/1.
:- dynamic pfcDatabase/1.
:- dynamic mpred_haltSignal/0.
%:- dynamic pfcDebugging/0.
%:- dynamic mpred_select/1.
%:- dynamic mpred_search/1.

%%% initialization of global assertons 

%% mpred_default/1 initialized a global assertion.
%%  mpred_default(P,Q) - if there is any fact unifying with P, then do 
%%  nothing, else db_assert Q.

mpred_default(GeneralTerm,Default) :-
  db_clause(GeneralTerm,true) -> true ; db_assert(Default).

%% pfcTmsMode is one of {none,local,cycles} and controles the tms alg.
:- mpred_default(mpred_settings(tmsMode,_), mpred_settings(tmsMode,cycles)).

% Pfc Search strategy. mpred_settings(searchMode,X) where X is one of {direct,depth,breadth}
:- mpred_default(mpred_settings(searchMode,_), mpred_settings(searchMode,direct)).


% 

%% add/2 and pfcPost/2 are the main ways to db_assert new clauses into the
%% database and have forward reasoning done.

%% ain(P,S) asserts P into the dataBase with support from S.

ain(P) :-  ain(P,(pcfUser,pcfUser)).

ain((=>P),S) :- ain(P,S).

ain(P,S) :- 
  pfcPost(P,S),
  pfcRun.

%ain(_,_).
%ain(P,S) :- mpred_warn("ain(~w,~w) failed",[P,S]).


% pfcPost(+Ps,+S) tries to add a fact or set of fact to the database.  For
% each fact (or the singelton) pfcPost1 is called. It always succeeds.

pfcPost([H|T],S) :-
  !,
  pfcPost1(H,S),
  pfcPost(T,S).
pfcPost([],_) :- !.
pfcPost(P,S) :- pfcPost1(P,S).


% pfcPost1(+P,+S) tries to add a fact to the database, and, if it succeeded,
% adds an entry to the pfc queue for subsequent forward chaining.
% It always succeeds.

pfcPost1(P,S) :- 
  %% db ainDbToHead(P,P2),
  % pfcRemoveOldVersion(P),
  ainSupport(P,S),
  pfcUnique(P),
  db_assert(P),
  pfcTraceAdd(P,S),
  !,
  pfcEnqueue(P,S),
  !.

pfcPost1(_,_).
%%pfcPost1(P,S) :-  mpred_warn("ain(~w,~w) failed",[P,S]).

%%
%% ainDbToHead(+P,-NewP) talkes a fact P or a conditioned fact
%% (P:-C) and adds the Db context.
%%

ainDbToHead(P,NewP) :-
  pfcCurrentDb(Db),
  (Db=true        -> NewP = P;
   P=(Head:-Body) -> NewP = (Head :- (Db,Body));
   otherwise      -> NewP = (P :- Db)).


% pfcUnique(X) is true if there is no assertion X in the prolog db.

pfcUnique((Head:-Tail)) :- 
  !, 
  \+ db_clause(Head,Tail).
pfcUnique(P) :-
  !,
  \+ db_clause(P,true).


pfcEnqueue(P,S) :-
  mpred_settings(searchMode,Mode) 
    -> (Mode=direct  -> pfcFwd(P) ;
	Mode=depth   -> pfcAsserta(mpred_queue(P),S) ;
	Mode=breadth -> pfcAssert(mpred_queue(P),S) ;
	else         -> mpred_warn("Unrecognized mpred_search mode: ~w", Mode))
     ; mpred_warn("No mpred_search mode").


% if there is a rule of the form Identifier ::: Rule then delete it.

pfcRemoveOldVersion((Identifier::::Body)) :-
  % this should never happen.
  var(identifier),
  !,
  mpred_warn("variable used as an  rule name in ~w :::: ~w",
          [Identifier,Body]).

  
pfcRemoveOldVersion((Identifier::::Body)) :-
  nonvar(Identifier),
  db_clause((Identifier::::OldBody),_),
  \+(Body=OldBody),
  pfcRem((Identifier::::OldBody)),
  !.
pfcRemoveOldVersion(_).



% 

% pfcRun compute the deductive closure of the current database. 
% How this is done depends on the searching mode:
%    direct -  fc has already done the job.
%    depth or breadth - use the mpred_queue mechanism.

pfcRun :-
  ( \+ mpred_settings(searchMode,direct)),
  mpred_step,
  pfcRun.
pfcRun.


% mpred_step removes one entry from the mpred_queue and reasons from it.


mpred_step :-  
  % if mpred_haltSignal is true, reset it and fail, thereby stopping inferencing.
  pfcRetract(mpred_haltSignal),
  !, 
  fail.

mpred_step :-
  % draw immediate conclusions from the next fact to be considered.
  % fails iff the queue is empty.
  get_next_fact(P),
  pfcdo(pfcFwd(P)),
  !.

get_next_fact(P) :-
  %identifies the nect fact to fc from and removes it from the queue.
  select_next_fact(P),
  remove_selection(P).

remove_selection(P) :- 
  pfcRetract(mpred_queue(P)),
  pfcRemoveSupportsQuietly(mpred_queue(P)),
  !.
remove_selection(P) :-
  brake(format("~Npfc:get_next_fact - selected fact not on Queue: ~w",
               [P])).


% select_next_fact(P) identifies the next fact to reason from.  
% It tries the pcfUser defined predicate first and, failing that, 
%  the default mechanism.

select_next_fact(P) :- 
  mpred_select(P),
  !.  
select_next_fact(P) :- 
  defaultmpred_select(P),
  !.  

% the default selection predicate takes the item at the froint of the queue.
defaultmpred_select(P) :- mpred_queue(P),!.

% mpred_halt stops the forward chaining.
mpred_halt :-  mpred_halt("",[]).

mpred_halt(Format) :- mpred_halt(Format,[]).

mpred_halt(Format,Args) :- 
  format(Format,Args),
  mpred_haltSignal -> 
       mpred_warn("mpred_halt finds mpred_haltSignal already set")
     ; db_assert(mpred_haltSignal).


%%
%%
%% predicates for manipulating triggers
%%


ainTrigger(pt(Trigger,Body),Support) :-
  !,
  mpred_trace_msg('~n      Adding positive trigger ~q~n',
		[pt(Trigger,Body)]),
  pfcAssert(pt(Trigger,Body),Support),
  copy_term(pt(Trigger,Body),Tcopy),
  pfcBC(Trigger),
  pfcEvalLHS(Body,(Trigger,Tcopy)),
  fail.


ainTrigger(nt(Trigger,Test,Body),Support) :-
  !,
  mpred_trace_msg('~n      Adding negative trigger: ~q~n       test: ~q~n       body: ~q~n',
		[Trigger,Test,Body]),
  copy_term(Trigger,TriggerCopy),
  pfcAssert(nt(TriggerCopy,Test,Body),Support),
  \+Test,
  pfcEvalLHS(Body,(( \+Trigger),nt(TriggerCopy,Test,Body))).

ainTrigger(bt(Trigger,Body),Support) :-
  !,
  pfcAssert(bt(Trigger,Body),Support),
  pfcBtPtCombine(Trigger,Body).

ainTrigger(X,_Support) :-
  mpred_warn("Unrecognized trigger to aintrigger: ~w",[X]).


pfcBtPtCombine(Head,Body,Support) :- 
  %% a backward trigger (bt) was just added with head and Body and support Support
  %% find any pt's with unifying heads and add the instantied bt body.
  pfcGetTriggerQuick(pt(Head,_PtBody)),
  pfcEvalLHS(Body,Support),
  fail.
pfcBtPtCombine(_,_,_) :- !.

pfcGetTriggerQuick(Trigger) :-  db_clause(Trigger,true).

pfcGetTrigger(Trigger):-pfcGetTriggerQuick(Trigger).

%%
%%
%% predicates for manipulating action traces.
%%

ainActionTrace(Action,Support) :- 
  % adds an action trace and it's support.
  ainSupport(mpred_action(Action),Support).

pfcRemActionTrace(mpred_action(A)) :-
  pfcUndoMethod(A,M),
  M,
  !.


%%
%% predicates to remove pfc facts, triggers, action traces, and queue items
%% from the database.
%%

pfcRetract(X) :- 
  %% db_retract an arbitrary thing.
  mpred_db_type(X,Type),
  pfcRetractType(Type,X),
  !.

pfcRetractType(fact,X) :-   
  %% db ainDbToHead(X,X2), db_retract(X2). 
  db_retract(X).

pfcRetractType(rule,X) :- 
  %% db  ainDbToHead(X,X2),  db_retract(X2).
  db_retract(X).
pfcRetractType(trigger,X) :- 
  db_retract(X)
    -> unFc(X)
     ; mpred_warn("Trigger not found to db_retract: ~w",[X]).

pfcRetractType(action,X) :- pfcRemActionTrace(X).
  

%% ainSome(X) adds item X to some database

ainSome(X) :-
  % what type of X do we have?
  mpred_db_type(X,Type),
  % db_call the appropriate predicate.
  ainType(Type,X).

ainType(fact,X) :- 
  pfcUnique(X), 
  db_assert(X),!.
ainType(rule,X) :- 
  pfcUnique(X), 
  db_assert(X),!.
ainType(trigger,X) :- 
  db_assert(X).
ainType(action,_Action) :- !.


  

%% pfcRem(P,S) removes support S from P and checks to see if P is still supported.
%% If it is not, then the fact is retreactred from the database and any support
%% relationships it participated in removed.

pfcRem(List) :- 
  % iterate down the list of facts to be pfcRem'ed.
  nonvar(List),
  List=[_|_],
  pfcRem_L(List).
  
pfcRem(P) :- 
  % pfcRem/1 is the pcfUser's interface - it withdraws pcfUser support for P.
  pfcRem(P,(pcfUser,pcfUser)).

pfcRem_L([H|T]) :-
  % pfcRem each element in the list.
  pfcRem(H,(pcfUser,pcfUser)),
  pfcRem_L(T).

pfcRem(P,S) :-
  % pfcDebug(format("~Nremoving support ~w from ~w",[S,P])),
  mpred_trace_msg('~n    Removing support: ~q from ~q~n',[S,P]),
  pfcRemSupport(P,S)
     -> pcfRemoveIfUnsupported(P)
      ; mpred_warn("pfcRem/2 Could not find support ~w to remove from fact ~w",
                [S,P]).

%%
%% mpred_rem2 is like pfcRem, but if P is still in the DB after removing the
%% pcfUser's support, it is retracted by more forceful means (e.g. remove).
%%

mpred_rem2(P) :- 
  % mpred_rem2/1 is the pcfUser's interface - it withdraws pcfUser support for P.
  mpred_rem2(P,(pcfUser,pcfUser)).

mpred_rem2(P,S) :-
  pfcRem(P,S),
  pfcBC(P)
     -> remove(P) 
      ; true.

%%
%% remove(+F) retracts fact F from the DB and removes any dependent facts */
%%

remove(F) :- 
  pfcRemoveSupports(F),
  pfcUndo(F).


% removes any remaining supports for fact F, complaining as it goes.

pfcRemoveSupports(F) :- 
  pfcRemSupport(F,S),
  mpred_warn("~w was still supported by ~w",[F,S]),
  fail.
pfcRemoveSupports(_).

pfcRemoveSupportsQuietly(F) :- 
  pfcRemSupport(F,_),
  fail.
pfcRemoveSupportsQuietly(_).

% pfcUndo(X) undoes X.


pfcUndo(mpred_action(A)) :-  
  % undo an action by finding a method and successfully executing it.
  !,
  pfcRemActionTrace(mpred_action(A)).

pfcUndo(pfcPT3(Key,Head,Body)) :-  
  % undo a positive trigger.
  %
  !,
  (db_retract(pfcPT3(Key,Head,Body))
    -> unFc(pt(Head,Body))
     ; mpred_warn("Trigger not found to db_retract: ~w",[pt(Head,Body)])).

pfcUndo(nt(Head,Condition,Body)) :-  
  % undo a negative trigger.
  !,
  (db_retract(nt(Head,Condition,Body))
    -> unFc(nt(Head,Condition,Body))
     ; mpred_warn("Trigger not found to db_retract: ~w",[nt(Head,Condition,Body)])).

pfcUndo(Fact) :-
  % undo a random fact, printing out the trace, if relevant.
  db_retract(Fact),
  pfcTraceRem(Fact),
  unFc1(Fact).
  


%% unFc(P) "un-forward-chains" from fact f.  That is, fact F has just
%% been removed from the database, so remove all support relations it
%% participates in and check the things that they support to see if they
%% should stayu in the database or should also be removed.


unFc(F) :- 
  pfcRetractSupportRelations(F),
  unFc1(F).

unFc1(F) :-
  pfcUnFcCheckTriggers(F),
  % is this really the right place for pfcRun<?
  pfcRun.


pfcUnFcCheckTriggers(F) :-
  mpred_db_type(F,fact),
  copy_term(F,Fcopy),
  nt(Fcopy,Condition,Action),
  ( \+ Condition),
  pfcEvalLHS(Action,(( \+F),nt(F,Condition,Action))),
  fail.
pfcUnFcCheckTriggers(_).

pfcRetractSupportRelations(Fact) :-
  mpred_db_type(Fact,Type),
  (Type=trigger -> pfcRemSupport(P,(_,Fact))
                ; pfcRemSupport(P,(Fact,_))),
  pcfRemoveIfUnsupported(P),
  fail.
pfcRetractSupportRelations(_).



%% pcfRemoveIfUnsupported(+P) checks to see if P is supported and removes
%% it from the DB if it is not.

pcfRemoveIfUnsupported(P) :- 
   mpred_tms_supported(P) -> true ;  pfcUndo(P).


%% mpred_tms_supported(+P) succeeds if P is "supported". What this means
%% depends on the TMS mode selected.

mpred_tms_supported(P) :- 
  mpred_settings(tmsMode,Mode),
  mpred_tms_supported(Mode,P).

mpred_tms_supported(local,P) :- !, pfcGetSupport(P,_).
mpred_tms_supported(cycles,P) :-  !, wellFounded(P).
mpred_tms_supported(_,_P) :- true.


%%
%% a fact is well founded if it is supported by the pcfUser
%% or by a set of facts and a rules, all of which are well founded.
%%

wellFounded(Fact) :- pfcWFF(Fact,[]).

pfcWFF(F,_) :-
  % supported by pcfUser (pfcAxiom) or an "absent" fact (pfcAssumptionBase).
  (pfcAxiom(F) ; pfcAssumptionBase(F)),
  !.

pfcWFF(F,Descendants) :-
  % first make sure we aren't in a loop.
  ( \+ memberchk(F,Descendants)),
  % find a pfcJustificationDB.
  supports(F,Supporters),
  % all of whose members are well founded.
  pfcWFF_L(Supporters,[F|Descendants]),
  !.

%% pfcWFF_L(L) simply maps pfcWFF over the list.

pfcWFF_L([],_).
pfcWFF_L([X|Rest],L) :-
  pfcWFF(X,L),
  pfcWFF_L(Rest,L).



% supports(+F,-ListofSupporters) where ListOfSupports is a list of the
% supports for one pfcJustificationDB for fact F -- i.e. a list of facts which,
% together allow one to deduce F.  One of the facts will typically be a rule.
% The supports for a pcfUser-defined fact are: [pcfUser].

supports(F,[Fact|MoreFacts]) :-
  pfcGetSupport(F,(Fact,Trigger)),
  triggerSupports(Trigger,MoreFacts).

triggerSupports(pcfUser,[]) :- !.
triggerSupports(Trigger,[Fact|MoreFacts]) :-
  pfcGetSupport(Trigger,(Fact,AnotherTrigger)),
  triggerSupports(AnotherTrigger,MoreFacts).


%%
%%
%% pfcFwd(X) forward chains from a fact or a list of facts X.
%%


pfcFwd([H|T]) :- !, pfcFwd1(H), pfcFwd(T).
pfcFwd([]) :- !.
pfcFwd(P) :- pfcFwd1(P).

% pfcFwd1(+P) forward chains for a single fact.

% pfcFwd1(Fact) :- map_if_list(pfcFwd1,List),!.
pfcFwd1(Fact) :-
  fc_rule_check(Fact),
  copy_term(Fact,F),
  % check positive triggers
  pfcRunPT(Fact,F),
  % check negative triggers
  pfcRunNT(Fact,F).


%%
%% fc_rule_check(P) does some special, built in forward chaining if P is 
%% a rule.
%% 

fc_rule_check((P=>Q)) :-  
  !,  
  pfcProcessRule(P,Q,(P=>Q)).
fc_rule_check((Name::::P=>Q)) :- 
  !,  
  pfcProcessRule(P,Q,(Name::::P=>Q)).
fc_rule_check((P<=>Q)) :- 
  !, 
  pfcProcessRule(P,Q,(P<=>Q)), 
  pfcProcessRule(Q,P,(P<=>Q)).
fc_rule_check((Name::::P<=>Q)) :- 
  !, 
  pfcProcessRule(P,Q,((Name::::P<=>Q))), 
  pfcProcessRule(Q,P,((Name::::P<=>Q))).

fc_rule_check(('<='(P,Q))) :-
  !,
  pfcDefineBcRule(P,Q,('<='(P,Q))).

fc_rule_check(_).


pfcRunPT(Fact,F) :- 
  pfcGetTriggerQuick(pt(F,Body)),
  mpred_trace_msg('~n      Found positive trigger: ~q~n       body: ~q~n',
		[F,Body]),
  pfcEvalLHS(Body,(Fact,pt(F,Body))),
  fail.

%pfcRunPT(Fact,F) :- 
%  pfcGetTriggerQuick(pt(presently(F),Body)),
%  pfcEvalLHS(Body,(presently(Fact),pt(presently(F),Body))),
%  fail.

pfcRunPT(_,_).

pfcRunNT(_Fact,F) :-
  support3(nt(F,Condition,Body),X,_),
  Condition,
  pfcRem(X,(_,nt(F,Condition,Body))),
  fail.
pfcRunNT(_,_).


%%
%% pfcDefineBcRule(+Head,+Body,+ParentRule) - defines a backeard
%% chaining rule and adds the corresponding bt triggers to the database.
%%

pfcDefineBcRule(Head,_Body,ParentRule) :-
  ( \+ mpred_literal(Head)),
  mpred_warn("Malformed backward chaining rule.  ~w not atomic.",[Head]),
  mpred_warn("rule: ~w",[ParentRule]),
  !,
  fail.

pfcDefineBcRule(Head,Body,ParentRule) :-
  copy_term(ParentRule,ParentRuleCopy),
  pfcBuildRhs(Head,Rhs),
  foreach(mpred_nf(Body,Lhs),
          (pfcBuildTrigger(Lhs,rhs(Rhs),Trigger),
           ain(bt(Head,Trigger),(ParentRuleCopy,pcfUser)))).
 


%%
%%
%% eval something on the LHS of a rule.
%%

 
pfcEvalLHS((Test->Body),Support) :-  
  !, 
  (db_call(nonPfC,Test) -> pfcEvalLHS(Body,Support)),
  !.

pfcEvalLHS(rhs(X),Support) :-
  !,
  mpred_eval_rhs(X,Support),
  !.

pfcEvalLHS(X,Support) :-
  mpred_db_type(X,trigger),
  !,
  ainTrigger(X,Support),
  !.

%pfcEvalLHS(snip(X),Support) :- 
%  snip(Support),
%  pfcEvalLHS(X,Support).

pfcEvalLHS(X,_) :-
  mpred_warn("Unrecognized item found in trigger body, namely ~w.",[X]).


%%
%% eval something on the RHS of a rule.
%%

mpred_eval_rhs([],_) :- !.
mpred_eval_rhs([Head|Tail],Support) :- 
  mpred_eval_rhs1(Head,Support),
  mpred_eval_rhs(Tail,Support).


mpred_eval_rhs1({Action},Support) :-
 % evaluable Prolog code.
 !,
 pfcEvalAction(Action,Support).

mpred_eval_rhs1(P,_Support) :-
 % predicate to remove.
 pfcNegatedLiteral(P),
 !,
 pfcRem(P).

mpred_eval_rhs1([X|Xrest],Support) :-
 % embedded sublist.
 !,
 mpred_eval_rhs([X|Xrest],Support).

mpred_eval_rhs1(Assertion,Support) :-
 % an assertion to be added.
 pfcPost1(Assertion,Support).


mpred_eval_rhs1(X,_) :-
  mpred_warn("Malformed rhs of a rule: ~w",[X]).


%%
%% evaluate an action found on the rhs of a rule.
%%

pfcEvalAction(Action,Support) :-
  db_call(nonPfC,Action), 
  (pfcUndoable(Action) 
     -> ainActionTrace(Action,Support) 
      ; true).


%%
%% 
%%

mpred_trigger_the_trigger(Trigger,Body,_Support) :-
 trigger_trigger1(Trigger,Body).
mpred_trigger_the_trigger(_,_,_).


%trigger_trigger1(presently(Trigger),Body) :-
%  !,
%  copy_term(Trigger,TriggerCopy),
%  pfcBC(Trigger),
%  pfcEvalLHS(Body,(presently(Trigger),pt(presently(TriggerCopy),Body))),
%  fail.

trigger_trigger1(Trigger,Body) :-
  copy_term(Trigger,TriggerCopy),
  pfcBC(Trigger),
  pfcEvalLHS(Body,(Trigger,pt(TriggerCopy,Body))),
  fail.



%%
%% pfcBC(F) is true iff F is a fact available for forward chaining.
%% Note that this has the side effect of catching unsupported facts and
%% assigning them support from God.
%%

pfcBC(P) :-
  % trigger any bc rules.
  bt(P,Trigger),
  pfcGetSupport(bt(P,Trigger),S),
  pfcEvalLHS(Trigger,S),
  fail.

pfcBC(F) :-
  %% this is probably not advisable due to extreme inefficiency.
  var(F)    ->  pfcFact(F) ;
  otherwise ->  db_clause(F,Condition),db_call(nonPfC,Condition).

%%pfcBC(F) :- 
%%  %% we really need to check for system predicates as well.
%%  % current_predicate(_,F) -> db_call(nonPfC,F).
%%  db_clause(F,Condition),db_call(nonPfC,Condition).


% an action is pfcUndoable if there exists a method for undoing it.
pfcUndoable(A) :- pfcUndoMethod(A,_).



%%
%%
%% defining fc rules 
%%

%% mpred_nf(+In,-Out) maps the LHR of a pfc rule In to one normal form 
%% Out.  It also does certain optimizations.  Backtracking into this
%% predicate will produce additional clauses.


mpred_nf(LHS,List) :-
  mpred_nf1(LHS,List2),
  mpred_nf_negations(List2,List).


%% mpred_nf1(+In,-Out) maps the LHR of a pfc rule In to one normal form
%% Out.  Backtracking into this predicate will produce additional clauses.

% handle a variable.

mpred_nf1(P,[P]) :- var(P), !.

% these next two rules are here for upward compatibility and will go 
% away eventually when the P/Condition form is no longer used anywhere.

mpred_nf1(P/Cond,[( \+P)/Cond]) :- pfcNegatedLiteral(P), !.

mpred_nf1(P/Cond,[P/Cond]) :-  mpred_literal(P), !.

%% handle a negated form

mpred_nf1(NegTerm,NF) :-
  mpred_negation(NegTerm,Term),
  !,
  mpred_nf1_negation(Term,NF).

%% disjunction.

mpred_nf1((P;Q),NF) :- 
  !,
  (mpred_nf1(P,NF) ;   mpred_nf1(Q,NF)).


%% conjunction.

mpred_nf1((P,Q),NF) :-
  !,
  mpred_nf1(P,NF1),
  mpred_nf1(Q,NF2),
  append(NF1,NF2,NF).

%% handle a random atom.

mpred_nf1(P,[P]) :- 
  mpred_literal(P), 
  !.

%%% shouln't we have something to catch the rest as errors?
mpred_nf1(Term,[Term]) :-
  mpred_warn("mpred_nf doesn't know how to normalize ~w",[Term]).


%% mpred_nf1_negation(P,NF) is true if NF is the normal form of \+P.
mpred_nf1_negation((P/Cond),[( \+(P))/Cond]) :- !.

mpred_nf1_negation((P;Q),NF) :-
  !,
  mpred_nf1_negation(P,NFp),
  mpred_nf1_negation(Q,NFq),
  append(NFp,NFq,NF).

mpred_nf1_negation((P,Q),NF) :- 
  % this code is not correct! twf.
  !,
  mpred_nf1_negation(P,NF) 
  ;
  (mpred_nf1(P,Pnf),
   mpred_nf1_negation(Q,Qnf),
   append(Pnf,Qnf,NF)).

mpred_nf1_negation(P,[\+P]).


%% mpred_nf_negations(List2,List) sweeps through List2 to produce List,
%% changing ~{...} to {\+...}
%%% ? is this still needed? twf 3/16/90

mpred_nf_negations(X,X) :- !.  % I think not! twf 3/27/90

mpred_nf_negations([],[]).

mpred_nf_negations([H1|T1],[H2|T2]) :-
  mpred_nf_negation(H1,H2),
  mpred_nf_negations(T1,T2).

mpred_nf_negation(Form,{\+ X}) :- 
  nonvar(Form),
  Form=(~({X})),
  !.
mpred_nf_negation(X,X).


%%
%% pfcBuildRhs(+Conjunction,-Rhs)
%%

pfcBuildRhs(X,[X]) :- 
  var(X),
  !.

pfcBuildRhs((A,B),[A2|Rest]) :- 
  !, 
  pfcCompileRhsTerm(A,A2),
  pfcBuildRhs(B,Rest).

pfcBuildRhs(X,[X2]) :-
   pfcCompileRhsTerm(X,X2).

pfcCompileRhsTerm((P/C),((P:-C))) :- !.

pfcCompileRhsTerm(P,P).


%% mpred_negation(N,P) is true if N is a negated term and P is the term
%% with the negation operator stripped.

mpred_negation((~P),P).
mpred_negation((-P),P).
mpred_negation(( \+(P)),P).

pfcNegatedLiteral(P) :- 
  mpred_negation(P,Q),
  pfcPositiveAtom(Q).

mpred_literal(X) :- pfcNegatedLiteral(X).
mpred_literal(X) :- pfcPositiveAtom(X).

pfcPositiveAtom(X) :-  
  functor(X,F,_), 
  \+ pfcConnective(F).

pfcConnective(';').
pfcConnective(',').
pfcConnective('/').
pfcConnective('|').
pfcConnective(('=>')).
pfcConnective(('<=')).
pfcConnective('<=>').

pfcConnective('-').
pfcConnective('~').
pfcConnective(('\\+')).

pfcProcessRule(Lhs,Rhs,ParentRule) :-
  copy_term(ParentRule,ParentRuleCopy),
  pfcBuildRhs(Rhs,Rhs2),
  foreach(mpred_nf(Lhs,Lhs2), 
          pfcBuild1Rule(Lhs2,rhs(Rhs2),(ParentRuleCopy,pcfUser))).

pfcBuild1Rule(Lhs,Rhs,Support) :-
  pfcBuildTrigger(Lhs,Rhs,Trigger),
  pfcEvalLHS(Trigger,Support).

pfcBuildTrigger([],Consequent,Consequent).

pfcBuildTrigger([V|Triggers],Consequent,pt(V,X)) :-
  var(V),
  !, 
  pfcBuildTrigger(Triggers,Consequent,X).

pfcBuildTrigger([(T1/Test)|Triggers],Consequent,nt(T2,Test2,X)) :-
  mpred_negation(T1,T2),
  !, 
  pfcBuildNtTest(T2,Test,Test2),
  pfcBuildTrigger(Triggers,Consequent,X).

pfcBuildTrigger([(T1)|Triggers],Consequent,nt(T2,Test,X)) :-
  mpred_negation(T1,T2),
  !,
  pfcBuildNtTest(T2,true,Test),
  pfcBuildTrigger(Triggers,Consequent,X).

pfcBuildTrigger([{Test}|Triggers],Consequent,(Test->X)) :-
  !,
  pfcBuildTrigger(Triggers,Consequent,X).

pfcBuildTrigger([T/Test|Triggers],Consequent,pt(T,X)) :-
  !, 
  pfcBuildTest(Test,Test2),
  pfcBuildTrigger([{Test2}|Triggers],Consequent,X).


%pfcBuildTrigger([snip|Triggers],Consequent,snip(X)) :-
%  !,
%  pfcBuildTrigger(Triggers,Consequent,X).

pfcBuildTrigger([T|Triggers],Consequent,pt(T,X)) :-
  !, 
  pfcBuildTrigger(Triggers,Consequent,X).

%%
%% pfcBuildNtTest(+,+,-).
%%
%% builds the test used in a negative trigger (nt/3).  This test is a
%% conjunction of the check than no matching facts are in the db and any
%% additional test specified in the rule attached to this ~ term.
%%

pfcBuildNtTest(T,Testin,Testout) :-
  pfcBuildTest(Testin,Testmid),
  pfcConjoin((pfcBC(T)),Testmid,Testout).

  
% this just strips away any currly brackets.

pfcBuildTest({Test},Test) :- !.
pfcBuildTest(Test,Test).

%%



%% simple typeing for pfc objects

mpred_db_type(('=>'(_,_)),Type) :- !, Type=rule.
mpred_db_type(('<=>'(_,_)),Type) :- !, Type=rule.
mpred_db_type(('<='(_,_)),Type) :- !, Type=rule.
mpred_db_type(pfcPT3(_,_,_),Type) :- !, Type=trigger.
mpred_db_type(pt(_,_),Type) :- !, Type=trigger.
mpred_db_type(nt(_,_,_),Type) :- !,  Type=trigger.
mpred_db_type(bt(_,_),Type) :- !,  Type=trigger.
mpred_db_type(mpred_action(_),Type) :- !, Type=action.
mpred_db_type((('::::'(_,X))),Type) :- !, mpred_db_type(X,Type).
mpred_db_type(_,fact) :-
  %% if it's not one of the above, it must be a fact!
  !.

pfcAssert(P,Support) :- 
  (mpred_clause(P) ; db_assert(P)),
  !,
  ainSupport(P,Support).

pfcAsserta(P,Support) :-
  (mpred_clause(P) ; db_asserta(P)),
  !,
  ainSupport(P,Support).

pfcAssertz(P,Support) :-
  (mpred_clause(P) ; db_assertz(P)),
  !,
  ainSupport(P,Support).

mpred_clause((Head :- Body)) :-
  !,
  copy_term(Head,Head_copy),
  copy_term(Body,Body_copy),
  db_clause(Head,Body),
  variant(Head,Head_copy),
  variant(Body,Body_copy).

mpred_clause(Head) :-
  % find a unit db_clause identical to Head by finding one which unifies,
  % and then checking to see if it is identical
  copy_term(Head,Head_copy),
  db_clause(Head_copy,true),
  variant(Head,Head_copy).

foreach(Binder,Body) :- Binder,pfcdo(Body),fail.
foreach(_,_).

% pfcdo(X) executes X once and always succeeds.
pfcdo(X) :- X,!.
pfcdo(_).


%% pfcUnion(L1,L2,L3) - true if set L3 is the result of appending sets
%% L1 and L2 where sets are represented as simple lists.

pfcUnion([],L,L).
pfcUnion([Head|Tail],L,Tail2) :-  
  memberchk(Head,L),
  !,
  pfcUnion(Tail,L,Tail2).
pfcUnion([Head|Tail],L,[Head|Tail2]) :-  
  pfcUnion(Tail,L,Tail2).


%% pfcConjoin(+Conjunct1,+Conjunct2,?Conjunction).
%% arg3 is a simplified expression representing the conjunction of
%% args 1 and 2.

pfcConjoin(true,X,X) :- !.
pfcConjoin(X,true,X) :- !.
pfcConjoin(C1,C2,(C1,C2)).

% pfcFile('pfcsupport').	% support maintenance

%%
%%
%% predicates for manipulating support relationships
%%

:- dynamic(support2/3).
:- dynamic(spft/3).
:- dynamic(support3/3).

%% ainSupport(+Fact,+Support)

ainSupport(P,(Fact,Trigger)) :-
  db_assert(spft(P,Fact,Trigger)),
  db_assert(support2(Fact,Trigger,P)),
  db_assert(support3(Trigger,P,Fact)).

pfcGetSupport(P,(Fact,Trigger)) :-
   nonvar(P)         -> spft(P,Fact,Trigger) 
   ; nonvar(Fact)    -> support2(Fact,Trigger,P) 
   ; nonvar(Trigger) -> support3(Trigger,P,Fact) 
   ; otherwise       -> spft(P,Fact,Trigger).


% There are three of these to try to efficiently handle the cases
% where some of the arguments are not bound but at least one is.

pfcRemSupport(P,(Fact,Trigger)) :-
  nonvar(P),
  !,
  pfcRetractOrWarn(spft(P,Fact,Trigger)),
  pfcRetractOrWarn(support2(Fact,Trigger,P)),
  pfcRetractOrWarn(support3(Trigger,P,Fact)).


pfcRemSupport(P,(Fact,Trigger)) :-
  nonvar(Fact),
  !,
  pfcRetractOrWarn(support2(Fact,Trigger,P)),
  pfcRetractOrWarn(spft(P,Fact,Trigger)),
  pfcRetractOrWarn(support3(Trigger,P,Fact)).

pfcRemSupport(P,(Fact,Trigger)) :-
  pfcRetractOrWarn(support3(Trigger,P,Fact)),
  pfcRetractOrWarn(spft(P,Fact,Trigger)),
  pfcRetractOrWarn(support2(Fact,Trigger,P)).


mpred_collect_supports(Tripples) :-
  bagof(Tripple, mpred_support_relation(Tripple), Tripples),
  !.
mpred_collect_supports([]).

mpred_support_relation((P,F,T)) :-
  spft(P,F,T).

mpred_make_supports((P,S1,S2)) :- 
  ainSupport(P,(S1,S2),_),
  (ainSome(P); true),
  !.

%% pfcTriggerKey(+Trigger,-Key) 
%%
%% Arg1 is a trigger.  Key is the best term to index it on.

pfcTriggerKey(pt(Key,_),Key).
pfcTriggerKey(pfcPT3(Key,_,_),Key).
pfcTriggerKey(nt(Key,_,_),Key).
pfcTriggerKey(Key,Key).


%%^L
%% Get a key from the trigger that will be used as the first argument of
%% the trigger pfcBase1 db_clause that stores the trigger.
%%

mpred_trigger_key(X,X) :- var(X), !.
mpred_trigger_key(chart(word(W),_L),W) :- !.
mpred_trigger_key(chart(stem([Char1|_Rest]),_L),Char1) :- !.
mpred_trigger_key(chart(Concept,_L),Concept) :- !.
mpred_trigger_key(X,X).



% pfcFile('t_l').	% predicates to manipulate database.


%   File   : t_l.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Author :  Dan Corpron
%   Updated: 10/11/87, ...
%   Purpose: predicates to manipulate a pfc database (e.g. save,
%%	restore, reset, etc.0

% pfcDatabaseTerm(P/A) is true iff P/A is something that pfc adds to
% the database and should not be present in an empty pfc database

pfcDatabaseTerm(spft/3).
pfcDatabaseTerm(support2/3).
pfcDatabaseTerm(support3/3).
pfcDatabaseTerm(pt/3).
pfcDatabaseTerm(bt/3).
pfcDatabaseTerm(nt/4).
pfcDatabaseTerm('=>'/2).
pfcDatabaseTerm('<=>'/2).
pfcDatabaseTerm('<='/2).
pfcDatabaseTerm(mpred_queue/1).

% removes all forward chaining rules and pfcJustification_L from db.

pfcReset :-
  db_clause(spft(P,F,Trigger),true),
  pfcRetractOrWarn(P),
  pfcRetractOrWarn(spft(P,F,Trigger)),
  pfcRetractOrWarn(support2(F,Trigger,P)),
  pfcRetractOrWarn(support3(Trigger,P,F)),
  fail.
pfcReset :-
  pfcDatabaseItem(T),
  pfcError("Pfc database not empty after pfcReset, e.g., ~p.~n",[T]).
pfcReset.

% true if there is some pfc crud still in the database.
pfcDatabaseItem(Term) :-
  pfcDatabaseTerm(P/A),
  functor(Term,P,A),
  db_clause(Term,_).

pfcRetractOrWarn(X) :-  db_retract(X), !.
pfcRetractOrWarn(X) :- 
  mpred_warn("Couldn't db_retract ~p.",[X]).



% pfcFile('pfcdebug').	% debugging aids (e.g. tracing).


%   File   : pfcdebug.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Updated:
%   Purpose: provides predicates for examining the database and debugginh 
%   for Pfc.

:- dynamic mpred_settings/2.
:- dynamic mpred_settings/3.

:- mpred_default(mpred_settings(warnings,_), mpred_settings(warnings,true)).

%% predicates to examine the state of pfc

mpred_queue :- listing(mpred_queue/1).

pfcPrintDB :-
  pfcPrintFacts,
  pfcPrintRules,
  pfcPrintTriggers,
  pfcPrintSupports,
  mpred_queue,!.

pfcPrintDB :-
  must_det_l([
   pfcPrintFacts,
   pfcPrintRules,
   pfcPrintTriggers,
   pfcPrintSupports,
   mpred_queue]).

%% pfcPrintFacts ..

pfcPrintFacts :- pfcPrintFacts(_,true).

pfcPrintFacts(Pattern) :- pfcPrintFacts(Pattern,true).

pfcPrintFacts(P,C) :-
  pfcFacts(P,C,L),
  pfcClassifyFacts(L,User,Pfc,_Rule),
  format("~n~nUser added facts:",[]),
  pfcPrintitems(User),
  format("~n~nPfc added facts:",[]),
  pfcPrintitems(Pfc).


%% printitems clobbers it's arguments - beware!

pfcPrintitems([]).
pfcPrintitems([H|T]) :-
  numbervars(H,0,_),
  format("~n  ~w",[H]),
  pfcPrintitems(T).

pfcClassifyFacts([],[],[],[]).

pfcClassifyFacts([H|T],User,Pfc,[H|Rule]) :-
  mpred_db_type(H,rule),
  !,
  pfcClassifyFacts(T,User,Pfc,Rule).

pfcClassifyFacts([H|T],[H|User],Pfc,Rule) :-
  pfcGetSupport(H,(pcfUser,pcfUser)),
  !,
  pfcClassifyFacts(T,User,Pfc,Rule).

pfcClassifyFacts([H|T],User,[H|Pfc],Rule) :-
  pfcClassifyFacts(T,User,Pfc,Rule).

pfcPrintRules :-
  bagof((P=>Q),db_clause((P=>Q),true),R1),
  pfcPrintitems(R1),
  bagof((P<=>Q),db_clause((P<=>Q),true),R2),
  pfcPrintitems(R2),
  bagof((P<=Q),db_clause((P<=Q),true),R3),
  pfcPrintitems(R3).

pfcPrintTriggers :-
  format("Positive triggers...~n",[]),
  bagof(pt(T,B),pfcGetTrigger(pt(T,B)),Pts),
  pfcPrintitems(Pts),
  format("Negative triggers...~n",[]),
  bagof(nt(A,B,C),pfcGetTrigger(nt(A,B,C)),Nts),
  pfcPrintitems(Nts),
  format("Goal triggers...~n",[]),
  bagof(bt(A,B),pfcGetTrigger(bt(A,B)),Bts),
  pfcPrintitems(Bts).

pfcPrintSupports :- 
  % temporary hack.
  setof((S > P), pfcGetSupport(P,S),L),
  pfcPrintitems(L).

%% pfcFact(P) is true if fact P was asserted into the database via add.

pfcFact(P) :- pfcFact(P,true).

%% pfcFact(P,C) is true if fact P was asserted into the database via
%% add and contdition C is satisfied.  For example, we might do:
%% 
%%  pfcFact(X,mpred_user_fact(X))
%%

pfcFact(P,C) :- 
  pfcGetSupport(P,_),
  mpred_db_type(P,fact),
  db_call(nonPfC,C).

%% pfcFacts(-ListofPfcFacts) returns a list of facts added.

pfcFacts(L) :- pfcFacts(_,true,L).

pfcFacts(P,L) :- pfcFacts(P,true,L).

%% pfcFacts(Pattern,Condition,-ListofPfcFacts) returns a list of facts added.

pfcFacts(P,C,L) :- setof(P,pfcFact(P,C),L).

brake(X) :-  X, break.

%%
%%
%% predicates providing a simple tracing facility
%%

pfcTraceAdd(P) :- 
  % this is here for upward compat. - should go away eventually.
  pfcTraceAdd(P,(o,o)).

pfcTraceAdd(pt(_,_),_) :-
  % hack for now - never trace triggers.
  !.
pfcTraceAdd(nt(_,_),_) :-
  % hack for now - never trace triggers.
  !.

pfcTraceAdd(P,S) :-
   pfcTraceAddPrint(P,S),
   pfcTraceBreak(P,S).
   

pfcTraceAddPrint(P,S) :-
  mpred_settings(traced,P),
  !,
  copy_term(P,Pcopy),
  numbervars(Pcopy,0,_),
  (S=(pcfUser,pcfUser)
       -> format("~nAdding (u) ~w",[Pcopy])
        ; format("~nAdding (g) ~w",[Pcopy])).

pfcTraceAddPrint(_,_).


pfcTraceBreak(P,_S) :-
  mpred_settings(spied,P,add) -> 
   (copy_term(P,Pcopy),
    numbervars(Pcopy,0,_),
    format("~nBreaking on ain(~w)",[Pcopy]),
    break)
   ; true.

pfcTraceRem(pt(_,_)) :-
  % hack for now - never trace triggers.
  !.
pfcTraceRem(nt(_,_)) :-
  % hack for now - never trace triggers.
  !.

pfcTraceRem(P) :-
  (mpred_settings(traced,P) 
     -> format('~nRemoving ~w.',[P])
      ; true),
  (mpred_settings(spied,P,pfcRem)
   -> (format("~nBreaking on pfcRem(~w)",[P]),
       break)
   ; true).


mpred_trace :- mpred_trace(_).

mpred_trace(Form) :-
  db_assert(mpred_settings(traced,Form)).

mpred_trace(Form,Condition) :- 
  db_assert((mpred_settings(traced,Form) :- Condition)).

mpred_spy(Form) :- mpred_spy(Form,[add,pfcRem],true).

mpred_spy(Form,Modes) :- mpred_spy(Form,Modes,true).

mpred_spy(Form,[add,pfcRem],Condition) :-
  !,
  mpred_spy1(Form,add,Condition),
  mpred_spy1(Form,pfcRem,Condition).

mpred_spy(Form,Mode,Condition) :-
  mpred_spy1(Form,Mode,Condition).

mpred_spy1(Form,Mode,Condition) :-
  db_assert((mpred_settings(spied,Form,Mode) :- Condition)).

pfcNospy :- pfcNospy(_,_,_).

pfcNospy(Form) :- pfcNospy(Form,_,_).

pfcNospy(Form,Mode,Condition) :- 
  db_clause(mpred_settings(spied,Form,Mode), Condition, Ref),
  erase(Ref),
  fail.
pfcNospy(_,_,_).

pfcNoTrace :- pfcUntrace.
pfcUntrace :- pfcUntrace(_).
pfcUntrace(Form) :- db_retractall(mpred_settings(traced,Form)).

% needed:  pfcTraceRule(Name)  ...


% if the correct flag is set, trace exection of Pfc
mpred_trace_msg(Msg,Args) :-
    mpred_settings(trace_exec,true),
    !,
    format(user_output, Msg, Args).
mpred_trace_msg(_Msg,_Args).

pfcWatch :- db_assert(mpred_settings(trace_exec,true)).

pfcNoWatch :-  db_retractall(mpred_settings(trace_exec,true)).

pfcError(Msg) :-  pfcError(Msg,[]).

pfcError(Msg,Args) :- 
  format("~nERROR/Pfc: ",[]),
  format(Msg,Args).


%%
%% These control whether or not warnings are printed at all.
%%   mpred_warn.
%%   nompred_warn.
%%
%% These print a warning message if the flag mpred_warnings is set.
%%   mpred_warn(+Message)
%%   mpred_warn(+Message,+ListOfArguments)
%%

mpred_warn :- 
  db_retractall(mpred_settings(warnings,_)),
  db_assert(mpred_settings(warnings,true)).

nompred_warn :-
  db_retractall(mpred_settings(warnings,_)),
  db_assert(mpred_settings(warnings,false)).
 
mpred_warn(Msg) :-  mpred_warn(Msg,[]).

mpred_warn(Msg,Args) :- 
  mpred_settings(warnings,true),
  !,
  format("~nWARNING/Pfc: ",[]),
  format(Msg,Args).
mpred_warn(_,_).

%%
%% mpred_warnings/0 sets flag to cause pfc warning messages to print.
%% pfcNoWarnings/0 sets flag to cause pfc warning messages not to print.
%%

mpred_warnings :- 
  db_retractall(mpred_settings(warnings,_)),
  db_assert(mpred_settings(warnings,true)).

pfcNoWarnings :- 
  db_retractall(mpred_settings(warnings,_)).



% pfcFile('pfcjust').	% predicates to manipulate pfcJustification_L.


%   File   : pfcjust.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Updated:
%   Purpose: predicates for accessing Pfc Justifications.
%   Status: more or less working.
%   Bugs:

%% *** predicates for exploring supports of a fact *****


:- use_module(library(lists)).

pfcJustificationDB(F,J) :- justSupports(F,J).

pfcJustification_L(F,Js) :- bagof(J,pfcJustificationDB(F,J),Js).


justSupports(F,J):- support2(F,J).

%% pfcBase1(P,L) - is true iff L is a list of "pfcBase1" facts which, taken
%% together, allows us to deduce P.  A pfcBase1 fact is an pfcAxiom (a fact 
%% added by the pcfUser or a raw Prolog fact (i.e. one w/o any support))
%% or an pfcAssumptionBase.

pfcBase1(F,[F]) :- (pfcAxiom(F) ; pfcAssumptionBase(F)),!.

pfcBase1(F,L) :-
  % i.e. (reduce 'append (map 'pfcBase1 (pfcJustificationDB f)))
  pfcJustificationDB(F,Js),
  pfcBases(Js,L).


%% pfcBases(L1,L2) is true if list L2 represents the union of all of the 
%% facts on which some conclusion in list L1 is based.

pfcBases([],[]).
pfcBases([X|Rest],L) :-
  pfcBase1(X,Bx),
  pfcBases(Rest,Br),
  pfcUnion(Bx,Br,L).
	
pfcAxiom(F) :- 
  pfcGetSupport(F,(pcfUser,pcfUser)); 
  pfcGetSupport(F,(pfcGod,pfcGod)).

%% an pfcAssumptionBase is a failed goal, i.e. were assuming that our failure to 
%% prove P is a proof of not(P)

pfcAssumptionBase(P) :- mpred_negation(P,_).
   
%% pfcAssumptionsSet(X,As) if As is a set of pfcAssumptionsSet which underly X.

pfcAssumptionsSet(X,[X]) :- pfcAssumptionBase(X).
pfcAssumptionsSet(X,[]) :- pfcAxiom(X).
pfcAssumptionsSet(X,L) :-
  pfcJustificationDB(X,Js),
  pfcAssumption1(Js,L).

pfcAssumption1([],[]).
pfcAssumption1([X|Rest],L) :-
  pfcAssumptionsSet(X,Bx),
  pfcAssumption1(Rest,Br),
  pfcUnion(Bx,Br,L).  


%% pfcProofTree(P,T) the proof tree for P is T where a proof tree is
%% of the form
%%
%%     [P , J1, J2, ;;; Jn]         each Ji is an independent P justifier.
%%          ^                         and has the form of
%%          [J11, J12,... J1n]      a list of proof trees.


% pfcChild(P,Q) is true iff P is an immediate justifier for Q.
% mode: pfcChild(+,?)

pfcChild(P,Q) :-
  pfcGetSupport(Q,(P,_)).

pfcChild(P,Q) :-
  pfcGetSupport(Q,(_,Trig)),
  mpred_db_type(Trig,trigger),
  pfcChild(P,Trig).

pfcChildren(P,L) :- bagof(C,pfcChild(P,C),L).

% pfcDescendant(P,Q) is true iff P is a justifier for Q.

pfcDescendant(P,Q) :- 
   pfcDescendant1(P,Q,[]).

pfcDescendant1(P,Q,Seen) :-
  pfcChild(X,Q),
  ( \+ member(X,Seen)),
  (P=X ; pfcDescendant1(P,X,[X|Seen])).
  
pfcDescendants(P,L) :- 
  bagof(Q,pfcDescendant1(P,Q,[]),L).



% pfcFile('pfcwhy').	% interactive exploration of pfcJustification_L.



%   File   : pfcwhy.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Updated:
%   Purpose: predicates for interactively exploring Pfc pfcJustification_L.

% ***** predicates for brousing pfcJustification_L *****

:- use_module(library(lists)).

pfcWhy :- 
  pfcWhyMemory1(P,_),
  pfcWhy(P).

pfcWhy(N) :-
  number(N),
  !,
  pfcWhyMemory1(P,Js),
  pfcWhyCommand(N,P,Js).

pfcWhy(P) :-
  pfcJustification_L(P,Js),
  db_retractall(pfcWhyMemory1(_,_)),
  db_assert(pfcWhyMemory1(P,Js)),
  pfcWhyBrouse(P,Js).

pfcWhy1(P) :-
  pfcJustification_L(P,Js),
  pfcWhyBrouse(P,Js).

pfcWhyBrouse(P,Js) :-
  mpred_showJustifications(P,Js),
  pfcAskUser(' >> ',Answer),
  pfcWhyCommand(Answer,P,Js).

pfcWhyCommand(q,_,_) :- !.
pfcWhyCommand(h,_,_) :- 
  !,
  format("~n
Justification Brouser Commands:
 q   quit.
 N   focus on Nth pfcJustificationDB.
 N.M brouse step M of the Nth pfcJustificationDB
 u   up a level
",[]).

pfcWhyCommand(N,_P,Js) :-
  float(N),
  !,
  mpred_selectJustificationNode(Js,N,Node),
  pfcWhy1(Node).

pfcWhyCommand(u,_,_) :-
  % u=up
  !.

pfcCommand(N,_,_) :-
  integer(N),
  !,
  format("~n~w is a yet unimplemented command.",[N]),
  fail.

pfcCommand(X,_,_) :-
 format("~n~w is an unrecognized command, enter h. for help.",[X]),
 fail.
  
mpred_showJustifications(P,Js) :-
  format("~nJustifications for ~w:",[P]),
  mpred_showJustification1(Js,1).

mpred_showJustification1([],_).

mpred_showJustification1([J|Js],N) :-
  % show one pfcJustificationDB and recurse.
  nl,
  mpred_showJustifications2(J,N,1),
  N2 is N+1,
  mpred_showJustification1(Js,N2).

mpred_showJustifications2([],_,_).

mpred_showJustifications2([C|Rest],JustNo,StepNo) :- 
  copy_term(C,CCopy),
  numbervars(CCopy,0,_),
  format("~n    ~w.~w ~w",[JustNo,StepNo,CCopy]),
  StepNext is 1+StepNo,
  mpred_showJustifications2(Rest,JustNo,StepNext).

pfcAskUser(Msg,Ans) :-
  format("~n~w",[Msg]),
  read(Ans).

mpred_selectJustificationNode(Js,Index,Step) :-
  JustNo is integer(Index),
  nth(JustNo,Js,Justification),
  StepNo is 1+ integer(Index*10 - JustNo*10),
  nth(StepNo,Justification,Step).

:- mpred_trace.
:- 
    ain([(faz(X), ~baz(Y)/{X=:=Y} => fazbaz(X)),
         (fazbaz(X), go => found(X)),
	 (found(X), {X>=100} => big(X)),
	 (found(X), {X>=10,X<100} => medium(X)),
	 (found(X), {X<10} => little(X)),
	 faz(1),
	 goAhead,
	 baz(2),
	 baz(1)
	]).
:- mpred_trace.

:- prolog.    

:- include(mpred_tests).
