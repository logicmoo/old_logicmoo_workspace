/*  
% ===================================================================
% File 'mpred_userkb.pl'
% Purpose: Emulation of OpenCyc for SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'interface.pl' 1.0.0
% Revision:  $Revision: 1.9 $
% Revised At:   $Date: 2002/06/27 14:13:20 $
% ===================================================================
% File used as storage place for all predicates which change as
% the world is run.
%
%
% Dec 13, 2035
% Douglas Miles
*/

% DWhitten> ... but is there a reason why "Absurdity" is the word used for something that doesn't exist?  
% SOWA> It's stronger than that.  The absurd type is defined by axioms that are contradictory. 
%  Therefore, by definition, nothing of that type can exist. 
:- module(baseKB_user, [mpred_userkb_file/0]).
:- include('mpred_header.pi').

mpred_userkb_file.

:- '$set_source_module'(baseKB).
:- '$set_typein_module'(baseKB).

:- ain(arity(functorDeclares, 1)).

%% base_kb_pred_list( ?VALUE1) is semidet.
%
% Base Knowledge Base Predicate List.
%
:- dynamic(baseKB:base_kb_pred_list/1).
baseKB:base_kb_pred_list([
 functorDeclares/1,
 arity/2,
 abox:(::::)/2,
 abox:(<-)/2,
 % (<==)/2,
 abox:(<==>)/2,
 abox:(==>)/2,
 abox:(==>)/1,
 abox:(nesc)/1,
 abox:(~)/1,
%mpred_f/1, 
mpred_f/2,mpred_f/3,mpred_f/4,mpred_f/5,mpred_f/6,mpred_f/7,
%add_args/15,
%naf_in_code/1,
%neg_may_naf/1,
%tilda_in_code/1,
mpred_undo_sys/3,
% addTiny_added/1,
baseKB:agent_call_command/2,
%baseKB:mud_test/2,
type_action_info/3,
argGenl/3,
argIsa/3,
argQuotedIsa/3,
%lmcache:loaded_external_kbs/1,
argsQuoted/1,
arity/2,
asserted_mpred_f/2,
asserted_mpred_f/3,
asserted_mpred_f/4,
asserted_mpred_f/5,
asserted_mpred_f/6,
asserted_mpred_f/7,
asserted_mpred_t/2,
asserted_mpred_t/3,
asserted_mpred_t/4,
asserted_mpred_t/5,
asserted_mpred_t/6,
asserted_mpred_t/7,
call_OnEachLoad/1,
coerce_hook/3,
completelyAssertedCollection/1,
conflict/1,
constrain_args_pttp/2,
contract_output_proof/2,
transitiveViaArg/3,
current_world/1,
predicateConventionMt/2, 
%is_never_type/1,
%cyckb_t/3,
%cycPrepending/2,
%cyc_to_plarkc/2,
%decided_not_was_isa/2,
deduceFromArgTypes/1,
default_type_props/3,
defnSufficient/2,
did_learn_from_name/1,
elInverse/2,
% baseKB:feature_test/0,
formatted_resultIsa/2,
function_corisponding_predicate/2,
transitiveViaArgInverse/3,
genls/2,
grid_key/1,
hybrid_support/2,
if_missing/2, % pfc
is_edited_clause/3,
is_wrapper_pred/1,
isa/2,
ruleRewrite/2,
resultIsa/2,
% lmcache:isCycAvailable_known/0,
isCycUnavailable_known/1,
lambda/5,
mpred_select/2,
localityOfObject/2,
meta_argtypes/1,
mpred_action/1,
mdefault/1, % pfc
% most/1, % pfc
mpred_do_and_undo_method/2,
%mpred_isa/2,
%mpred_manages_unknowns/0,
mpred_mark/3,
predicateConventionMt/2,
mudKeyword/2,
mudDescription/2,
never_assert_u/2,
never_assert_u0/2,
never_retract_u/2,
never_assert_u/1,
never_retract_u/1,
now_unused/1,
%baseKB:only_if_pttp/0,
pddlSomethingIsa/2,
pfcControlled/1,
pfcRHS/1,
predCanHaveSingletons/1,
prologBuiltin/1,
prologDynamic/1,prologHybrid/1,prologKIF/1,prologListValued/1,prologMacroHead/1,prologMultiValued/1,prologNegByFailure/1,prologOrdered/1,
prologPTTP/1,
prologSideEffects/1,
prologSingleValued/1,
props/2,ptReformulatorDirectivePredicate/1,pttp1a_wid/3,pttp_builtin/2,
% pttp_nnf_pre_clean_functor/3,
quasiQuote/1,relationMostInstance/3,resolveConflict/1,
ptSymmetric/1,
resolverConflict_robot/1,
retractall_wid/1,
search/7,
skolem/2,skolem/3,
completeExtentEnumerable/1,
%use_ideep_swi/0,
cycPred/2,
isa/2,
cycPlus2/2,
predStub/2,
singleValuedInArg/2,
subFormat/2,
support_hilog/2,
t/1,t/10,t/11,t/2,t/3,t/4,t/5,t/6,t/7,t/8,t/9,
tCol/1,
tFarthestReachableItem/1,
tFunction/1,
tNearestReachableItem/1,
tNotForUnboundPredicates/1,
tPred/1,
tRegion/1,
tAgent/1,
tRelation/1,
tried_guess_types_from_name/1,
tCol/1,
ttExpressionType/1,
ttPredType/1,
ttTemporalType/1,
ttUnverifiableType/1,
type_action_info/3,
typeProps/2,
% vtUnreifiableFunction/1,
was_chain_rule/1,
wid/3,
use_kif/2,
never_assert_u/2,
prologEquality/1,pfcBcTrigger/1,meta_argtypes/1,pfcDatabaseTerm/1,pfcControlled/1,pfcWatched/1,pfcMustFC/1,predIsFlag/1,tPred/1,prologMultiValued/1,
 prologSingleValued/1,prologMacroHead/1,notAssertable/1,prologBuiltin/1,prologDynamic/1,prologOrdered/1,prologNegByFailure/1,prologPTTP/1,prologKIF/1,prologEquality/1,prologPTTP/1,
 prologSideEffects/1,prologHybrid/1,prologListValued/1]).

