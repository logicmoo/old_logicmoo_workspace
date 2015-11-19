
:- if((prolog_load_context(source,F), prolog_load_context(file,F))).

%   File   : pfc
%   Author : Tim Finin, finin@umbc.edu
%   Updated: 10/11/87, ...
%   Purpose: consult system file for ensure

:- module(old_mpred_pfc_utils,
          [  ]).



:- else.

%   File   : pfc
%   Author : Tim Finin, finin@umbc.edu
%   Updated: 10/11/87, ...
%   Purpose: consult system file for ensure
/*
:-export((
          all_different_head_vals/1,all_different_head_vals_2/2,

mpred_run_resume/0,mpred_run_pause/0,

% old_ain_t/2,
% mpred_select/2,
add_reprop/2,
add_side_effect/2,
%mpred_ain/1,mpred_ain/2,
old_ain_actiontrace/2,
old_ain_db_to_head/2,
old_ain_fast/1,
old_ain_fast/2,
old_ain_fast_sp/2,
old_ain_fast_sp0/2,
old_ain_fast_timed/2,
ain_minfo/1,
mpred_retry/1,
ain_minfo/2,
ain_minfo_2/2,
old_ain_rule0/1,
old_ain_rule_if_rule/1,
old_ain_support/2,
old_ain_trigger/2,
old_ain_trigger_0/3,
old_ain_trigger_1/3,
old_ain_ts/2,
aina_i/2,            
ainz_i/2,
all_closed/1,
append_as_first_arg/3,
assert_eq_quitely/1,
assert_u/1,
assert_u/1,
assert_u/4,
assertz_mu/2,
assertz_u/1,
mpred_assumption/1,
mpred_assumptions/2,
mpred_assumptions1/2,
attvar_op/2,
baseable/2,
baseable_list/2,
old_brake/1,
build_code_test/3,
build_consequent/3,
build_neg_test/4,
build_rhs/3,
old_build_rule/3,
build_trigger/4,
bwc/0,
call_i/1,
call_prologsys/1,
call_u/1,
call_u/2,
call_with_bc_triggers/1,
check_context_module/0,
check_never_assert/1,
check_never_retract/1,
clause_asserted_local/1,
clause_i/2,
clause_i/3,
clause_or_call/2,
clause_u/2,
clause_u/3,
cnstrn/1,
cnstrn/2,
cnstrn0/2,
code_sentence_op/1,
compute_resolve/3,
compute_resolve/5,
correctify_support/2,
cwc/0,
defaultmpred_select/2,            
each_in_list/3,
erase_w_attvars/2,
exact_args/1,
f_to_mfa/4,
fa_to_p/3,
old_fc_eval_action/2,
old_fcnt/2,
old_fcnt0/2,
old_fcpt/2,
old_fcpt0/2,
fix_negations/2,
fixed_negations/2,
old_foreachl_do/2,
fwc/0,            
fwd_ok/1,
get_fa/3,
get_mpred_is_tracing/1,
get_next_fact/2,
get_source_ref/1,
get_source_ref1/1,
get_user_abox_umt/1,
get_why/4,
has_body_atom/2,
has_cl/1,
has_db_clauses/1,
has_functor/1,
if_missing_mask/3,
if_missing_mask/4,
is_action_body/1,
is_already_supported/3,
is_bc_body/1,
is_disabled_clause/1,
is_fc_body/1,
is_mpred_action/1,
is_relative/1,
is_reprop/1,
is_reprop_0/1,
is_resolved/1,
is_retract_first/1,
is_side_effect_disabled/0,
justification/2,
old_justifications/2,
lmconf:module_local_init/0,
%loop_check_nr/1,
make_uu_remove/1,
map_literals/2,
map_literals/3,
map_unless/4,
match_source_ref1/1,
maybeSupport/2,
meta_wrapper_rule/1,
mmsg/2,
mpred_ain/1,
mpred_ain/2,
mpred_aina/1,
mpred_ainz/1,
mpred_ainz/2,
mpred_axiom/1,
mpred_bc_only/1,
mpred_bc_only0/1,
mpred_bt_pt_combine/3,
mpred_call_0/1,
mpred_call_1/3,
mpred_call_only_facts/1,
mpred_call_only_facts/2,
mpred_call_with_no_triggers/1,
mpred_call_with_no_triggers_bound/1,
mpred_call_with_no_triggers_uncaugth/1,
mpred_child/2,
mpred_children/2,
mpred_clause/3,
mpred_clause_i/1,
mpred_clause_is_asserted/2,
mpred_clause_is_asserted_hb_nonunify/2,
mpred_cleanup/0,
mpred_cleanup/2,
mpred_cleanup_0/1,
mpred_compile_rhsTerm/3,
mpred_connective/1,
mpred_current/0,
mpred_current_db/1,
mpred_current_op_support/1,
mpred_database_item/1,
mpred_database_term/1,
mpred_db_type/2,
mpred_deep_support/2,
mpred_deep_support0/2,
mpred_define_bc_rule/3,
mpred_descendant/2,
mpred_descendant1/3,
mpred_descendants/2,
mpred_each_literal/2,
mpred_enqueue/2,
mpred_error/1,
mpred_error/2,
mpred_eval_lhs/2,
mpred_eval_lhs0/2,
mpred_eval_rhs1/3,
mpred_eval_rhs_0/3,
mpred_fact/1,
mpred_fact/2,
mpred_facts/1,
mpred_facts/2,
mpred_facts/3,
mpred_facts_and_universe/1,
mpred_facts_only/1,
mpred_file_expansion_0/2,
mpred_freeLastArg/2,
mpred_fwd/1,
mpred_fwd/2,
mpred_fwd1/2,
mpred_fwd2/2,
mpred_get_support/2,
mpred_get_support_neg/2,
mpred_get_support_one/2,
mpred_get_support_precanonical/2,
mpred_get_support_precanonical_plus_more/2,
mpred_get_support_via_clause_db/2,
mpred_get_support_via_sentence/2,
mpred_get_trigger_quick/2,
mpred_had_support/2,
mpred_halt/0,
mpred_halt/1,
mpred_halt/2,
mpred_hide_msg/1,
mpred_ignored/1,
mpred_init_i/2,
mpred_is_builtin/1,
mpred_is_minfo/1,
mpred_is_silient/0,
mpred_is_spying/2,
mpred_is_taut/1,
mpred_is_tautology/1,
mpred_is_tracing_exec/0,
mpred_literal/1,
mpred_literal_nv/1,
map_first_arg/2,
map_first_arg/2,
map_first_arg/3,
mpred_mark_as/4,
mpred_mark_as_ml/4,
mpred_mark_fa_as/6,
mpred_negated_literal/1,
mpred_negated_literal/2,
mpred_negation/2,
mpred_negation_w_neg/2,
mpred_nf/2,
mpred_nf1/2,
mpred_nf1_negation/2,
mpred_nf_negation/2,
mpred_nf_negations/2,
mpred_no_chaining/1,
mpred_no_spy/0,
mpred_no_spy/1,
mpred_no_spy/3,
mpred_no_spy_all/0,
mpred_no_trace/0,
mpred_no_trace_all/0,
mpred_no_warnings/0,
mpred_no_watch/0,
mpred_non_neg_literal/1,
mpred_notrace_exec/0,
mpred_pbody/5,
mpred_pbody_f/5,
mpred_pfc_file/0,
mpred_positive_literal/1,
mpred_post/2,
mpred_post1/2,
mpred_post1_sp_0/2,
mpred_post1_sp_1/2,
mpred_post_sp/2,
mpred_post_sp_zzz/2,
mpred_post_sp_zzzz/2,
mpred_prove_neg/1,
mpred_rem/1,
mpred_withdraw/1,
mpred_withdraw/2,
mpred_remove/1,
mpred_remove/1,
mpred_remove/2,
mpred_rem_actiontrace/2,
mpred_blast/1,
mpred_remove_file_support/1,
mpred_remove_old_version/1,
mpred_remove_supports/2,
mpred_remove_supports_quietly/1,
mpred_reset/0,
mpred_retract_db_type/1,
mpred_retract_db_type/2,
mpred_retract_or_warn_i/1,
mpred_retract_support_relations/2,
mpred_rewrap_h/2,
mpred_rule_hb/3,
mpred_rule_hb_0/3,
mpred_run/0,
mpred_scan_tms/1,
mpred_slow_search/0,
mpred_spy/1,
mpred_spy/2,
mpred_spy/3,
mpred_spy1/3,
mpred_spy_all/0,
mpred_step/0,
mpred_support_db_rem/3,
mpred_test/1,
mpred_tms_supported/2,
mpred_tms_supported/3,
mpred_tms_supported0/3,
mpred_trace/0,
mpred_trace/1,
mpred_trace/2,
mpred_trace_add/2,
mpred_trace_add_print/2,
mpred_trace_add_print_0/2,
mpred_trace_break/2,
mpred_trace_exec/0,
mpred_trace_msg/1,
mpred_trace_msg/2,
mpred_trace_rem/2,
mpred_undo/2,
mpred_undo_e/2,
mpred_undo_u/2,
mpred_unfwc/1,
mpred_unfwc1/1,
mpred_unfwc_check_triggers/2,
mpred_union/3,
mpred_unique_i/1,
mpred_unique_u/1,
mpred_untrace/0,
mpred_untrace/1,
mpred_update_literal/4,
mpred_user_fact/1,
mpred_warn/0,
mpred_warn/1,
mpred_warn/2,
mpred_warnings/0,
mpred_warnings/1,
mpred_watch/0,
mpred_wff/3,
mpred_wfflist/2,
mreq/1,
neg_in_code/1,
no_side_effects/1,
nmpred_warn/0,
nonfact_metawrapper/1,
not_cond/2,
pfc_add/1,
pfc_provide_storage_op/2,
pfcBC_Cache/1,
pfcBC_NoFacts/1,
pfcBC_NoFacts_TRY/1,
old_pfcl_do/1,
pfcVerifyMissing/3,
pfcVersion/1,
physical_side_effect/1,
pred_all/1,
pred_head/2,
pred_head_all/1,
pred_r0/1,
pred_t0/1,
pred_u0/1,
pred_u1/1,
pred_u2/1,
old_process_rule/3,
put_clause_ref/2,
record_se/0,
reduce_clause_from_fwd/2,
remove_if_unsupported/2,
remove_if_unsupported_verbose/3,
remove_selection/2,
repropagate/1,
repropagate_0/1,
repropagate_1/1,
repropagate_2/1,
repropagate_meta_wrapper_rule/1,
req/1,
rescan_pfc/0,
retract_eq_quitely/1,
retract_eq_quitely_f/1,
retract_i/1,
retract_t/1,
retract_u/1,
retractall_u/1,
retractall_u/1,
rewritten_metawrapper/1,
ruleBackward/2,
ruleBackward0/2,
run_nt/5,
select_next_fact/2,
set_prolog_stack_gb/1,
should_call_for_facts/1,
should_call_for_facts/3,
show_if_debug/1,
spft_precanonical/3,
sub_term_eq/2,
sub_term_v/2,
support_ok_via_clause_body/1,
support_ok_via_clause_body/3,
supporters_list/2,
to_addable_form/2,
to_addable_form_wte/3,
to_predicate_isas/2,
to_predicate_isas0/2,
to_predicate_isas_each/2,
trigger_supporters_list/2,
undoable/1,
update_single_valued_arg/2,
use_presently/0,
user_atom/1,
w_get_fa/3,
wac/0,
well_founded/2,
which_missing_argnum/2,
with_mpred_trace_exec/1,
with_no_mpred_trace_exec/1,
with_search_mode/2,
with_umt/1,
without_running/1,
{}/1,
          wac/0)).
*/
/*
:- shared_multifile    
        lmconf:hook_one_minute_timer_tick/0,
        lmconf:infoF/1,
        lmconf:mpred_hook_rescan_files/0,
        baseKB:resolveConflict/1,
        baseKB:resolverConflict_robot/1.
*/


:- meta_predicate((

% baseKB:resolveConflict(0),baseKB:resolveConflict0(0),baseKB:resolverConflict_robot(0),
without_running(0),
with_umt((*)),
with_search_mode(+,0),
with_no_mpred_trace_exec((*)),
with_mpred_trace_exec(0),
with_mpred_trace_exec((*)),
update_single_valued_arg(0,*),
update_single_valued_arg((*),*),
req((*)),
repropagate_meta_wrapper_rule(0),
repropagate_meta_wrapper_rule((*)),
repropagate_1(0),
repropagate_1((*)),
repropagate_0(0),
repropagate_0((*)),
pred_head(1,*),
physical_side_effect(0),
physical_side_effect((*)),
pfcBC_NoFacts(0),
pfcBC_NoFacts((*)),
pfcBC_Cache(0),
pfcBC_Cache((*)),
pfc_provide_storage_op(*,0),
pfc_provide_storage_op(*,(*)),
not_cond(*,0),
not_cond(*,(*)),
mpred_update_literal(*,*,0,*),
mpred_update_literal(*,*,(*),*),
mpred_tms_supported0(*,0,?),
mpred_tms_supported0(*,(*),?),
mpred_tms_supported(0,?),
mpred_tms_supported(*,0,?),
mpred_tms_supported(*,(*),?),
mpred_tms_supported((*),?),
mpred_test(*),
mpred_scan_tms(0),
mpred_scan_tms((*)),
mpred_retry(0),
mpred_remove_supports_quietly((*)),
mpred_prove_neg(0),
mpred_prove_neg((*)),
mpred_facts_only(0),
mpred_facts_only((*)),
mpred_facts_and_universe(0),
mpred_facts_and_universe((*)),
mpred_fact(*,(*)),
mpred_enqueue((*),?),
mpred_deep_support0(*,0),
mpred_deep_support0(*,(*)),
mpred_deep_support(*,0),
mpred_deep_support(*,(*)),
mpred_call_with_no_triggers_uncaugth((*)),
mpred_call_with_no_triggers(0),
mpred_call_with_no_triggers((*)),
mpred_call_only_facts(0),
mpred_call_only_facts(*,0),
mpred_call_only_facts(*,(*)),
mpred_call_only_facts((*)),
mpred_call_0(0),
mpred_call_0((*)),
mpred_bc_only(:),
mpred_bc_only((:)),
map_unless(1,:,*,*),
is_resolved(0),
is_resolved((*)),
cnstrn0(0,*),
cnstrn0((*),*),
cnstrn(?,0),
cnstrn(?,(*)),
cnstrn(0),
cnstrn((*)),
call_u(0),
call_u((*)),
call_prologsys(0),
attvar_op(1,*),
ain_minfo_2(1,*),
ain_minfo(1,*)
      )).

:- dynamic((
        mpred_hide_msg/1,
        mpred_is_spying/2,
        mpred_warnings/1,
        %mpred_select/2,
        mpred_is_tracing_exec/0,
        use_presently/0)).

:- module_transparent((check_context_module/0,clause_i/2,
clause_i/3)).

%% check_context_module is semidet.
%
% Check Context Module.
%
check_context_module:- is_release,!.
check_context_module:- must((source_context_module(M),M\==mpred_pfc,M\==mpred_loader)).

%% check_real_context_module is semidet.
%
% Check Real Context Module.
%
check_real_context_module:- must((context_module(M),M\==mpred_pfc,M\==mpred_loader)).


:- shared_multifile(basePFC:bt/3).
:- shared_multifile(basePFC:nt/4).
:- shared_multifile(basePFC:pk/4).
:- shared_multifile(basePFC:pt/3).
:- shared_multifile(basePFC:spft/5).
:- shared_multifile(basePFC:tms/1).
:- shared_multifile(basePFC:hs/1).
:- shared_multifile(basePFC:qu/3).
:- shared_multifile(basePFC:sm/1).
:- shared_multifile(mpred_do_and_undo_method/2).
/*
:- shared_multifile(('==>')/1).
:- shared_multifile(('::::')/2).
:- shared_multifile(('<-')/2).
:- shared_multifile(('<==>')/2).
:- shared_multifile(('==>')/2).
:- shared_multifile(('~')/1).
:- shared_multifile(('nesc')/1).
:- shared_multifile((('~'))/1).
*/
:- shared_multifile((mpred_action)/1).
:- foreach(arg(_,isEach(prologMultiValued,prologOrdered,prologNegByFailure,prologPTTP,prologKIF,pfcControlled,ttPredType,
     prologHybrid,predCanHaveSingletons,prologDynamic,prologBuiltin,prologMacroHead,prologListValued,prologSingleValued),P),
   ((shared_multifile(baseKB:P/1)))).
:- shared_multifile(basePFC:hs/2).
:- shared_multifile(pfcControlled/1).
:- shared_multifile(prologDynamic/2).
:- shared_multifile(prologSideEffects/1).
:- shared_multifile(prologSingleValued/1).
:- shared_multifile(singleValuedInArg/2).
:- shared_multifile(prologSideEffects/1).

:- was_dynamic(lmconf:module_local_init/0).
:- discontiguous(lmconf:module_local_init/0).

% :- include('mpred_header.pi').
:- style_check(+singleton).


%% get_user_abox_umt( ?A) is semidet.
%
% Get User Abox Ignore.
%
get_user_abox_umt(A):-!,A=umt.
get_user_abox_umt(A):-ignore(get_user_abox(A)).


% ======================= mpred_file('pfcsyntax').	% operator declarations.
:- was_module_transparent(with_umt/1).
:- was_export(with_umt/1).

%% with_umt( ?ABOX, ?G) is semidet.
%
% Using User Microtheory.
%
with_umt(ABOX,G):- w_tl(t_l:user_abox(ABOX),ABOX:call(ABOX:G)).

%% with_umt( ?G) is semidet.
%
% Using User Microtheory.
%
with_umt(G):- get_user_abox(M),!, M:call(M:G).
with_umt(Goal):- source_context_module(M) -> M:call(Goal).


with_search_mode(Mode,Goal):- w_tl(t_l:mpred_search_mode(Mode),Goal).


%   File   : pfcsyntax.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Purpose: syntactic sugar for Pfc - operator definitions and term expansions.

:-
 op(1199,fx,('==>')), 
 op(1190,xfx,('::::')),
 op(1180,xfx,('==>')),
 op(1170,xfx,'<==>'),  
 op(1160,xfx,('<-')),
 op(1150,xfx,'=>'),
 op(1140,xfx,'<='),
 op(1130,xfx,'<=>'), 
 op(600,yfx,'&'), 
 op(600,yfx,'v'),
 op(350,xfx,'xor'),
 op(300,fx,'~'),
 op(300,fx,'-').

:- op(1100,fx,(shared_multifile)).




%% mreq( ?G) is semidet.
%
% Mreq.
%
mreq(G):- if_defined_else(G,fail).

% ======================= mpred_file('pfccore').	% core of Pfc.

%   File   : pfccore.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Updated: 10/11/87, ...
%            4/2/91 by R. McEntire: added calls to valid_dbref as a
%                                   workaround for the Quintus 3.1
%                            bug in the recorded database.
%   Purpose: core Pfc predicates.

/*

LogicMOO is mixing Mark Stickel's PTTP (prolog techn theorem prover) to create horn clauses that 
 PFC forwards and helps maintain in visible states )  in prolog knowledge baseable.. We use basePFC:spft/5 to track deductions
Research~wise LogicMOO has a main purpose is to prove that grounded negations (of contrapostives) are of first class in importance in helping
with Wff checking/TMS 
Also alows an inference engine constrain search.. PFC became important since it helps memoize and close off (terminate) transitive closures

*/


%% is_side_effect_disabled is semidet.
%
% If Is A Side Effect Disabled.
%
is_side_effect_disabled:- t_l:no_physical_side_effects,!.
is_side_effect_disabled:- t_l:side_effect_ok,!,fail.
is_side_effect_disabled:- t_l:noDBaseMODs(_),!.



%% f_to_mfa( ?EF, ?R, ?F, ?A) is semidet.
%
% Functor Converted To Module-functor-arity.
%
f_to_mfa(EF,R,F,A):-w_get_fa(EF,F,A),
              (((current_predicate(F/A),functor(P,F,A),predicate_property(_M:P,imported_from(R)))*->true;
              current_predicate(F/A),functor(P,F,A),source_file(R:P,_SF))),
              current_predicate(R:F/A).


%% w_get_fa( ?PI, ?F, ?A) is semidet.
%
% W Get Functor-arity.
%
w_get_fa(PI,_F,_A):-is_ftVar(PI),!.
w_get_fa(F/A,F,A):- !.
w_get_fa(PI,PI,_A):- atomic(PI),!.
w_get_fa(PI,F,A):- is_ftCompound(PI),!,functor(PI,F,A).
w_get_fa(Mask,F,A):-get_functor(Mask,F,A).



%% set_prolog_stack_gb( ?Six) is semidet.
%
% Set Prolog Stack Gb.
%
set_prolog_stack_gb(Six):-set_prolog_stack(global, limit(Six*10**9)),set_prolog_stack(local, limit(Six*10**9)),set_prolog_stack(trail, limit(Six*10**9)).

%% module_local_init is semidet.
%
% Hook To [lmconf:module_local_init/0] For Module Mpred_pfc.
% Module Local Init.
%
lmconf:module_local_init:-set_prolog_stack_gb(16).
:- shared_multifile(lmconf:mpred_hook_rescan_files/0).
:- was_dynamic(lmconf:mpred_hook_rescan_files/0).
:- was_dynamic(use_presently/0).
% used to annotate a predciate to indicate PFC support
:- shared_multifile(infoF/1).
:- was_dynamic(infoF/1).
:- was_export(infoF/1).

% :- set_prolog_flag(access_level,system).


%% is_mpred_action( :TermP) is semidet.
%
% If Is A Managed Predicate Action.
%
is_mpred_action('$VAR'(_)):-!,fail.
is_mpred_action(remove_if_unsupported(_,_)).
is_mpred_action(P):-predicate_property(P,static).

%% mpred_is_builtin( ?P) is semidet.
%
% PFC If Is A Builtin.
%
mpred_is_builtin(P):-predicate_property(P,built_in).

/* UNUSED TODAY

:- use_module(library(mavis)).
:- use_module(library(type_check)).
:- use_module(library(typedef)).
*/

:- use_module(library(lists)).
:- meta_predicate with_mpred_trace_exec(0).

% :- use_module(library(dra/tabling3/swi_toplevel)).

:- discontiguous(mpred_file_expansion_0/2).
/*
compiled(F/A):- was_dynamic(F/A),compile_predicates([F/A]).
:- compiled(('nesc')/1).
:- compiled(('~')/1).
:- compiled(('<-')/2).
:- compiled(('==>')/2).
:- compiled(('::::')/2).
:- compiled(('<==>')/2).
*/

:- thread_local((t_l:use_side_effect_buffer , t_l:verify_side_effect_buffer)).

%% record_se is semidet.
%
% Record Se.
%
record_se:- (t_l:use_side_effect_buffer ; t_l:verify_side_effect_buffer).



%% add_side_effect( ?Op, ?Data) is semidet.
%
% Add Side Effect.
%
add_side_effect(_,_):- ( \+  record_se ),!.
add_side_effect(Op,Data):-current_why(Why),assert(t_l:side_effect_buffer(Op,Data,Why)).


%% attvar_op( +:PRED1, ?Data) is semidet.
%
% Attribute Variable Oper..
%


attvar_op(Op,Data):- strip_module(Op,_,OpA), sanity((atom(OpA))),
   add_side_effect(Op,Data),   
   unnumbervars_and_save(Data,Data0),
   all_different_head_vals(Data0),
   clausify_attributes(Data0,DataA),
   (==(Data0,DataA)->
     physical_side_effect(call(Op,DataA));

   ((atom_concat(asse,_,OpA) -> physical_side_effect(call(Op,DataA)));
   ((
    % nop((expand_to_hb(DataA,H,B),split_attrs(B,BA,G))),
     
    physical_side_effect(call(Op,DataA))

    )))).
    


%% erase_w_attvars( ?Data0, ?Ref) is semidet.
%
% Erase W Attribute Variables.
%
erase_w_attvars(Data0,Ref):- physical_side_effect(erase(Ref)),add_side_effect(erase,Data0).

:- thread_local(t_l:no_physical_side_effects/0).

%% physical_side_effect( ?PSE) is semidet.
%
% Physical Side Effect.
%
physical_side_effect(PSE):- is_side_effect_disabled,!,mpred_warn('no_physical_side_effects ~p',PSE).
physical_side_effect(PSE):- PSE.

%% mpred_no_chaining( ?Goal) is semidet.
%
% PFC No Chaining.
%
mpred_no_chaining(Goal):- w_tl(t_l:no_physical_side_effects,call(Goal)).

%% contains_ftVar( ?Term) is semidet.
%
% Contains Format Type Variable.
%
contains_ftVar(Term):- sub_term(Sub,Term),compound(Sub),Sub='$VAR'(_).

% TODO ISSUE https://github.com/TeamSPoon/PrologMUD/issues/7

%% match_source_ref1( :TermARG1) is semidet.
%
% Match Source Ref Secondary Helper.
%
match_source_ref1(u):-!.
match_source_ref1(u(_)).

%% make_uu_remove( :TermU) is semidet.
%
% Make Uu Remove.
%
make_uu_remove((U,U)):-match_source_ref1(U).

% TODO ISSUE https://github.com/TeamSPoon/PrologMUD/issues/7
:- was_export(get_source_ref/1).

%% get_source_ref1( ?Mt) is semidet.
%
% Get Source Ref Secondary Helper.
%
get_source_ref1(_):- check_context_module,fail.
get_source_ref1(u):-!.
get_source_ref1(u(Mt)):-current_why(Mt),!.
get_source_ref1(u(Mt)):-Mt=mt.

%% get_source_ref( :TermU) is semidet.
%
% Get Source Ref.
%
get_source_ref((U,U)):- get_source_ref1(U).


%% has_functor( :TermC) is semidet.
%
% Has Functor.
%
has_functor(_):-!,fail.
has_functor(F/A):-!,atom(F),integer(A),!.
has_functor(C):- (\+ is_ftCompound(C)),!,fail.
has_functor(C):-is_ftCompound(C),\+is_list(C).


