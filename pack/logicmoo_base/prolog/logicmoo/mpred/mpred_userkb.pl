/* <module> 
% ===================================================================
% File 'mpred_db_preds.pl'
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
:- module(baseKB, [

% current_op_alias/2,
% prolog_load_file_loop_checked/2,

(::::) / 2,
(<-)/2,
(<==>)/2,
(==>)/1,
(==>)/2,
(neg)/1,
(nesc)/1,
add_args/15,
addTiny_added/1,
agent_call_command/2,
argGenl/3,
argIsa/3,
argQuotedIsa/3,
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
assertion_f/1,
call_mt_t/11,
call_OnEachLoad/1,
call_which_t/9,
coerce/3,
completelyAssertedCollection/1,
conflict/1,
constrain_args_pttp/2,
contract_output_proof/2,
current_world/1,
cyc_to_plarkc/2,
cyckb_t/3,
cycPrepending/2,
decided_not_was_isa/2,
deduceFromArgTypes/1,
default_type_props/3,
defnSufficient/2,
did_learn_from_name/1,
elInverse/2,
feature_test/0,
formatted_resultIsa/2,
function_corisponding_predicate/2,
functorDeclares/1,
genls/2,
grid_key/1,
holds_f_p2/2,
if_missing/2, % pfc
is_edited_clause/3,
is_wrapper_pred/1,
isa/2,
isCycAvailable_known/0,
isCycUnavailable_known/1,
never_assert_u/2,
never_retract_u/2,
lambda/5,
lmconf:mpred_select/2,

localityOfObject/2,
logical_functor_pttp/1,
meta_argtypes/1,
mpred_action/1,
mpred_default/1, % pfc
mpred_do_and_undo_method/2,
mpred_f/1,
mpred_f/2,
mpred_f/3,
mpred_f/4,
mpred_f/5,
mpred_f/6,
mpred_f/7,
mpred_isa/2,
mpred_manages_unknowns/0,
mpred_mark/4,
mpred_module/2,
mpred_univ/1,
mpred_univ/3,
mudKeyword/2,
now_unused/1,
only_if_pttp/0,
pddlSomethingIsa/2,
pfcControlled/1,
pfcRHS/1,
predCanHaveSingletons/1,
prologBuiltin/1,
prologDynamic/1,
prologDynamic/2,
prologHybrid/1,
prologHybrid/2,
prologKIF/1,
prologListValued/1,
prologMacroHead/1,
prologMultiValued/1,
prologNegByFailure/1,
prologOrdered/1,
prologPTTP/1,
prologSideEffects/1,
prologSingleValued/1,
props/2,
ptReformulatorDirectivePredicate/1,
pttp1a_wid/3,
pttp_builtin/2,
pttp_nnf_pre_clean_functor/3,
quasiQuote/1,
relationMostInstance/3,
relax_term/6,
resolveConflict/1,
resolverConflict_robot/1,
resultIsa/2,
retractall_wid/1,
ruleRewrite/2,
search/7,
singleValuedInArg/2,
startup_option/2,
subFormat/2,
support_hilog/2,
t/1,
t/10,
t/11,
t/2,
t/3,
t/4,
t/5,
t/6,
t/7,
t/8,
t/9,
tCol/1,
tFarthestReachableItem/1,
tFunction/1,
tNearestReachableItem/1,
tNotForUnboundPredicates/1,
ptSymmetric/1,
tPred/1,
tPredType/1,
tRegion/1,
tRelation/1,
tried_guess_types_from_name/1,
tSet/1,
ttFormatType/1,
ttPredType/1,
ttTemporalType/1,
ttUnverifiableType/1,
type_action_info/3,
typeProps/2,
use_ideep_swi/0,
vtUnreifiableFunction/1,
was_chain_rule/1,
wid/3,
prologEquality/1,pfcBcTrigger/1,meta_argtypes/1,pfcDatabaseTerm/1,pfcControlled/1,pfcWatched/1,pfcMustFC/1,predIsFlag/1,tPred/1,prologMultiValued/1,
 prologSingleValued/1,prologMacroHead/1,notAssertable/1,prologBuiltin/1,prologDynamic/1,prologOrdered/1,prologNegByFailure/1,prologPTTP/1,prologKIF/1,prologEquality/1,prologPTTP/1,
 prologSideEffects/1,prologHybrid/1,prologListValued/1



 ]).

% XXXXXXXXXXXXXXXXXXXXXXXXXx
% XXXXXXXXXXXXXXXXXXXXXXXXXx
% XXXXXXXXXXXXXXXXXXXXXXXXXx
% XXXXXXXXXXXXXXXXXXXXXXXXXx

:- meta_predicate

        t(?, ?, ?),
        t(?, ?, ?, ?),
        t(?, ?, ?, ?, ?),
        t(5,?,?,?,?,?),
        t(6,?,?,?,?,?,?),
        t(7,?,?,?,?,?,?,?).   
:- dynamic(((::::) / 2,
(<-)/2,
(<==>)/2,
(==>)/1,
(==>)/2,
(neg)/1,
(nesc)/1,
add_args/15,
addTiny_added/1,
agent_call_command/2,
argGenl/3,
argIsa/3,
argQuotedIsa/3,
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
assertion_f/1,
call_mt_t/11,
call_OnEachLoad/1,
call_which_t/9,
coerce/3,
completelyAssertedCollection/1,
conflict/1,
constrain_args_pttp/2,
contract_output_proof/2,
current_world/1,
cyc_to_plarkc/2,
cyckb_t/3,
cycPrepending/2,
decided_not_was_isa/2,
deduceFromArgTypes/1,
default_type_props/3,
defnSufficient/2,
did_learn_from_name/1,
elInverse/2,
feature_test/0,
formatted_resultIsa/2,
function_corisponding_predicate/2,
functorDeclares/1,
genls/2,
grid_key/1,
holds_f_p2/2,
if_missing/2, % pfc
is_edited_clause/3,
is_wrapper_pred/1,
isa/2,
isCycAvailable_known/0,
isCycUnavailable_known/1,
baseKB:never_assert_u/2,
baseKB:never_retract_u/2,
lambda/5,
lmconf:mpred_select/2,

localityOfObject/2,
logical_functor_pttp/1,
meta_argtypes/1,
mpred_action/1,
mpred_default/1, % pfc
mpred_do_and_undo_method/2,
mpred_f/1,
mpred_f/2,
mpred_f/3,
mpred_f/4,
mpred_f/5,
mpred_f/6,
mpred_f/7,
mpred_isa/2,
mpred_manages_unknowns/0,
mpred_mark/4,
mpred_module/2,
mpred_univ/1,
mpred_univ/3,
mudKeyword/2,
now_unused/1,
only_if_pttp/0,
pddlSomethingIsa/2,
pfcControlled/1,
pfcRHS/1,
predCanHaveSingletons/1,
prologBuiltin/1,
prologDynamic/1,
prologDynamic/2,
prologHybrid/1,
prologHybrid/2,
prologKIF/1,
prologListValued/1,
prologMacroHead/1,
prologMultiValued/1,
prologNegByFailure/1,
prologOrdered/1,
prologPTTP/1,
prologSideEffects/1,
prologSingleValued/1,
props/2,
ptReformulatorDirectivePredicate/1,
pttp1a_wid/3,
pttp_builtin/2,
pttp_nnf_pre_clean_functor/3,
quasiQuote/1,
relationMostInstance/3,
relax_term/6,
resolveConflict/1,
resolverConflict_robot/1,
resultIsa/2,
retractall_wid/1,
ruleRewrite/2,
search/7,
singleValuedInArg/2,
startup_option/2,
subFormat/2,
support_hilog/2,
t/1,
t/10,
t/11,
t/2,
t/3,
t/4,
t/5,
t/6,
t/7,
t/8,
t/9,
tCol/1,
tFarthestReachableItem/1,
tFunction/1,
tNearestReachableItem/1,
tNotForUnboundPredicates/1,
ptSymmetric/1,
tPred/1,
tPredType/1,
tRegion/1,
tRelation/1,
tried_guess_types_from_name/1,
tSet/1,
ttFormatType/1,
ttPredType/1,
ttTemporalType/1,
ttUnverifiableType/1,
type_action_info/3,
typeProps/2,
use_ideep_swi/0,
vtUnreifiableFunction/1,
was_chain_rule/1,
meta_argtypes/1,pfcDatabaseTerm/1,pfcControlled/1,pfcWatched/1,pfcMustFC/1,predIsFlag/1,tPred/1,prologMultiValued/1,pfcBcTrigger/1,
 prologSingleValued/1,prologMacroHead/1,notAssertable/1,prologBuiltin/1,prologDynamic/1,prologOrdered/1,prologNegByFailure/1,prologPTTP/1,prologKIF/1,prologEquality/1,prologPTTP/1,
 prologSideEffects/1,prologHybrid/1,prologListValued/1,
wid/3)).

:- meta_predicate((
      baseKB:resolveConflict((*)),
      baseKB:resolveConflict0((*)),
      baseKB:resolverConflict_robot((*)))).

:- show_call(why,source_context_module(_CM)).
:- module_property(baseKB, exports(List)),forall(member(E,List),baseKB:dynamic(baseKB:E)).
% :- module_property(baseKB, exports(List)),forall(member(E,List),kb_dynamic(E)).

% :- use_module(mpred_pfc).

:- source_location(F,_),asserta(never_registered_mpred_file(F)).

prologNegByFailure(prologNegByFailure).
completelyAssertedCollection(prologNegByFailure).

:- dynamic(t/2).
:- dynamic(t/1).
% t(C,I):- trace_or_throw(t(C,I)),t(C,I). % ,fail,loop_check_term(isa_backchaing(I,C),t(C,I),fail).

%t([P|LIST]):- !,mpred_plist_t(P,LIST).
%t(naf(CALL)):-!,not(t(CALL)).
%t(not(CALL)):-!,mpred_f(CALL).
t(X,Y):- cwc, isa(Y,X).
t(CALL):- cwc, call(into_plist_arities(3,10,CALL,[P|LIST])),mpred_plist_t(P,LIST).
:- meta_predicate(t(?,?,?,?,?)).
:- meta_predicate(t(?,?,?,?)).
:- meta_predicate(t(?,?,?)).



neg_may_naf(P):- mpred_non_neg_literal(P),get_functor(P,F),clause(prologNegByFailure(F),true),!.
neg_may_naf(P):- is_ftCompound(P),predicate_property(P,static).

neg_in_code(P):-   neg_may_naf(P), \+ P.
neg_in_code(Q):-  is_ftNonvar(Q), prologSingleValued(Q),if_missing_mask(Q,R,Test),req(R),Test.

tilda_in_code(~(G)):-nonvar(G),!, req(~neg(G)).
tilda_in_code(G):- req(neg(G)).



t(P,A1,A2):- mpred_pa_call(P,2,call(P,A1,A2)).
t(P,A1,A2):- loop_check_mpred(t(P,A1,A2)).
t(P,A1,A2,A3):- mpred_pa_call(P,3,call(P,A1,A2,A3)).
t(P,A1,A2,A3):- loop_check_mpred(t(P,A1,A2,A3)).
t(P,A1,A2,A3,A4):- mpred_pa_call(P,4,call(P,A1,A2,A3,A4)).
t(P,A1,A2,A3,A4):- loop_check_mpred(t(P,A1,A2,A3,A4)).
t(P,A1,A2,A3,A4,A5):- mpred_pa_call(P,5,call(P,A1,A2,A3,A4,A5)).
t(P,A1,A2,A3,A4,A5):- loop_check_mpred(t(P,A1,A2,A3,A4,A5)).
t(P,A1,A2,A3,A4,A5,A6):- mpred_pa_call(P,6,call(P,A1,A2,A3,A4,A5,A6)).
t(P,A1,A2,A3,A4,A5,A6):- loop_check_mpred(t(P,A1,A2,A3,A4,A5,A6)).
t(P,A1,A2,A3,A4,A5,A6,A7):- mpred_pa_call(P,7,call(P,A1,A2,A3,A4,A5,A6,A7)).
t(P,A1,A2,A3,A4,A5,A6,A7):- loop_check_mpred(t(P,A1,A2,A3,A4,A5,A6,A7)).


% :- use_module(logicmoo(mpred/mpred_loader)).
% :- use_module(logicmoo(mpred/mpred_pfc)).



baseKB:current_world(current).


mpred_univ(C,I,Head):-atom(C),!,Head=..[C,I],predicate_property(Head,number_of_clauses(_)).


/*
:- use_module(logicmoo(mpred/'mpred_stubs.pl')).
:- use_module(logicmoo(mpred/'mpred_*.pl')).

baseKB:resolveConflict(C):- cwc, must((resolveConflict0(C),
  show_if_debug(is_resolved(C)),mpred_rem(conflict(C)))).
baseKB:resolveConflict(C) :- cwc,
  wdmsg("Halting with conflict ~p", [C]),   
  must(mpred_halt(conflict(C))),fail.
*/