:- multifile(baseKB:'$exported_op'/3).
:- discontiguous baseKB:'$exported_op'/3.
:- thread_local t_l:disable_px.

:- dynamic(baseKB:use_kif/2).

% :- shared_multifile(baseKB:use_kif/2).

:- set_defaultAssertMt(baseKB).
:- set_fileAssertMt(baseKB).

:- '$set_source_module'(baseKB).
:- '$set_typein_module'(baseKB).
:- set_defaultAssertMt(baseKB).
:- set_fileAssertMt(baseKB).

kb_dynamic_m(E):- with_source_module(baseKB,decl_shared(kb_dynamic,E)).

:- multifile(baseKB:predicateConventionMt/2).
:- dynamic(baseKB:predicateConventionMt/2).

% :- kb_dynamic(mpred_online:semweb_startup/0).

% :- baseKB:base_kb_pred_list([A,B|_List]),rtrace(call(must_maplist(kb_dynamic_m,[A,B]))).
:- baseKB:base_kb_pred_list(List),call(must_maplist(kb_dynamic_m,List)).

% XXXXXXXXXXXXXXXXXXXXXXXXXx
% XXXXXXXXXXXXXXXXXXXXXXXXXx
% XXXXXXXXXXXXXXXXXXXXXXXXXx
% XXXXXXXXXXXXXXXXXXXXXXXXXx

:- meta_predicate
        t(*,?,?),
        t(*,?,?,?),
        t(*,?,?,?,?),
        t(*,?,?,?,?,?),
        t(*,?,?,?,?,?,?),
        t(*,?,?,?,?,?,?,?).   

:- meta_predicate
      resolveConflict(+),
      resolveConflict0(+),
      %mpred_isa(?,1),
      resolverConflict_robot(+).


:- kb_dynamic(arity/2).
:- forall(between(1,11,A),kb_dynamic(t/A)).
:- kb_dynamic(meta_argtypes/1).

%:- import_module_to_user(logicmoo_user).

%:- initialization(import_module_to_user(logicmoo_user)).

:- source_location(F,_),asserta(baseKB:ignore_file_mpreds(F)).

%% prologNegByFailure( ?VALUE1) is semidet.
%
% Prolog Negated By Failure.
%
prologNegByFailure(prologNegByFailure).
   	 

%% completelyAssertedCollection( ?VALUE1) is semidet.
%
% Completely Asserted Collection.
%
completelyAssertedCollection(prologNegByFailure).

:- dynamic(t/2).
:- dynamic(t/1).
% t(C,I):- trace_or_throw(t(C,I)),t(C,I). % ,fail,loop_check_term(isa_backchaing(I,C),t(C,I),fail).

%t([P|LIST]):- !,mpred_plist_t(P,LIST).
%t(naf(CALL)):-!,not(t(CALL)).
%t(not(CALL)):-!,mpred_f(CALL).