%% mpred_each_literal( ?P, ?E) is semidet.
%
% PFC Each Literal.
%
mpred_each_literal(P,E):-is_ftNonvar(P),P=(P1,P2),!,(mpred_each_literal(P1,E);mpred_each_literal(P2,E)).
mpred_each_literal(P,P). %:-conjuncts_to_list(P,List),member(E,List).



is_nc_as_is(P) :- \+ compound(P),!.
is_nc_as_is(P):- is_ftVar(P),!.

fixed_negations(I,O):-notrace((fix_negations(I,O),!,I\=@=O)).
fix_negations(P0,P0):- is_nc_as_is(P0),!.
fix_negations(~(P0),~(P0)):- is_nc_as_is(P0),!.
fix_negations(\+(P0),\+(P0)):- is_nc_as_is(P0),!.
fix_negations(~(~I),O):- !, fix_negations(\+(~I),O).
fix_negations(~not(I),O):- !, fix_negations(\+(~I),O).
fix_negations(~~(I),O):- functor(~~(I),~~,1),!, fix_negations(\+(~I),O).
fix_negations(not(I),O):- !, fix_negations(\+(I),O).
fix_negations(~(I),~(O)):- !, fix_negations(I,O).
fix_negations(\+(I),\+(O)):- !, fix_negations(I,O).
% fix_negations(C,C):-exact_args(C),!.
fix_negations([H|T],[HH|TT]):-!,fix_negations(H,HH),fix_negations(T,TT),!.
fix_negations(C,CO):-C=..[F|CL],must_maplist(fix_negations,CL,CLO),!,CO=..[F|CLO].




%% to_addable_form_wte( ?Why, :TermI, :TermO) is semidet.
%
% Converted To Addable Form Wte.
%
to_addable_form_wte(Why,I,O):-nonvar(O),!,to_addable_form_wte(Why,I,M),!,mustvv(M=O).
to_addable_form_wte(Why,I,O):-string(I),must_det_l((input_to_forms(string(I),Wff,Vs),put_variable_names(Vs),!,sexpr_sterm_to_pterm(Wff,PTerm),
  to_addable_form_wte(Why,PTerm,O))).
to_addable_form_wte(Why,I,O):-atom(I),atom_contains(I,'('),must_det_l((input_to_forms(atom(I),Wff,Vs),put_variable_names(Vs),!,sexpr_sterm_to_pterm(Wff,PTerm),
  to_addable_form_wte(Why,PTerm,O))).

to_addable_form_wte(_,X,X):-mreq(as_is_term(X)),!.
to_addable_form_wte(Why,nesc(I),O):-!,to_addable_form_wte(Why,I,O).
to_addable_form_wte(Why,USER:I,O):-USER==user,!,to_addable_form_wte(Why,I,O).
to_addable_form_wte(Why,I,O):- fixed_negations(I,M),to_addable_form_wte(Why,M,O).
to_addable_form_wte(assert,(H:-B),(H:-B)):-B\==true,!.
to_addable_form_wte(Why,(CUT0,P0),(CUT,P)):-to_addable_form_wte(Why,CUT0,CUT),!,to_addable_form_wte(Why,P0,P).
% to_addable_form_wte(Why,(CUT,P0),(CUT,P)):-mpred_is_builtin(CUT),!,to_addable_form_wte(Why,P0,P).
to_addable_form_wte(Why,P0,P):- notrace((
    once(cnotrace(to_addable_form(P0,P));must(to_addable_form(P0,P))),
    ignore((((P0\=@=P,P0\=isa(_,_)),mpred_trace_msg((to_addable_form(Why):-[P0,P]))))))),!.


%% retract_eq_quitely( ?H) is semidet.
%
% Retract Using (==/2) (or =@=/2) ) Quitely.
%
retract_eq_quitely(H):- with_umt(retract_eq_quitely_f(H)).

%% retract_eq_quitely_f( ?H) is semidet.
%
% Retract Using (==/2) (or =@=/2) ) Quitely False.
%
retract_eq_quitely_f((H:-B)):- !,clause_asserted_i(H,B,Ref),erase(Ref).
retract_eq_quitely_f(pfclog(H)):- retract_eq_quitely_f(H),fail.
retract_eq_quitely_f((H)):- clause_asserted_i(H,true,Ref),erase(Ref).


%% assert_eq_quitely( ?H) is semidet.
%
% Assert Using (==/2) (or =@=/2) ) Quitely.
%
assert_eq_quitely(H):- attvar_op(assert_if_new,H).


%% reduce_clause_from_fwd( ?H, ?H) is semidet.
%
% Reduce Clause Converted From Forward Repropigated.
%
reduce_clause_from_fwd(H,H):- (\+is_ftCompound(H)),!.
reduce_clause_from_fwd((H:-B),HH):-B==true,reduce_clause_from_fwd(H,HH).
reduce_clause_from_fwd((B==>H),HH):-B==true,reduce_clause_from_fwd(H,HH).
reduce_clause_from_fwd(I,O):- fixed_negations(I,M),reduce_clause_from_fwd(M,O).
reduce_clause_from_fwd((==>H),HH):-!,reduce_clause_from_fwd(H,HH).
reduce_clause_from_fwd((H<- B),HH):-B==true,reduce_clause_from_fwd(H,HH).
reduce_clause_from_fwd((B<==> H),HH):-B==true,reduce_clause_from_fwd(H,HH).
reduce_clause_from_fwd((H<==> B),HH):-B==true,reduce_clause_from_fwd(H,HH).
reduce_clause_from_fwd((H,B),(HH,BB)):-!,reduce_clause_from_fwd(H,HH),reduce_clause_from_fwd(B,BB).
reduce_clause_from_fwd(H,H).



%% to_addable_form( ?I, ?I) is semidet.
%
% Converted To Addable Form.
%
to_addable_form(I,I):- is_ftVar(I),!.
to_addable_form(I,OOO):-is_list(I),!,must_maplist(to_addable_form,I,O),flatten(O,OO),!,must(reduce_clause_from_fwd(OO,OOO)).

to_addable_form(I,OO):- current_predicate(_:mpred_expansion_file/0),must(fully_expand(pfc,I,II)),!,
 must((into_mpred_form(II,M),to_predicate_isas_each(M,O))),!,reduce_clause_from_fwd(O,OO).

to_addable_form(I,O):- must((bagof(M,do_expand_args(isEachAF,I,M),IM))),list_to_conjuncts(IM,M),to_predicate_isas_each(M,O),!.

:-mpred_expansion_file.
% I =((P,Q)==>(p(P),q(Q))) , findall(O,baseKB:do_expand_args(isEachAF,I,O),L).



%% to_predicate_isas_each( ?I, ?O) is semidet.
%
% Converted To Predicate Isas Each.
%
to_predicate_isas_each(I,O):-to_predicate_isas(I,O).


%% to_predicate_isas( :TermV, :TermV) is semidet.
%
% Converted To Predicate Isas.
%
to_predicate_isas(V,V):- (\+is_ftCompound(V)),!.
to_predicate_isas([H|T],[HH|TT]):-!,to_predicate_isas(H,HH),to_predicate_isas(T,TT),!.
to_predicate_isas((H,T),(HH,TT)):-!,to_predicate_isas(H,HH),to_predicate_isas(T,TT),!.
%to_predicate_isas(I,I):-contains_term(S,I),is_ftNonvar(S),exact_args(S),!.
to_predicate_isas(I,O):-must(to_predicate_isas0(I,O)),!.


%% append_as_first_arg( ?C, ?I, ?V) is semidet.
%
% Append Converted To First Argument.
%
append_as_first_arg(C,I,V):-C=..[F|ARGS],V=..[F,I|ARGS].


%% to_predicate_isas0( :TermV, :TermV) is semidet.
%
% Converted To Predicate Isas Primary Helper.
%
to_predicate_isas0(V,V):- (\+is_ftCompound(V)),!.
to_predicate_isas0({V},{V}):-!.
to_predicate_isas0(eXact(V),V):-!.
to_predicate_isas0(t(C,I),V):-atom(C)->V=..[C,I];(is_ftVar(C)->V=t(C,I);append_as_first_arg(C,I,V)).
to_predicate_isas0(isa(I,C),V):-!,atom(C)->V=..[C,I];(is_ftVar(C)->V=isa(I,C);append_as_first_arg(C,I,V)).
to_predicate_isas0(C,C):-exact_args(C),!.
to_predicate_isas0([H|T],[HH|TT]):-!,to_predicate_isas0(H,HH),to_predicate_isas0(T,TT),!.
to_predicate_isas0(C,CO):-C=..[F|CL],must_maplist(to_predicate_isas0,CL,CLO),!,CO=..[F|CLO].

:- source_location(F,_),asserta(absolute_source_location_pfc(F)).

%% exact_args( ?Q) is semidet.
%
% Exact Arguments.
%
exact_args(Q):-is_ftVar(Q),!,fail.
exact_args(argsQuoted(_)):-!,fail.
exact_args(Q):- req(argsQuoted(Q)).
exact_args(Q):-is_ftCompound(Q),functor(Q,F,_),req(argsQuoted(F)).
exact_args(second_order(_,_)).
exact_args(call(_)).
exact_args(asserted(_)).
exact_args(retract_eq_quitely(_)).
exact_args(asserts_eq_quitely(_)).
exact_args(assertz_if_new(_)).
exact_args((_:-_)).
exact_args((_ =.. _)).
exact_args((:-( _))).
exact_args((A/B)):- (is_ftVar(A);is_ftVar(B)).
exact_args(mpred_ain(_)).
exact_args(dynamic(_)).
exact_args(cwc).
exact_args(true).
% exact_args(C):-source_file(C,I),absolute_source_location_pfc(I).


%% mpred_is_tautology( ?Var) is semidet.
%
% PFC If Is A Tautology.
%
mpred_is_tautology(Var):-is_ftVar(Var).
mpred_is_tautology(V):- copy_term_nat(V,VC),numbervars(VC),show_success(mpred_is_taut(VC)).


%% mpred_is_taut( :TermA) is semidet.
%
% PFC If Is A Taut.
%
mpred_is_taut(A):-var(A),!.
mpred_is_taut(A:-B):-!,mpred_is_taut(B==>A).
mpred_is_taut(A<-B):-!,mpred_is_taut(B==>A).
mpred_is_taut(A<==>B):-!,(mpred_is_taut(A==>B);mpred_is_taut(B==>A)).
mpred_is_taut(A==>B):- A==B,!.
mpred_is_taut((B,_)==>A):- mpred_is_assertable(B),mpred_is_taut(A==>B),!.
mpred_is_taut((_,B)==>A):- mpred_is_assertable(B),mpred_is_taut(A==>B),!.
mpred_is_taut(B==>(A,_)):- mpred_is_assertable(A),mpred_is_taut(A==>B),!.
mpred_is_taut(B==>(_,A)):- mpred_is_assertable(A),mpred_is_taut(A==>B),!.


/*
%% loop_check_nr( ?CL) is semidet.
%
% Loop Check Nr.
%
loop_check_nr(CL):- loop_check(no_repeats(CL)).
*/

% lmconf:decl_database_hook(Op,Hook):- loop_check_nr(pfc_provide_storage_op(Op,Hook)).


%% is_retract_first( ?VALUE1) is semidet.
%
% If Is A Retract First.
%
is_retract_first(one).
is_retract_first(a).


%% pfc_provide_storage_op( ?Op, ?I1) is semidet.
%
% Prolog Forward Chaining Provide Storage Oper..
%
pfc_provide_storage_op(Op,(I1,I2)):-!,pfc_provide_storage_op(Op,I1),pfc_provide_storage_op(Op,I2).
pfc_provide_storage_op(Op,(nesc(P))):-!,pfc_provide_storage_op(Op,P).
%pfc_provide_storage_op(change(assert,_AorZ),Fact):- loop_check_nr(ainPreTermExpansion(Fact)).
% pfcRem1 to just get the first
pfc_provide_storage_op(change(retract,OneOrA),FactOrRule):- is_retract_first(OneOrA),!,
            loop_check_nr(mpred_withdraw(FactOrRule)),
  ignore((ground(FactOrRule),mpred_remove(FactOrRule))).
% mpred_remove should be forcefull enough
pfc_provide_storage_op(change(retract,all),FactOrRule):- loop_check_nr(mpred_remove(FactOrRule)),!.
% pfc_provide_storage_op(is_asserted,FactOrRule):- is_ftNonvar(FactOrRule),!,loop_check_nr(clause_i(FactOrRule)).


%% mpred_clause_is_asserted_hb_nonunify( ?H, :TermB) is semidet.
%
% PFC Clause If Is A Asserted Head+body Nonunify.
%
mpred_clause_is_asserted_hb_nonunify(H,B):- clause_true( ==>( B , H) ).
mpred_clause_is_asserted_hb_nonunify(H,B):- clause_true( <-( H , B) ).
mpred_clause_is_asserted_hb_nonunify(_,_):-!,fail.
mpred_clause_is_asserted_hb_nonunify(G, T   ):- T==true,!,hotrace(mpred_rule_hb(G,H,B)),G\=@=H,!,mpred_clause_is_asserted(H,B).
mpred_clause_is_asserted_hb_nonunify(H,(T,B)):- T==true,!,mpred_clause_is_asserted_hb_nonunify(H,B).
mpred_clause_is_asserted_hb_nonunify(H,(B,T)):- T==true,!,mpred_clause_is_asserted_hb_nonunify(H,B).
mpred_clause_is_asserted_hb_nonunify(H,B):- clause_u( <-( H , B) , true).
mpred_clause_is_asserted_hb_nonunify(H,B):- mpred_clause_is_asserted(H,B).


%% mpred_clause_is_asserted( ?H, ?B) is semidet.
%
% PFC Clause If Is A Asserted.
%
mpred_clause_is_asserted(H,B):- is_ftVar(H),is_ftNonvar(B),!,fail.
mpred_clause_is_asserted(H,B):- modulize_head(H,HH), (has_cl(HH) -> clause_i(HH,B) ; mpred_clause_is_asserted_hb_nonunify(H,B)).
%mpred_clause_is_asserted(H,B,Ref):- clause_u(H,B,Ref).


% pfcDatabaseGoal(G):-is_ftCompound(G),get_functor(G,F,A),pfcDatabaseTerm(F/A).


%% lmconf:mpred_provide_storage_clauses( ?VALUE1, ?H, ?B, ?Proof) is semidet.
%
% Hook To [lmconf:mpred_provide_storage_clauses/4] For Module Mpred_pfc.
% PFC Provide Storage Clauses.
%
lmconf:mpred_provide_storage_clauses(pfc,H,B,Proof):-mpred_clause(H,B,Proof).

%mpred_clause('nesc'(H),B,forward(Proof)):- is_ftNonvar(H),!, lmconf:mpred_provide_storage_clauses(H,B,Proof).
%mpred_clause(H,B,forward(R)):- R=(==>(B,H)),clause_i(R,true).

%% mpred_clause( ?H, ?B, ?Why) is semidet.
%
% PFC Clause.
%
mpred_clause(H,B,Why):-has_cl(H),clause_i(H,CL,R),mpred_pbody(H,CL,R,B,Why).
%mpred_clause(H,B,backward(R)):- R=(<-(H,B)),clause_i(R,true).
%mpred_clause(H,B,equiv(R)):- R=(<==>(LS,RS)),clause_i(R,true),(((LS=H,RS=B));((LS=B,RS=H))).
% mpred_clause(H,true, pfcTypeFull(R,Type)):-is_ftNonvar(H),!,pfcDatabaseTerm(F/A),make_functor(R,F,A),pfcRuleOutcomeHead(R,H),clause(R,true),pfcTypeFull(R,Type),Type\=rule.
% mpred_clause(H,true, pfcTypeFull(R)):-pfcDatabaseTerm(F/A),make_functor(R,F,A),pfcTypeFull(R,Type),Type\=rule,clause(R,true),once(pfcRuleOutcomeHead(R,H)).


%% mpred_pbody( ?H, ?B, ?R, ?BIn, ?WHY) is semidet.
%
% PFC Pbody.
%
mpred_pbody(_H,mpred_bc_only(_BC),_R,fail,deduced(backchains)):-!.
mpred_pbody(H,infoF(INFO),R,B,Why):-!,mpred_pbody_f(H,INFO,R,B,Why).
mpred_pbody(H,B,R,BIn,WHY):- is_true(B),!,BIn=B,get_why(H,H,R,WHY).
mpred_pbody(H,B,R,B,asserted(R,(H:-B))).


%% get_why( ?VALUE1, ?CL, ?R, :TermR) is semidet.
%
% Get Generation Of Proof.
%
get_why(_,CL,R,asserted(R,CL)):- get_user_abox_umt(ABOX),clause_i(basePFC:spft(ABOX,CL, U, U, _Why),true),!.
get_why(H,CL,R,deduced(R,WHY)):- (mpred_get_support(H,WH)*->WHY=(H=WH);(mpred_get_support(CL,WH),WHY=(CL=WH))).



%% mpred_pbody_f( ?H, ?CL, ?R, ?B, ?WHY) is semidet.
%
% PFC Pbody False.
%
mpred_pbody_f(H,CL,R,B,WHY):- CL=(B==>HH),sub_term_eq(H,HH),!,get_why(H,CL,R,WHY).
mpred_pbody_f(H,CL,R,B,WHY):- CL=(HH<-B),sub_term_eq(H,HH),!,get_why(H,CL,R,WHY).
mpred_pbody_f(H,CL,R,B,WHY):- CL=(HH<==>B),sub_term_eq(H,HH),get_why(H,CL,R,WHY).
mpred_pbody_f(H,CL,R,B,WHY):- CL=(B<==>HH),sub_term_eq(H,HH),!,get_why(H,CL,R,WHY).
mpred_pbody_f(H,CL,R,fail,infoF(CL)):- trace_or_throw(mpred_pbody_f(H,CL,R)).


%% sub_term_eq( ?H, ?HH) is semidet.
%
% Sub Term Using (==/2) (or =@=/2) ).
%
sub_term_eq(H,HH):-H==HH,!.
sub_term_eq(H,HH):-each_subterm(HH,ST),ST==H,!.


%% sub_term_v( ?H, ?HH) is semidet.
%
% Sub Term V.
%
sub_term_v(H,HH):-H=@=HH,!.
sub_term_v(H,HH):-each_subterm(HH,ST),ST=@=H,!.

%% all_different_head_vals(+Clause) is det.
%
% Enforces All Different Head Vals.
%
all_different_head_vals(HB):- (\+ compound(HB) ; ground(HB)),!.
all_different_head_vals(HB):- 
  mpred_rule_hb(HB,H,B),
  term_slots(H,Slots),  
  (Slots==[]->
     all_different_head_vals(B);
    (lock_vars(Slots),all_different_head_vals_2(H,Slots),unlock_vars(Slots))),!.
  

all_different_head_vals_2(_H,[]):-!.
all_different_head_vals_2(H,[A,R|EST]):-arg(_,H,E1),E1 ==A,dif(A,E2),arg(_,H,E2),\+ contains_var(A,E2),all_different_vals(dif_matrix,[A,E2,R|EST]),!.
all_different_head_vals_2(_H,[A,B|C]):-all_different_vals(dif_matrix,[A,B|C]),!.
all_different_head_vals_2(HB,_):- \+ compound(HB),!.
all_different_head_vals_2(H,[A]):-arg(_,H,E1),E1 ==A, H=..[_|ARGS], all_different_vals(dif_matrix,ARGS),!.
all_different_head_vals_2(H,[A]):-arg(_,H,E1),E1 ==A,  arg(_,H,E2), A\==E2, \+ contains_var(A,E2), dif(A,E2),!.
all_different_head_vals_2(H,[A]):-arg(_,H,E1),E1\==A, compound(E1), contains_var(A,E1), all_different_head_vals_2(E1,[A]),!.
all_different_head_vals_2(_,_).
   	 

%% mpred_rule_hb( ?Outcome, ?OutcomeO, ?AnteO) is semidet.
%
% PFC Rule Head+body.
%
mpred_rule_hb(Outcome,OutcomeO,AnteO):-hotrace((mpred_rule_hb_0(Outcome,OutcomeO,Ante),mpred_rule_hb_0(Ante,AnteO,_))),!.
:-mpred_trace_nochilds(mpred_rule_hb/3).


%% mpred_rule_hb_0( ?Outcome, ?OutcomeO, ?VALUE3) is semidet.
%
% PFC rule Head+Body  Primary Helper.
%
mpred_rule_hb_0(Outcome,OutcomeO,true):-is_ftVar(Outcome),!,OutcomeO=Outcome.
mpred_rule_hb_0(Outcome,OutcomeO,true):- \+compound(Outcome),!,OutcomeO=Outcome.
mpred_rule_hb_0((Outcome1,Outcome2),OutcomeO,AnteO):-!,mpred_rule_hb(Outcome1,Outcome1O,Ante1),mpred_rule_hb(Outcome2,Outcome2O,Ante2),
                   conjoin(Outcome1O,Outcome2O,OutcomeO),
                   conjoin(Ante1,Ante2,AnteO).