resolveConflict0(C) :- cwc, forall(must(mpred_negation_w_neg(C,N)),ignore(show_failure(why,(nop(baseKB:resolveConflict(C)),pp_why(N))))),
  ignore(show_failure(why,(nop(baseKB:resolveConflict(C)),pp_why(C)))), 
    doall((mreq(resolverConflict_robot(C)),\+ is_resolved(C),!)),
    is_resolved(C),!.

resolverConflict_robot(N) :- cwc, forall(must(mpred_negation_w_neg(N,C)),forall(compute_resolve(C,N,TODO),on_x_rtrace(show_if_debug(TODO)))).
resolverConflict_robot(C) :- cwc, must((mpred_remove3(C),wdmsg("Rem-3 with conflict ~p", [C]),mpred_run,sanity(\+C))).

% never_assert_u(pt(_,Pre,Post),head_singletons(Pre,Post)):- cwc, head_singletons(Pre,Post).
never_assert_u(Rule,is_var(Rule)):- cwc, is_ftVar(Rule),!.
never_assert_u(Rule,head_singletons(Pre,Post)):- cwc, Rule \= (_:-_), once(mpred_rule_hb(Rule,Post,Pre)), head_singletons(Pre,Post).

never_assert_u(A,B):-never_assert_u0(A,B),trace,never_assert_u0(A,B).
never_assert_u(M:Rule,Why):- cwc, atom(M),never_assert_u(Rule,Why).