%% t( ?VALUE1, ?VALUE2) is semidet.
%
% True Structure.
%
t(X,Y):- cwc, isa(Y,X).

%% t( ?CALL) is semidet.
%
% True Structure.
%
t(CALL):- cwc, call(into_plist_arities(3,10,CALL,[P|LIST])),mpred_plist_t(P,LIST).

:-asserta_if_new((~(G):- (cwc, neg_in_code(G)))).



%% ~( ?VALUE1) is semidet.
%
% ~.
%
:-asserta('~'(tCol('$VAR'))).






%% skolem( ?X, ?SK) is semidet.
%
% Skolem.
%
skolem(X,SK):-skolem_in_code(X,SK).




%% skolem( ?X, ?Vs, ?SK) is semidet.
%
% Skolem.
%
skolem(X,Vs,SK):-skolem_in_code(X,Vs,SK).





%% t( ?P, ?A1, ?A2) is semidet.
%
% True Structure.
%
t(P,A1,A2):- loop_check(mpred_fa_call(P,2,call(P,A1,A2))).
t(P,A1,A2):- loop_check(call_u(t(P,A1,A2))).



%% t( ?P, ?A1, ?A2, ?A3) is semidet.
%
% True Structure.
%
t(P,A1,A2,A3):- mpred_fa_call(P,3,call(P,A1,A2,A3)).
t(P,A1,A2,A3):- call_u(t(P,A1,A2,A3)).



%% t( ?P, ?A1, ?A2, ?A3, ?A4) is semidet.
%
% True Structure.
%
t(P,A1,A2,A3,A4):- mpred_fa_call(P,4,call(P,A1,A2,A3,A4)).
t(P,A1,A2,A3,A4):- call_u(t(P,A1,A2,A3,A4)).



%% t( :PRED5P, ?A1, ?A2, ?A3, ?A4, ?A5) is semidet.
%
% True Structure.
%
t(P,A1,A2,A3,A4,A5):- mpred_fa_call(P,5,call(P,A1,A2,A3,A4,A5)).
t(P,A1,A2,A3,A4,A5):- call_u(t(P,A1,A2,A3,A4,A5)).



%% t( :PRED6P, ?A1, ?A2, ?A3, ?A4, ?A5, ?A6) is semidet.
%
% True Structure.
%
t(P,A1,A2,A3,A4,A5,A6):- mpred_fa_call(P,6,call(P,A1,A2,A3,A4,A5,A6)).
t(P,A1,A2,A3,A4,A5,A6):- call_u(t(P,A1,A2,A3,A4,A5,A6)).



%% t( :PRED7P, ?A1, ?A2, ?A3, ?A4, ?A5, ?A6, ?A7) is semidet.
%
% True Structure.
%
t(P,A1,A2,A3,A4,A5,A6,A7):- mpred_fa_call(P,7,call(P,A1,A2,A3,A4,A5,A6,A7)).
t(P,A1,A2,A3,A4,A5,A6,A7):- call_u(t(P,A1,A2,A3,A4,A5,A6,A7)).





%% current_world( ?VALUE1) is semidet.
%
% Current World.
%
current_world(current).



/*
:- use_module(logicmoo(mpred/'mpred_stubs.pl')).
:- use_module(logicmoo(mpred/'mpred_*.pl')).

*/

resolveConflict(C):- cwc, must((resolveConflict0(C),
  show_if_debug(is_resolved(C)),mpred_remove(conflict(C)))).
resolveConflict(C) :- cwc,
  wdmsg("Halting with conflict ~p", [C]),   
  must(mpred_halt(conflict(C))),fail.



%% resolveConflict0( ?C) is semidet.
%
% Resolve Conflict Primary Helper.
%
resolveConflict0(C) :- cwc, forall(must(mpred_negation_w_neg(C,N)),ignore(show_failure(why,(nop(resolveConflict(C)),mpred_why(N))))),
  ignore(show_failure(why,(nop(resolveConflict(C)),mpred_why(C)))), 
    doall((call_u(resolverConflict_robot(C)),\+ is_resolved(C),!)),
    is_resolved(C),!.




%% resolverConflict_robot( ?N) is semidet.
%
% Resolver Conflict Robot.
%
resolverConflict_robot(N) :- cwc, forall(must(mpred_negation_w_neg(N,C)),forall(compute_resolve(C,N,TODO),on_x_rtrace(show_if_debug(TODO)))).
resolverConflict_robot(C) :- cwc, must((mpred_remove(C),wdmsg("Rem-3 with conflict ~p", [C]),mpred_run,sanity(\+C))).