mpred_rule_hb_0((Ante1==>Outcome),OutcomeO,(Ante1,Ante2)):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0((Ante1=>Outcome),OutcomeO,(Ante1,Ante2)):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0((Ante1->Outcome),OutcomeO,(Ante1,Ante2)):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
% mpred_rule_hb_0((Outcome/Ante1),OutcomeO,(Ante1,Ante2)):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0(rhs(Outcome),OutcomeO,Ante2):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0({Outcome},OutcomeO,Ante2):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0((Outcome<-Ante1),OutcomeO,(Ante1,Ante2)):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0((Ante1 & Outcome),OutcomeO,(Ante1,Ante2)):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0((Ante1 , Outcome),OutcomeO,(Ante1,Ante2)):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0((Outcome<==>Ante1),OutcomeO,(Ante1,Ante2)):-mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0((Ante1<==>Outcome),OutcomeO,(Ante1,Ante2)):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0(_::::Outcome,OutcomeO,Ante2):-!,mpred_rule_hb_0(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0(basePFC:bt(ABOX,Outcome,Ante1),OutcomeO,(Ante1,Ante2)):-!,get_user_abox_umt(ABOX),mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0(basePFC:pt(ABOX,Ante1,Outcome),OutcomeO,(Ante1,Ante2)):-!,get_user_abox_umt(ABOX),mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0(basePFC:pk(ABOX,Ante1a,Ante1b,Outcome),OutcomeO,(Ante1a,Ante1b,Ante2)):-!,get_user_abox_umt(ABOX),mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0(basePFC:nt(ABOX,Ante1a,Ante1b,Outcome),OutcomeO,(Ante1a,Ante1b,Ante2)):-!,get_user_abox_umt(ABOX),mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0(basePFC:spft(ABOX,Outcome,Ante1a,Ante1b,_),OutcomeO,(Ante1a,Ante1b,Ante2)):-!,get_user_abox_umt(ABOX),mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0(basePFC:qu(ABOX,Outcome,_),OutcomeO,Ante2):-!,get_user_abox_umt(ABOX),mpred_rule_hb(Outcome,OutcomeO,Ante2).
% mpred_rule_hb_0(pfc Default(Outcome),OutcomeO,Ante2):-!,mpred_rule_hb(Outcome,OutcomeO,Ante2).
mpred_rule_hb_0((Outcome:-Ante),Outcome,Ante):-!.
mpred_rule_hb_0(Outcome,Outcome,true).


%% ain_minfo( ?G) is semidet.
%
% Assert If New Metainformation.
%
ain_minfo(G):-ain_minfo(assertz_if_new,G).

%% ain_minfo( :PRED1How, ?H) is semidet.
%
% Assert If New Metainformation.
%
ain_minfo(How,(H:-True)):-is_true(True),must(is_ftNonvar(H)),!,ain_minfo(How,H).
ain_minfo(How,(H<-B)):- !,ain_minfo(How,(H:-infoF(H<-B))),!,ain_minfo(How,(H:-mpred_bc_only(H))),ain_minfo_2(How,(B:-infoF(H<-B))).
ain_minfo(How,(B==>H)):- !,ain_minfo(How,(H:-infoF(B==>H))),!,ain_minfo_2(How,(B:-infoF(B==>H))).
ain_minfo(How,(B<==>H)):- !,ain_minfo(How,(H:-infoF(B<==>H))),!,ain_minfo(How,(B:-infoF(B<==>H))),!.
ain_minfo(How,((A,B):-INFOC)):-mpred_is_minfo(INFOC),(is_ftNonvar(A);is_ftNonvar(B)),!,ain_minfo(How,((A):-INFOC)),ain_minfo(How,((B):-INFOC)),!.
ain_minfo(How,((A;B):-INFOC)):-mpred_is_minfo(INFOC),(is_ftNonvar(A);is_ftNonvar(B)),!,ain_minfo(How,((A):-INFOC)),ain_minfo(How,((B):-INFOC)),!.
ain_minfo(How,(-(A):-infoF(C))):-is_ftNonvar(C),is_ftNonvar(A),!,ain_minfo(How,((A):-infoF((C)))). % attvar_op(How,(-(A):-infoF(C))).
ain_minfo(How,(~(A):-infoF(C))):-is_ftNonvar(C),is_ftNonvar(A),!,ain_minfo(How,((A):-infoF((C)))). % attvar_op(How,(-(A):-infoF(C))).
ain_minfo(How,(A:-INFOC)):-is_ftNonvar(INFOC),INFOC= mpred_bc_only(A),!,attvar_op(How,(A:-INFOC)),!.
ain_minfo(How,basePFC:bt(_ABOX,H,_)):-!,attvar_op(How,(H:-mpred_bc_only(H))).
ain_minfo(How,basePFC:nt(ABOX,H,Test,Body)):-!,attvar_op(How,(H:-fail,basePFC:nt(ABOX,H,Test,Body))).
ain_minfo(How,basePFC:pt(ABOX,H,Body)):-!,attvar_op(How,(H:-fail,basePFC:pt(ABOX,H,Body))).
ain_minfo(How,(A0:-INFOC0)):- mpred_is_minfo(INFOC0), copy_term_and_varnames((A0:-INFOC0),(A:-INFOC)),!,must((mpred_rewrap_h(A,AA),imploded_copyvars((AA:-INFOC),ALLINFO), attvar_op(How,(ALLINFO)))),!.
%ain_minfo(How,G):-mpred_trace_msg(skipped_add_meta_facts(How,G)).
ain_minfo(_,_).

:- was_export(ain_minfo_2/2).

%% ain_minfo_2( :PRED1How, ?G) is semidet.
%
% Assert If New Metainformation  Extended Helper.
%
ain_minfo_2(How,G):-ain_minfo(How,G).


%% mpred_is_minfo( :TermC) is semidet.
%
% PFC If Is A Info.
%
mpred_is_minfo(mpred_bc_only(C)):-is_ftNonvar(C),!.
mpred_is_minfo(infoF(C)):-is_ftNonvar(C),!.

%:- was_dynamic(not_not/1).

%% mpred_rewrap_h( ?A, ?A) is semidet.
%
% PFC Rewrap Head.
%
mpred_rewrap_h(A,A):-is_ftNonvar(A),\+ is_static_pred(A).
mpred_rewrap_h(A,F):- functor(A,F,_),\+ is_static_pred(F),!.
%mpred_rewrap_h(A,not_not(A)):-!.


%% cwc is semidet.
%
% Cwc.
%
cwc:-true.

%% fwc is semidet.
%
% Fwc.
%
fwc:-true.

%% bwc is semidet.
%
% Bwc.
%
bwc:-true.

%% wac is semidet.
%
% Wac.
%
wac:-true.

%% is_fc_body( ?P) is semidet.
%
% If Is A Forward Chaining Body.
%
is_fc_body(P):-cwc, has_body_atom(fwc,P).

%% is_bc_body( ?P) is semidet.
%
% If Is A Backchaining Body.
%
is_bc_body(P):-cwc, has_body_atom(bwc,P).

%% is_action_body( ?P) is semidet.
%
% If Is A Action Body.
%
is_action_body(P):-cwc, has_body_atom(wac,P).



%% has_body_atom( ?WAC, ?P) is semidet.
%
% Has Body Atom.
%
has_body_atom(WAC,P):-cwc, call(
   WAC==P -> true ; (is_ftCompound(P),arg(1,P,E),has_body_atom(WAC,E))),!.

/*
has_body_atom(WAC,P,Rest):-cwc, call(WAC==P -> Rest = true ; (is_ftCompound(P),functor(P,F,A),is_atom_body_pfa(WAC,P,F,A,Rest))).
is_atom_body_pfa(WAC,P,F,2,Rest):-arg(1,P,E),E==WAC,arg(2,P,Rest),!.
is_atom_body_pfa(WAC,P,F,2,Rest):-arg(2,P,E),E==WAC,arg(1,P,Rest),!.
*/


:- thread_local(t_l:mpred_debug_local/0).

%% mpred_is_silient is det.
%
% If Is A Silient.
%
mpred_is_silient :- ( \+ t_l:mpred_debug_local, \+ mpred_is_tracing_exec, \+ mpred_is_tracing(_), current_prolog_flag(debug,false), is_release) ,!.


:- meta_predicate(show_if_debug(0)).
% show_if_debug(A):- !,show_call(why,A).

%% show_if_debug( :GoalA) is semidet.
%
% Show If Debug.
%
show_if_debug(A):- get_mpred_is_tracing(A) -> show_call(mpred_is_tracing,A) ; A.

% ======================= 
% user''s program''s database
% ======================= 
% assert_u(arity(prologHybrid,0)):-trace_or_throw(assert_u(arity(prologHybrid,0))).
% assert_u(X):- \+ (is_ftCompound(X)),!,asserta_u(X,X,0).


%% assert_u( ?X) is semidet.
%
% Assert For User Code.
%
assert_u(M:X):- !,functor(X,F,A),assert_u(M,X,F,A).
assert_u(X):- functor(X,F,A),assert_u(abox,X,F,A).


%% assert_u( ?M, ?X, ?F, ?VALUE4) is semidet.
%
% Assert For User Code.
%
assert_u(_M,X,F,_):- req(singleValuedInArg(F,SV)),!,must(update_single_valued_arg(X,SV)),!.
assert_u(_M,X,F,A):- req(prologSingleValued(F)),!,must(update_single_valued_arg(X,A)),!.
% assert_u(M,X,F,A):-must(isa(F,prologAssertAOrdered) -> asserta_u(M,X) ; assertz_u(M,X)).
% assert_u(M,X,F,A):-must(isa(F,prologOrdered)        -> assertz_u(M,X) ; asserta_u(M,X)).
assert_u(M,X,_,_):- assertz_mu(M,X).




%% check_never_assert( ?X) is semidet.
%
% Check Never Assert.
%
check_never_assert(X):- hotrace((( copy_term_and_varnames(X,Y),req(never_assert_u(Y,Why)),X=@=Y,trace_or_throw(never_assert_u(X,Why))))),fail.
check_never_assert(X):- hotrace(ignore(( copy_term_and_varnames(X,Y),req(never_assert_u(Y)),X=@=Y,trace_or_throw(never_assert_u(X))))).

%% check_never_retract( ?X) is semidet.
%
% Check Never Retract.
%
check_never_retract(X):- hotrace(ignore(( copy_term_and_varnames(X,Y),req(never_retract_u(Y,Why)),X=@=Y,trace_or_throw(never_retract_u(X,Why))))).



%% assertz_u( ?X) is semidet.
%
% Assertz For User Code.
%
assertz_u(M:X):-!,assertz_mu(M,X).
assertz_u(X):- assertz_mu(abox,X).


%% assertz_mu( ?M, ?X) is semidet.
%
% Assertz Module Unit.
%
assertz_mu(M,X):- correct_module(M,X,T),T\==M,!,assertz_mu(T,X).
assertz_mu(M,X):- check_never_assert(M:X), clause_asserted_i(M:X),!.
assertz_mu(M,X):- must((expire_tabled_list(M:X),show_call(attvar_op(assertz_if_new,M:X)))).



%% retract_u( :TermX) is semidet.
%
% Retract For User Code.
%
retract_u(X):- check_never_retract(X),fail.
%retract_u(~(X)):-must(is_ftNonvar(X)),!,retract_eq_quitely_f(~(X)),must((expire_tabled_list(~(X)))),must((expire_tabled_list((X)))).
%retract_u(basePFC:hs(X)):-!,retract_eq_quitely_f(basePFC:hs(X)),must((expire_tabled_list(~(X)))),must((expire_tabled_list((X)))).

retract_u(basePFC:qu(ABOX,X,Y)):-!,show_failure(why,retract_eq_quitely_f(basePFC:qu(ABOX,X,Y))),must((expire_tabled_list(~(X)))),must((expire_tabled_list((X)))).
retract_u(~(X)):-!,show_success(why,retract_eq_quitely_f(~(X))),must((expire_tabled_list(~(X)))),must((expire_tabled_list((X)))).
retract_u((X)):-!,show_success(why,retract_eq_quitely_f((X))),must((expire_tabled_list(~(X)))),must((expire_tabled_list((X)))).
retract_u(X):-show_if_debug(attvar_op(retract_eq,X)),!,must((expire_tabled_list(X))).


%% retractall_u( ?X) is semidet.
%
% Retractall For User Code.
%
retractall_u(X):-retractall(X),must((expire_tabled_list(X))).

%% clause_u( ?H, ?B) is semidet.
%
% Clause For User Code.
%
clause_u(H,B):- must(H\==true),catchv(clause_i(H,B),_,fail).

%% clause_u( ?H, ?B, ?Ref) is semidet.
%
% Clause For User Code.
%
clause_u(H,B,Ref):-must(H\==true),catchv(clause_i(H,B,Ref),_,fail).


%% mpred_update_literal( ?P, ?N, ?Q, ?R) is semidet.
%
% PFC Update Literal.
%
mpred_update_literal(P,N,Q,R):-
    arg(N,P,UPDATE),call(replace_arg(P,N,OLD,Q)),
    must(Q),update_value(OLD,UPDATE,NEW), 
    call(replace_arg(Q,N,NEW,R)).


%% update_single_valued_arg( ?P, ?N) is semidet.
%
% Update Single Valued Argument.
%
update_single_valued_arg(P,N):-
 must_det_l((
  get_user_abox_umt(ABOX),
  get_source_ref((U,U)),
  arg(N,P,UPDATE),
  replace_arg(P,N,OLD,Q),
  current_why(Why),
  get_user_abox(M), 
  M:get_source_ref1(U),
  must_det_l((
     attvar_op(assert_if_new,
     basePFC:spft(ABOX,P,U,U,Why)),
     (req(P)->true;(assertz_u(P))),
     doall((
          clause_i(Q,true,E),
          UPDATE \== OLD,
          erase_w_attvars(clause_i(Q,true,E),E),
          mpred_unfwc1(Q))))))).

% ======================= 
% prolog system database
% ======================= 
/*
assert_prologsys(X):- attvar_op(assert,X).
asserta_prologsys(X):- attvar_op(asserta,X).
assertz_prologsys(X):-attvar_op(assertz,X).

clause_prologsys(H,B):-clause_i(H,B).
clause_prologsys(H,B,Ref):-clause_i(H,B,Ref).
*/

%% call_prologsys( ?X) is semidet.
%
% Call Prologsys.
%
call_prologsys(X):-with_umt(X).
% ======================= 
% utils
% ======================= 

%% map_literals( ?P, ?G) is semidet.
%
% Map Literals.
%
map_literals(P,G):-map_literals(P,G,[]).


%% map_literals( ?VALUE1, :TermH, ?VALUE3) is semidet.
%
% Map Literals.
%
map_literals(_,H,_):-is_ftVar(H),!. % skip over it
map_literals(_,[],_) :- !.
map_literals(Pred,(H,T),S):-!, apply(Pred,[H|S]), map_literals(Pred,T,S).
map_literals(Pred,[H|T],S):-!, apply(Pred,[H|S]), map_literals(Pred,T,S).
map_literals(Pred,H,S):- mpred_literal(H),must(apply(Pred,[H|S])),!.
map_literals(_Pred,H,_S):- \+ is_ftCompound(H),!. % skip over it
map_literals(Pred,H,S):-H=..List,!,map_literals(Pred,List,S),!.



%% map_unless( :PRED1Test, ?Pred, ?H, ?S) is semidet.
%
% Map Unless.
%
map_unless(Test,Pred,H,S):- call(Test,H),ignore(apply(Pred,[H|S])),!.
map_unless(_Test,_,[],_) :- !.
map_unless(_Test,_Pred,H,_S):- \+ is_ftCompound(H),!. % skip over it
map_unless(Test,Pred,(H,T),S):-!, apply(Pred,[H|S]), map_unless(Test,Pred,T,S).
map_unless(Test,Pred,[H|T],S):-!, apply(Pred,[H|S]), map_unless(Test,Pred,T,S).
map_unless(Test,Pred,H,S):-H=..List,!,map_unless(Test,Pred,List,S),!.


%% map_first_arg( ?Pred, ?List) is semidet.
%
% PFC Maptree.
%
map_first_arg(Pred,List):-map_first_arg(Pred,List,[]).

%% map_first_arg( ?Pred, :TermH, ?S) is semidet.
%
% PFC Maptree.
%
map_first_arg(Pred,H,S):-is_ftVar(H),!,apply(Pred,[H|S]).
map_first_arg(_,[],_) :- !.
map_first_arg(Pred,(H,T),S):-!, map_first_arg(Pred,H,S), map_first_arg(Pred,T,S).
map_first_arg(Pred,(H;T),S):-!, map_first_arg(Pred,H,S) ; map_first_arg(Pred,T,S).
map_first_arg(Pred,[H|T],S):-!, apply(Pred,[H|S]), map_first_arg(Pred,T,S).
map_first_arg(Pred,H,S):-apply(Pred,[H|S]). 

% % :- use_module(logicmoo(util/rec_lambda)).

%example pfcVerifyMissing(mpred_isa(I,D), mpred_isa(I,C), ((mpred_isa(I,C), {D==C});-mpred_isa(I,C))). 
%example pfcVerifyMissing(mudColor(I,D), mudColor(I,C), ((mudColor(I,C), {D==C});-mudColor(I,C))). 


%% pfcVerifyMissing( ?GC, ?GO, ?GO) is semidet.
%
% Prolog Forward Chaining Verify Missing.
%
pfcVerifyMissing(GC, GO, ((GO, {D==C});\+ GO) ):-  GC=..[F,A|Args],append(Left,[D],Args),append(Left,[C],NewArgs),GO=..[F,A|NewArgs],!.

%example mpred_freeLastArg(mpred_isa(I,C),~(mpred_isa(I,C))):-is_ftNonvar(C),!.
%example mpred_freeLastArg(mpred_isa(I,C),(mpred_isa(I,F),C\=F)):-!.

%% mpred_freeLastArg( ?G, ?GG) is semidet.
%
% PFC Free Last Argument.
%
mpred_freeLastArg(G,GG):- G=..[F,A|Args],append(Left,[_],Args),append(Left,[_],NewArgs),GG=..[F,A|NewArgs],!.
mpred_freeLastArg(_G,false).


%% mpred_current_op_support( ?VALUE1) is semidet.
%
% PFC Current Oper. Support.
%
mpred_current_op_support((p,p)):-!.


%% pfcVersion( ?VALUE1) is semidet.
%
% Prolog Forward Chaining Version.
%
pfcVersion(6.6).



%% correctify_support( ?S, ?S) is semidet.
%
% Correctify Support.
%
correctify_support((S,T),(S,T)):-!.
correctify_support(U,(U,U)):-atom(U),!.
correctify_support([U],S):-correctify_support(U,S).

%=% initialization of global assertons

%= lmconf:mpred_init_i/1 initialized a global assertion.
%=  lmconf:mpred_init_i(P,Q) - if there is any fact unifying with P, then do
%=  nothing, else assert_db Q.


%% mpred_init_i( ?GeneralTerm, ?Default) is semidet.
%
% PFC Init For Internal Interface.
%
mpred_init_i(GeneralTerm,Default) :- ((
  clause_i(GeneralTerm,true) -> true ; assert_u(Default))).

%= basePFC:tms is one of {none,local,cycles} and controles the tms alg.
lmconf:module_local_init:- must((mpred_init_i(basePFC:tms(_), basePFC:tms(cycles)))).

% Pfc Search strategy. basePFC:sm(X) where X is one of {direct,depth,breadth}
lmconf:module_local_init:- mpred_init_i(basePFC:sm(_), basePFC:sm(direct)).

% aliases

/*
%% mpred_ain( ?G) is semidet.
%
% PFC Assert If New.
%
mpred_ain(G):-pfc_add(G).

%% mpred_ainz( ?G) is semidet.
%
% PFC Ainz.
%
mpred_ainz(G):-pfc_add(G).

%% mpred_aina( ?G) is semidet.
%
% PFC Aina.
%
mpred_aina(G):-pfc_add(G).


%% mpred_ain( ?G, ?S) is semidet.
%
% PFC Assert If New.
%
mpred_ain(G,S):- mpred_ain(G,S).

%% mpred_ainz( ?G, ?S) is semidet.
%
% PFC Ainz.
%
mpred_ainz(G,S):-mpred_ain(G,S).

%% mpred_aina( ?G, ?S) is semidet.
%
% PFC Aina.
%
mpred_aina(G,S):-mpred_ain(G,S).

%= mpred_ain/2 and mpred_post/2 are the main ways to assert_db new clauses into the
%= database and have forward reasoning done.

%= mpred_ain(P,S) asserts P into the user''s dataBase with support from S.

%% pfc_add( ?P) is semidet.
%
% Prolog Forward Chaining Add.
%
pfc_add(P) :- 
  old_ain_fast(P),mpred_run.


%% old_ain( ?P, ?S) is semidet.
%
% Assert If New.
%
old_ain(P,S) :- 
  old_ain_fast(P,S),mpred_run.



%% old_ain_fast( ?P0) is semidet.
%
% Assert If New Fast.
%
old_ain_fast('$si$':'$was_imported_kb_content$'(_, _)<-THIS):-is_ftNonvar(THIS),!.
old_ain_fast(P0):-
  must(get_source_ref(S)), old_ain_fast(P0,S).



%% old_ain_fast( ?P0, ?S) is semidet.
%
% Assert If New Fast.
%
old_ain_fast(nesc(P),S) :- nonvar(P),!,old_ain_fast(P,S).
old_ain_fast(P0,S):- gripe_time(23.6,old_ain_fast_timed(P0,S)).


%% old_ain_fast_timed( ?P0, ?S) is semidet.
%
% Assert If New Fast Timed.
%
old_ain_fast_timed(P0,S):- '$module'(user,user),'$set_source_module'(user,user),!,
  '$module'(WM,baseKB),'$set_source_module'(WS,baseKB),
   call_cleanup(old_ain_fast_timed(P0,S),('$module'(_,WM),'$set_source_module'(_,WS))).

old_ain_fast_timed(P000,S0):- check_context_module,
  unnumbervars(P000:S0,P00:S),
  strip_module(P00,_,P0),  
  must(to_addable_form_wte(assert,P0,P)),
      (is_list(P)
        ->must_maplist(old_ain_fast_sp(S),P);
       old_ain_fast_sp(S,P)).


% a really common example is people want unbound predicate backchaining .. that is to query the predicates witha  varaible where the predciate is 

%% old_ain_fast_sp( ?S, ?P0) is semidet.
%
% Assert If New Fast Sp.
%
old_ain_fast_sp(S,P0):- 
  strip_module(P0,_,P),
  ensure_vars_labled(P,P0),fully_expand(change(assert,add),P0,P1),old_ain_fast_sp0(S,P1).


% old_ain_fast_sp(S,P->Q) :-!,old_ain_fast_sp(S,P==>Q).

%% old_ain_fast_sp0( ?S, ?P) is semidet.
%
% Assert If New Fast Sp Primary Helper.
%
old_ain_fast_sp0(S,P) :-
   mpred_rule_hb(P,OutcomeO,_),!,
     loop_check_term(mpred_post_sp_zzz(S,P),
     aining(OutcomeO),
     (mpred_post_sp_zzz(S,P),mpred_trace_msg(looped_outcome((P))))),!.
%old_ain_fast_sp(_,_).
old_ain_fast_sp0(P,S) :- mpred_error("old_ain_fast(~p,~p) failed",[P,S]).
*/
/*
:-module_transparent(mpred_ain/1).
:-module_transparent(mpred_aina/1).
:-module_transparent(mpred_ainz/1).
:-module_transparent(logicmoo_util_database:mpred_ain/1).
:-module_transparent(logicmoo_util_database:aina/1).
:-module_transparent(logicmoo_util_database:ainz/1).
:-multifile(logicmoo_util_database:mpred_ain/1).
:-multifile(logicmoo_util_database:aina/1).
:-multifile(logicmoo_util_database:ainz/1).
:-asserta((logicmoo_util_database:ainz(G):- !, with_umt(mpred_ainz(G)))).
:-asserta((logicmoo_util_database:mpred_ain(G):- !, with_umt(mpred_ain(G)))).
:-asserta((logicmoo_util_database:aina(G):- !, with_umt(mpred_aina(G)))).

mpred_ain(G):- !, with_umt(mpred_ain(G)).
*/
/*
% mpred_post(+Ps,+S) tries to assert a fact or set of fact to the database.  For
% each fact (or the singelton) mpred_post1 is called. It always succeeds.


%% mpred_post( ?P, ?S) is semidet.
%
% PFC Post.
%
mpred_post([H|T],S) :-
  !,
  mpred_post1(H,S),
  mpred_post(T,S).
mpred_post([],_) :- !.
mpred_post(P,S) :-   
  mpred_post1(P,S).

% mpred_post1(+P,+S) tries to assert a fact to the database, and, if it succeeded,
% adds an entry to the pfc queue for subsequent forward chaining.
% It always succeeds.

%% mpred_post1( ?P0, ?S) is semidet.
%
% PFC Post Secondary Helper.
%
mpred_post1(mpred_ain(P0),S):- must(is_ftNonvar(P0)), !,mpred_ain(P0,S).
mpred_post1(P0,S):-
  to_addable_form_wte(assert,P0,P),
      (is_list(P)
        ->maplist(mpred_post_sp_zzz(S),P);
       mpred_post_sp_zzz(S,P)).


%% mpred_post_sp( ?S, ?P) is semidet.
%
% PFC Post Sp.
%
mpred_post_sp(S,P):- mpred_post_sp_zzz(S,P).



%% mpred_post_sp_zzz( ?S, ?P) is semidet.
%
% PFC Post Sp Zzz.
%
mpred_post_sp_zzz(S,P):- ground(S:P),!,mpred_post_sp_zzzz(S,P),!.
mpred_post_sp_zzz(S,P):- \+ is_main_thread,!,
   (hotrace(ensure_vars_labled(S:P,S0:P0))-> 
     mpred_post_sp_zzzz(S0,P0);mpred_post_sp_zzzz(S,P)),!.

mpred_post_sp_zzz(S,P):-  is_main_thread,!,
   (hotrace(ensure_vars_labled(S:P,S0:P0))-> 
     mpred_post_sp_zzzz(S0,P0);mpred_post_sp_zzzz(S,P)),!.

mpred_post_sp_zzz(S,P):- 
    hotrace(dcall_when(ensure_vars_labled,S:P,S0:P0)),!,
    mpred_post_sp_zzzz(S0,P0),!.

mpred_post_sp_zzz(S,P):-mpred_post_sp_zzzz(S,P),!.




%% mpred_post_sp_zzzz( ?S, ?P) is semidet.
%
% PFC Post Sp Zzzz.
%
mpred_post_sp_zzzz(S, Var):-is_ftVar(Var),!,trace_or_throw(var_mpred_post_sp_zzzz(S, Var)).
mpred_post_sp_zzzz(S,(P1,P2)) :- !,mpred_post_sp_zzzz(S,(P1)),mpred_post_sp_zzzz(S,(P2)).
mpred_post_sp_zzzz(S,[P1]) :- !,mpred_post_sp_zzzz(S,(P1)).
mpred_post_sp_zzzz(S,[P1|P2]) :- !,mpred_post_sp_zzzz(S,(P1)),mpred_post_sp_zzzz(S,(P2)).

mpred_post_sp_zzzz(S,NEG) :- fixed_negations(NEG,NEGO),!,mpred_post_sp_zzzz(S,NEGO).

mpred_post_sp_zzzz(S, \+ P) :- must(is_ftNonvar(P)),!, doall(mpred_remove(P,S)),!,mpred_undo((\+),P).
mpred_post_sp_zzzz(S, ~(P)) :- nonvar(P),doall(mpred_remove(P,S)),mpred_undo((\+),P),fail.

mpred_post_sp_zzzz(_S,P) :- once((notrace(mpred_is_tautology(P)),wdmsg(trace_or_throw(todo(error(mpred_is_tautology(P))))))),show_load_context,fail.

% only do loop check if it's already supported

mpred_post_sp_zzzz(S,P) :- is_ftCompound(P), arg(SV,P,V),is_relative(V),must((mpred_update_literal(P,SV,Q,R),mpred_post_sp_zzzz(S,R))),(Q=R->true;mpred_undo(update,Q)).
mpred_post_sp_zzzz(S,P) :- is_already_supported(P,S,_How),must(loop_check(mpred_post1_sp_0(S,P),mpred_post1_sp_1(S,P))),!. % ,mpred_enqueue(P,S).

mpred_post_sp_zzzz(S,~(P)) :-!, mpred_post1_sp_0(S,~(P)),!,assert_u(~(P)).

mpred_post_sp_zzzz(S,P) :- mpred_post1_sp_0(S,P).


%% mpred_post1_sp_0( ?S, ?P) is semidet.
%
% PFC post Secondary Helper sp  Primary Helper.
%
mpred_post1_sp_0(S,P) :-
  %= db old_ain_db_to_head(P,P2),
  % mpred_remove_old_version(P),
  must(once(old_ain_support(P,S))),
  mpred_post1_sp_1(S,P).


%% mpred_post1_sp_1( ?S, ?P) is semidet.
%
% PFC post Secondary Helper sp  Secondary Helper.
%
mpred_post1_sp_1(S,P):- P\==true,
  mpred_unique_u(P),
  must(import_to_user(P)),
  must(assert_u(P)),!,
  must(mpred_trace_add(P,S)),
  !,
  must(mpred_enqueue(P,S)),
  !.

mpred_post1_sp_1(_,_). % already added
mpred_post1_sp_1(S,P) :-  mpred_warn("mpred_post1(~p,~p) failed",[P,S]).
*/

%% with_mpred_trace_exec( ?P) is semidet.
%
% Using Managed Predicate  Trace exec.
%
with_mpred_trace_exec(P):- w_tl(t_l:mpred_debug_local,w_tl(mpred_is_tracing_exec, must(show_if_debug(P)))).

%% with_mpred_trace_exec( ?P) is semidet.
%
% Without Trace exec.
%
with_no_mpred_trace_exec(P):- wno_tl(t_l:mpred_debug_local,wno_tl(mpred_is_tracing_exec, must(show_if_debug(P)))).


%% mpred_test( ?P) is semidet.
%
% PFC Test.
%
mpred_test(_):- (compiling; current_prolog_flag(xref,true)),!.
mpred_test(P):- mpred_is_silient,!,sanity(req(P)),!.
mpred_test(P):- (show_call(with_mpred_trace_exec(req(P))) -> why_was_true(P) ; ((why_was_true( \+( P )),!,fail))).

why_was_true(P):- mpred_why(P),!.
why_was_true(P):- dmsg(justfied_true(P)),!.



%% clause_asserted_local( :TermABOX) is semidet.
%
% Clause Asserted Local.
%
clause_asserted_local(CL):- must(CL=basePFC:spft(ABOX,P,Fact,Trigger,UOldWhy)),!,
  clause_i(basePFC:spft(ABOX,P,Fact,Trigger,_OldWhy),true,Ref),
  clause_i(basePFC:spft(ABOX,UP,UFact,UTrigger,UOldWhy),true,Ref),
  (((UP=@=P,UFact=@=Fact,UTrigger=@=Trigger))).



%% is_already_supported( ?P, ?S, ?UU) is semidet.
%
% If Is A Already Supported.
%
is_already_supported(P,(S,T),(S,T)):- get_user_abox_umt(ABOX),clause_asserted_local(basePFC:spft(ABOX,P,S,T,_)),!.
is_already_supported(P,_S,UU):- get_user_abox_umt(ABOX),clause_asserted_local(basePFC:spft(ABOX,P,US,UT,_)),must(get_source_ref(UU)),UU=(US,UT).

% TOO UNSAFE 
% is_already_supported(P,_S):- copy_term_and_varnames(P,PC),sp ftY(PC,_,_),P=@=PC,!.



%% if_missing_mask( ?Q, ?R, ?Test) is semidet.
%
% If Missing Mask.
%
if_missing_mask(Q,R,Test):-
   which_missing_argnum(Q,N),
   if_missing_mask(Q,N,R,Test).


%% if_missing_mask( ?Q, ?N, ?R, ?Test) is semidet.
%
% If Missing Mask.
%
if_missing_mask(Q,N,R,Test):-
  arg(N,Q,Was),
  (nonvar(R)-> (which_missing_argnum(R,RN),arg(RN,R,NEW));replace_arg(Q,N,NEW,R)),!,
   Test=dif:dif(Was,NEW).

/*
Old version
if_missing_mask(Q,N,R,dif:dif(Was,NEW)):- 
 must((is_ftNonvar(Q),acyclic_term(Q),acyclic_term(R),functor(Q,F,A),functor(R,F,A))),
  (singleValuedInArg(F,N) -> 
    (arg(N,Q,Was),replace_arg(Q,N,NEW,R));
    ((arg(N,Q,Was),is_ftNonvar(Was)) -> replace_arg(Q,N,NEW,R);
        (N=A,arg(N,Q,Was),replace_arg(Q,N,NEW,R)))).
*/


%% which_missing_argnum( ?VALUE1, ?VALUE2) is semidet.
%
% Which Missing Argnum.
%
which_missing_argnum(Q,N):-
 must((acyclic_term(Q),is_ftCompound(Q),get_functor(Q,F,A))),
 F\=t,
  (singleValuedInArg(F,N) -> true;
    ((arg(N,Q,Was),is_ftNonvar(Was)) -> true; N=A)).

% was nothing  mpred_current_db/1.

%% mpred_current_db( ?U) is semidet.
%
% PFC Current Database.
%
mpred_current_db(U):-get_source_ref1(U).

%% mpred_current is semidet.
%
% PFC Current.
%
mpred_current.

/*
%=
%= old_ain_db_to_head(+P,-NewP) talkes a fact P or a conditioned fact
%= (P:-C) and adds the Db context.
%=


%% old_ain_db_to_head( ?P, ?NewP) is semidet.
%
% Assert If New Database Converted To Head.
%
old_ain_db_to_head(P,NewP) :-
  mpred_current_db(Db),
  (Db=true        -> NewP = P;
   P=(Head:-Body) -> NewP = (Head :- (Db,Body));
   otherwise      -> NewP = (P :- Db)).


% mpred_unique_u(X) is true if there is no assertion X in the prolog db.


%% mpred_unique_u( ?P) is semidet.
%
% PFC Unique For User Code.
%
mpred_unique_u((Head:-Tail)) :-
  !,
  \+ clause_u(Head,Tail).
mpred_unique_u(P) :-
  !,
  \+ clause_u(P,true).



%% mpred_unique_i( ?P) is semidet.
%
% PFC Unique For Internal Interface.
%
mpred_unique_i((Head:-Tail)) :-
  !,
  \+ clause_i(Head,Tail).
mpred_unique_i(P) :-
  !,
  \+ clause_i(P,true).

% mpred_enqueue(P,S) :- !,get_user_abox_umt(ABOX),ainz_i(basePFC:qu(ABOX,P,S),S).


%% mpred_enqueue(+P,+S) is det.
%
%  Enqueue P with support S
%
mpred_enqueue(P,S) :-
   (get_search_mode(Mode,P,S),get_user_abox_umt(ABOX))
    -> (Mode=direct  -> must(mpred_fwd(P,S)) ;
	Mode=depth   -> aina_i(basePFC:qu(ABOX,P,S),S) ;
	Mode=breadth -> ainz_i(basePFC:qu(ABOX,P,S),S) ;
	% else
          otherwise           -> mpred_warn("Unrecognized basePFC:sm mode: ~p", Mode))
     ; mpred_warn("No basePFC:sm mode").

get_search_mode(Mode,_P,_S):- t_l:mpred_search_mode(Mode),!.
get_search_mode(Mode,_P,_S):- Mode=direct,!.
get_search_mode(Mode,_P,_S):- Mode=breadth,!.
get_search_mode(Mode,_P,_S):- must(mreq(basePFC:sm(Mode))),!.


%% mpred_remove_old_version( :TermIdentifier) is semidet.
%
% if there is a rule of the form Identifier ::: Rule then delete it.
%
mpred_remove_old_version((Identifier::::Body)) :-
  % this should never happen.
  is_ftVar(identifier),
  !,
  mpred_warn("variable used as an  rule name in ~p :::: ~p",
          [Identifier,Body]).


mpred_remove_old_version((Identifier::::Body)) :-
  is_ftNonvar(Identifier),
  clause_u((Identifier::::OldBody),_),
  \+(Body=OldBody),
  mpred_withdraw((Identifier::::OldBody)),
  !.
mpred_remove_old_version(_).
*/

mpred_run_pause:- asserta(t_l:mpred_run_paused).
mpred_run_resume:- retractall(t_l:mpred_run_paused).

without_running(G):- (t_l:mpred_run_paused->G;w_tl(t_l:mpred_run_pause,G)).

/*
%% mpred_run is det.
%
% mpred_run computes the deductive closure of the current database.
% How this is done depends on the searching mode:
%    direct -  fc has already done the job.
%    depth or breadth - use the basePFC:qu mechanism.
%
mpred_run :- repeat, \+ mpred_step, !.

%mpred_run_queued:- repeat,sleep(1.0),mpred_run,fail.
%:-thread_property(_,alias(mpred_running_queue))-> true ; thread_create(mpred_run_queued,_,[alias(mpred_running_queue)]).


% mpred_step removes one entry from the basePFC:qu/2 and reasons from it.


%% mpred_step is semidet.
%
% PFC Step.
%
mpred_step :- t_l:mpred_run_paused,!,fail.
mpred_step :-
  % if basePFC:hs(Signal) is true, reset it and fail, thereby stopping inferencing.
  basePFC:hs(Signal),!,
  mpred_retract_db_type(basePFC:hs(Signal)),
  !,
  mpred_warn("Stopping on signal ~p",[Signal]),
  fail.
mpred_step :-
  % draw immediate conclusions from the next fact to be considered.
  % fails iff the queue is empty.
  get_next_fact(P,S) -> old_pfcl_do(mpred_fwd(P,S)),!.


%% get_next_fact( ?P, ?WS) is semidet.
%
% Get Next Fact.
%
get_next_fact(P,WS) :-
  %identifies the nect fact to fc from and removes it from the queue.
  select_next_fact(P,WS),
  remove_selection(P,WS).


%% remove_selection( ?P, ?S) is semidet.
%
% Remove Selection.
%
remove_selection(P,S) :-
 get_user_abox_umt(ABOX),
  clause(basePFC:qu(ABOX,P,S),B,Ref),must(B),erase(Ref),!.
remove_selection(P,S) :-
  old_brake(wdmsg("pfc:get_next_fact - selected fact not on Queue: ~p (~p)",
               [P,S])).


% select_next_fact(P) identifies the next fact to reason from.
% It tries the user defined predicate first and, failing that,
%  the mdefault mechanism.

%% select_next_fact( ?P, ?S) is semidet.
%
% Select Next Fact.
%
select_next_fact(P,S) :-
  req(mpred_select(P,S)),
  !.
select_next_fact(P,S) :-
  defaultmpred_select(P,S),
  !.

% the mdefault selection predicate takes the item at the froint of the queue.

%% defaultmpred_select( ?P, ?S) is semidet.
%
% Defaultmpred Select.
%
defaultmpred_select(P,S) :- get_user_abox_umt(ABOX),basePFC:qu(ABOX,P,S),!.

:- shared_multifile(basePFC:hs/1).

% mpred_halt stops the forward chaining.

%% mpred_halt is semidet.
%
% PFC Halt.
%
mpred_halt :-  mpred_halt("",[]).


%% mpred_halt( ?Format) is semidet.
%
% PFC Halt.
%
mpred_halt(Format) :- mpred_halt(Format,[]).


%% mpred_halt( ?Format, ?Args) is semidet.
%
% PFC Halt.
%
mpred_halt(Format,Args) :-
  sformat(S,Format,Args),
  !,
  in_cmt((wdmsg('-s',[S]))),
  (basePFC:hs(Signal) ->
       mpred_warn("mpred_halt finds basePFC:hs(Signal) already set to ~p",[Signal])
     ; assert_u(basePFC:hs(S))).


%=
%=
%= predicates for manipulating triggers
%=

%% old_ain_trigger( ?TriggerBody, ?Support) is semidet.
%
% Assert If New Trigger.
%
old_ain_trigger(TriggerBody,Support) :- mpred_had_support(TriggerBody,Support),!,mpred_trace_msg('Had Support',TriggerBody).

% old_ain_trigger(Trig,Support) :-  !,copy_term(Trig,TriggerBody), old_ain_trigger_0(Trig,TriggerBody,Support).

old_ain_trigger(Trig,Support) :-
   copy_term_and_varnames(Trig,Int), 
   loop_check_term(old_ain_trigger_1(Int,Trig,Support),here,nop((dmsg(old_ain_trigger_1(Int,Trig,Support))))).

% old_ain_trigger(_Trig,TriggerBody,Support) :- mpred_had_support(TriggerBody,Support),!,mpred_trace_msg('Had Support',TriggerBody).


%% old_ain_trigger_1( ?Trig, ?Trigger, ?Support) is semidet.
%
% Assert If New trigger  Secondary Helper.
%
old_ain_trigger_1(Trig,Trigger,Support) :- 
   old_ain_support(Trigger,Support), 
   (mpred_clause_i(Trigger)-> true ; 
      ((
        mpred_trace_msg('Adding For Later',Trigger),
        old_ain_trigger_0(Trig,Trigger,Support)))),!.



%% old_ain_trigger_0( ?Trig, :TermX, ?Support) is semidet.
%
% Assert If New trigger  Primary Helper.
%
old_ain_trigger_0(Trig,basePFC:pt(ABOX,Trigger,Body),Support) :- !,
  (clause_asserted_i(basePFC:pt(ABOX,Trigger,Body)) -> trace_or_throw(never_happens(clause_asserted_i(basePFC:pt(ABOX,Trigger,Body)))) ;   
     (( old_ain_ts(basePFC:pt(ABOX,Trigger,Body),Support),
        (must(mpred_mark_as(Support,p,Trigger,pfcPosTrigger))),
        add_reprop(Trig,Trigger)))).

old_ain_trigger_0(Trig,basePFC:pt(_ABOX,Trigger,_Body),Support) :-!,
   mpred_mark_as(Support,p,Trigger,pfcPosTrigger),
   add_reprop(Trig,Trigger).

old_ain_trigger_0(_Trig,basePFC:bt(ABOX,Trigger,Body),Support) :- 
 must((
   must(old_ain_ts(basePFC:bt(ABOX,Trigger,Body),Support)),
      attvar_op(assertz_if_new,((Trigger:-mpred_bc_only(Trigger)))),!,
      import_to_user(Trigger),
      must(mpred_mark_as(Support,p,Trigger,pfcBcTrigger)),
     % WAS mpred_bt_pt_combine(Trigger,Body).
   mpred_bt_pt_combine(Trigger,Body,Support))),!.


old_ain_trigger_0(_Trig,basePFC:bt(_ABOX,Trigger,Body),Support) :- !,
  import_to_user(Trigger),
  attvar_op(assertz_if_new,((Trigger:-mpred_bc_only(Trigger)))),!,
  must(mpred_mark_as(Support,p,Trigger,pfcBcTrigger)),
     % WAS mpred_bt_pt_combine(Trigger,Body).
  mpred_bt_pt_combine(Trigger,Body,Support).


old_ain_trigger_0(Trig,basePFC:nt(ABOX,Trigger,Test,Body),Support) :- !,
 get_user_abox_umt(ABOX),
  (must(mpred_mark_as(Support,n,Trigger,pfcNegTrigger)),
         copy_term_and_varnames(Trigger,TriggerCopy),!,
         old_ain_ts(basePFC:nt(ABOX,TriggerCopy,Test,Body),Support)),
  run_nt(ABOX,Trigger,TriggerCopy,Test,Body),
  nop(add_reprop(Trig, Trigger)).

old_ain_trigger_0(Trig,X,Support) :- mpred_warn("Unrecognized trigger to aintrigger: ~p for ~p",[old_ain_trigger(X,Support),Trig]).



%% run_nt( ?ABOX, ?Trigger, ?TriggerCopy, ?Test, ?Body) is semidet.
%
% Run Nt.
%
run_nt(ABOX,Trigger,TriggerCopy,Test,Body):-
   not_cond(old_ain_trigger,Test),
    (SupportLHS = ( \+ Trigger,  basePFC:nt(ABOX,TriggerCopy,Test,Body))),
     mpred_eval_lhs(Body,SupportLHS).


%% mpred_bt_pt_combine( ?Head, ?Body, ?Support) is semidet.
%
% PFC Bt Predicate Type Combine.
%
mpred_bt_pt_combine(Head,Body,Support) :-
 get_user_abox_umt(ABOX),
  %= a backward trigger (basePFC:bt) was just added with head and Body and support Support
  %= find any basePFC:pt''s with unifying heads and assert the instantied basePFC:bt body.
  mpred_get_trigger_quick(ABOX,basePFC:pt(ABOX,Head,_PtBody)),
  mpred_eval_lhs(Body,Support),
  fail.
mpred_bt_pt_combine(_,_,_) :- !.



%% mpred_get_trigger_quick( ?ABOX, ?Trigger) is semidet.
%
% PFC Get Trigger Incomplete, But Fast, Version.
%
mpred_get_trigger_quick(ABOX,Trigger) :- ignore(get_user_abox_umt(ABOX)), 
   (ABOX:clause_i(Trigger,true)*->true;clause_i(basePFC:spft(ABOX,Trigger,_,_,_),true)).

%=
%=
%= predicates for manipulating action traces.
%=


%% old_ain_actiontrace( ?Action, ?Support) is semidet.
%
% Assert If New Action Trace.
%
old_ain_actiontrace(Action,Support) :-
  % adds an action trace and it''s support.
  old_ain_support(mpred_action(Action),Support).


%% mpred_rem_actiontrace( ?VALUE1, :TermARG2) is semidet.
%
% PFC Remove/erase Action Trace.
%
mpred_rem_actiontrace(_,mpred_action(A)) :-
  mpred_do_and_undo_method(A,M),
  M,
  !.


%=
%= predicates to remove pfc facts, triggers, action traces, and queue items
%= from the database.
%=
%= was simply:  mpred_retract

%% mpred_retract_db_type( ?X) is semidet.
%
% PFC Retract Database Type.
%
mpred_retract_db_type(X) :-
  %= retract an arbitrary thing.
  mpred_db_type(X,Type),
  mpred_retract_db_type(Type,X),
  !.



%% mpred_retract_db_type( ?VALUE1, ?ABOX) is semidet.
%
% PFC Retract Database Type.
%
mpred_retract_db_type(_,basePFC:qu(ABOX,P,S)) :-
  doall(retract_u(basePFC:qu(ABOX,P,_))),
  ignore(mpred_unfwc(basePFC:qu(ABOX,P,S))).


mpred_retract_db_type(fact,X) :-
  %= db old_ain_db_to_head(X,X2), retract(X2).
  retract_u(X),
  ignore(mpred_unfwc(X)).

mpred_retract_db_type(rule,X) :-
  %= db  old_ain_db_to_head(X,X2),  retract(X2).
  retract_u(X).

mpred_retract_db_type(trigger,X) :-
  retract_t(X)
    -> mpred_unfwc(X)
     ; mpred_warn("Trigger not found to mpred_retract_db_type: ~p",[X]).

mpred_retract_db_type(action,X) :- mpred_rem_actiontrace(mpred_retract_db_type,X).

*/

/* UNUSED TODAY
%= old_ain_db_type(X) adds item X to some database
%= was simply:  mpred_Add
old_ain_db_type(X) :-
  % what type of X do we have?
  mpred_db_type(X,Type),
  % call the appropriate predicate.
  old_ain_db_type(Type,X).

old_ain_db_type(fact,X) :-
  mpred_unique_u(X),
  import_to_user(X),
  must(assert_u(X)),!.
old_ain_db_type(rule,X) :-
  mpred_unique_i(X),
  assert_u(X),!.
old_ain_db_type(trigger,X) :-
  assert_t(X).
old_ain_db_type(action,_Action) :- !.
*/
/*
%% each_in_list(+P2,+HT,+S) semidet.
%
% Call P(E,S). each Element in the list.
%
each_in_list(P,[H|T],S) :-
  % mpred_withdraw 
  call(P,H,S),
  each_in_list(P,T,S).

%% mpred_withdraw( ?List) is semidet.
%
% mpred_withdraw/1 is the user''s interface - it withdraws user support for P.
%
mpred_withdraw(P) :-
  make_uu_remove(UU),
  mpred_withdraw(P,UU).


%% mpred_withdraw( ?P, ?S) is semidet.
%
% Removes support S from P and checks to see if P is still supported.
% If it is not, then the fact is retracted from the database and any support
% relationships it participated in removed.
%
mpred_withdraw(List,S) :-
  % iterate down the list of facts to be mpred_withdraw'ed.
  is_ftNonvar(List),
  List=[_|_],!,
  each_in_list(mpred_withdraw,List,S).
mpred_withdraw(pfclog(P),S) :- nonvar(P),ignore((mpred_withdraw(P,S))), retract_eq_quitely(P),fail.
mpred_withdraw(P,S) :- 
 with_umt((copy_term_and_varnames(mpred_withdraw(P,S),Why),   
  mpred_support_db_rem(Why,P,S)
     -> (remove_if_unsupported(Why,P))
      ; mpred_warn("mpred_withdraw/2 Could not find support ~p to remove from fact ~p",
                [S,P]))).

%% mpred_remove( ?P) is semidet.
%
% Ensure it is unasserted
%
mpred_remove(P):- mpred_remove(P),mpred_unfwc(P).      
mpred_rem(P):- mpred_remove(P),mpred_unfwc(P).      


%% mpred_remove( ?P) is semidet.
%
% mpred_remove is like mpred_withdraw, but if P is still in the DB after removing the
% user''s support, it is retracted by more forceful means (e.g. remove).
%
mpred_remove(P) :- 
  % mpred_remove/1 is the user''s interface - it withdraws user support for P.
  make_uu_remove(UU),
  mpred_remove(P,UU).


%% mpred_remove( ?P, ?S) is semidet.
%
% mpred_remove is like mpred_withdraw, but if P is still in the DB after removing the
% S support, it is retracted by more forceful means (e.g. remove).
%
mpred_remove(List,S) :-
  % iterate down the list of facts to be mpred_withdraw'ed.
  is_ftNonvar(List),
  List=[_|_],!,
  each_in_list(mpred_remove,List,S).
mpred_remove(P,S) :- 
 with_umt((
  mpred_withdraw(P,S),
  % used to say mpred_call_only_facts(Why,P) but that meant it was 
  % was no_repeats(( mpred_call_with_triggers(P);mpred_call_with_no_triggers(Why,P)))
  (( mpred_call_only_facts(mpred_remove,P) )  
     -> (mpred_blast(P))
      ; true))).

% prev way
% mpred_remove(P):-!,mpred_remove(P).
% new way

%% mpred_blast( ?F) is semidet.
%
% retracts fact F from the DB and removes any dependent facts
%
mpred_blast(F) :-
 with_umt((
  show_if_debug(mpred_remove_supports(mpred_blast(F),F)),
  mpred_undo(mpred_blast(F),F))).

%% mpred_remove_supports( ?Why, ?F) is semidet.
%
% Will remove any remaining supports for fact F, complaining as it goes.
%
mpred_remove_supports(Why,F) :-
  mpred_support_db_rem(Why,F,S),
  (S=(z,z)->true;mpred_trace_msg("~p was supported by ~p",[F,S])),
  fail.
mpred_remove_supports(Why,F) :- fail,
  mpred_support_db_rem(Why,F,S),nonvar(S),
  (S=(z,z)->true;mpred_warn("WARN: ~p was still supported by ~p",[F,S])),
  fail.
mpred_remove_supports(_,_).


%% mpred_remove_supports_quietly( ?F) is semidet.
%
% Will remove any remaining supports for fact F, uncomplainingly
%
mpred_remove_supports_quietly(F) :-
  mpred_support_db_rem(mpred_remove_supports_quietly,F,_),
  fail.
mpred_remove_supports_quietly(_).

% mpred_undo(Why,X) undoes X.

%% mpred_undo( ?Why, :TermFact) is semidet.
%
% Undose any resulting deductions
%
mpred_undo(Why,mpred_action(A)) :-
  % undo an action by finding a method and successfully executing it.
  !,
  mpred_rem_actiontrace(Why,mpred_action(A)).

mpred_undo(Why,basePFC:pk(ABOX,Key,Head,Body)) :-
  % undo a positive trigger.
  %
  !,
  (retract_i(basePFC:pk(ABOX,Key,Head,Body))
    -> mpred_unfwc(basePFC:pt(ABOX,Head,Body))
     ; mpred_warn("for ~p \nTrigger not found to retract basePFC:pk= ~p: ~p",[Why,Key,basePFC:pt(ABOX,Head,Body)])).

mpred_undo(Why,basePFC:pt(ABOX,Head,Body)) :- 
  % undo a positive trigger.
  %
  !,
  (retract_i(basePFC:pt(ABOX,Head,Body))
    -> mpred_unfwc(basePFC:pt(ABOX,Head,Body))
     ; mpred_warn("for ~p:\nTrigger not found to retract: ~p",[Why,basePFC:pt(ABOX,Head,Body)])).


mpred_undo(Why,basePFC:bt(ABOX,Head,Body)) :- 
  % undo a backchaining trigger.
  %
  !,
  dtrace(attvar_op(retractall,(Head:-mpred_bc_only(Head)))),
  (retract_i(basePFC:bt(ABOX,Head,Body))
    -> mpred_unfwc(basePFC:bt(ABOX,Head,Body))
     ; mpred_warn("for ~p:\nTrigger not found to retract: ~p",[Why,basePFC:bt(ABOX,Head,Body)])).


mpred_undo(Why,basePFC:nt(ABOX,Head,Condition,Body)) :-
  % undo a negative trigger.
  !,
  (retract_i(basePFC:nt(ABOX,Head,Condition,Body))
    -> true
     ; mpred_trace_msg("for ~p:\nTrigger not found to retract: ~p",[Why,basePFC:nt(ABOX,Head,Condition,Body)])),
  mpred_unfwc(basePFC:nt(ABOX,Head,Condition,Body)).

mpred_undo(Why,( \+ ~Fact)):- mpred_undo(Why, Fact),fail.
mpred_undo(Why,   ~(~Fact)):- mpred_undo(Why, Fact),fail.

mpred_undo(Why,Fact):- mpred_undo_u(Why,Fact)*->true;mpred_undo_e(Why,Fact).

%% mpred_undo_u( ?Why, ?Fact) is semidet.
%
% PFC Undo For User Code.
%
mpred_undo_u(Why,Fact) :-
  % undo a random fact, printing out the trace, if relevant.
  retract_u(Fact),
     must(mpred_trace_rem(Why,Fact)),
     mpred_unfwc1(Fact).


%% mpred_undo_e( ?Why, ?Fact) is semidet.
%
% PFC Undo E.
%
mpred_undo_e(Why,Fact) :- 
    % (Fact\= ~(_)->cnotrace(mpred_trace_msg("mpred_undo_e ; Fact not found in user db: ~p",[Fact]));true),
     (Fact\= ~(_)->mpred_trace_rem(Why,Fact);true),
     mpred_unfwc(Fact).

%% mpred_unfwc(+Fact) is semidet.
%
% mpred_unfwc(Fact) "un-forward-chains" from fact Fact.  That is, fact Fact has just
% been removed from the database, so remove all support relations it
% participates in and check the things that they support to see if they
% should stay in the database or should also be removed.
%
mpred_unfwc(UnFact) :-   
  strip_module(UnFact,_,Fact),
  mpred_retract_support_relations(why(mpred_unfwc(Fact)),Fact),
  mpred_unfwc1(Fact).
  


%% mpred_unfwc1( ?F) is semidet.
%
% PFC Unfwc Secondary Helper.
%
mpred_unfwc1(F) :-
  mpred_unfwc_check_triggers(_Sup,F),
  % is this really the right place for mpred_run<?
  mpred_run.


%% mpred_unfwc_check_triggers( ?Sup, ?Clause) is semidet.
%
% PFC Unfwc Check Triggers.
%
mpred_unfwc_check_triggers(_Sup,Clause) :- 
 strip_module(Clause,_,F),
  mpred_db_type(F,fact),
  copy_term_and_varnames(F,Fcopy),
  mpred_get_trigger_quick(ABOX,basePFC:nt(ABOX,Fcopy,Condition,Action)),
  (not_cond(basePFC:nt,Condition)),
  G = mpred_eval_lhs(Action,((\+F),basePFC:nt(ABOX,F,Condition,Action))),
  loop_check(G,mpred_trace_msg(unfwc_caught_loop(G))),
  fail.
mpred_unfwc_check_triggers(_Sup,_).


%% mpred_retract_support_relations( ?Why, ?Fact) is semidet.
%
% PFC Retract Support Relations.
%
mpred_retract_support_relations(Why,Fact) :-
  mpred_db_type(Fact,Type),
  (Type=trigger -> mpred_support_db_rem(Why,P,(_,Fact)) ;
    % non trigger
    mpred_support_db_rem(Why,P,(Fact,_))),
  remove_if_unsupported(Why,P),
  fail.
mpred_retract_support_relations(_,_).

%= remove_if_unsupported(Why,+P) checks to see if P is supported and removes
%= it from the DB if it is not.

*/
/*
%% remove_if_unsupported_verbose( ?Why, ?TMS, ?P) is semidet.
%
% Remove If Unsupported While Being Descriptive.
%
remove_if_unsupported_verbose(Why,TMS,P) :- is_ftVar(P),!,trace_or_throw(warn(var_remove_if_unsupported_verbose(Why,TMS,P))).
remove_if_unsupported_verbose(Why,TMS,P) :- 
   (((mpred_tms_supported(TMS,P,How),How\=unknown(_)) -> mpred_trace_msg(v_still_supported(How,Why,TMS,P)) ; ( mpred_undo(Why,P)))).
   % mpred_run.
*/

mpred_remove_file_support(_File):- !.
mpred_remove_file_support(File):- 
  forall(filematch(File,Match),
      forall(basePFC:spft(ABOX, W, U, U, Match),forall(retract_i(basePFC:spft(ABOX, W, U, U, Match)),mpred_remove(W)))).
/*

%% remove_if_unsupported( ?Why, ?P) is semidet.
%
% Remove If Unsupported.
%
remove_if_unsupported(Why,P) :- is_ftVar(P),!,trace_or_throw(warn(var_remove_if_unsupported(Why,P))).
remove_if_unsupported(Why,P) :- ((\+ ground(P), P \= (_:-_) , P \= ~(_) ) -> mpred_trace_msg(warn(nonground_remove_if_unsupported(Why,P))) ;true),
   (((mpred_tms_supported(local,P,How),How\=unknown(_)) -> mpred_trace_msg(still_supported(How,Why,local,P)) ; (  mpred_undo(Why,P)))),!.
   % mpred_run.

*/

%= mpred_tms_supported(+P,-How) succeeds if P is "supported". What "How" means
%= depends on the TMS mode selected.


%% mpred_tms_supported( ?P, ?How) is semidet.
%
% PFC Truth Maintainence/wff Supported.
%
mpred_tms_supported(P,How) :-
  basePFC:tms(Mode),
  mpred_tms_supported0(Mode,P,How).



%% mpred_tms_supported( ?Mode, ?P, ?How) is semidet.
%
% PFC Truth Maintainence/wff Supported.
%
mpred_tms_supported(Mode,P,How) :- is_ftVar(Mode),basePFC:tms(Mode),!,mpred_tms_supported0(Mode,P,How).
mpred_tms_supported(Mode,P,How) :- mpred_tms_supported0(Mode,P,How).
mpred_tms_supported(How,_P,unknown(How)).


%% mpred_tms_supported0( ?UPARAM1, ?P, ?How) is semidet.
%
% PFC Truth Maintainence/wff Supported Primary Helper.
%
mpred_tms_supported0(local,P,How) :-  mpred_get_support(P,How). % ,sanity(mpred_deep_support(How,S)).
mpred_tms_supported0(cycles,P,How) :-  well_founded(P,How).
mpred_tms_supported0(deep,P,How) :- mpred_deep_support(How,P).

% lmconf:hook_one_minute_timer_tick:- statistics.



%% mpred_scan_tms( ?P) is semidet.
%
% PFC Scan Truth Maintainence/wff.
%
mpred_scan_tms(P):-mpred_get_support(P,(S,SS)),
  (S==SS-> true;
   once((mpred_deep_support(_How,P)->true;
     (mpred_trace_msg(warn(now_maybe_unsupported(mpred_get_support(P,(S,SS)),fail))))))).


%% user_atom( ?U) is semidet.
%
% User Atom.
%
user_atom(U):-match_source_ref1(U).
user_atom(g).
user_atom(m).
user_atom(d).


%% mpred_deep_support( ?How, ?M) is semidet.
%
% PFC Deep Support.
%
mpred_deep_support(_How,unbound):-!,fail.
mpred_deep_support(How,M):-loop_check(mpred_deep_support0(How,M),fail).


%% mpred_deep_support0( ?U, ?U) is semidet.
%
% PFC Deep Support Primary Helper.
%
mpred_deep_support0(user_atom(U),(U,U)):-user_atom(U),!.
mpred_deep_support0(How,(A==>_)):-!,mpred_deep_support(How,A).
mpred_deep_support0(basePFC:pt(ABOX,HowA,HowB),basePFC:pt(ABOX,A,B)):-!,mpred_deep_support(HowA,A),mpred_deep_support(HowB,B).
mpred_deep_support0(HowA->HowB,(A->B)):-!,mpred_deep_support(HowA,A),mpred_deep_support(HowB,B).
mpred_deep_support0(HowA/HowB,(A/B)):-!,mpred_deep_support(HowA,A),mpred_deep_support(HowB,B).
mpred_deep_support0((HowA,HowB),(A,B)):-!,mpred_deep_support(HowA,A),mpred_deep_support(HowB,B).
mpred_deep_support0(How,rhs(P)):-!,maplist(mpred_deep_support,How,P).
mpred_deep_support0(mpred_call_only_facts(\+ P),\+ call_u(P)):-!,mpred_call_only_facts(\+ P).
mpred_deep_support0(mpred_call_only_facts(P),call_u(P)):-!,mpred_call_only_facts(P).
mpred_deep_support0(mpred_call_only_facts(P),{P}):-!,mpred_call_only_facts(P).
mpred_deep_support0(S==>How,P):-mpred_get_support(P,S),mpred_deep_support(How,S),!.
mpred_deep_support0(mpred_call_only_facts(\+(P)),\+(P)):-!, mpred_call_only_facts(\+(P)).
mpred_deep_support0(user_atom(P),P):-user_atom(P),!.
mpred_deep_support0(mpred_call_only_facts((P)),P):-mpred_call_only_facts(P).


%=
%= a fact is well founded if it is supported by the user
%= or by a set of facts and a rules, all of which are well founded.
%=


%% well_founded( ?Fact, ?How) is semidet.
%
% Well Founded.
%
well_founded(Fact,How) :- mpred_wff(Fact,[],How).


%% mpred_wff( ?F, ?VALUE2, :TermHow) is semidet.
%
% PFC Well-formed Formula.
%
mpred_wff(F,_,How) :-
  % supported by user (mpred_axiom) or an "absent" fact (mpred_assumption).
  ((mpred_axiom(F),How =mpred_axiom(F) ); (mpred_assumption(F),How=mpred_assumption(F))),
  !.

mpred_wff(F,Descendants,wff(Supporters)) :-
  % first make sure we aren''t in a loop.
  (\+ memberchk(F,Descendants)),
  % find a justification.
  supporters_list(F,Supporters),
  % all of whose members are well founded.
  mpred_wfflist(Supporters,[F|Descendants]),
  !.

%= mpred_wfflist(L) simply maps mpred_wff over the list.

%% mpred_wfflist( :TermX, ?L) is semidet.
%
% PFC Wfflist.
%
mpred_wfflist([],_).
mpred_wfflist([X|Rest],L) :-
  mpred_wff(X,L,_How),
  mpred_wfflist(Rest,L).

/*

% supporters_list(+F,-ListofSupporters) where ListOfSupports is a list of the
% supports for one justification for fact F -- i.e. a list of facts which,
% together allow one to deduce F.  One of the facts will typically be a rule.
% The supports for a user-defined fact are: [u].


%% supporters_list( ?F, :TermFact) is semidet.
%
% Supports Functor (list Version).
%
supporters_list(F,[Fact|MoreFacts]) :-
  mpred_get_support_precanonical_plus_more(F,(Fact,Trigger)),
  must(trigger_supporters_list(Trigger,MoreFacts)).
*/

%% mpred_get_support_precanonical_plus_more( ?P, ?Sup) is semidet.
%
% PFC Get Support Precanonical Plus More.
%
mpred_get_support_precanonical_plus_more(P,Sup):-mpred_get_support_one(P,Sup)*->true;
  ((to_addable_form_wte(mpred_get_support_precanonical_plus_more,P,PE),!,
    P\=@=PE,mpred_get_support_one(PE,Sup))).

%% mpred_get_support_one( ?P, ?Sup) is semidet.
%
% PFC Get Support One.
%
mpred_get_support_one(P,Sup):- mpred_get_support(P,Sup)*->true;
  (mpred_get_support_via_clause_db(P,Sup)*->true;
     mpred_get_support_via_sentence(P,Sup)).


%% mpred_get_support_via_sentence( ?Var, ?VALUE2) is semidet.
%
% PFC Get Support Via Sentence.
%
mpred_get_support_via_sentence(Var,_):-is_ftVar(Var),!,fail.
mpred_get_support_via_sentence((A,B),(FC,TC)):-!, mpred_get_support_precanonical_plus_more(A,(FA,TA)),mpred_get_support_precanonical_plus_more(B,(FB,TB)),conjoin(FA,FB,FC),conjoin(TA,TB,TC).
mpred_get_support_via_sentence(true,g):-!.
mpred_get_support_via_sentence(G,req(G)):- req(G).



%% mpred_get_support_via_clause_db( :TermP, ?OUT) is semidet.
%
% PFC Get Support Via Clause Database.
%
mpred_get_support_via_clause_db(\+ P,OUT):- mpred_get_support_via_clause_db(~(P),OUT).
mpred_get_support_via_clause_db(\+ P,(naf(g),g)):- !, predicate_property(P,number_of_clauses(_)),\+ clause(P,_Body).
mpred_get_support_via_clause_db(P,OUT):- predicate_property(P,number_of_clauses(N)),N>0,
   clause_i(P,Body),(Body==true->Sup=(g);
    (support_ok_via_clause_body(P),mpred_get_support_precanonical_plus_more(Body,Sup))),
   OUT=(Sup,g).



%% support_ok_via_clause_body( ?H) is semidet.
%
% Support Ok Via Clause Body.
%
support_ok_via_clause_body(_H):-!,fail.
support_ok_via_clause_body(H):- get_functor(H,F,A),support_ok_via_clause_body(H,F,A).


%% support_ok_via_clause_body( ?VALUE1, ?F, ?VALUE3) is semidet.
%
% Support Ok Via Clause Body.
%
support_ok_via_clause_body(_,(\+),1):-!,fail.
support_ok_via_clause_body(_,F,_):- req(argsQuoted(F)),!,fail.
support_ok_via_clause_body(H,F,A):- should_call_for_facts(H,F,A).




%% mpred_get_support_precanonical( ?F, ?Sup) is semidet.
%
% PFC Get Support Precanonical.
%
mpred_get_support_precanonical(F,Sup):-to_addable_form_wte(mpred_get_support_precanonical,F,P),mpred_get_support(P,Sup).

%% spft_precanonical( ?F, ?SF, ?ST) is semidet.
%
% Spft Precanonical.
%
spft_precanonical(F,SF,ST):- to_addable_form_wte(spft_precanonical,F,P),!,get_user_abox_umt(ABOX),basePFC:spft(ABOX,P,SF,ST,_).


%% trigger_supporters_list( ?U, :TermARG2) is semidet.
%
% Trigger Supports Functor (list Version).
%
trigger_supporters_list(U,[]) :- match_source_ref1(U),!.
trigger_supporters_list(U,[]) :- atom(U),!.

trigger_supporters_list(Trigger,[Fact|MoreFacts]) :-
  mpred_get_support_precanonical_plus_more(Trigger,(Fact,AnotherTrigger)),
  must(trigger_supporters_list(AnotherTrigger,MoreFacts)).

/*
%=
%=
%= mpred_fwd(X) forward chains from a fact or a list of facts X.
%=
% mpred_fwd(+P) forward chains for a multiple facts.


%% mpred_fwd( ?P) is semidet.
%
% PFC Forward Repropigated.
%
mpred_fwd(P):- get_source_ref(UU), mpred_fwd(P,UU).

%% mpred_fwd( ?P, ?S) is semidet.
%
% PFC Forward Repropigated.
%
mpred_fwd([H|T],S) :- !, mpred_fwd1(H,S), mpred_fwd(T,S).
mpred_fwd([],_) :- !.
mpred_fwd(P,S) :- copy_term(P:S,P0:S0),mpred_fwd1(P0,S0),!.

%=
% mpred_fwd1(+P) forward chains for a single fact.

%% mpred_fwd1( ?Fact, ?Sup) is semidet.
%
% PFC Forward Repropigated Secondary Helper.
%
mpred_fwd1(Fact,Sup) :- gripe_time(24.80,mpred_fwd2(Fact,Sup)),!.


unnumbervars_equals(A,B):- =(A,BO),!,BO=B.
% unnumbervars_equals(A,B):-unnumbervars(A,B).

%% mpred_fwd2( ?Fact, ?Sup) is semidet.
%
% PFC Forward Repropigated Extended Helper.
%
mpred_fwd2(Fact,Sup) :- fixed_negations(Fact,M),!,mpred_fwd2(M,Sup).
mpred_fwd2(Fact,Sup) :- cyclic_term(Fact;Sup),writeq(mpred_fwd2_cyclic_term(Fact;Sup)),!,trace_or_throw(mpred_fwd2_cyclic_term(Fact;Sup)).
mpred_fwd2(Fact0,_Sup):-
  once(must(old_ain_rule_if_rule(Fact0))),
  unnumbervars_equals(Fact0,Fact),  
  copy_term(Fact,F),
  % check positive triggers
  once(must(old_fcpt(Fact,F))),
  % check negative triggers
  once(must(old_fcnt(Fact,F))).


%=
%= old_ain_rule_if_rule(P) does some special, built in forward chaining if P is
%= a rule.
%=

% old_ain_rule_if_rule(Fact) :- cyclic_break(Fact),is_mpred_action(Fact),(ground(Fact)->must(once(Fact));doall(show_if_debug(must(Fact)))),fail.
% old_ain_rule_if_rule(Fact) :- cyclic_break(Fact),is_mpred_action(Fact),(ground(Fact)->must(once(Fact));doall(show_if_debug(must(Fact)))),!.

%% old_ain_rule_if_rule( ?Fact) is semidet.
%
% Assert If New Rule If Rule.
%
old_ain_rule_if_rule(Fact) :- fixed_negations(Fact,M),!,old_ain_rule_if_rule(M).
old_ain_rule_if_rule(Fact) :- cyclic_break(Fact),is_mpred_action(Fact),
    doall(show_if_debug(with_umt(req(Fact)))),!.
old_ain_rule_if_rule(Fact):- must(old_ain_rule0(Fact)),!.


%% old_ain_rule0( :TermP) is semidet.
%
% Assert If New Rule Primary Helper.
%
old_ain_rule0((P==>Q)) :-
  !,
  old_process_rule(P,Q,(P==>Q)).

old_ain_rule0((Name::::P==>Q)) :-
  !,
  old_process_rule(P,Q,(Name::::P==>Q)).

old_ain_rule0((P<==>Q)) :-
  !,
  old_process_rule(P,Q,(P<==>Q)),
  old_process_rule(Q,P,(P<==>Q)).

old_ain_rule0((Name::::P<==>Q)) :-
  !,
  old_process_rule(P,Q,((Name::::P<==>Q))),
  old_process_rule(Q,P,((Name::::P<==>Q))).

old_ain_rule0(('<-'(P,Q))) :-
  !,
  mpred_define_bc_rule(P,Q,('<-'(P,Q))).

old_ain_rule0(_).


%% old_fcpt( ?Fact, ?F) is semidet.
%
% Fcpt.
%
old_fcpt(Fact,F):- old_fcpt0(Fact,F)*->fail;nop(mpred_trace_msg(no_pt(Fact,F))).
old_fcpt(_,_).


%% old_fcpt0( ?Fact, ?F) is semidet.
%
% Fcpt Primary Helper.
%
old_fcpt0(Fact,F) :- 
  mpred_get_trigger_quick(ABOX,basePFC:pt(ABOX,F,Body)),
  (mpred_eval_lhs(Body,(Fact,basePFC:pt(ABOX,F,Body)))
    *-> mpred_trace_msg('Using',basePFC:pt(ABOX,F,Body));
      (mpred_trace_msg('Skipped',basePFC:pt(ABOX,F,Body)),fail)).
  

old_fcpt0(Fact,F) :- use_presently,
  mpred_get_trigger_quick(ABOX,basePFC:pt(ABOX,presently(F),Body)),
  pp_item('Found presently ',basePFC:pt(ABOX,F,Body)),
  mpred_eval_lhs(Body,(presently(Fact),basePFC:pt(ABOX,presently(F),Body))).


%% old_fcnt( ?Fact, ?F) is semidet.
%
% Fcnt.
%
old_fcnt(Fact,F):- old_fcnt0(Fact,F)*->fail;nop(mpred_trace_msg(no_spft_nt(Fact,F))).
old_fcnt(_,_).


%% old_fcnt0( ?Fact, ?F) is semidet.
%
% Fcnt Primary Helper.
%
old_fcnt0(_Fact,F) :- 
  mpred_get_trigger_quick(ABOX,basePFC:nt(ABOX,F,Condition,Body)),
  basePFC:spft(ABOX,REMOVE,GU,basePFC:nt(ABOX,F,Condition,Body),_Why),
   (call_u(Condition) *-> 
   (mpred_trace_msg('Using ~'(REMOVE),basePFC:nt(ABOX,F,Condition,Body)),
      mpred_withdraw(REMOVE,(GU,basePFC:nt(ABOX,F,Condition,Body))),fail);
      (mpred_trace_msg('Skipped ~'(REMOVE),basePFC:nt(ABOX,F,Condition,Body)),fail)).

%=
%= mpred_define_bc_rule(+Head,+Body,+Parent_rule) - defines a backward
%= chaining rule and adds the corresponding basePFC:bt triggers to the database.
%=


%% mpred_define_bc_rule( ?Head, ?Body, ?Parent_rule) is semidet.
%
% PFC Define Backchaining Rule.
%
mpred_define_bc_rule(Head,Body,Parent_rule) :-
  (\+ mpred_literal(Head)),
  mpred_warn("Malformed backward chaining rule.  ~p not atomic.",[(Head:-Body)]),
  mpred_warn("rule: ~p",[Parent_rule]),
 % !,
  dtrace(mpred_define_bc_rule(Head,Body,Parent_rule)),
  fail.

mpred_define_bc_rule(Head,Body,Parent_rule) :- 
 get_user_abox_umt(ABOX),
  (copy_term_and_varnames(Parent_rule,Parent_ruleCopy),
  attvar_op(assert_if_new,(Head:-mpred_bc_only(Head))),
  must(import_to_user(Head)),
  build_rhs(Head,Head,Rhs),
  old_foreachl_do(mpred_nf(Body,Lhs),
       (build_trigger(Parent_ruleCopy,Lhs,rhs(Rhs),Trigger),
       % can be mpred_post_sp(basePFC:bt(ABOX,Head,Trigger),(Parent_ruleCopy,U))
         ((get_source_ref1(U),old_ain_fast(basePFC:bt(ABOX,Head,Trigger),(Parent_ruleCopy,U))))))).
        
*/
/*

%=
%=
%= eval something on the LHS of a rule.
%=
%mpred_eval_lhs(P,S):- contains_ftVar(P),unnumbervars_equals(mpred_eval_lhs(P,S),mpred_eval_lhs(P0,S0)),P\=@=P0,!,mpred_eval_lhs(P0,S0).
%mpred_eval_lhs(P,S):- contains_ftVar(P),trace_or_throw(contains_ftVar_mpred_eval_lhs(P,S)).

%% mpred_eval_lhs( ?P, ?S) is semidet.
%
% PFC Eval Left-hand-side.
%
mpred_eval_lhs(P,S):-
  unnumbervars_equals(+(P,S),+(P0,S0)),
    mpred_eval_lhs0(P0,S0).


%% mpred_eval_lhs0( ?X, ?Support) is semidet.
%
% PFC Eval Left-hand-side Primary Helper.
%
mpred_eval_lhs0((Test->Body),Support) :-
  !,
  % (call_prologsys(Test) -> mpred_eval_lhs(Body,Support)),
   ((no_repeats(call_prologsys(Test)) , 
       (mpred_eval_lhs(Body,Support))) *-> true ; (!,fail)).

mpred_eval_lhs0(rhs(X),Support) :-
   cyclic_break(X),
  !,
  on_x_rtrace(mpred_eval_rhs_0(+,X,Support)),
  !.

mpred_eval_lhs0(X,Support) :-
  is_ftCompound(X),
  cyclic_break((X)),  
  mpred_db_type(X,trigger),
  !,
  doall(show_call(old_ain_trigger(X,Support))),
  !.

%mpred_eval_lhs0(snip(X),Support) :-
%  snip(Support),
%  mpred_eval_lhs(X,Support).

mpred_eval_lhs0(X,Why) :-
  mpred_warn("Unrecognized item found in trigger body, namely ~p.",[mpred_eval_lhs0(X,Why)]),!.

%=
%= eval something on the RHS of a rule.
%=


%% mpred_eval_rhs_0( ?DIR, :TermARG2, ?VALUE3) is semidet.
%
% PFC eval Right-Hand-Side  Primary Helper.
%
mpred_eval_rhs_0(_DIR,[],_) :- !.
mpred_eval_rhs_0(DIR,[Head|Tail],Support) :-
  mpred_eval_rhs1(DIR,Head,Support),
  mpred_eval_rhs_0(DIR,Tail,Support).



%% mpred_eval_rhs1( +DIR, ?X, ?Support) is semidet.
%
% PFC Eval Right-hand-side Secondary Helper.
%
mpred_eval_rhs1(+,{Action},Support) :-
 % evaluable Prolog code.
 !,
 old_fc_eval_action(Action,Support).

mpred_eval_rhs1(+,mpred_action(Action),Support) :-
 % evaluable Prolog code.
 !,
 old_fc_eval_action(Action,Support).

mpred_eval_rhs1(+,P,_Support) :-
 % predicate to remove.
 mpred_negation(P,N),
 !,
 doall(mpred_withdraw(N)),!.

mpred_eval_rhs1(DIR,[X|Xrest],Support) :-
 % embedded sublist.
 !,
 mpred_eval_rhs_0(DIR,[X|Xrest],Support).

mpred_eval_rhs1(+,added(Assertion),Support) :-
 % an assertion to be added.
 mpred_ain(Assertion,Support),!.

mpred_eval_rhs1(+,Assertion,Support) :-
 % an assertion to be added.
 mpred_post1(Assertion,Support),!.

mpred_eval_rhs1(DIR,X,_) :-
  mpred_warn("Malformed rhs of a rule: ~p",[DIR:X]).


%=
%= evaluate an action found on the rhs of a rule.
%=


%% old_fc_eval_action( ?Action, ?Support) is semidet.
%
% Forward Chaining Eval Action.
%
old_fc_eval_action(Action,Support) :-
  call_prologsys(Action),
  (undoable(Action)
     -> old_ain_actiontrace(Action,Support)
      ; true).
*/

%=
%=
%=
/*
trigger_trigger(Trigger,Body,_Support) :-
 trigger_trigger1(Trigger,Body).
trigger_trigger(_,_,_).


trigger_trigger1(presently(Trigger),Body) :- use_presently,
  is_ftNonvar(Trigger),!,
  copy_term_and_varnames(Trigger,TriggerCopy),
  no_repeats(call_u(Trigger)),
  mpred_eval_lhs(Body,(presently(Trigger),basePFC:pt(ABOX,presently(TriggerCopy),Body))),
  fail.

trigger_trigger1(Trigger,Body) :-
  copy_term_and_varnames(Trigger,TriggerCopy),
  no_repeats(mpred_call_only_facts(Trigger)),
  mpred_eval_lhs(Body,(Trigger,basePFC:pt(ABOX,TriggerCopy,Body))),
  fail.
*/

%=
%= call_u(Why,F) is true iff F is a fact is true
%=

%% call_u( ?X) is semidet.
%
% Call For User Code.
%
call_u(X):- mpred_call_only_facts(X).

%% call_u( ?Why, ?X) is semidet.
%
% Call For User Code.
%
call_u(Why,X):- show_call(why,(nop(Why),mpred_call_only_facts(X))).

%=
%= not_cond(Why,F) is true iff F is a fact is not true
%=
% not_cond(_Why,X):- show_success(why,mpred_call_0(~(X))).

%% not_cond( ?Why, ?X) is semidet.
%
% Not Cond.
%
not_cond(_Why,X):- \+ X.


mpred_retry(G):- fail;G.


%% { ?G} is semidet.
%
% {}.
%
'{}'(G):-req(G).

:- meta_predicate neg_in_code(*).
:- export(neg_in_code/1).

%% neg_in_code( ?G) is semidet.
%
% Negated In Code.
%
neg_in_code(G):-var(G),!,fail.
neg_in_code(req(G)):- !,~G.
neg_in_code(~(G)):- nonvar(G),!, \+ ~G.
neg_in_code(G):-   neg_may_naf(G), \+ with_umt(G).
neg_in_code(G):-  is_ftNonvar(G), prologSingleValued(G),must((if_missing_mask(G,R,Test),nonvar(R))),req(R),with_umt(Test).


:- meta_predicate neg_may_naf(0).
:- export(neg_may_naf/1).

%% neg_may_naf( :GoalP) is semidet.
%
% Negated May Negation-by-faliure.
%
neg_may_naf(P):- mpred_non_neg_literal(P),get_functor(P,F),clause_i(prologNegByFailure(F),true),!.
neg_may_naf(P):- is_ftCompound(P),predicate_property(P,static).

%=
%= mpred_call_only_facts(+Why,:F) is true iff F is a fact available for forward chaining.
%= Note that this has the side effect [maybe] of catching unsupported facts and
%= assigning them support from God. (g,g)
%=

%% req( ?G) is semidet.
%
% Req.
%
req(G):- loop_check(mpred_call_0(G),fail).


%% mpred_call_only_facts( ?Clause) is semidet.
%
% PFC Call Only Facts.
%
mpred_call_only_facts(Clause) :-  strip_module(Clause,_,F), on_x_rtrace(no_repeats(loop_check(mpred_call_0(F),fail))). 

%% mpred_call_only_facts( ?Why, ?F) is semidet.
%
% PFC Call Only Facts.
%
mpred_call_only_facts(_Why,F):- on_x_rtrace(no_repeats(loop_check(mpred_call_0(F),fail))). 




%% mpred_call_0( ?Var) is semidet.
%
% PFC call  Primary Helper.
%
mpred_call_0(Var):-is_ftVar(Var),!,mpred_call_with_no_triggers(Var).
mpred_call_0(M):-fixed_negations(M,O),!,mpred_call_0(O).
mpred_call_0(U:X):-U==user,!,mpred_call_0(X).
mpred_call_0(t(A,B)):-(atom(A)->true;(no_repeats(arity(A,1)),atom(A))),ABC=..[A,B],mpred_call_0(ABC).
mpred_call_0(isa(B,A)):-(atom(A)->true;(no_repeats(tCol(A)),atom(A))),ABC=..[A,B],mpred_call_0(ABC).
%mpred_call_0(t(A,B)):-!,(atom(A)->true;(no_repeats(arity(A,1)),atom(A))),ABC=..[A,B],mpred_call_0(ABC).
mpred_call_0(t(A,B,C)):-!,(atom(A)->true;(no_repeats(arity(A,2)),atom(A))),ABC=..[A,B,C],mpred_call_0(ABC).
mpred_call_0(t(A,B,C,D)):-!,(atom(A)->true;(no_repeats(arity(A,3)),atom(A))),ABC=..[A,B,C,D],mpred_call_0(ABC).
mpred_call_0(t(A,B,C,D,E)):-!,(atom(A)->true;(no_repeats(arity(A,4)),atom(A))),ABC=..[A,B,C,D,E],mpred_call_0(ABC).
mpred_call_0((C1,C2)):-!,mpred_call_0(C1),mpred_call_0(C2).
mpred_call_0((C1;C2)):-!,(mpred_call_0(C1);mpred_call_0(C2)).
mpred_call_0((C1->C2;C3)):-!,(mpred_call_0(C1)->mpred_call_0(C2);mpred_call_0(C3)).
mpred_call_0((C1*->C2;C3)):-!,(mpred_call_0(C1)*->mpred_call_0(C2);mpred_call_0(C3)).
mpred_call_0((C1->C2)):-!,(mpred_call_0(C1)->mpred_call_0(C2)).
mpred_call_0((C1*->C2)):-!,(mpred_call_0(C1)*->mpred_call_0(C2)).
mpred_call_0(call(X)):- !, mpred_call_0(X).
mpred_call_0(req(X)):- !, mpred_call_0(X).
mpred_call_0(\+(X)):- !, \+ mpred_call_0(X).
mpred_call_0(call_u(X)):- !, mpred_call_0(X).
mpred_call_0(asserta(X)):- !, aina(X).
mpred_call_0(assertz(X)):- !, ainz(X).
mpred_call_0(assert(X)):- !, mpred_ain(X).
mpred_call_0(retract(X)):- !, mpred_remove(X).

mpred_call_0(M:P):-!,sanity(nonvar(P)),functor(P,F,_),mpred_call_1(M,P,F).
mpred_call_0(G):- strip_module(G,M,P),sanity(nonvar(P)),functor(P,F,_),mpred_call_1(M,P,F).



%% mpred_call_1( ?VALUE1, ?G, ?VALUE3) is semidet.
%
% PFC call  Secondary Helper.
%
mpred_call_1(_,G,_):- is_side_effect_disabled,!,mpred_call_with_no_triggers(G).

mpred_call_1(M,G,F):- sanity(\+  is_side_effect_disabled),
               (ground(G); \+ current_predicate(_,M:G) ; \+ (predicate_property(M:G,number_of_clauses(CC)),CC>1)), 
    
                ignore((loop_check(call_with_bc_triggers(M:G)),maybeSupport(G,(g,g)),fail)),
                 \+ current_predicate(F,M:G),\+ current_predicate(_,_:G),
                 doall(show_call(predicate_property(_UM:G,_PP))),
                 debug(mpred),
                 must(show_call(kb_dynamic(M:G))),import_to_user(M:G),!,fail.
mpred_call_1(_,G,_):- mpred_call_with_no_triggers(G).


:- thread_local t_l:infBackChainPrevented/1.


%% call_with_bc_triggers( ?MP) is semidet.
%
% Call Using Backchaining Triggers.
%
call_with_bc_triggers(MP) :- strip_module(MP,_,P), functor(P,F,A), \+ t_l:infBackChainPrevented(F/A), 
  mpred_get_trigger_quick(ABOX,basePFC:bt(ABOX,P,Trigger)),
  no_repeats(mpred_get_support(basePFC:bt(ABOX,P,Trigger),S)),
  once(no_side_effects(P)),
  w_tl(t_l:infBackChainPrevented(F/A),mpred_eval_lhs(Trigger,S)).


%% mpred_call_with_no_triggers( ?Clause) is semidet.
%
% PFC Call Using No Triggers.
%
mpred_call_with_no_triggers(Clause) :-  strip_module(Clause,_,F),
  %= this (is_ftVar(F)) is probably not advisable due to extreme inefficiency.
  (is_ftVar(F)    ->  mpred_facts_and_universe(F) ; mpred_call_with_no_triggers_bound(F)).


%% mpred_call_with_no_triggers_bound( ?F) is semidet.
%
% PFC Call Using No Triggers Bound.
%
mpred_call_with_no_triggers_bound(F):- mpred_call_with_no_triggers_uncaugth(F).

%% mpred_call_with_no_triggers_uncaugth( ?Clause) is semidet.
%
% PFC Call Using No Triggers Uncaugth.
%
mpred_call_with_no_triggers_uncaugth(Clause) :-  strip_module(Clause,_,F),
  show_failure(mpred_call_with_no_triggers_bound,no_side_effects(F)),
  (\+ current_predicate(_,F) -> fail;call_prologsys(F)).
  %= we check for system predicates as well.
  %has_cl(F) -> (clause_u(F,Condition),(Condition==true->true;call_u(Condition)));
  %call_prologsys(F).


%% mpred_bc_only( ?M) is semidet.
%
% PFC Backchaining Only.
%
mpred_bc_only(M:G):- with_umt(M,mpred_bc_only0(G)).

%% mpred_bc_only0( ?G) is semidet.
%
% PFC Backchaining Only Primary Helper.
%
mpred_bc_only0(G):- mpred_negation(G,Pos),!, show_call(why,\+ mpred_bc_only(Pos)).
mpred_bc_only0(G):- loop_check(no_repeats(pfcBC_NoFacts(G))).
mpred_bc_only0(G):- mpred_call_only_facts(G).

%%
%= pfcBC_NoFacts(F) is true iff F is a fact available for backward chaining ONLY.
%= Note that this has the side effect of catching unsupported facts and
%= assigning them support from God.
%= this Predicate should hide Facts from mpred_bc_only/1
%%

%% pfcBC_NoFacts( ?F) is semidet.
%
% Prolog Forward Chaining Backtackable Class No Facts.
%
pfcBC_NoFacts(F):- pfcBC_NoFacts_TRY(F)*-> true ; (mpred_slow_search,pfcBC_Cache(F)).


%% mpred_slow_search is semidet.
%
% PFC Slow Search.
%
mpred_slow_search.


/*
%% ruleBackward( ?R, ?Condition) is semidet.
%
% Rule Backward.
%
ruleBackward(R,Condition):- with_umt(( ruleBackward0(R,Condition),functor(Condition,F,_),\+ arg(_,v(call_prologsys,call_u),F))).
%ruleBackward0(F,Condition):-clause_u(F,Condition),\+ (is_true(Condition);mpred_is_minfo(Condition)).

%% ruleBackward0( ?F, ?Condition) is semidet.
%
% Rule Backward Primary Helper.
%
ruleBackward0(F,Condition):- with_umt((  '<-'(F,Condition),\+ (is_true(Condition);mpred_is_minfo(Condition)) )).

%:- was_dynamic('{}'/1).
%{X}:-dmsg(legacy({X})),call_prologsys(X).
*/


%% pfcBC_NoFacts_TRY( ?F) is semidet.
%
% Prolog Forward Chaining Backtackable Class No Facts Try.
%
pfcBC_NoFacts_TRY(F) :- no_repeats(ruleBackward(F,Condition)),
  % neck(F),
  call_prologsys(Condition),
  maybeSupport(F,(g,g)).



%% pfcBC_Cache( ?F) is semidet.
%
% Prolog Forward Chaining Backtackable Class Cache.
%
pfcBC_Cache(F) :- mpred_call_only_facts(pfcBC_Cache,F),
   ignore((ground(F),( (\+is_asserted_1(F)), maybeSupport(F,(g,g))))).



%% maybeSupport( ?P, ?VALUE2) is semidet.
%
% Maybe Support.
%
maybeSupport(P,_):-mpred_ignored(P),!.
maybeSupport(P,S):-( \+ ground(P)-> true;
  (predicate_property(P,dynamic)->mpred_ain(P,S);true)).


%% mpred_ignored( :TermC) is semidet.
%
% PFC Ignored.
%
mpred_ignored(argIsa(F, A, argIsaFn(F, A))).
mpred_ignored(genls(A,A)).
mpred_ignored(isa(tCol,tCol)).
%mpred_ignored(isa(W,tCol)):-mreq(lmconf:hasInstance_dyn(tCol,W)).
mpred_ignored(isa(W,_)):-is_ftCompound(W),isa(W,pred_argtypes).
mpred_ignored(C):-clause_safe(C,true). 
mpred_ignored(isa(_,Atom)):-atom(Atom),atom_concat(ft,_,Atom),!.
mpred_ignored(isa(_,argIsaFn(_, _))).



%% has_cl( ?H) is semidet.
%
% Has Clause.
%
has_cl(H):-predicate_property(H,number_of_clauses(_)).

% an action is undoable if there exists a method for undoing it.

%% undoable( ?A) is semidet.
%
% Undoable.
%
undoable(A) :- req(mpred_do_and_undo_method(A,_)).

/*

%=
%=
%= defining fc rules
%=

%= mpred_nf(+In,-Out) maps the LHR of a pfc rule In to one normal form
%= Out.  It also does certain optimizations.  Backtracking into this
%= predicate will produce additional clauses.



%% mpred_nf( ?LHS, ?List) is semidet.
%
% PFC Normal Form.
%
mpred_nf(LHS,List) :-
  must(mpred_nf1(LHS,List2)),
  mpred_nf_negations(List2,List).


%= mpred_nf1(+In,-Out) maps the LHR of a pfc rule In to one normal form
%= Out.  Backtracking into this predicate will produce additional clauses.

% handle a variable.


%% mpred_nf1( ?NegTerm, ?NF) is semidet.
%
% PFC Normal Form Secondary Helper.
%
mpred_nf1(P,[P]) :- is_ftVar(P), !.

% these next three rules are here for upward compatibility and will go
% away eventually when the P/Condition form is no longer used anywhere.

mpred_nf1(P/Cond,[(\+Q)/Cond]) :- fail, mpred_negated_literal(P,Q), !.  % DMILES does not undersand why this is wron gand the next is correct here
mpred_nf1(P/Cond,[(\+P)/Cond]) :- mpred_negated_literal(P,_), !.

mpred_nf1(P/Cond,[P/Cond]) :-  mpred_literal(P), !.

mpred_nf1((P/Cond),O) :-!,mpred_nf1((P,{Cond}),O).

mpred_nf1({P},[{P}]) :-!.

%= handle a negated form

mpred_nf1(NegTerm,NF) :-
  mpred_negation(NegTerm,Term),
  !,
  mpred_nf1_negation(Term,NF).

mpred_nf1(-((P,Q)),NF) :-
 mpred_nf1(-P,NP),
 mpred_nf1(-Q,NQ),
 !,
 mpred_nf1(((NP/Q);(NQ/P)),NF).

%= disjunction.

mpred_nf1((P;Q),NF) :-
  !,
  (mpred_nf1(P,NF) ;   mpred_nf1(Q,NF)).


%= conjunction.

mpred_nf1((P,Q),NF) :-
  !,
  mpred_nf1(P,NF1),
  mpred_nf1(Q,NF2),
  append(NF1,NF2,NF).

%= handle a random atom.

mpred_nf1(P,[P]) :-
  mpred_literal(P),
  !.

%=% shouln't we have something to catch the rest as errors?
mpred_nf1(Term,[Term]) :-
  mpred_warn("mpred_nf doesn't know how to normalize ~p",[Term]),!,fail.

*/

%% mpred_negation_w_neg( ?P, ?NF) is semidet.
%
% PFC Negation W Negated.
%
mpred_negation_w_neg(~(P),P):-is_ftNonvar(P),!.
mpred_negation_w_neg(P,NF):-mpred_nf1_negation(P,NF).

/*
%= mpred_nf1_negation(P,NF) is true if NF is the normal form of \+P.

%% mpred_nf1_negation( ?P, ?P) is semidet.
%
% PFC Normal Form Secondary Helper Negation.
%
mpred_nf1_negation((P/Cond),[(\+(P))/Cond]) :- !.

mpred_nf1_negation((P;Q),NF) :-
  !,
  mpred_nf1_negation(P,NFp),
  mpred_nf1_negation(Q,NFq),
  append(NFp,NFq,NF).

mpred_nf1_negation((P,Q),NF) :-
  % this code is not correct! tmpred_wff.
  !,
  mpred_nf1_negation(P,NF)
  ;
  (mpred_nf1(P,Pnf),
   mpred_nf1_negation(Q,Qnf),
   append(Pnf,Qnf,NF)).

mpred_nf1_negation(P,[\+P]).


%= mpred_nf_negations(List2,List) sweeps through List2 to produce List,
%= changing -{...} to {\+...}
%=% ? is this still needed? tmpred_wff 3/16/90


%% mpred_nf_negations( :TermX, :TermX) is semidet.
%
% PFC Normal Form Negations.
%
mpred_nf_negations(X,X) :- !.  % I think not! tmpred_wff 3/27/90

mpred_nf_negations([],[]).

mpred_nf_negations([H1|T1],[H2|T2]) :-
  mpred_nf_negation(H1,H2),
  mpred_nf_negations(T1,T2).


%% mpred_nf_negation( ?X, ?X) is semidet.
%
% PFC Normal Form Negation.
%
mpred_nf_negation(Form,{\+ X}) :-
  is_ftNonvar(Form),
  Form=(-({X})),
  !.
mpred_nf_negation(Form,{\+ X}) :-
  is_ftNonvar(Form),
  Form=(~({X})),
  !.
mpred_nf_negation(X,X).
*/
/*

%=
%= build_rhs(Sup,+Conjunction,-Rhs)
%=


%% build_rhs( ?Sup, :TermX, :TermX) is semidet.
%
% Build Right-hand-side.
%

build_rhs(_Sup,X,[X]) :-
  is_ftVar(X),
  !.
build_rhs(_Sup,~(X),[~(X)]) :-
  is_ftVar(X),
  !.

build_rhs(Sup,call(A),Rest) :- !, build_rhs(Sup,(A),Rest).
build_rhs(Sup,call_u(A),Rest) :- !, build_rhs(Sup,(A),Rest).

build_rhs(Sup,(A,B),[A2|Rest]) :-
  !,
  mpred_compile_rhsTerm(Sup,A,A2),
  build_rhs(Sup,B,Rest).

build_rhs(Sup,X,[X2]) :-
   mpred_compile_rhsTerm(Sup,X,X2).



%% mpred_compile_rhsTerm( ?Sup, :TermP, :TermP) is semidet.
%
% PFC Compile Right-hand-side Term.
%
mpred_compile_rhsTerm(_Sup,P,P):-is_ftVar(P),!.
mpred_compile_rhsTerm(Sup,(P/C),((P0:-C0))) :- !,mpred_compile_rhsTerm(Sup,P,P0),build_code_test(Sup,C,C0),!.
mpred_compile_rhsTerm(Sup,I,O):-to_addable_form_wte(mpred_compile_rhsTerm,I,O), must(\+ \+ mpred_mark_as(Sup,p,O,pfcRHS)),!.

*/

:- export(mpred_mark_as_ml/4).

%% mpred_mark_as_ml( ?Sup, ?PosNeg, ?Type, ?P) is semidet.
%
% PFC Mark Converted To Ml.
%
mpred_mark_as_ml(Sup,PosNeg,Type,P):- mpred_mark_as(Sup,PosNeg,P,Type).


%% pos_2_neg( ?P, ?P) is semidet.
%
% pos  Extended Helper Negated.
%
pos_2_neg(p,n):-!.
pos_2_neg(n,p):-!.
pos_2_neg(P,~(P)).


%% mpred_mark_as( ?VALUE1, ?VALUE2, :TermP, ?VALUE4) is semidet.
%
% PFC Mark Converted To.
%
mpred_mark_as(_,_,P,_):- is_ftVar(P),!.
mpred_mark_as(Sup,Pos,\+(P),Type):- pos_2_neg(Pos,Neg),!,mpred_mark_as(Sup,Neg,P,Type).
mpred_mark_as(Sup,Pos,~(P),Type):- pos_2_neg(Pos,Neg),!,mpred_mark_as(Sup,Neg,P,Type).
mpred_mark_as(Sup,Pos,-(P),Type):- pos_2_neg(Pos,Neg),!,mpred_mark_as(Sup,Neg,P,Type).
mpred_mark_as(Sup,Pos,not(P),Type):- pos_2_neg(Pos,Neg),!,mpred_mark_as(Sup,Neg,P,Type).
mpred_mark_as(Sup,PosNeg,[P|PL],Type):- is_list([P|PL]), !,must_maplist(mpred_mark_as_ml(Sup,PosNeg,Type),[P|PL]).
mpred_mark_as(Sup,PosNeg,( P / CC ),Type):- !, mpred_mark_as(Sup,PosNeg,P,Type),mpred_mark_as(Sup,PosNeg,( CC ),pfcCallCode).
mpred_mark_as(Sup,PosNeg,'{}'(  CC ), _Type):- mpred_mark_as(Sup,PosNeg,( CC ),pfcCallCode).
mpred_mark_as(Sup,PosNeg,( A , B), Type):- !, mpred_mark_as(Sup,PosNeg,A, Type),mpred_mark_as(Sup,PosNeg,B, Type).
mpred_mark_as(Sup,PosNeg,( A ; B), Type):- !, mpred_mark_as(Sup,PosNeg,A, Type),mpred_mark_as(Sup,PosNeg,B, Type).
mpred_mark_as(Sup,PosNeg,( A ==> B), Type):- !, mpred_mark_as(Sup,PosNeg,A, Type),mpred_mark_as(Sup,PosNeg,B, pfcRHS).
mpred_mark_as(Sup,PosNeg,( B <- A), Type):- !, mpred_mark_as(Sup,PosNeg,A, Type),mpred_mark_as(Sup,PosNeg,B, pfcRHS).
%mpred_mark_as(_Sup,_PosNeg,( _ :- _ ),_Type):-!.
mpred_mark_as(Sup,PosNeg,( P :- CC ),Type):- !, mpred_mark_as(Sup,PosNeg,P,Type),mpred_mark_as(Sup,PosNeg,( CC ),pfcCallCode).
mpred_mark_as(Sup,PosNeg,P,Type):-get_functor(P,F,A),ignore(mpred_mark_fa_as(Sup,PosNeg,P,F,A,Type)),!.

:- was_dynamic( mpred_mark/4).

% mpred_mark_fa_as(_,_,_,'\=',2,_):- trace.

%% mpred_mark_fa_as( ?Sup, ?PosNeg, ?P, ?F, ?A, ?Type) is semidet.
%
% PFC Mark Functor-arity Converted To.
%
mpred_mark_fa_as(_Sup,_PosNeg,_P,isa,_,_):- !.
mpred_mark_fa_as(_Sup,_PosNeg,_P,t,_,_):- !.
mpred_mark_fa_as(_Sup,_PosNeg,_P,argIsa,N,_):- !,must(N=3).
mpred_mark_fa_as(_Sup,_PosNeg,_P,arity,N,_):- !,must(N=2).
mpred_mark_fa_as(_Sup,_PosNeg,_P,mpred_mark,N,_):- !,must(N=4).
mpred_mark_fa_as(_Sup,_PosNeg,_P,mpred_isa,N,_):- must(N=2).
mpred_mark_fa_as(_Sup,_PosNeg,_P,'[|]',N,_):- trace,must(N=2).
mpred_mark_fa_as(_Sup,_PosNeg,_P,_:mpred_isa,N,_):- must(N=2).
mpred_mark_fa_as(_Sup, PosNeg,_P,F,A,Type):- req(mpred_mark(Type,PosNeg,F,A)),!.
mpred_mark_fa_as(Sup,PosNeg,_P,F,A,Type):- 
  MARK = mpred_mark(Type,PosNeg,F,A),
  check_never_assert(MARK),
  with_no_mpred_trace_exec(mpred_ain(MARK,(s(Sup),g))).
  % with_no_mpred_trace_exec(with_search_mode(direct,mpred_fwd2(MARK,(s(Sup),g)))),!.
   

%% fa_to_p( ?F, ?A, ?P) is semidet.
%
% Functor-arity Converted To Pred.
%
fa_to_p(F,A,P):-integer(A),atom(F),functor(P,F,A),( P \= call_u(_) ),( P \= '$VAR'(_)).


%% hook_one_minute_timer_tick is semidet.
%
% Hook To [lmconf:hook_one_minute_timer_tick/0] For Module Mpred_pfc.
% Hook One Minute Timer Tick.
%
lmconf:hook_one_minute_timer_tick:-mpred_cleanup.


%% mpred_cleanup is semidet.
%
% PFC Cleanup.
%
mpred_cleanup:- forall((no_repeats(F-A,(mpred_mark(pfcRHS,_,F,A),A>1))),mpred_cleanup(F,A)).


%% mpred_cleanup( ?F, ?A) is semidet.
%
% PFC Cleanup.
%
mpred_cleanup(F,A):-functor(P,F,A),predicate_property(P,dynamic)->mpred_cleanup_0(P);true.


%% mpred_cleanup_0( ?P) is semidet.
%
% PFC cleanup  Primary Helper.
%
mpred_cleanup_0(P):- findall(P-B-Ref,clause(P,B,Ref),L),
  forall(member(P-B-Ref,L),erase_w_attvars(clause(P,B,Ref),Ref)),forall(member(P-B-Ref,L),attvar_op(assertz_if_new,((P:-B)))).

% :-debug.
%isInstFn(A):-!,trace_or_throw(isInstFn(A)).

%= mpred_negation(N,P) is true if N is a negated term and P is the term
%= with the negation operator stripped.

/*
%% mpred_negation( ?P, ?P) is semidet.
%
% PFC Negation.
%
mpred_negation((-P),P).
mpred_negation((-P),P).
mpred_negation((\+(P)),P).
*/
/*

%% mpred_negated_literal( ?P) is semidet.
%
% PFC Negated Literal.
%
mpred_negated_literal(P):-mpred_negated_literal(P,_).

%% mpred_negated_literal( ?P, ?Q) is semidet.
%
% PFC Negated Literal.
%
mpred_negated_literal(P,Q) :- is_ftNonvar(P),
  mpred_negation(P,Q),
  mpred_literal(Q).

*/

%% mpred_is_assertable( ?X) is semidet.
%
% PFC If Is A Assertable.
%
mpred_is_assertable(X):- mpred_literal_nv(X),\+ functor(X,{},_).

%% mpred_literal_nv( ?X) is semidet.
%
% PFC Literal Nv.
%
mpred_literal_nv(X):-is_ftNonvar(X),mpred_literal(X).

/*
%% mpred_literal( ?X) is semidet.
%
% PFC Literal.
%
mpred_literal(X) :- is_reprop(X),!,fail.
mpred_literal(X) :- cyclic_term(X),!,fail.
mpred_literal(X) :- atom(X),!.
mpred_literal(X) :- mpred_negated_literal(X),!.
mpred_literal(X) :- mpred_positive_literal(X),!.
mpred_literal(X) :- is_ftVar(X),!.

*/

%% is_reprop( ?X) is semidet.
%
% If Is A Reprop.
%
is_reprop(X):- compound(X),is_reprop_0(X).

%% is_reprop_0( ?X) is semidet.
%
% If Is A reprop  Primary Helper.
%
is_reprop_0(~(X)):-!,is_reprop(X).
is_reprop_0(X):-get_functor(X,repropagate,_).


%% mpred_non_neg_literal( ?X) is semidet.
%
% PFC Not Negated Literal.
%
mpred_non_neg_literal(X):-is_reprop(X),!,fail.
mpred_non_neg_literal(X):-atom(X),!.
mpred_non_neg_literal(X):- sanity(stack_check),
    mpred_positive_literal(X), X \= ~(_), X \= mpred_mark(_,_,_,_), X \= conflict(_).

mpred_non_neg_literal(X):-is_reprop(X),!,fail.

/*
%% mpred_positive_literal( ?X) is semidet.
%
% PFC Positive Literal.
%
mpred_positive_literal(X) :- is_ftNonvar(X),
  get_functor(X,F,_),
  \+ mpred_connective(F).


%% mpred_connective( ?VALUE1) is semidet.
%
% PFC Connective.
%
mpred_connective(';').
mpred_connective(',').
mpred_connective('/').
mpred_connective('|').
mpred_connective(('==>')).
mpred_connective(('<-')).
mpred_connective('<==>').

mpred_connective('-').
mpred_connective('-').
mpred_connective('\\+').
*/
/*
%% old_process_rule( ?Lhs, ?Rhs, ?Parent_rule) is semidet.
%
% Process Rule.
%
old_process_rule(Lhs,Rhs,Parent_rule) :- 
  copy_term_and_varnames(Parent_rule,Parent_ruleCopy),
  build_rhs((Parent_ruleCopy),Rhs,Rhs2),
   cyclic_break((Lhs,Rhs,Rhs2,Parent_ruleCopy)),
  old_foreachl_do(mpred_nf(Lhs,Lhs2),
   old_build_rule(Lhs2,rhs(Rhs2),(Parent_ruleCopy,u))).


%% old_build_rule( ?Lhs, ?Rhs, ?Support) is semidet.
%
% Build Rule.
%
old_build_rule(Lhs,Rhs,Support) :-
  build_trigger(Support,Lhs,Rhs,Trigger),
   mpred_mark_as(Support,p,Lhs,pfcLHS),
   cyclic_break((Lhs,Rhs,Support,Trigger)),
  mpred_eval_lhs(Trigger,Support).


%% build_trigger( ?Support, :TermARG2, ?Consequent, :TermConsequentO) is semidet.
%
% Build Trigger.
%
build_trigger(Support,[],Consequent,ConsequentO):- 
      build_consequent(Support,Consequent,ConsequentO).

build_trigger(Support,[V|Triggers],Consequent,basePFC:pt(ABOX,V,X)) :- get_user_abox_umt(ABOX),
  is_ftVar(V),
  !,
  build_trigger(Support,Triggers,Consequent,X).

build_trigger(Support,[added(T)|Triggers],Consequent,basePFC:pt(ABOX,T,X)) :- get_user_abox_umt(ABOX),
  !,
  build_code_test(Support,ground(T),Test2),
  build_trigger(Support,[{Test2}|Triggers],Consequent,X).

build_trigger(Support,[(T1/Test)|Triggers],Consequent,basePFC:nt(ABOX,T2,Test2,X)) :- get_user_abox_umt(ABOX),
  is_ftNonvar(T1),mpred_negation(T1,T2),
  !,
  build_neg_test(Support,T2,Test,Test2),
  build_trigger(Support,Triggers,Consequent,X).

build_trigger(Support,[(T1)|Triggers],Consequent,basePFC:nt(ABOX,T2,Test,X)) :- get_user_abox_umt(ABOX),
  mpred_negation(T1,T2),
  !,
  build_neg_test(Support,T2,true,Test),
  build_trigger(Support,Triggers,Consequent,X).

build_trigger(Support,[{Test}|Triggers],Consequent,(Test->X)) :-
  !,
  build_trigger(Support,Triggers,Consequent,X).

build_trigger(Support,[T/Test|Triggers],Consequent,basePFC:pt(ABOX,T,X)) :- get_user_abox_umt(ABOX),
  !,
  build_code_test(Support,Test,Test2),
  build_trigger(Support,[{Test2}|Triggers],Consequent,X).


%build_trigger(Support,[snip|Triggers],Consequent,snip(X)) :-
%  !,
%  build_trigger(Support,Triggers,Consequent,X).

build_trigger(Support,[T|Triggers],Consequent,basePFC:pt(ABOX,T,X)) :- get_user_abox_umt(ABOX),
  !,
  build_trigger(Support,Triggers,Consequent,X).

%=
%= build_neg_test(Support,+,+,-).
%=
%= builds the test used in a negative trigger (basePFC:nt/4).  This test is a
%= conjunction of the check than no matching facts are in the db and any
%= additional test specified in the rule attached to this - term.
%=


%% build_neg_test( ?Support, ?T, ?Testin, ?Testout) is semidet.
%
% Build Negated Test.
%
build_neg_test(Support,T,Testin,Testout) :-  % must(sanity(is_ftNonvar(T))),
  build_code_test(Support,Testin,Testmid),
  conjoin((call_u(T)),Testmid,Testout).


%= this just strips away any currly brackets.


%% build_code_test( ?Support, ?Test, ?TestO) is semidet.
%
% Build Code Test.
%
build_code_test(_Support,Test,TestO):-is_ftVar(Test),!,must(is_ftNonvar(Test)),TestO=call_u(Test).
build_code_test(Support,{Test},TestO) :- !,build_code_test(Support,Test,TestO).
build_code_test(Support,Test,TestO):- code_sentence_op(Test),Test=..[F|TestL],must_maplist(build_code_test(Support),TestL,TestLO),TestO=..[F|TestLO],!.
build_code_test(Support,Test,Test):- must(mpred_mark_as(Support,p,Test,pfcCallCode)),!.
build_code_test(_,Test,Test).


%% code_sentence_op( :TermVar) is semidet.
%
% Code Sentence Oper..
%
code_sentence_op(Var):-is_ftVar(Var),!,fail.
code_sentence_op(rhs(_)).
code_sentence_op(~(_)).
code_sentence_op(-(_)).
code_sentence_op(-(_)).
code_sentence_op(\+(_)).
code_sentence_op(call_u(_)).
code_sentence_op(call_u(_,_)).
code_sentence_op(Test):-predicate_property(Test,meta_predicate(PP)),predicate_property(Test,built_in),  \+ (( arg(_,PP,N), N\=0)).


%% all_closed( ?C) is semidet.
%
% All Closed.
%
all_closed(C):- \+is_ftCompound(C)->true;(functor(C,_,A),A>1,\+((arg(_,C,Arg),is_ftVar(Arg)))),!.

%=


%% build_consequent( ?VALUE1, ?Test, ?Test) is semidet.
%
% Build Consequent.
%
build_consequent(_      ,Test,Test):- is_ftVar(Test),!.
build_consequent(_      ,Test,TestO):-is_ftVar(Test),!,TestO=added(Test).
build_consequent(Support,rhs(Test),rhs(TestO)) :- !,build_consequent(Support,Test,TestO).
build_consequent(Support,Test,TestO):- code_sentence_op(Test),Test=..[F|TestL],
   maplist(build_consequent(Support),TestL,TestLO),TestO=..[F|TestLO],!.
build_consequent(Support,Test,Test):-must(mpred_mark_as(Support,p,Test,pfcCreates)),!.
build_consequent(_ ,Test,Test).

%= simple typeing for pfc objects


%% mpred_db_type( ?VALUE1, ?Type) is semidet.
%
% PFC Database Type.
%
mpred_db_type(('<-'(_,_)),Type) :- !, Type=rule.
mpred_db_type(('<==>'(_,_)),Type) :- !, Type=rule.
mpred_db_type(('==>'(_,_)),Type) :- !, Type=rule.
mpred_db_type((':-'(_,_)),Type) :- !, Type=rule.
mpred_db_type(basePFC:pk(_ABOX,_,_,_),Type) :- !, Type=trigger.
mpred_db_type(basePFC:pt(_ABOX,_,_),Type) :- !, Type=trigger.
mpred_db_type(basePFC:nt(_ABOX,_,_,_),Type) :- !,  Type=trigger.
mpred_db_type(basePFC:bt(_ABOX,_,_),Type) :- !,  Type=trigger.
mpred_db_type(mpred_action(_),Type) :- !, Type=action.
mpred_db_type((('::::'(_,X))),Type) :- is_ftNonvar(X),!, mpred_db_type(X,Type).
mpred_db_type(_,fact) :-
  %= if it''s not one of the above, it must be a fact!
  !.



%% retract_t( ?Trigger) is semidet.
%
% Retract Trigger Stucture.
%
retract_t(Trigger) :- arg(1,Trigger,ABOX),retract_i(basePFC:spft(ABOX,Trigger,_,_,_)),ignore(retract_i(Trigger)).



%% old_ain_ts( ?P, ?Support) is semidet.
%
% Assert If New True Structures.
%
old_ain_ts(P,Support) :- 
  (mpred_clause_i(P) ; (assert_u(P))),
  !,
  old_ain_support(P,Support).
*/
/*

old_ain_t(P,Support) :- 
  (mpred_clause_i(P) ; (assert_u(P),old_ain_trigger(P,Support))),
  !,
  old_ain_support(P,Support).

*/

/*

%% aina_i( ?P, ?Support) is semidet.
%
% Aina For Internal Interface.
%
aina_i(P,Support) :-
  (mpred_clause_i(P) ; asserta_i(P)),
  !,
  old_ain_support(P,Support).



%% ainz_i( ?P, ?Support) is semidet.
%
% Ainz For Internal Interface.
%
ainz_i(P,Support) :-  
  (mpred_clause_i(P) ; assertz_i(P)),
  !,
  old_ain_support(P,Support).



%% mpred_clause_i( ?Head) is semidet.
%
% PFC Clause For Internal Interface.
%
mpred_clause_i((Head :- Body)) :-
  !,
  copy_term_and_varnames(Head,Head_copy),
  copy_term_and_varnames(Body,Body_copy),
  clause_i(Head,Body),
  variant(Head,Head_copy),
  variant(Body,Body_copy).

mpred_clause_i(Head) :-
  % find a unit clause_db identical to Head by finding one which unifies,
  % and then checking to see if it is identical
  copy_term_and_varnames(Head,Head_copy),
  clause_i(Head_copy,true),
  variant(Head,Head_copy).



%% old_foreachl_do( ?Binder, ?Body) is semidet.
%
% Foreachl Do.
%
old_foreachl_do(Binder,Body) :- Binder,old_pfcl_do(Body),fail.
old_foreachl_do(_,_).

% old_pfcl_do(X) executesf X once and always succeeds.

%% old_pfcl_do( ?X) is semidet.
%
% Pfcl Do.
%
old_pfcl_do(X) :- X,!.
old_pfcl_do(_).


%= mpred_union(L1,L2,L3) - true if set L3 is the result of appending sets
%= L1 and L2 where sets are represented as simple lists.


%% mpred_union( :TermARG1, ?L, :TermL) is semidet.
%
% PFC Union.
%
mpred_union([],L,L).
mpred_union([Head|Tail],L,Tail2) :-
  memberchk(Head,L),
  !,
  mpred_union(Tail,L,Tail2).
mpred_union([Head|Tail],L,[Head|Tail2]) :-
  mpred_union(Tail,L,Tail2).
*/
% ======================= mpred_file('pfcsupport').	% support maintenance

%=
%=
%= predicates for manipulating support relationships
%=


% user:portray(C):-is_ftCompound(C),C=basePFC:spft(ABOX,_,_,_,_),pp_item('',C).

%= mpred_had_support(+Fact,+Support)

%% mpred_had_support( ?P, :TermFact) is semidet.
%
% PFC Had Support.
%
mpred_had_support(P,(Fact,Trigger)) :- 
 get_user_abox_umt(ABOX),
 ( clause_asserted_local(basePFC:spft(ABOX,P,Fact,Trigger,_OldWhy)) -> 
    true ; fail).


%= old_ain_support(+Fact,+Support)


%% old_ain_support( ?P, ?FT) is semidet.
%
% Assert If New Support.
%
old_ain_support(P,(Fact,Trigger)) :- 
get_user_abox_umt(ABOX),
 (( clause_asserted_local(basePFC:spft(ABOX,P,Fact,Trigger,_OldWhy)) ->
    true ; 
    (current_why(Why), 
      ( % get_clause_vars(P),get_clause_vars(Fact),get_clause_vars(Trigger),
        get_clause_vars(basePFC:spft(ABOX,P,Fact,Trigger,Why)),
      attvar_op(assertz,(basePFC:spft(ABOX,P,Fact,Trigger,Why))))))),!.  % was assert_u

/*
old_ain_support(P,(Fact,Trigger)) :-
  NEWSUPPORT = basePFC:spft(ABOX,NewP,NewFact,NewTrigger,NewWhy),
 copy_term_and_varnames(basePFC:spft(ABOX,P,Fact,Trigger,Why,OldWhy),NEWSUPPORT),
 ( clause_asserted_local(basePFC:spft(ABOX,P,Fact,Trigger,OldWhy)) ->
    true ; 
    (current_why(NewWhy),attvar_op(assertz,(NEWSUPPORT)))),!. 
*/
/*
old_ain_support(P,FT) :- trace_or_throw(failed_old_ain_support(P,FT)).

%% mpred_get_support( ?P, :TermFact) is semidet.
%
% PFC Get Support.
%
mpred_get_support(not(P),(Fact,Trigger)) :- is_ftNonvar(P),!, mpred_get_support(~(P),(Fact,Trigger)).
mpred_get_support(P,(Fact,Trigger)) :-
  get_user_abox_umt(ABOX),
    (basePFC:spft(ABOX,P,Fact,Trigger,_)*->true;(is_ftNonvar(P),mpred_get_support_neg(P,(Fact,Trigger)))).

%% mpred_get_support_neg( :TermP, ?S) is semidet.
%
% PFC Get Support Negated.
%
mpred_get_support_neg(\+ (P),S) :- !, is_ftNonvar(P), mpred_get_support(~(P),S).
mpred_get_support_neg(- (P),S) :- !, is_ftNonvar(P), mpred_get_support(~(P),S).
% dont mpred_get_support_neg(\+ ~(P),(Fact,Trigger)) :- sp ftY((P),Fact,Trigger).

%% mpred_support_db_rem( ?WhyIn, ?P, ?S) is semidet.
%
% There were three of these to try to efficiently handle the cases
% where some of the arguments are not bound but at least one is.
%
*/
/*
mpred_support_db_rem(WhyIn,P,S):- P \= ~(_), mpred_trace_msg('Removing',mpred_support_db_rem(WhyIn,P,S)),fail.
mpred_support_db_rem(WhyIn,P,(Fact,Trigger)) :- is_ftVar(P),!,
  get_user_abox_umt(ABOX),
  copy_term_and_varnames(mpred_support_db_rem(mpred_support_db_rem,P,(Fact,Trigger)) ,TheWhy),
  SPFC = basePFC:spft(ABOX,RP,RFact,RTrigger,_RWhy),
  clause_i(basePFC:spft(ABOX,P,Fact,Trigger,_),true,Ref),
  ((clause_i(SPFC,true,Ref),
     ( spftV(RP,RFact,RTrigger) =@= spftV(P,Fact,Trigger) -> 
        erase_w_attvars(clause(SPFC,true,Ref),Ref); 
       (mpred_trace_msg(<=(TheWhy,-SPFC)),nop(mpred_retract_or_warn_i(spftVVVVVVV(P,Fact,Trigger))),nop(trace))),
   (is_ftVar(P)->trace_or_throw(is_ftVar(P));remove_if_unsupported_verbose(WhyIn,local,P)))).
mpred_support_db_rem(Why,(\+ N) , S):- mpred_support_db_rem(Why,~(N),S).
mpred_support_db_rem(_Why,P,(Fact,Trigger)):-get_user_abox_umt(ABOX),mpred_retract_or_warn_i(basePFC:spft(ABOX,P,Fact,Trigger,_)).
*/
/*
% TODO not called yet
mpred_collect_supporters_list(Tripples) :-
  bagof(Tripple, mpred_support_relation(Tripple), Tripples),
  !.
mpred_collect_supporters_list([]).
*/
/* UNUSED TODAY
% TODO not called yet
mpred_support_relation((P,F,T)) :- basePFC:spft(ABOX,P,F,T,_).

% TODO not called yet
mpred_make_supporters_list((P,S1,S2)) :-
  % was old_ain_support(P,(S1,S2),_),
  old_ain_support(P,(S1,S2)),
  (old_ain_db_type(P); true),
  !.
*/


%% is_relative( :TermV) is semidet.
%
% If Is A Relative.
%
is_relative(V):- (\+is_ftCompound(V)),!,fail.
is_relative(update(_)).
is_relative(replace(_)).
is_relative(rel(_)).
is_relative(+(X)):- \+ is_ftVar(X).
is_relative(-(X)):- \+ is_ftVar(X).
is_relative(*(X)):- \+ is_ftVar(X).

/*
% TODO not called yet
%= mpred_get_trigger_key(+Trigger,-Key)
%=
%= Arg1 is a trigger.  Key is the best term to index it on.

mpred_get_trigger_key(basePFC:pt(ABOX,Key,_),Key).
mpred_get_trigger_key(basePFC:pk(ABOX,Key,_,_),Key).
mpred_get_trigger_key(basePFC:nt(ABOX,Key,_,_),Key).
mpred_get_trigger_key(Key,Key).
*/

/*

the FOL i get from SUMO, CycL, UMBEL and many *non* RDF ontologies out there.. i convert to Datalog..  evidently my conversion process is unique as it preserves semantics most by the book conversions gave up on. 


% TODO not called yet
%=^L
%= Get a key from the trigger that will be used as the first argument of
%= the trigger baseable clause that stores the trigger.
%=
mpred_trigger_key(X,X) :- is_ftVar(X), !.
mpred_trigger_key(chart(word(W),_L),W) :- !.
mpred_trigger_key(chart(stem([Char1|_Rest]),_L),Char1) :- !.
mpred_trigger_key(chart(Concept,_L),Concept) :- !.
mpred_trigger_key(X,X).
*/
% ======================= mpred_file('pfcdb').	% predicates to manipulate database.

%   File   : pfcdb.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Author :  Dan Corpron
%   Updated: 10/11/87, ...
%   Purpose: predicates to manipulate a pfc database (e.g. save,
%=	restore, reset, etc).

% mpred_database_term(P/A) is true iff P/A is something that pfc adds to
% the database and should not be present in an empty pfc database

/*
%% mpred_database_term( :PRED3VALUE1) is semidet.
%
% PFC Database Term.
%
mpred_database_term(basePFC:spft/5).
mpred_database_term(basePFC:pk/4).
mpred_database_term(basePFC:pt/3).  % was 3
mpred_database_term(basePFC:bt/3).  % was 3
mpred_database_term(basePFC:nt/4). % was 4
mpred_database_term('<-'/2).
mpred_database_term('==>'/2).
mpred_database_term('<==>'/2).
mpred_database_term(basePFC:qu/3).

% :- forall(mpred_database_term(T),shared_multifile(T)).


% removes all forward chaining rules and old_justifications from db.


%% mpred_reset is semidet.
%
% PFC Reset.
%
mpred_reset :-
 get_user_abox_umt(ABOX),
  (clause_i(basePFC:spft(ABOX,P,F,Trigger,Why),BB),BB),
  mpred_retract_or_warn_i(P),
  mpred_retract_or_warn_i(basePFC:spft(ABOX,P,F,Trigger,Why)),
  fail.
mpred_reset :-
  mpred_database_item(T),
  mpred_error("Pfc database not empty after mpred_reset, e.g., ~p.",[T]).
mpred_reset.

% true if there is some pfc crud still in the database.

%% mpred_database_item( ?Term) is semidet.
%
% PFC Database Item.
%
mpred_database_item(Term) :-
  mpred_database_term(P/A),
  functor(Term,P,A),
  clause_u(Term,_).


%% mpred_retract_or_warn_i( ?X) is semidet.
%
% PFC Retract Or Warn For Internal Interface.
%
mpred_retract_or_warn_i(X) :- retract_i(X),mpred_trace_msg("Success retract: ~p.",[X]),!.
mpred_retract_or_warn_i(X) :- get_user_abox_umt(ABOX), \+ \+ X =basePFC:spft(ABOX,~(_),_,_,_),!.
mpred_retract_or_warn_i(X) :- ground(X),mpred_trace_msg("Couldn't retract ~p.",[X]),!.
mpred_retract_or_warn_i(_).

*/
% ======================= mpred_file('pfcdebug').	% debugging aids (e.g. tracing).
%   File   : pfcdebug.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Updated:
%   Purpose: provides predicates for examining the database and debugginh
%   for Pfc.

:- dynamic mpred_is_spying/2.
:- thread_local mpred_is_tracing/1.
:- dynamic mpred_warnings/1.


%% mpred_is_tracing( ?VALUE1) is semidet.
%
% PFC If Is A Tracing.
%
get_mpred_is_tracing(_):- mpred_is_tracing_exec ; t_l:mpred_debug_local.

lmconf:module_local_init:- mpred_init_i(mpred_warnings(_), mpred_warnings(true)).




%% get_fa( ?PI, ?F, ?A) is semidet.
%
% Get Functor-arity.
%
get_fa(PI,_F,_A):-is_ftVar(PI),!.
get_fa(F/A,F,A):- !.
get_fa(PI,PI,_A):- atomic(PI),!.
get_fa(PI,F,A):- is_ftCompound(PI),!,functor(PI,F,A).
get_fa(Mask,F,A):-get_functor(Mask,F,A).



%% clause_or_call( ?H, ?B) is semidet.
%
% Clause Or Call.
%
clause_or_call(M:H,B):-is_ftVar(M),!,no_repeats(M:F/A,(f_to_mfa(H,M,F,A))),M:clause_or_call(H,B).
clause_or_call(isa(I,C),true):-!,req(isa_asserted(I,C)).
clause_or_call(genls(I,C),true):-!,on_x_log_throw(req(genls(I,C))).
clause_or_call(H,B):- clause(src_edit(_Before,H),B).
clause_or_call(H,B):- predicate_property(H,number_of_clauses(C)),predicate_property(H,number_of_rules(R)),((R*2<C) -> (clause_i(H,B)*->!;fail) ; clause_i(H,B)).
clause_or_call(H,true):- req(should_call_for_facts(H)),no_repeats(on_x_log_throw(H)).


% as opposed to simply using clause(H,true).

%% should_call_for_facts( ?H) is semidet.
%
% Should Call For Facts.
%
should_call_for_facts(H):- get_functor(H,F,A),with_umt(should_call_for_facts(H,F,A)).

%% should_call_for_facts( ?VALUE1, ?F, ?VALUE3) is semidet.
%
% Should Call For Facts.
%
should_call_for_facts(_,F,_):- a(prologSideEffects,F),!,fail.
should_call_for_facts(H,_,_):- modulize_head(H,HH), \+ predicate_property(HH,number_of_clauses(_)),!.
should_call_for_facts(_,F,A):- clause_true(mpred_mark(pfcRHS,_,F,A)),!,fail.
should_call_for_facts(_,F,A):- clause_true(mpred_mark(pfcMustFC,_,F,A)),!,fail.
should_call_for_facts(_,F,_):- a(prologDynamic,F),!.
should_call_for_facts(_,F,_):- \+ a(pfcControlled,F),!.



%% no_side_effects( ?P) is semidet.
%
% No Side Effects.
%
no_side_effects(P):-  (\+ is_side_effect_disabled->true;(get_functor(P,F,_),a(prologSideEffects,F))).

/*
%% is_disabled_clause( ?C) is semidet.
%
% If Is A Disabled Clause.
%
is_disabled_clause(C):-req(is_edited_clause(C,_,New)),memberchk((disabled),New).

%= mpred_fact(P) is true if fact P was asserted into the database via mpred_ain.


%% mpred_fact( ?P) is semidet.
%
% PFC Fact.
%
mpred_fact(P) :- mpred_fact(P,true).

%= mpred_fact(P,C) is true if fact P was asserted into the database via
%= assert and condition C is satisfied.  For example, we might do:
%=
%=  mpred_fact(X,mpred_user_fact(X))
%=



%% mpred_user_fact( ?X) is semidet.
%
% PFC User Fact.
%
mpred_user_fact(X):-get_user_abox_umt(ABOX),no_repeats(basePFC:spft(ABOX,X,U,U,_)).


%% mpred_fact( ?P, ?PrologCond) is semidet.
%
% PFC Fact.
%
mpred_fact(P,PrologCond) :-
  mpred_get_support(P,_),is_ftNonvar(P),
  once(mpred_db_type(P,F)),F=fact,
  call_prologsys(PrologCond).

%= mpred_facts(-ListofPfcFacts) returns a list of facts added.


%% mpred_facts( ?L) is semidet.
%
% PFC Facts.
%
mpred_facts(L) :- mpred_facts(_,true,L).


%% mpred_facts( ?P, ?L) is semidet.
%
% PFC Facts.
%
mpred_facts(P,L) :- mpred_facts(P,true,L).

%= mpred_facts(Pattern,Condition,-ListofPfcFacts) returns a list of facts added.


%% mpred_facts( ?P, ?C, ?L) is semidet.
%
% PFC Facts.
%
mpred_facts(P,C,L) :- setof(P,mpred_fact(P,C),L).


%% old_brake( ?X) is semidet.
%
% Brake.
%
old_brake(X) :-  X, break.
*/
%=
%=
%= predicates providing a simple tracing facility
%=
/*
NOT NEEDED ANYMORE
mpred_trace_add(P) :-
  % this is here for upward compat. - should go away eventually.
  mpred_trace_add(P,(o,o)).
*/
/*
mpred_trace_add(basePFC:bt(ABOX,Head,Body)) :-
  % hack for now - never trace triggers.
  !.
mpred_trace_add(basePFC:pt(ABOX,Head,Body)) :-
  % hack for now - never trace triggers.
  !.
mpred_trace_add(basePFC:nt(ABOX,Head,Condition,Body)) :-
  % hack for now - never trace triggers.
  !.
*/

%% mpred_trace_add( ?P, ?S) is semidet.
%
% PFC Trace add.
%
mpred_trace_add(P,S) :-
   mpred_trace_add_print(P,S),
   mpred_trace_break(P,S).


/*
%% mpred_trace_add_print( ?P, ?S) is semidet.
%
% PFC Trace add print.
%
mpred_trace_add_print(P,S):- (\+ \+ mpred_trace_add_print_0(P,S)).

%% mpred_trace_add_print_0( ?P, ?S) is semidet.
%
% PFC Trace add print  Primary Helper.
%
mpred_trace_add_print_0(P,S) :-
  get_mpred_is_tracing(P),
  !,
  must(S=(F,T)),
  (F==T
       -> mpred_trace_msg("Adding (~p) ~p ",[F,P])
        ; (((mpred_trace_msg("Adding (:) ~p    <-------- -n (~p <-TF-> ~p)",[P,(T),(F)]))))).

mpred_trace_add_print_0(_,_).



%% mpred_trace_break( ?P, ?S) is semidet.
%
% PFC Trace break.
%
mpred_trace_break(P,_S) :-
  mpred_is_spying(P,add) ->
   ((\+ \+ wdmsg("Breaking on mpred_ain(~p)",[P])),
    break)
   ; true.
*/
/*
mpred_trace_rem(Why,basePFC:bt(ABOX,Head,Body)) :-
  % hack for now - never trace triggers.
  !.
mpred_trace_rem(Why,basePFC:pt(ABOX,Head,Body)) :-
  % hack for now - never trace triggers.
  !.
mpred_trace_rem(Why,basePFC:nt(ABOX,Head,Condition,Body)) :-
  % hack for now - never trace triggers.
  !.
*/

/*
%% mpred_trace_rem( ?Why, ?P) is semidet.
%
% PFC Trace Remove/Erase.
%
mpred_trace_rem(Why,P) :-
  ((get_mpred_is_tracing(P);get_mpred_is_tracing(Why))
     -> (mpred_trace_msg('Removing (~p) ~p.',[Why,P]))
      ; true),
  ((mpred_is_spying(P,rem);mpred_is_spying(P,Why))
     -> (in_cmt(wdmsg("Breaking on remove(~p,~p)",[Why,P])), break)
   ; true),!.



%% mpred_no_spy_all is semidet.
%
% PFC No Spy All.
%
mpred_no_spy_all :- mpred_no_spy, retractall_u(mpred_is_tracing_exec).

%% mpred_no_trace_all is semidet.
%
% PFC no  Trace all.
%
mpred_no_trace_all :-  retractall_u(mpred_is_tracing_exec).

%% mpred_spy_all is semidet.
%
% PFC Spy All.
%
mpred_spy_all :- assert_u(mpred_is_tracing_exec).

%% mpred_trace_exec is semidet.
%
% PFC Trace exec.
%
mpred_trace_exec :- assert_u(mpred_is_tracing_exec),set_prolog_flag(gc,false).

%% mpred_notrace_exec is semidet.
%
% PFC No Trace Exec.
%
mpred_notrace_exec :- retractall_u(mpred_is_tracing_exec).

%% mpred_trace is semidet.
%
% PFC Trace.
%
mpred_trace :- mpred_trace(_).
lmconf:module_local_init:-mpred_no_trace_all.


%% mpred_trace( ?Form) is semidet.
%
% PFC Trace.
%
mpred_trace(Form) :-
  assert_u(mpred_is_tracing(Form)).


%% mpred_trace( ?Form, ?Condition) is semidet.
%
% PFC Trace.
%
mpred_trace(Form,Condition) :-
  assert_u((mpred_is_tracing(Form) :- Condition)).


%% mpred_spy( ?Form) is semidet.
%
% PFC Spy.
%
mpred_spy(Form) :- mpred_spy(Form,[add,rem],true).


%% mpred_spy( ?Form, ?Modes) is semidet.
%
% PFC Spy.
%
mpred_spy(Form,Modes) :- mpred_spy(Form,Modes,true).


%% mpred_spy( ?Form, ?Mode, ?Condition) is semidet.
%
% PFC Spy.
%
mpred_spy(Form,[add,rem],Condition) :-
  !,
  mpred_spy1(Form,add,Condition),
  mpred_spy1(Form,rem,Condition).

mpred_spy(Form,Mode,Condition) :-
  mpred_spy1(Form,Mode,Condition).


%% mpred_spy1( ?Form, ?Mode, ?Condition) is semidet.
%
% PFC Spy Secondary Helper.
%
mpred_spy1(Form,Mode,Condition) :-
  assert_u((mpred_is_spying(Form,Mode) :- Condition)).


%% mpred_no_spy is semidet.
%
% PFC No Spy.
%
mpred_no_spy :- mpred_no_spy(_,_,_).


%% mpred_no_spy( ?Form) is semidet.
%
% PFC No Spy.
%
mpred_no_spy(Form) :- mpred_no_spy(Form,_,_).


%% mpred_no_spy( ?Form, ?Mode, ?Condition) is semidet.
%
% PFC No Spy.
%
mpred_no_spy(Form,Mode,Condition) :-
  clause_i(mpred_is_spying(Form,Mode), Condition, Ref),
  erase_w_attvars(clause_i(mpred_is_spying(Form,Mode), Condition, Ref),Ref),
  fail.
mpred_no_spy(_,_,_).


%% mpred_no_trace is semidet.
%
% PFC no  Trace.
%
mpred_no_trace :- mpred_untrace.

%% mpred_untrace is semidet.
%
% PFC Un Trace.
%
mpred_untrace :- mpred_untrace(_).

%% mpred_untrace( ?Form) is semidet.
%
% PFC Un Trace.
%
mpred_untrace(Form) :- retractall_u(mpred_is_tracing(Form)).

% needed:  mpred_trace_rule(Name)  ...


% if the correct flag is set, trace exection of Pfc

%% mpred_trace_msg( ?Msg) is semidet.
%
% PFC Trace msg.
%
mpred_trace_msg(Msg) :- mpred_trace_msg('~p.',[Msg]),!.

*/

%% mmsg( ?Msg, ?Args) is semidet.
%
% Module Message.
%
mmsg(Msg,Args):- is_list(Args) -> wdmsg(Msg, Args) ; pp_item(Msg, Args).

:- was_dynamic(mpred_hide_msg/1).

%% mpred_hide_msg( ?VALUE1) is semidet.
%
% PFC Hide Msg.
%
mpred_hide_msg('Adding For Later').
mpred_hide_msg('Skipped Trigger').
mpred_hide_msg('Had Support').

/*

% mpred_trace_msg(Msg,Args) :- !, mmsg(Msg,Args).
% mpred_trace_msg(Msg,_Args) :- mpred_hide_msg(Msg),!.

%% mpred_trace_msg( ?Msg, ?Args) is semidet.
%
% PFC Trace msg.
%
mpred_trace_msg(Msg,Args) :- ignore((mpred_is_tracing_exec, !, mmsg(Msg,Args))),!.




%% mpred_watch is semidet.
%
% PFC Watch.
%
mpred_watch :- assert_u(mpred_is_tracing_exec).


%% mpred_no_watch is semidet.
%
% PFC No Watch.
%
mpred_no_watch :-  retractall_u(mpred_is_tracing_exec).


%% mpred_error( ?Msg) is semidet.
%
% PFC Error.
%
mpred_error(Msg) :-  mpred_error(Msg,[]).


%% mpred_error( ?Msg, ?Args) is semidet.
%
% PFC Error.
%
mpred_error(Msg,Args) :-
 ignore((in_cmt(( wdmsg("ERROR/Pfc: ",[]),wdmsg(Msg,Args))))),!.


%=
%= These control whether or not warnings are printed at all.
%=   mpred_warn.
%=   nmpred_warn.
%=
%= These print a warning message if the flag mpred_warnings is set.
%=   mpred_warn(+Message)
%=   mpred_warn(+Message,+ListOfArguments)
%=


%% mpred_warn is semidet.
%
% PFC Warn.
%
mpred_warn :-
  retractall_u(mpred_warnings(_)),
  assert_u(mpred_warnings(true)).


%% nmpred_warn is semidet.
%
% Nompred Warn.
%
nmpred_warn :-
  retractall_u(mpred_warnings(_)),
  assert_u(mpred_warnings(false)).


%% mpred_warn( ?Msg) is semidet.
%
% PFC Warn.
%
mpred_warn(Msg) :-  mpred_warn(Msg,[]).

*/


lmconf:module_local_init:-mpred_warn.

/*
%% mpred_warn( ?Msg, ?Args) is semidet.
%
% PFC Warn.
%
mpred_warn(Msg,Args) :-
  gethostname(ubuntu),!,
 ignore((
  sformat(S, Msg,Args),
  show_source_location,
  wdmsg(pfc(warn(S))))),!.

mpred_warn(Msg,Args) :-
 ignore((
 (mpred_warnings(true); \+ mpred_is_silient),
  !,
  sformat(S, Msg,Args),
  show_source_location,
  wdmsg(pfc(warn(S))))),!.


%=
%= mpred_warnings/0 sets flag to cause pfc warning messages to print.
%= mpred_no_warnings/0 sets flag to cause pfc warning messages not to print.
%=


%% mpred_warnings is semidet.
%
% PFC Warnings.
%
mpred_warnings :-
  retractall_u(mpred_warnings(_)),
  assert_u(mpred_warnings(true)).


%% mpred_no_warnings is semidet.
%
% PFC No Warnings.
%
mpred_no_warnings :-
  retractall_u(mpred_warnings(_)).
*/

% ======================= mpred_file('pfcjust').	% predicates to manipulate old_justifications.


%   File   : pfcjust.pl
%   Author : Tim Finin, finin@prc.unisys.com
%   Author :  Dave Matuszek, dave@prc.unisys.com
%   Updated:
%   Purpose: predicates for accessing Pfc old_justifications.
%   Status: more or less working.
%   Bugs:

%= *** predicates for exploring supports of a fact *****

/*
:- use_module(library(lists)).


%% justification( ?F, ?J) is semidet.
%
% Justification.
%
justification(F,J) :- supporters_list(F,J).


%% old_justifications( ?F, ?Js) is semidet.
%
% Justifications.
%
old_justifications(F,Js) :- bagof(J,justification(F,J),Js).


%% baseable( ?P, ?L) is semidet.
% - is true iff L is a list of "baseable" facts which, taken
% together, allows us to deduce P.  A baseable fact is an mpred_axiom (a fact
% added by the user or a raw Prolog fact (i.e. one w/o any support))
% or an mpred_assumption.
baseable(F,[F]) :- (mpred_axiom(F) ; mpred_assumption(F)),!.
baseable(F,L) :-
  % i.e. (reduce 'append (map 'baseable (justification f)))
  justification(F,Js),
  baseable_list(Js,L).




%% baseable_list( ?L1, ?L2) is semidet.
% baseable_list(L1,L2) is true if list L2 represents the union of all of the
% facts on which some conclusion in list L1 is based.
baseable_list([],[]).
baseable_list([X|Rest],L) :-
  baseable(X,Bx),
  baseable_list(Rest,Br),  
  mpred_union(Bx,Br,L).
	


%% mpred_axiom( ?F) is semidet.
%
% PFC Axiom.
%
mpred_axiom(F) :-
  %mpred_get_support(F,UU);
  %mpred_get_support(F,(g,g));
  mpred_get_support(F,(OTHER,OTHER)).

%= an mpred_assumption is a failed action, i.e. were assuming that our failure to
%= prove P is a proof of not(P)


%% mpred_assumption( ?P) is semidet.
%
% Assumption.
%
mpred_assumption(P) :- is_ftNonvar(P),mpred_negation(P,_).

%= mpred_assumptions(X,As) if As is a set of mpred_assumptions which underly X.


%% mpred_assumptions( ?X, ?L) is semidet.
%
% Assumptions.
%
mpred_assumptions(X,[X]) :- mpred_assumption(X).
mpred_assumptions(X,[]) :- mpred_axiom(X).
mpred_assumptions(X,L) :-
  justification(X,Js),
  mpred_assumptions1(Js,L).


%% mpred_assumptions1( :TermX, ?L) is semidet.
%
% Assumptions Secondary Helper.
%
mpred_assumptions1([],[]).
mpred_assumptions1([X|Rest],L) :-
  mpred_assumptions(X,Bx),
  mpred_assumptions1(Rest,Br),
  mpred_union(Bx,Br,L).


%= pfcProofTree(P,T) the proof tree for P is T where a proof tree is
%= of the form
%=
%=     [P , J1, J2, ;;; Jn]         each Ji is an independent P justifier.
%=          ^                         and has the form of
%=          [J11, J12,... J1n]      a list of proof trees.


% mpred_child(P,Q) is true iff P is an immediate justifier for Q.
% mode: mpred_child(+,?)


%% mpred_child( ?P, ?Q) is semidet.
%
% PFC Child.
%
mpred_child(P,Q) :-
  mpred_get_support(Q,(P,_)).

mpred_child(P,Q) :-
  mpred_get_support(Q,(_,Trig)),
  mpred_db_type(Trig,trigger),
  mpred_child(P,Trig).


%% mpred_children( ?P, ?L) is semidet.
%
% PFC Children.
%
mpred_children(P,L) :- bagof(C,mpred_child(P,C),L).

% mpred_descendant(P,Q) is true iff P is a justifier for Q.


%% mpred_descendant( ?P, ?Q) is semidet.
%
% PFC Descendant.
%
mpred_descendant(P,Q) :-
   mpred_descendant1(P,Q,[]).


%% mpred_descendant1( ?P, ?Q, ?Seen) is semidet.
%
% PFC Descendant Secondary Helper.
%
mpred_descendant1(P,Q,Seen) :-
  mpred_child(X,Q),
  (\+ member(X,Seen)),
  (P=X ; mpred_descendant1(P,X,[X|Seen])).


%% mpred_descendants( ?P, ?L) is semidet.
%
% PFC Descendants.
%
mpred_descendants(P,L) :-
  bagof(Q,mpred_descendant1(P,Q,[]),L).

*/

:- was_dynamic(baseKB:prologMacroHead/1).


%% compute_resolve( ?NewerP, ?OlderQ, ?SU, ?SU, ?OlderQ) is semidet.
%
% Compute Resolve.
%
compute_resolve(NewerP,OlderQ,SU,SU,(mpred_blast(OlderQ),mpred_ain(NewerP,S),mpred_withdraw(conflict(NewerP)))):-
  must(correctify_support(SU,S)),
  wdmsg(compute_resolve(newer(NewerP-S)>older(OlderQ-S))).
compute_resolve(NewerP,OlderQ,S1,[U],Resolve):-compute_resolve(OlderQ,NewerP,[U2],S1,Resolve),match_source_ref1(U),match_source_ref1(U2),!.
compute_resolve(NewerP,OlderQ,SU,S2,(mpred_blast(OlderQ),mpred_ain(NewerP,S1),mpred_withdraw(conflict(NewerP)))):-
  must(correctify_support(SU,S1)),
  wdmsg(compute_resolve((NewerP-S1)>(OlderQ-S2))).



%% compute_resolve( ?NewerP, ?OlderQ, ?Resolve) is semidet.
%
% Compute Resolve.
%
compute_resolve(NewerP,OlderQ,Resolve):-
   supporters_list(NewerP,S1),
   supporters_list(OlderQ,S2),
   compute_resolve(NewerP,OlderQ,S1,S2,Resolve).



%% is_resolved( ?C) is semidet.
%
% If Is A Resolved.
%
is_resolved(C):- Why= is_resolved, mpred_call_only_facts(Why,C),\+mpred_call_only_facts(Why,~(C)).
is_resolved(C):- Why= is_resolved, mpred_call_only_facts(Why,~(C)),\+mpred_call_only_facts(Why,C).

:- must(nop(_)).


%% mpred_prove_neg( ?G) is semidet.
%
% PFC Prove Negated.
%
mpred_prove_neg(G):-nop(trace), \+ mpred_bc_only(G), \+ mpred_fact(G).


%% pred_head( :PRED1Type, ?P) is semidet.
%
% Predicate Head.
%
pred_head(Type,P):- no_repeats_u(P,(call(Type,P),\+ nonfact_metawrapper(P),is_ftCompound(P))).


%% pred_head_all( ?P) is semidet.
%
% Predicate Head All.
%
pred_head_all(P):- pred_head(pred_all,P).


%% nonfact_metawrapper( :TermP) is semidet.
%
% Nonfact Metawrapper.
%
nonfact_metawrapper(~(_)).
nonfact_metawrapper(basePFC:pt(_,_,_)).
nonfact_metawrapper(basePFC:bt(_,_,_)).
nonfact_metawrapper(basePFC:nt(_,_,_,_)).
nonfact_metawrapper(basePFC:spft(_,_,_,_,_)).
nonfact_metawrapper(added(_)).
% we use the arity 1 forms is why 
nonfact_metawrapper(term_expansion(_,_)).
nonfact_metawrapper(P):- \+ current_predicate(_,P).
nonfact_metawrapper(P):- get_functor(P,F,_), 
   (a(prologSideEffects,F);a(tNotForUnboundPredicates,F)).
nonfact_metawrapper(P):-rewritten_metawrapper(P).


%% rewritten_metawrapper( ?C) is semidet.
%
% Rewritten Metawrapper.
%
rewritten_metawrapper(_):-!,fail.
%rewritten_metawrapper(isa(_,_)).
rewritten_metawrapper(C):-is_ftCompound(C),functor(C,t,_).


%% meta_wrapper_rule( :TermARG1) is semidet.
%
% Meta Wrapper Rule.
%
meta_wrapper_rule((_<-_)).
meta_wrapper_rule((_<==>_)).
meta_wrapper_rule((_==>_)).
meta_wrapper_rule((_:-_)).



%% pred_all( ?P) is semidet.
%
% Predicate All.
%
pred_all(P):-pred_u0(P).
pred_all(P):-pred_t0(P).
pred_all(P):-pred_r0(P).


%% pred_u0( ?P) is semidet.
%
% Predicate For User Code Primary Helper.
%
pred_u0(P):-pred_u1(P),has_db_clauses(P).
pred_u0(P):-pred_u2(P).

%% pred_u1( ?VALUE1) is semidet.
%
% Predicate For User Code Secondary Helper.
%
pred_u1(P):-a(pfcControlled,F),arity(F,A),functor(P,F,A).
pred_u1(P):-a(prologHybrid,F),arity(F,A),functor(P,F,A).
pred_u1(P):-a(prologDynamic,F),arity(F,A),functor(P,F,A).

%% pred_u2( ?P) is semidet.
%
% Predicate For User Code Extended Helper.
%
pred_u2(P):-support_hilog(F,A),functor(P,F,A),has_db_clauses(P).
pred_u2(P):-clause_true(arity(F,A)),functor(P,F,A),has_db_clauses(P).



%% has_db_clauses( ?PI) is semidet.
%
% Has Database Clauses.
%
has_db_clauses(PI):-modulize_head(PI,P),predicate_property(P,number_of_clauses(NC)),\+ predicate_property(P,number_of_rules(NC)), \+ \+ clause_i(P,true).


%% pred_t0( ?P) is semidet.
%
% Predicate True Stucture Primary Helper.
%
pred_t0(P):- get_user_abox_umt(ABOX),pred_t0(ABOX,P).
pred_t0(P):- mreq('nesc'(P)).


%% pred_t0( ?ABOX, ?P) is semidet.
%
% Predicate True Stucture Primary Helper.
%
pred_t0(ABOX,P):-mreq(basePFC:pt(ABOX,P,_)).
pred_t0(ABOX,P):-mreq(basePFC:bt(ABOX,P,_)).
pred_t0(ABOX,P):-mreq(basePFC:nt(ABOX,P,_,_)).
pred_t0(ABOX,P):-mreq(basePFC:spft(ABOX,P,_,_,_)).

%pred_r0(-(P)):- req(-(P)).
%pred_r0(~(P)):- mreq(~(P)).


%% pred_r0( :TermP) is semidet.
%
% Predicate R Primary Helper.
%
pred_r0(P==>Q):- mreq(P==>Q).
pred_r0(P<==>Q):- mreq(P<==>Q).
pred_r0(P<-Q):- mreq(P<-Q).


%% cnstrn( ?X) is semidet.
%
% Cnstrn.
%
cnstrn(X):-term_variables(X,Vs),maplist(cnstrn0(X),Vs),!.

%% cnstrn( ?V, ?X) is semidet.
%
% Cnstrn.
%
cnstrn(V,X):-cnstrn0(X,V).

%% cnstrn0( ?X, ?V) is semidet.
%
% Cnstrn Primary Helper.
%
cnstrn0(X,V):-when(is_ftNonvar(V),X).


%% rescan_pfc is semidet.
%
% Rescan Prolog Forward Chaining.
%
rescan_pfc:-forall(clause(lmconf:mpred_hook_rescan_files,Body),show_entry(rescan_pfc,Body)).


%% mpred_facts_and_universe( ?P) is semidet.
%
% PFC Facts And Universe.
%
mpred_facts_and_universe(P):- (is_ftVar(P)->pred_head_all(P);true),req(P). % (meta_wrapper_rule(P)->req(P) ; req(P)).

/*
%add_reprop(_,_):-!.

%% add_reprop( ?Trig, :TermVar) is semidet.
%
% Add Reprop.
%
add_reprop(_Trig,Var):- is_ftVar(Var), !. % trace_or_throw(var_add_reprop(Trig,Var)).
add_reprop(_Trig,~(Var)):- is_ftVar(Var),!.
% CREATES ERROR!!!  add_reprop(_Trig,~(_Var)):-!.
add_reprop(_Trig,~(repropagate(Var))):- \+ is_ftVar(Var),!.
add_reprop(_Trig,repropagate(~(Var))):- \+ is_ftVar(Var),!.
add_reprop(_Trig,repropagate(Var)):- \+ is_ftVar(Var),!.
% add_reprop(_Trig,_):-!.
add_reprop(Trig,(H:-B)):- trace_or_throw(bad_add_reprop(Trig,(H:-B))).

% instant 
add_reprop(Trig ,Trigger):- fail, !, w_tl(t_l:current_why_source(Trig),  repropagate(Trigger)).

% settings
add_reprop( Trig ,Trigger):- fail,
  w_tl(t_l:current_why_source(Trig),
    (
     mpred_fwd(repropagate(Trigger),Trig))),!.

% delayed
add_reprop( Trig ,Trigger):- 
  w_tl(t_l:current_why_source(Trig),
    (get_user_abox_umt(ABOX),
     show_call(attvar_op(assertz_if_new,(basePFC:qu(ABOX,repropagate(Trigger),(Trig,g))))))).
*/

%% repropagate( :TermP) is semidet.
%
% Repropagate.
%
repropagate(_):-  check_context_module,fail.
%repropagate(P):-  check_real_context_module,fail.

repropagate(P):-  is_ftVar(P),!.
repropagate(P):-  meta_wrapper_rule(P),!,with_umt(repropagate_meta_wrapper_rule(P)).
repropagate(P):-  \+ predicate_property(P,_),'$find_predicate'(P,PP),PP\=[],!,forall(member(M:F/A,PP),
                                                          must((functor(Q,F,A),repropagate_1(M:Q)))).
repropagate(F/A):- atom(F),integer(A),!,functor(P,F,A),!,repropagate(P).
repropagate(F/A):- atom(F),is_ftVar(A),!,repropagate(F).

repropagate(P):-  \+ predicate_property(_:P,_),dmsg(undefined_repropagate(P)),dumpST,dtrace,!,fail.
repropagate(P):-  repropagate_0(P).


%% repropagate_0( ?P) is semidet.
%
% repropagate  Primary Helper.
%
repropagate_0(P):- loop_check(with_umt(repropagate_1(P)),true).

:- thread_local t_l:is_repropagating/1.


%% repropagate_1( ?P) is semidet.
%
% repropagate  Secondary Helper.
%
repropagate_1(P):- is_ftVar(P),!.
repropagate_1(USER:P):- USER==user,!,repropagate_1(P).
%repropagate_1((P/_)):-!,repropagate_1(P).

repropagate_1(P):- with_umt(repropagate_2(P)).

:- export(repropagate_2/1).
:- module_transparent(repropagate_2/1).

%% repropagate_2( ?P) is semidet.
%
% repropagate  Extended Helper.
%
repropagate_2(P):-
 doall((no_repeats((mpred_facts_and_universe(P))),
    w_tl(t_l:is_repropagating(P),ignore((once(show_failure(fwd_ok(P))),show_call(mpred_fwd(P))))))).

% repropagate_meta_wrapper_rule(P==>_):- !, repropagate(P).

%% repropagate_meta_wrapper_rule( ?P) is semidet.
%
% Repropagate Meta Wrapper Rule.
%
repropagate_meta_wrapper_rule(P):-repropagate_1(P).


%% fwd_ok( :TermP) is semidet.
%
% Forward Repropigated Ok.
%
fwd_ok(_):-!.
fwd_ok(P):-ground(P),!.
fwd_ok(if_missing(_,_)).
fwd_ok(idForTest(_,_)).
fwd_ok(clif(_)).
fwd_ok(pfclog(_)).
fwd_ok(X):-compound(X),arg(_,X,E),compound(E),functor(E,(:-),_),!.
% fwd_ok(P):-must(ground(P)),!.


%% mpred_facts_only( ?P) is semidet.
%
% PFC Facts Only.
%
mpred_facts_only(P):- (is_ftVar(P)->(pred_head_all(P),\+ meta_wrapper_rule(P));true),no_repeats(P).

:- thread_local(t_l:in_rescan_mpred_hook/0).

%% mpred_hook_rescan_files is semidet.
%
% Hook To [lmconf:mpred_hook_rescan_files/0] For Module Mpred_pfc.
% PFC Hook Rescan Files.
%
lmconf:mpred_hook_rescan_files:- forall(mpred_facts_and_universe(P),w_tl(t_l:in_rescan_mpred_hook,mpred_fwd(P))).
lmconf:mpred_hook_rescan_files:- forall(mpred_facts_and_universe(P),w_tl(t_l:in_rescan_mpred_hook,mpred_scan_tms(P))).
/*
lmconf:mpred_hook_rescan_files:- forall(pred_head(pred_u0,P), 
                          forall(no_repeats(P,call(P)),
                            show_if_debug(mpred_fwd(P)))).
*/


:- retractall(t_l:mpred_debug_local).
:- retractall(mpred_is_tracing_exec).
:- retractall(mpred_is_tracing(_)).

:- logicmoo_util_shared_dynamic:asserta_if_new((ereq(G):- !, req(G))).
:- ignore((logicmoo_util_shared_dynamic:retract((ereq(G):- find_and_call(G))),fail)).
% :- logicmoo_util_shared_dynamic:listing(ereq/1).



:- source_location(S,_),prolog_load_context(module,M),forall(source_file(M:H,S),(functor(H,F,A),M:module_transparent(M:F/A),M:export(M:F/A))).

%% mpred_pfc_file is det.
%
% PFC Forward Chaining File.
%
mpred_pfc_file. 

% :- doall(lmconf:module_local_init).


:- endif.