never_assert_u0(mpred_mark(pfcPosTrigger,_,F,A),Why):-
  functor(P,F,A),
  ignore(predicate_property(M:P,exported)),
  current_predicate(_,M:P),
  ( \+ predicate_property(M:P,imported_from(_))),  
  is_static_why(M,P,F,A,R),
  Why = static(M:P-F/A,R).

is_static_why(M,P,_,_,_):- predicate_property(M:P,dynamic),!,fail.
is_static_why(M,P,F,A,WHY):- show_success(predicate_property(M:P,static)),!,WHY=static(M:F/A).

  

/*
never_assert_u(pt(_,
       singleValuedInArg(A, _),
       (trace->rhs([{trace}, prologSingleValued(B)]))),singletons):- trace,A\=B,trace.
*/


%  Pred='$VAR'('Pred'),unnumbervars(mpred_eval_lhs(basePFC:pt(umt,singleValuedInArg(Pred,_G8263654),(trace->rhs([{trace},prologSingleValued(Pred)]))),(singleValuedInArg(Pred,_G8263679),{trace}==>{trace},prologSingleValued(Pred),u)),UN).
%  Pred='$VAR'('Pred'),unnumbervars(mpred_eval_lhs(basePFC:pt(umt,singleValuedInArg(Pred,_G8263654),(trace->rhs([{trace},prologSingleValued(Pred)]))),(singleValuedInArg(Pred,_G8263679),{trace}==>{trace},prologSingleValued(Pred),u)),UN).



:- source_location(S,_),forall(source_file(H,S),(functor(H,F,A),export(F/A),module_transparent(F/A))).

:- with_ukb(baseKB,baseKB:ensure_mpred_file_loaded('../pfc/autoexec.pfc')).