%% never_declare( :TermRule, ?Rule) is semidet.
%
% Never Declare For User Code.
%
never_declare(declared(M:F/A),never_declared(M:F/A)):- M:F/A = qrTBox:p/1.
never_declare(declared(P),Why):- nonvar(P),functor(P,F,A),F\=(:),F\=(/),never_declare(declared(F/A),Why).
never_declare(declared(mpred_run_resume/0),cuz).
never_declare(declared(decl_type/1),cuz).
never_declare(declared(is_clif/1),cuz).

never_declare(declared(_:FA),Why):-nonvar(FA),never_declare(declared(FA),Why).
never_declare(_:declared(_:FA),Why):-nonvar(FA),never_declare(declared(FA),Why).
never_declare(_:declared(FA),Why):-nonvar(FA),never_declare(declared(FA),Why).




%% never_assert_u( :TermRule, ?Rule) is semidet.
%
% Never Assert For User Code.
%
:- dynamic((never_assert_u/2)).
:- multifile((never_assert_u/2)).
% never_assert_u(pt(_,Pre,Post),head_singletons(Pre,Post)):- cwc, head_singletons(Pre,Post).
never_assert_u(Rule,is_var(Rule)):- cwc, is_ftVar(Rule),!.
never_assert_u(Rule,head_singletons(Pre,Post)):- cwc, Rule \= (_:-_), once(mpred_rule_hb(Rule,Post,Pre)), head_singletons(Pre,Post).
never_assert_u(A,B):-never_assert_u0(A,B),dtrace,never_assert_u0(A,B).
% never_assert_u(M:arity(_,_),is_support(arity/2)):- M==pqr,dumpST, dtrace, cwc,!.

never_assert_u(A,B):-ground(A),never_declare(A,B).


never_assert_u(M:Rule,Why):- cwc, atom(M),never_assert_u(Rule,Why).

/*
never_assert_u(pt(_,
       singleValuedInArg(A, _),
       (dtrace->rhs([{dtrace}, prologSingleValued(B)]))),singletons):- dtrace,A\=B,dtrace.
*/

on_modules_changed:-!.
on_modules_changed :-
  forall((current_module(M),M\=user,M\=system,M\=baseKB,M\=abox,\+ baseKB:mtCycL(M)),
      (default_module(abox,M)->true;catch(add_import_module(M,abox,start),_E,dmsg(add_import_module(M,abox,start))))),
  forall((current_module(M),M\=user,M\=system,M\=baseKB),
     (default_module(baseKB,M)->true;catch(add_import_module(M,baseKB,end),_E,dmsg(add_import_module(M,baseKB,end))))).

:- on_modules_changed.
:- initialization(on_modules_changed).

%% never_assert_u0( :TermARG1, ?Why) is semidet.
%
% Never Assert For User Code Primary Helper.
%
never_assert_u0(mpred_mark(pfcPosTrigger,F,A),Why):- fail,
  functor(P,F,A),
  ignore(predicate_property(M:P,exported)),
  defined_predicate(M:P),  
  is_static_why(M,P,F,A,R),
  Why = static(M:P-F/A,R).



%:- rtrace.
%:- dtrace.
%:- ignore(delete_import_module(baseKB,user)).
%:- add_import_module(baseKB,lmcode,start).
%:- nortrace.
%:- cnotrace.


%  Pred='$VAR'('Pred'),unnumbervars(mpred_eval_lhs(pt(UMT,singleValuedInArg(Pred,_G8263654),(dtrace->rhs([{dtrace},prologSingleValued(Pred)]))),(singleValuedInArg(Pred,_G8263679),{dtrace}==>{dtrace},prologSingleValued(Pred),ax)),UN).
%  Pred='$VAR'('Pred'),unnumbervars(mpred_eval_lhs(pt(UMT,singleValuedInArg(Pred,_G8263654),(dtrace->rhs([{dtrace},prologSingleValued(Pred)]))),(singleValuedInArg(Pred,_G8263679),{dtrace}==>{dtrace},prologSingleValued(Pred),ax)),UN).


%:- maybe_add_import_module(tbox,basePFC,end).
%:- initialization(maybe_add_import_module(tbox,basePFC,end)).

/*
BAD IDEAS
system:term_expansion(M1:(M2:G),(M1:G)):-atom(M1),M1==M2,!.
system:goal_expansion(M1:(M2:G),(M1:G)):-atom(M1),M1==M2,!.
system:sub_call_expansion(_:dynamic(_:((M:F)/A)),dynamic(M:F/A)):-atom(M),atom(F),integer(A).
*/
