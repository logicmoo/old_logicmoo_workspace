/* ***********************************/
/* Douglas Miles 2005, 2010, 2014 */
/* Denton, TX */
/* ***********************************/
/* Donghong Liu */
/* University of Huddersfield */
/* September 2002 */
/* **********************************/
/* gipohyhtn.pl */
/* HyHTN planning: do preprocess first  */
/* make all method and operators primitive */
/* htncode.pl */

planner_failure(Why,Info):-dmsg(error,Why-Info),banner_party(error,'FAILURE_PLANNER'),print_message(error,'FAILURE_PLANNER'(Why,Info)),!. %sleep(2).

:- discontiguous(post_header_hook/0).
:- thread_local((canDoTermExp/0)).
:-thread_local thlocal:doing/1.
:-retractall(canDoTermExp).
:-dynamic(env_kb/1).

statistics_runtime(CP):-statistics(process_cputime,[_,CP0]), CP is CP0 + 0.0000000000001 .

/*********************** initialisation**************/
:-dynamic( in_dyn/2).
in_dyn(_DB,Call):- var(Call),!,mpred_arity(F,A),functor(Call,F,A),( predicate_property(Call,_) -> loop_check(Call)).
in_dyn(_DB,Call):- functor(Call,F,A), mpred_arity(F,A), predicate_property(Call,_), !, loop_check(Call).
in_dyn_pred(_DB,Call):- var(Call),!,mpred_arity(F,A),functor(Call,F,A),( predicate_property(Call,_) -> loop_check(Call)).
in_dyn_pred(_DB,Call):- functor(Call,F,A), mpred_arity(F,A), predicate_property(Call,_), !, loop_check(Call).


env_mpred(Prop,F,A):- mpred_prop(F,Prop),ignore(mpred_arity(F,A)).

get_mpred_stubType(F,A,StubIn):- env_mpred(stubType(Stub),F,A),!,must(StubIn=Stub).
get_mpred_stubType(F,A,dyn):-env_mpred(dyn,F,A).

:-assert_if_new(env_kb(l)).
:-assert_if_new(env_kb(g)).
:-assert_if_new(env_kb(dyn)).
:-nb_setval(disabled_env_learn_pred,false).

decl_mpred_env(_,[]):-!.
decl_mpred_env(Props,[H|T]):-!,decl_mpred_env(Props,H),decl_mpred_env(Props,T).
decl_mpred_env(Props,(H,T)):-!,decl_mpred_env(Props,H),decl_mpred_env(Props,T).
decl_mpred_env([H|T],Pred):-!,decl_mpred_env(H,Pred),decl_mpred_env(T,Pred).
decl_mpred_env((H,T),Pred):-!,decl_mpred_env(H,Pred),decl_mpred_env(T,Pred).
decl_mpred_env(kb(KB),_):- assert_if_new(env_kb(KB)),fail.
decl_mpred_env(stubType(dyn),Pred):-!, decl_mpred_env(dyn,Pred).
decl_mpred_env(Prop,Pred):- functor_h(Pred,F,A),decl_mpred_env(Prop,Pred,F,A).

decl_mpred_env(Prop,Pred,F,A):- !,swi_export(F/A),dynamic(F/A),multifile(F/A), decl_mpred(Pred,Prop),!.

env_learn_pred(_,_):-nb_getval(disabled_env_learn_pred,true),!.
env_learn_pred(ENV,P):-decl_mpred_env(ENV,P).

env_recorded(call,Val) :- recorded(Val,Val).
env_recorded(assert, Val) :- recordz(Val,Val).
env_recorded(asserta, Val) :- recorda(Val,Val).
env_recorded(retract, Val) :- recorded(Val,Val,Ref), erase(Ref).
env_recorded(retractall, Val) :- foreach( recorded(Val,Val,Ref), erase(Ref) ).

lg_op2(rec_db,OP,env_recorded(OP)).
lg_op2(g,OP,OP).

lg_op2(_,OP,OP).

simplest(_LG):-!.

env_clear(kb(Dom)):-nonvar(Dom),!,env_clear(Dom).
env_clear(Dom):- forall(env_mpred(Dom,F,A),env_op(retractall(F/A))).

env_op(OP_P):- OP_P=..[OP,P],env_lg_op(OP,P).

env_lg_op(OP,P):-functor_h(P,F,A),must(get_mpred_stubType(F,A,ENV)),!,env_op(ENV,OP,P).

env_shadow(OP,P):-call(OP,P).

env_op(ENV,OP_P):- simplest(ENV),!,OP_P.
env_op(ENV,call(P)):-env_op(ENV,call,P).
env_op(ENV,assert(P)):-env_op(ENV,assert,P).
env_op(ENV,asserta(P)):-env_op(ENV,asserta,P).
env_op(ENV,retract(P)):-env_op(ENV,retract,P).
env_op(ENV,retractall(P)):-env_op(ENV,retractall,P).
env_op(ENV,OP_P):- OP_P=..[OP,P], env_op(ENV,OP,P).


env_op(_,_,[]):-!.
env_op(ENV,OP,F/A):- var(A),!, forall(env_mpred(ENV,F,A),((functor(P,F,A),env_op(ENV,OP,P)))).
env_op(ENV,retractall,F/A):-functor(P,F,A),!,env_op(ENV,retractall,P).
% env_op(ENV,OP,Dom):- env_kb(Dom),!,forall(env_mpred(Dom,F,A),env_op(ENV,OP,F/A)).
% env_op(ENV,OP,F/A):-!, functor(P,F,A), (((get_mpred_stubType(F,A,LG2),LG2\==ENV)  -> env_op(LG2,OP,P) ; env_op(ENV,OP,P) )).
% env_op(_,retractall,P):-functor_h(P,F,A),must(get_mpred_stubType(F,A,_)),fail.
% env_op(ENV,OP,P):- functor_h(P,F,A),  (((get_mpred_stubType(F,A,LG2),LG2\==ENV)  -> env_op(LG2,OP,P) ; fail )).
env_op(ENV,OP,P):- functor_h(P,F,A),  (((get_mpred_stubType(F,A,LG2),LG2\==ENV)  -> env_op2(LG2,OP,P) ; env_op2(ENV,OP,P) )).


env_op2(dyn,OP,P):- !,call(OP,P).
env_op2(ENV,OP,(A,B)):-!, env_op(OP,A), env_op(ENV,OP,B).
env_op2(ENV,OP,[A|B]):-!, env_op(ENV,OP,A), env_op(ENV,OP,B).

env_op2(in_dyn(DB),OP,P):- !, call(OP,in_dyn(DB,P)).
env_op2(in_pred(DB),OP,P):-!, DBPRED=..[DB,P], call(OP,DBPRED).
env_op2(with_pred(Pred),OP,P):-!, call(Pred,OP,P).
% env_op2(ENV,OP,P):- dmsg(env_op2(ENV,OP,P)),fail.
env_op2(ENV,OP,P):- lg_op2(ENV,OP,OP2),!,call(OP2,P).
env_op2(ENV,OP,P):- trace,simplest(ENV),!,call(OP,P).
env_op2(stubType(ENV),OP,P):-!,env_op(ENV,OP,P).
% !,env_op2(in_dyn(DB),OP,P).
env_op2(_,OP,P):-!,env_op2(in_dyn(db),OP,P).
env_op2(_,_,_):-trace,fail.
env_op2(l,OP,P):-!,call(OP,P).
env_op2(g,OP,P):-!,call(OP,P).
env_op2(l,OP,P):-!,env_op2(dyn,OP,P).
env_op2(l,OP,P):-!,env_op2(in_dyn(db),OP,P).
env_op2(l,OP,P):-!,env_op2(rec_db,OP,P).
env_op2(g,asserta,P):-retractall(P),asserta(P).
env_op2(g,assert,P):-assert_if_new(P).
env_op2(g,retract,P):-env_op2(g,call,P),retract(P).
env_op2(g,retractall,P):-foreach(env_op2(g,call,P),retractall(P)).
env_op2(ENV,OP,P):-env_learn_pred(ENV,P),lg_op2(ENV,OP,OP2),!,call(OP2,P).
env_op2(_,OP,P):-call(OP,P).

ppi(P):-functor(P,tp_node,_),!.
ppi(P):-predicate_property(P,number_of_clauses(NC)),!,(NC<200->true;(dmsg((number_of_clauses(NC):-P)))),!.
ppi(_).

env_call(P):- env_lg_op(call,P),ppi(P).
env_assert(P):- env_lg_op(assert,P).
env_asserta(P):- env_lg_op(asserta,P).
env_retract(P):- env_lg_op(retract,P).
env_retractall(P):-env_lg_op(retractall,P).


tryff(Call):- predicate_property(Call,_),!,once(tryf((Call,assert(passed_test_try(Call))))),fail.
tryf(Call):- predicate_property(Call,_),!,catch(Call,E,dmsg(E = Call)).
trye(Call):- catch(Call,E,((dmsg(error(E , Call)),trace,Call))).

:-dynamic(passed_test_try/1).
:-dynamic(testing_already/0).

check_passed_any:-not(not(passed_test_try(_))),nl,listing(passed_test_try/1).

ttm:-retractall(passed_test_try(_)),fail.
ttm:-testing_already,!.
ttm:-asserta(testing_already), make, retractall(testing_already),fail.


get_tasks(N,Goal,State):-htn_task(N,Goal,State).
get_tasks(N,Goal,State):-planner_task(N,Goal,State).

banner_party(E,BANNER):- 
      dmsg(E,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx':E),
      dmsg(E,BANNER),
      forall(thlocal:doing(X),dmsg(E,doing(X))),
      dmsg(E,'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx':E),
      dmsg(E,BANNER),!.


tasks:- 
 Call = get_tasks(N,Goal,State),
   setof(Call,Call,List),list_to_set(List,Set),!,
   env_info(domfile),!,
   once((ignore(forall(member(Call,Set),
     with_assertions(thlocal:doing(tasks(N,Goal)),
      ((
      must(nonvar(Goal)),must(nonvar(State)),
      ignore(N=Goal),      
      must((term_expansion_alias((Goal:-State),(GGoal:-GState)))),
      must(nonvar(GGoal)),must(nonvar(GState)),
      banner_party(informational,('GOAL'(N):-GGoal)),
      must(((once( once(startOCL(GGoal,GState))*->banner_party(informational,'SUCCESSS');banner_party(error,'FAILUR!!!!!!!!!!!!!!!!!!!!!!!!!!!E')))))))))))).

t:- once(run_header_tests).

tt:-catch(ttm,E,dmsg(E)),!.

tt:-tryff((tasks)).
tt:-tryff((task1)).
tt:-tryff((task2)).
tt:-tryff((task3)).
tt:-tryff((task4)).
tt:-tryff((task5)).
tt:-tryff((task6)).
tt:-tryff((task7)).
tt:-tryff((task8)).
tt:-tryff((task9)).
tt:-tryff((task10)).
tt:-tryff((task11)).
tt:-tryff((task22)).
tt:-tryff((task33)).
tt:-tryff((task44)).
tt:-check_passed_any,!.


tdom:-tdom([htn1,ty,ocl1,r3]).
tdom2:-tdom([ocl2,htn2,htn3,htn4]).

tdomfile(F):-tdomcall(load_data_file(F)).
tdomcall(Call):- trye(once((env_clear_doms_and_tasks,trye(Call),tt))).

tdom([]):-!.
tdom([H|T]):- !, tdom(H),tdom(T).
tdom(H):- predicate_property(H,_),!, call(H).
tdom(F):- tdom1(F),!.
tdom(F):- expand_file_name(F,List),List\=[],!,tdom1(List).
tdom(F):- throw(tdom(F)).

tdom1([]):-!.
tdom1([H|T]):- !, tdom(H),tdom(T).
tdom1(F):- tdom2(F),!.
tdom1(FIn):- atom(FIn),tdom2(FIn).

tdom2(FIn):- tdom3(FIn),!.
tdom2(FIn):- atom_concat('domains/',FIn,F), tdom3(F),!.

tdom3(FIn):- tdom4(FIn).
tdom3(FIn):- atom_concat(FIn,'htn',F),tdom4(F).
tdom3(FIn):- atom_concat(FIn,'ocl',F),tdom4(F).

tdom4(F):- exists_file(F),!,tdomfile(F).


post_header_hook:-retractall(canDoTermExp).
% user:term_expansion(In,Out):- canDoTermExp,term_expansion_hyhtn(In,M),In\=@=M,expand_term(M,Out).
% user:goal_expansion(In,Out):- canDoTermExp,term_expansion_hyhtn(In,M),In\=@=M,expand_goal(M,Out).
post_header_hook:-asserta(canDoTermExp).

env_clear_doms_and_tasks:- env_clear(kb(domfile)),env_clear(kb(domtasks)),env_clear(kb(domcache)),!.
   

:- op(100,xfy,'=>').

env_info(O):- forall(env_info(O,Info),portray_clause(env_info(O):-Info)).

env_info(Type,Infos):- env_kb(Type),atom(Type),!,findall(Info,env_1_info(Type,Info),Infos),!.
env_info(Pred,Infos):- (nonvar(Pred)-> env_predinfo(Pred,Infos) ; (mpred_arity(F,A),Pred=F/A,env_predinfo(Pred,Infos))),!.


harvest_preds(Type,Functors):-
 findall(functor(P,F,A),((mpred_arity(F,A),(env_mpred(Type,F,A);Type=F),functor(P,F,A))),Functors).

env_1_info(Type,[predcount(NC)|Infos]):- 
 gensym(env_1_info,Sym),flag(Sym,_,0),
   harvest_preds(Type,PFAs),
    findall(F/A - PredInf,
      (member(functor(P,F,A),PFAs),
        predicate_property(P,number_of_clauses(NC)),
        env_predinfo(P,PredInf),
        flag(Sym,X,X+NC)),
    Infos),flag(Sym,NC,0).

env_predinfo(PIn,Infos):- functor_h(PIn,F,A),mpred_arity(F,A),functor(P,F,A),findall(Info,pred_1_info(P,F,A,Info),Infos).

pred_1_info(P,_,_,Info):- member(Info:Prop,[count(NC):number_of_clauses(NC),mf:multifile,dyn:dynamic,vol:volitile,local:local]),predicate_property(P,Prop).
pred_1_info(_,F,A,Info):- env_mpred(Info,F,A).
pred_1_info(_,F,A,F/A).


% :-set_prolog_flag(verbose_file_search,true).
post_header_hook:-set_prolog_flag(verbose_load,full).
post_header_hook:-use_module(library(lists)).
:- style_check(-singleton).
:- style_check(+discontiguous).

post_header_hook:-use_module(library(system)).
post_header_hook:-catch(guitracer,_,true).
post_header:- !.
post_header:- dmsg(post_header),fail, forall(clause(post_header_hook,G),G). 


:- discontiguous(header_tests/0).

run_tests(Call) :- 
  statistics_runtime(InTime),  
  with_assertions(doing(run_tests(Call)),
   call_cleanup(Call, 
  ((
 statistics_runtime(OutTime),
  Time is OutTime - InTime,
  banner_party(informational,runtests(Call) = time(Time)))))).

run_header_tests :- run_tests(forall(clause(header_tests,G),run_tests(G))).




retest_domfile(F):- expand_file_name(F,List),List\=[],!,forall(member(E,List),retest_domfile0(E)).
retest_domfile(F):- retest_domfile0(F),!. 
retest_domfile0(File):- time(with_assertions(thlocal:doing(retest_domfile(File)), once((env_clear_doms_and_tasks,clean,consult(File),tasks)))).

header_tests :-retest_domfile('domains/*.ocl').
header_tests :-retest_domfile('../src_included/planner/domains/*.ocl').


:- style_check(-singleton).
:- style_check(-discontiguous).
:-use_module(library(system)).


/*
 * GIPO COPYRIGHT NOTICE, LICENSE AND DISCLAIMER.
 *
 * Copyright 2001 - 2003 by R.M.Simpson W.Zhao T.L.McCLuskey D Liu D. Kitchin
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted,
 * provided that the above copyright notice appear in all copies and that
 * both the copyright notice and this permission notice and warranty
 * disclaimer appear in supporting documentation, and that the names of
 * the authors or their employers not be used in advertising or publicity 
 * pertaining to distribution of the software without specific, written 
 * prior permission.
 *
 * The authors and their employers disclaim all warranties with regard to 
 * this software, including all implied warranties of merchantability and 
 * fitness.  In no event shall the authors or their employers be liable 
 * for any special, indirect or consequential damages or any damages 
 * whatsoever resulting from loss of use, data or profits, whether in an 
 * action of contract, negligence or other tortious action, arising out of 
 * or in connection with the use or performance of this software.
 */
 /* gipohyhtn.pl */
/* HyHTN planning: do preprocess first  */
/* make all method and operators primitive */
:-use_module(library(system)).
/*********************** initialisation**************/
:-dynamic my_stats/1. 


:- use_module(library(rbtrees)).
:- use_module(library(nb_rbtrees)).

p_e(P,ENV):-functor(P,ENV,_),!. % ,functor(ENV,F,A).
p_e(P,test123).

pe_get(P,ENV,Q):-p_e(P,ENV), nb_getval(ENV,Q),!.
pe_set(P,ENV,Q):-p_e(P,ENV), nb_setval(ENV,Q),!.

pe_get_key(P,_,Q):-p_e(P,Q).

:-dynamic(in_bb/2).

gvar_update_value(Before,After):-p_e(Before,BB),nb_current(BB,Before),!,nb_setval(BB,After).
gvar_update_value(Before,After):-retract(Before),assert(After),!.
gvar_update_value(Before,After):-env_retract(Before),env_assert(After).

gvar_value(BB,OP,Value):-must(gvar_value0(BB,OP,Value)).
gvar_value0(BB,call,Value):-!,nb_current(BB,Value),!.
gvar_value0(BB,assert,Value):-!,nb_setval(BB,Value).
gvar_value0(BB,asserta,Value):-!,nb_setval(BB,Value),!.
gvar_value0(BB,retract,Value):-nb_getval(BB,Value),!,nb_setval(BB,[]).
gvar_value0(BB,retractall,_):-nb_setval(BB,[]).


gvar_list(BB,call,Value):-!,must(nb_current(BB,List)),!,dmsg(member(Value,List)),!,member(Value,List).
gvar_list(BB,OP,Value):-must(gvar_list0(BB,OP,Value)).
gvar_list0(BB,assert,Value):-!,must(nb_current(BB,List)), (List=[] ->  nb_setval(BB,[Value]); append_el_via_setarg(List,Value)).
gvar_list0(BB,asserta,Value):-!,must(nb_current(BB,List)),nb_setval(BB,[Value|List]).
gvar_list0(BB,retract,Value):-!,must(nb_current(BB,List)), ( List=[Value|Rest]-> nb_setval(BB,Rest); remove_el_via_setarg(List,Value) ).
gvar_list0(BB,retractall,F/A):- !,nb_setval(BB,[]).
gvar_list0(BB,retractall,Value):- args_all_vars(Value)-> nb_setval(BB,[]) ;  
  ((   must(nb_current(BB,List)) , gvar_remove_all_list_matches(BB,List,Value) )).


args_all_vars(Value):- not((arg(_,Value,Nv),nonvar(Nv))).

gvar_remove_all_list_matches(BB,List,Value) :-
  ( List ==[] -> true ; 
    ((List \= [Value|Rest] ->  gvar_remove_all_list_matches(BB, Rest,Value) ;
       ((nb_setval(BB,Rest),gvar_remove_all_list_matches(BB,Rest,Value)))))).

remove_el_via_setarg(List,Value):- ([Value|T] = List -> nb_setarg(2,List,T) ; remove_el_via_setarg(T,Value)).
append_el_via_setarg(List,Value):- List = [_|T], (T==[] -> setarg(2,List,[Value]) ; append_el_via_setarg(T,Value)).



bnb_current(BB,LIST):-!,fail.
bnb_current(BB,LIST):-nb_current(BB,LIST),!.
bnb_current(BB,LIST):-nb_setval(BB,[]),nb_current(BB,LIST),!.

bb_lookup(BB,P):-bnb_current(BB,LIST),!,member(P,LIST).
bb_lookup(BB,P):-in_bb(BB,P).

bb_add(BB,P):-bnb_current(BB,LIST),!,nb_setval(BB,[P|LIST]).
bb_add(BB,P):-asserta(in_bb(BB,P)).

bb_rem(BB,P):-bnb_current(BB,LIST),!,remove_el(LIST,P,NLIST),nb_setval(BB,NLIST).
bb_rem(BB,P):-retract(in_bb(BB,P)).

bb_op(ENV,call,P):-pe_get_key(P,ENV,BB),bb_lookup(BB,P).
bb_op(ENV,assert,P):-pe_get_key(P,ENV,BB),bb_add(BB,P).
bb_op(ENV,asserta,P):-pe_get_key(P,ENV,BB),bb_add(BB,P).
bb_op(ENV,retract,P):-pe_get_key(P,ENV,BB),bb_rem(BB,P).
bb_op(ENV,retractall,P):-pe_get_key(P,ENV,BB),forall(bb_lookup(BB,P),bb_rem(BB,P)).

bb_op_rb(ENV,call,P):-pe_get(P,ENV,BB),rb_lookup(P,P,BB).
bb_op_rb(ENV,assert,P):-pe_get(P,ENV,BB),nb_rb_insert(P,P,BB).
bb_op_rb(ENV,asserta,P):-pe_get(P,ENV,BB),nb_rb_insert(P,P,BB).
bb_op_rb(ENV,retract,P):-pe_get(P,ENV,BB),nb_rb_get_node(P,P,BB).
bb_op_rb(ENV,retractall,P):-rb_new(BB),pe_set(P,ENV,BB).

bb_op_qu(ENV,call,P):-pe_get(P,ENV,Q),inside_queue(Q,P).
bb_op_qu(ENV,assert,P):-pe_get(P,ENV,Q),push_slow_queue(Q,P).
bb_op_qu(ENV,asserta,P):-pe_get(P,ENV,Q),push_fast_queue(Q,P).
bb_op_qu(ENV,retract,P):-pe_get(P,ENV,Q),pop_queue(Q,P).
bb_op_qu(ENV,retractall,P):-make_queue(Q),pe_set(P,ENV,Q).

% FIFO queue

make_queue(Q) :- nb_setval(Q, fast_slow(QU-QU, L-L)).

push_fast_queue(Q,E) :-
        b_getval(Q, fast_slow(H-[E|T], L)),
        b_setval(Q, fast_slow(H-T, L)).

push_slow_queue(Q,E) :-
        b_getval(Q, fast_slow(L, H-[E|T])),
        b_setval(Q, fast_slow(L, H-T)).

pop_queue(Q,E) :-
        b_getval(Q, fast_slow(H-T, I-U)),
        (   nonvar(H) ->
            H = [E|NH],
            b_setval(Q, fast_slow(NH-T, I-U))
        ;   nonvar(I) ->
            I = [E|NI],
            b_setval(Q, fast_slow(H-T, NI-U))
        ;   false
        ).

inside_queue(Q,E) :-
        b_getval(Q, fast_slow(H-T, I-U)),(   nonvar(H) , member(E,H)  ;   nonvar(I) , member(E,H)).


:-swi_export(on_call_decl_hyhtn/0).
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(domcache)],(temp_assertIndivConds/1)). % Used for grounding operators
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(domcache)],(is_of_primitive_sort/2, is_of_sort/2)).
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(domcache)],(methodC/7, opParent/6,operatorC/5,gOperator/3)).
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(domcache)],(objectsC/2,objectsD/2,atomic_invariantsC/1)).% Used only dynamic objects
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(domcache)],(objectsOfSort/2)).      % Used to store all objects of a sort

on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(domcache) /*stubType(with_pred(bb_op(_)))*/],(related_op/2, gsubstate_classes/3, gsstates/3)).  

on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(nodecache) /*stubType(with_pred(bb_op(_)))*/],(op_score/2)). 
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(nodecache)/*stubType(rec_db)*/],(node/5,final_node/1)).
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(nodecache)],(tp_goal/3,closed_node/6,solved_node/2, goal_related_search/1)). 
on_call_decl_hyhtn :- decl_mpred_env([stubType(rec_db),kb(nodecache)],(goal_related/3)).
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(nodecache)],(current_num/2)).
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(nodecache)],(tn/6)). % Used to store full expanded steps
on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(nodecache)],(tp_node/6)).
% on_call_decl_hyhtn :- decl_mpred_env([stubType(dyn),kb(nodecache)],(tp_node_cached/6)).
% on_call_decl_hyhtn :- decl_mpred_env([stubType(with_pred(gvar_list(tnodeSORTED))),kb(nodecache)],tp_node/6).

% Tasks
on_call_decl_hyhtn :- decl_mpred_env([kb(domtasks),stubType(dyn)], ( htn_task/3, planner_task/3, planner_task_slow/3 )).

% Contents of a OCLh Domain
on_call_decl_hyhtn :- 
 decl_mpred_env([kb(domfile),stubType(dyn)],[
  domain_name/1,
  sorts/2,
  substate_classes/3,
  objects/2,
  predicates/1,
  inconsistent_constraint/1,
  atomic_invariants/1,
  implied_invariant/2,  
  operator/4,
  % oper/4,
  method/6]).

:-doall(on_call_decl_hyhtn).


% The following elements are expected in the sort engineered domain model
% 
%  sorts
%  objects
%  predictates
%  ss class expressions
%  invariants:
%   atomic invariants
%   -ve invariants
%   +ve invariants
%  operators
startOCL(Goal,Init):-
  clean,
   dmsg('OCL-PLANNER-TASK'(Goal)),
	must(planner_interface(Goal,Init,Sol,_,TNLst)),
        show_result_and_clean(F,Id,Sol,TNLst).

/*
:-dynamic 
      
      sorts/2,
      objects/2,
      predicates/1,
      atomic_invariants/1,  
      substate_classes/3,
      method/6,
      operator/4,
      implied_invariant/2, oper/4,
      domain_name/1,
      inconsistent_constraint/1.
*/
  




% for boot..
:-dynamic kill_file/1,solution_file/1.
%
% :-expects_dialect(sicstus).
:- style_check(-singleton).
%:- prolog_flag(single_var_warnings, _, off).
%:-set_prolog_flag(unknown,fail).
% :- unknown(error,fail).
:- op(100,xfy,'=>').
%---------------------structure--------------------
% for whole search:
% node(Nodeid, Precond, Decomps, Temp, Statics)
% tn(Tnid, Name, Precond, Postcond,Temp, Decomps)
% tn is a full expanded node, it has fixed decomps and postcondtion
% step(HPid,ActName,Precond,Postcond,Expansion)
% for fwsearch achieve(Goal) only:
% tp_goal(Pre,Goal,Statics)
% goal_related(se(Sort,Obj,SEpre),Opls,LengthToGoal)
% tp_node(TPid,Pre,Statics,from(Parentid),Score,Steps)
% closed_node(TPid,Pre,from(Parentid),Score,Steps)
%---------------------structure end--------------------

incr_op_num:- flag(op_num,X,X+1).
set_op_num(X):-flag(op_num,_,X).
current_op_num(X):- flag(op_num,X,X).

:- set_op_num(0).
% my_stats(0).

solve(Id) :-
	htn_task(Id,Goal,Init),
	planner_interface(Goal,Init,Sol,_,TNLst),
        show_result_and_clean(user,Id,Sol,TNLst).

solve(Id) :-
	planner_task(Id,Goal,Init),
	planner_interface(Goal,Init,Sol,_,TNLst),
        show_result_and_clean(user,Id,Sol,TNLst).

show_result_and_clean(F,Id,Sol,TNLst):-
   must(solution_file(F)),
	tell(F),
	write('TASK '),write(Id),nl,
	write('SOLUTION'),nl,
	display_sol(Sol),
	write('END FILE'),nl,nl,
	nop((reverse(TNLst,TNForward),
	display_details(TNForward),
	write('END PLANNER RESULT'))),
	told,
	clean.

display_sol([]).
display_sol([H|T]) :-
	write(H),
	nl,
	display_sol(T).

display_details([]):-!.
display_details([H|T]):-!,display_details(H),display_details(T),!.
display_details(tn(TN,Name,Pre,Post,Temp,Dec)):-
%    write('method::Description:'),write(';'),
    nl,write('BEGIN METHOD'),nl,write(TN),write(';'),
    nl,write('Name:'),write(Name),write(';'),
    nl,write('Pre-condition:'),write(Pre),write(';'),
%    write('Index Transitions:'),write(Pre),write('=>'),write(Post1),write(';'),
    nl,write('Index Transitions:'),write('=>'),write(Post),write(';'),
%    write('Static:'),write(';'),
    nl,write('Temporal Constraints:'),write(Temp),write(';'),
    nl,write('Decomposition:'),write(Dec),write(';'),
    nl.

display_details(H):-dmsg((display_details:-H)).

clean:-	
      env_retractall(temp_assertIndivConds(_)),
      env_retractall(opParent(_,_,_,_,_,_)),
      env_retractall(operatorC(_,_,_,_,_)),
      env_retractall(objectsOfSort(_,_)),
      env_retractall(objectsD(_,_)),
      env_retractall(objectsC(_,_)),
      env_retractall(methodC(_,_,_,_,_,_,_)),
      env_retractall(is_of_sort(_,_)),
      env_retractall(is_of_primitive_sort(_,_)),
      env_retractall(gsubstate_classes(_,_,_)),
      env_retractall(gOperator(_,_,_)),
      env_retractall(current_num(_,_)),	
      env_retractall(atomic_invariantsC(_)),

   % nodes
         env_retractall(final_node(_)),
   % temp nodes
         nb_setval(tnodeSORTED,[]),
         env_retractall(tp_node(_,_,_,_,_,_)),
         env_retractall(current_num(tp,_)),
         env_retractall(node(_,_,_,_,_)),         
         env_retractall(solved_node(_,_)),
         env_retractall(tn(_,_,_,_,_,_)),         
         env_retractall(closed_node(_,_,_,_,_,_)),
         % env_retractall(score_list(_)),
         % env_retractall(related_op(_)),
         env_retractall(op_score(_,_)),
         env_retractall(goal_related(_,_,_)),
         env_retractall(goal_related_search(_)),	


	% retractall(my_stats(_)),assert(my_stats(0)),
	set_op_num(0).

init_locl_planner_interface(G,I,Node):-   
	change_obj_list(I),
	ground_op,
	assert_is_of_sort,
	change_op_representation,
	prim_substate_class,
        set_op_num(0),
        statistics_runtime(Time),
        ignore(retract(my_stats(_))),
        assert(my_stats(Time)),
        make_problem_into_node(I, G, Node),!.
        

planner_interface(G,I, SOLN,OPNUM,TNList):-
	init_locl_planner_interface(G,I,Node),
        env_assert(Node),
	start_solve(SOLN,OPNUM,TNList).
planner_interface(G,I, SOLN,OPNUM,TNList):-
	tell(user),nl,write('failure in initial node'),
     planner_failure('failure in initial node',planner_interface(G,I, SOLN,NODES,TNList)),
 !.

/******************** Nodes *******************/
% node(Name, Precond ,Decomps, Temp, Statics)
% Initial Node: node(root, Init, Decomps, Temp, Statics)

getN_name(node(Name, _, _, _,_),  Name).
getN_pre(node(_,Pre, _, _, _),  Pre).
getN_decomp(node(_, _, Decomp,_,_),  Decomp).
getH_temp(node(_, _, _,Temps, _),  Temps).
getN_statics(node(_,_,_,_,Statics),  Statics).

%Ron  21/9/01 - Try to give a closedown method
start_solve(SOLN,OPNUM,_):-
	kill_file(Kill),
	exists_file(Kill),
%	write('Found kill file'),nl.
        !,fail.

start_solve(Sol,OPNUM,TNList):-
   env_retract(final_node(Node)),
   env_retractall(current_num(_,_)),
   getN_statics(Node,Statics),
   statics_consist(Statics),
   extract_solution(Node,Sol,SIZE,TNList),
   statistics_runtime(CP),
   TIM is CP/1000, tell(user),
   flag(op_num,OPNUM,0),
   nl, nl, write('CPU Time = '),write(CP),nl,
   write('TIME TAKEN = '),write(TIM),
   write(' SECONDS'),nl,
   write('Solution SIZE = '),write(SIZE),nl,
   write('Operator Used = '),write(OPNUM),nl,
   write('***************************************'),
   assert(time_taken(CP)),  
   assert(soln_size(SIZE)),
   env_retractall(tn(_,_,_,_,_,_)),
   !.
start_solve(Sol,OPNUM,TNList):-
   select_node(Node),
%   nl,write('processing '),write(Node),nl,
            % expand/prove its hps
   process_node(Node),
   start_solve(Sol,OPNUM,TNList).

start_solve(Sol,OPNUM,TNList):- solve_failed(Sol,OPNUM,TNList).

solve_failed(Sol,OPNUM,TNList):-
    tell(user), write('+++ task FAILED +++'),    
    planner_failure('+++ task FAILED +++',start_solve(Sol,OPNUM,TNList)),
    listing(in_dyn/2),
    clean.



/******************************** MAIN LOOP **********/

% expand a node..
process_node(Node) :-
   getN_name(Node,  Name),
   getN_pre(Node, Pre),
   getN_decomp(Node, Dec),
   getH_temp(Node, Temps),
   getN_statics(Node, Statics),
   expand_decomp(Dec,Pre,Post,Temps,Temp1,Statics,Statics1,Dec1),
   statics_consist(Statics),
   assert_node(Name,Pre,Dec1,Temp1,Statics1).

assert_node(Name,Pre,Decomp,Temp,Statics):-
   all_HP_expanded(Decomp),
   env_assert(final_node(node(Name,Pre,Decomp,Temp,Statics))),!.
assert_node(Name,Pre,Dec,Temp,Statics):-
   gensym_special(root,SYM),
   env_assert(node(SYM,Pre,Dec,Temp,Statics)),!.

all_HP_expanded([]):-!.
all_HP_expanded([step(HPid,Name,_,_,exp(TN))|THPS]):-
   all_HP_expanded(THPS),!.

/************ expand every step in Dec *********************/
% expand_decomp(Dec,Pre,Post,Temps,Temp1,Statics,Statics1,Dec1)
% Pre and Post here is the current ground states changes
% starts from Initial states to final ground states
% 0. end, Post is the final ground states
expand_decomp([],Post,Post,Temp,Temp,Statics,Statics,[]):-!.

% 1. if the step has expand already, get the state change, go to next
expand_decomp([step(HPid,Name,Pre0,Post0,exp(TN))|Decomp],Pre,Post,Temp,Temp1,Statics,Statics1,[step(HPid,Name,Pre,State,exp(TN))|Decomp1]):-
   state_achieved(Pre0,Pre),
   state_change(Pre,Pre0,Post0,State),
   statics_consist(Statics),
   expand_decomp(Decomp,State,Post,Temp,Temp1,Statics,Statics1,Decomp1),!.

% 2. if it is an achieve goal
expand_decomp([step(HPid,ACH,Pre0,Post0,unexp)|Decomp],Pre,Post,Temp,Temp1,Statics,Statics1,Decomp1):-
   ACH=..[achieve|_],
   statics_consist(Statics),
   expand_decomp_ach([step(HPid,ACH,Pre,Post0,unexp)|Decomp],Pre,Post,
        Temp,Temp1,Statics,Statics1,Decomp1),!.

% 3. if HP's name and it's Pre meet an operator, return operator's name
expand_decomp([step(HPid,Name,undefd,undefd,unexp)|Decomp],Pre,Post,Temp,Temp1,Statics,Statics1,[step(HPid,Name,Pre,State,exp(Name))|Decomp1]):-
   apply_op(Name,HPid,Name,Pre,undefd,State,Statics,Statics2),
   expand_decomp(Decomp,State,Post,Temp,Temp1,Statics2,Statics1,Decomp1),!.

% apply operator by known its name and post state
apply_op(Name,HPid,Name,Pre,Post,State,Statics,Statics1):-
   operatorC(Name,Pre0,Post0,Cond,Statics0),
   statics_append(Statics0,Statics,Statics2),
   state_achieved(Pre,Pre0,Statics2),
   state_change(Pre,Pre0,Post0,State2),
   cond_state_change(State2,Cond,State),
   all_achieved(Post,Statics2,State),
   remove_unneed(Statics2,[],Statics1),
   statics_consist_instance(Statics1),
   statics_consist_instance(Statics0),
   incr_op_num,!.

% 4. if HP's name meet an method, and it's precondition  achieved
% expand it and make it to that TNs
expand_decomp([step(HPid,Name,undefd,undefd,unexp)|Decomp],Pre,Post,Temp,Temp1,Statics,Statics1,[step(HPid,Name,Pre,State,exp(TN))|Decomp1]):-
   apply_method(TN,HPid,Name,Pre,undefd,State,Statics,Statics2),
   expand_decomp(Decomp,State,Post,Temp,Temp1,Statics2,Statics1,Decomp1),!.

% apply an method by its name
apply_method(TN,HPid,Name,Pre,Post,State,Statics,Statics1):-
   methodC(Name,Pre0,Post0,Statics0,Temp0,achieve(ACH0),Dec0),
   statics_append(Statics0,Statics,Statics2),
   all_achieved(Pre0,Statics2,Pre),
   remove_unneed(Statics2,[],Statics21),
   make_dec1(HPid,Pre,ACH0,Statics21,Temp0,Dec0,Temp2,Dec2),
   expand_decomp(Dec2,Pre,State,Temp2,Temp1,Statics21,Statics1,Dec1),
   all_achieved(Post,Statics1,State),
   incr_op_num,
   make_tn(TN,Name,Pre,State,Temp1,Dec1),!.

% 5. get another step which matchs and not after it before it to give a try
expand_decomp([step(HP,N,Pre0,Post0,unexp)|Decomp],Pre,Post,Temp,Temp1,Statics,Statics1,Decomp1):-  
   get_another_step(step(HP2,N2,Pre2,Post2,Exp),Pre,Statics,
                                  HP,Temp,Temp2,Decomp,Decomp2),
   expand_decomp([step(HP2,N2,Pre2,Post2,Exp),step(HP,N,Pre0,Post0,unexp)|Decomp2],
                     Pre,Post,Temp2,Temp1,Statics,Statics1,Decomp1).

% 6. all failed, expanding failed 
/************ end of expand_decomp *********************/

% get another step which is not after it before it
get_another_step(A,Pre,Statics,HP,Temp,Temp1,[],Dec2):-fail.
get_another_step(step(HP2,Name2,Pre2,Post2,Exp),Pre,Statics,HP,Temp,[before(HP2,HP)|Temp],Dec,Dec2):-
   member(step(HP2,Name2,Pre2,Post2,Exp),Dec),
   not(necessarily_before(HP,HP2, Temp)),
   state_achieved(Pre2,Pre,Statics),
   list_take(Dec,[step(HP2,Name2,Pre2,Post2,Exp)],Dec2).

% ***********expand the achieve goal***********
% 1.if the ACH is achieved already
%   remove it from decomposion and do the next
expand_decomp_ach([step(HPid,ACH,Pre,Post0,unexp)|Decomp],Pre,Post,Temp,Temp1,Statics,Statics1,Decomp1):-
   state_achieved(Post0,Pre),
%   nl,write('step '),write(HPid),
%   write('is already achieved'),nl,
   remove_temp(Temp,HPid,Temp,Temp2),
   expand_decomp(Decomp,Pre,Post,Temp2,Temp1,Statics,Statics1,Decomp1),!.

% 2.do expanding achieve goal
expand_decomp_ach([step(HPid,ACH,Pre,Post0,unexp)|Decomp],Pre,Post,Temp,Temp1,Statics,Statics1,[step(HPid,ACH,Pre,Post0,exp(TN))|Decomp1]):-
   expand_ach_goal(HPid,TN,ACH,Pre,Post0,State,Statics,Statics2),
   expand_decomp(Decomp,State,Post,Temp,Temp1,Statics2,Statics1,Decomp1),!.

% 3. get another step which matchs and not after it before it to give a try
expand_decomp_ach([step(HPid,ACH,Pre,Post0,unexp)|Decomp],Pre,Post,Temp,Temp1,Statics,Statics1,[step(HPid,ACH,Pre,Post0,exp(TN))|Decomp1]):-  
   get_another_step(step(HP2,N2,Pre2,Post2,Exp),Pre,Statics,
                                  HP,Temp,Temp2,Decomp,Decomp2),
   expand_decomp([step(HP2,N2,Pre2,Post2,Exp),step(HPid,ACH,Pre,Post0,unexp)|Decomp2], Pre,Post,Temp2,Temp1,Statics,Statics1,Decomp1).

% 4. all failed, expanding failed 
/************ end of expand_decomp_ach *********************/
       
%************ expand an achive goal *********************/
% 1. directly achieve goal's Pre and Post by operator,method or tn
expand_ach_goal(HPid,TN,ACH,Pre,Post,State,Statics,Statics1):-
   direct_expand_ach_goal(HPid,TN,ACH,Pre,Post,State,Statics,Statics1),!.

% 2. else, nothing directly can achieve HP's Pre and Post
% env_assert a temporely node for forward search
% tp_node(TPid,Pre,Statics,from(Parentid),Score,Steps)
expand_ach_goal(HPid,TN,ACH,Pre,Post,State,Statics,Statics1):-
   make_tpnodes(Pre,Post,Statics),
%   tell(user),
   fwsearch(TN,State),
%   told,
%   all_achieved(Post,Statics1,State),
   clean_temp_nodes.

% 3. else, fail expand
/************ end of expand_ach_goal *********************/

% -------direct expand an achieve goal-----------------------
%1. if an achieve action meets an TN Pre and post
direct_expand_ach_goal(HPid,TN,ACH,Pre,Post,State,Statics,Statics):-
   apply_tn(TN,HPid,ACH,Pre,Post,State,Statics,Statics).
%2. if an action's action meets an operator Pre and post
direct_expand_ach_goal(HPid,OP,ACH,Pre,Post,State,Statics,Statics1):-
   dir_apply_op(OP,HPid,ACH,Pre,Post,State,Statics,Statics1).
%3. if an achieve action meets a method's pre and post,
%    expand it and make it to that TNs
direct_expand_ach_goal(HPid,TN,ACH,Pre,Post,State,Statics,Statics1):-
   dir_apply_method(TN,HPid,ACH,Pre,Post,State,Statics,Statics1),!.
%4. else, failed for direct expand an achieve goal------

% apply an TN to an achieve goal that matches both pre and post conditions
apply_tn(Tn0,HPid,ACH,Pre,Post,State,Statics,Statics):-
   env_call(tn(Tn0,Name,Pre0,Post0,Temp0,Decomp0)),
   state_achieved(Pre0,Pre),
   state_change(Pre,Pre0,Post0,State),
   all_achieved(Post,Statics,State),
%   nl,write('step '),write(HPid),
    incr_op_num,!.
%    write('can be expand by tn '),write(Tn0),nl,!.

% directly apply an operator when its Pre and Post matches
dir_apply_op(Name,HPid,ACH,Pre,Goal,State,Statics,Statics1):-
%   ACH=..[achieve|Rest],
   make_se_primitive(Goal,Post),
   operatorC(Name,Pre0,Post0,Cond,Statics0),
   statics_append(Statics0,Statics,Statics2),
   state_related(Post0,Cond,Post),
%   state_achieved(Pre,Pre0,Statics2),% can't say because not full instatiate
   state_change(Pre,Pre0,Post0,State2),
   cond_state_change(State2,Cond,State),
   all_achieved(Post,Statics2,State),
   remove_unneed(Statics2,[],Statics1),
   statics_consist(Statics1),
%   nl,write('step '),write(HPid),
%   write('can be expand by operator '),write(Name),nl,
   % eretract(op_num_GONE(N_GONE)),
   % N1_GONE is N_GONE+1,
   incr_op_num,!.

% apply mehtod when Pre and Post condition matchs
dir_apply_method(TN,HPid,ACH,Pre,Goal,State,Statics,Statics1):-
%   ACH=..[achieve|Rest],
   make_se_primitive(Goal,Post),
   methodC(Name,Pre0,Post0,Statics0,Temp0,achieve(ACH0),Dec0),
   statics_append(Statics0,Statics,Statics2),
   state_related(Post0,Post),
%   state_achieved(Pre0,Pre,Statics2),
   state_change(Pre,Pre0,Post0,State2),
%   rough_state_change(Pre,Pre0,Post0,State2),
   may_achieved(Post,Statics2,State2),
%   remove_unneed(Statics2,[],Statics21),
   make_dec1(HPid,Pre,ACH0,Statics2,Temp0,Dec0,Temp2,Dec2),
   expand_decomp(Dec2,Pre,State,Temp2,Temp1,Statics2,Statics1,Dec1),
   all_achieved(Post,Statics1,State),
%   nl,write('step '),write(HPid),
%   write('can be expand by method '),write(Name),nl,
   incr_op_num,
   make_tn(TN,Name,Pre,State,Temp1,Dec1),!.

% make decomposition steps when expand a method
make_dec1(HPid,Pre,ACH,Statics,Temp,Dec,Temp1,Dec1):-
   var(HPid),
   gensym_special(hp,HPid),
   make_dec1(HPid,Pre,ACH,Statics,Temp,Dec,Temp1,Dec1),!.
make_dec1(HPid,Pre,ACH,Statics,Temp,Dec,Temp1,Dec1):-
   all_achieved(ACH,Statics,Pre),
   make_dec01(HPid,1,Dec,Dec1),
   change_temp(HPid,Temp,[],Temp1),!.
make_dec1(HPid,Pre,ACH,Statics,Temp,Dec,[before(STID0,STID1)|Temp1],[step(STID0,achieve(ACH),Pre,ACH,unexp)|Dec1]):-
   gensym_num(HPid,0,STID0),
   gensym_num(HPid,1,STID1),
   make_dec01(HPid,1,Dec,Dec1),
   change_temp(HPid,Temp,[],Temp1),!.

make_dec01(HPid,_,[],[]):-!.
make_dec01(HPid,Num,[HDec|TDec],[step(STID,HDec,undefd,undefd,unexp)|TDec0]):-
   operatorC(HDec,_,_,_,_),
   gensym_num(HPid,Num,STID),
   Num1 is Num + 1,
   make_dec01(HPid,Num1,TDec,TDec0).
make_dec01(HPid,Num,[HDec|TDec],[step(STID,HDec,undefd,undefd,unexp)|TDec0]):-
   methodC(HDec,_,_,_,_,_,_),
   gensym_num(HPid,Num,STID),
   Num1 is Num + 1,
   make_dec01(HPid,Num1,TDec,TDec0).

change_temp(HPid,[],Temp2,Temp2):-!.
change_temp(HPid,[before(N1,N2)|Temp],Temp2,[before(ST1,ST2)|Temp0]):-
   gensym_num(HPid,N1,ST1),
   gensym_num(HPid,N2,ST2),
   change_temp(HPid,Temp,Temp2,Temp0),!.
% --------------------end of dir_apply_method/8---------------------
/************ end of direct_expand_ach_goal *********************/

% ----------------forward searching--------------
% make tp_node(TPID, Pre,Statics,from(Parent),Score,Steps)
make_tpnodes(Pre,Post, Statics):-
   flag(opCounter,Num,Num),
   Num>=1000,
   env_retractall(tp_goal(_,_,_)),
   env_retractall(related_op(_,_)),
   env_assert(tp_goal(Pre,Post,Statics)),
   env_assert(tp_node(init,Pre,Statics,from(init),0,[])),!.

make_tpnodes(Pre,Post, Statics):-
   env_retractall(tp_goal(_,_,_)),
   env_retractall(related_op(_,_)),
   env_assert(tp_goal(Pre,Post,Statics)),
   assert_goal_related_init(Pre,Post,Statics),
   env_assert(op_score(goal,0)),
   find_all_related_goals(Pre,Statics,1,N),
%   find_all_related_op,
   env_assert(tp_node(init,Pre,Statics,from(init),0,[])),!.

%tp_node(TP,Pre,Statics,from(Parent),Score,Steps)
% forward search for operators can't directly solved

fwsearch(TN,State):- fwsearch0(fwsearch,800, TN,State).

fwsearch0(_,_, TN,State):-
   env_retract(solved_node(_,step(HP,Name,Pre,State,exp(TN)))).
fwsearch0(Caller, D, TN,State):- 
   var(TN),var(State),!,
   D > 2, D2 is D-2,
   fwsearch1(var_fwsearch0, D2, TN,State).
fwsearch0(Caller, D, TN,State):- 
   D > 0, D2 is D-1,
   fwsearch1(fwsearch0, D2, TN,State).

fwsearch1(Caller, D, TN,State):-
   select_tnode(tp_node(TP,Pre,Statics,from(PR),Score,Steps)),
   env_assert(closed_node(TP,Pre,Statics,from(PR),Score,Steps)),
   expand_node(TP,OP,Statics,Statics1,Pre,Post,from(PR),Steps,Steps1),
   assert_tnode(TP,OP,PR,Score1,Post,Statics1,Steps1),
   solved_node(_,_),%expand every possible way until find solution
   fwsearch0(fwsearch1, D, TN,State).
fwsearch1(Caller, D ,TN,State):-
   env_call(tp_node(TP,Pre,Statics,from(PR),Score,Steps)),
   fwsearch0(tp_node, D ,TN,State).

clean_temp_nodes_was_wrong:-
   % env_retractall(related_op(_)),
   env_retractall(related_op(_,_)),
   % env_retractall(tp_goal(_,_)),
   env_retractall(tp_goal(_,_,_)),!.

clean_temp_nodes:-
   clean_temp_nodes_was_wrong,   
   env_retractall(goal_related(_,_,_)),
   env_retractall(goal_related_search(_)),
   env_retractall(op_score(_,_)),
   env_retractall(solved_node(_,_)),
   env_retractall(current_num(tp,_)),
   env_retractall(tp_node(_,_,_,_,_,_)),
   

   env_retractall(closed_node(_,_,_,_,_,_)),!.

% expand all way possible to achieve the Post
% if Post is achieved by Pre, finish
expand_node(TP,done,Statics,Statics,Pre,Pre,from(PR),List,List):-
   tp_goal(_,Goal,_),
   state_achieved(Goal,Pre,Statics),!.
expand_node(TP,TN,Statics,Statics1,Pre,State,from(PR),List,List1):-
   expand_node1(TN,Statics,Statics1,Pre,State,from(PR),List,List1).

% check the Post can be solved by direct expand (Operator or Method)
expand_node1(TN,Statics,Statics1,Pre,State,from(PR),List,List1):-
   tp_goal(_,Goal,_),
   direct_expand(HP,TN,achieve(Goal),Pre,Goal,State,Statics,Statics1),
%   gensym_special(hp,HP),
   append_dcut(List,[step(HP,achieve(Goal),Pre,State,exp(TN))],List1),!.
% -------direct expand -----------------------
% if the goal canbe achieved by a method's pre and post,
%    expand it and make it to that TNs
direct_expand(HPid,TN,ACH,Pre,Post,State,Statics,Statics1):-
   dir_apply_method(TN,HPid,ACH,Pre,Post,State,Statics,Statics1),!.

% search forwards use ground operators only
expand_node1(ID,Statics,Statics,Pre,State,from(PR),List,List1):-
   find_related_op(Pre,[],OPls),
   member(ID,OPls),
   gOperator(ID,_,OP),
   apply_ground_op(OP,Pre,State,List,List1).
expand_node1(OP,Statics,Statics1,Pre,State,from(PR),List,List1):-
   not(goal_related(_,_,_)),
   operatorC(OP,Pre0,Post0,Cond,ST),
   apply_unground_op(OP,Pre0,Post0,Cond,ST,Statics,Statics1,Pre,State,List,List1).

apply_ground_op(operator(OP,Prev,Nec,Cond),Pre,State,List,List1):-
   state_achieved(Prev,Pre),
   nec_state_change(Pre,Nec,State2),
   cond_state_change(State2,Cond,State),
   gensym_special(hp,HP),
   append_dcut(List,[step(HP,OP,Pre,State,exp(OP))],List1),
   incr_op_num,!.

apply_unground_op(OP,Pre0,Post0,Cond,ST,Statics,Statics1,Pre,State,List,List1):-
   statics_append(ST,Statics,Statics2),
   state_achieved(Pre0,Pre,Statics2),
   state_change(Pre,Pre0,Post0,State2),
   cond_state_change(State2,Cond,State),
   statics_consist_instance(ST),
   remove_unneed(Statics2,[],Statics1),
   gensym_special(hp,HP),
   append_dcut(List,[step(HP,OP,Pre,State,exp(OP))],List1),
   incr_op_num.

find_related_op([],Ops1,Ops):-
   remove_dup(Ops1,[],Ops),!.
find_related_op([Head|Pre],List,Ops):-
   setof(OPls,Head^Level^env_call(goal_related(Head,OPls,Level)),OPs0),
   flatten(OPs0,[],OPs1),
   append_dcut(List,OPs1,List1),
   find_related_op(Pre,List1,Ops),!.
find_related_op([Head|Pre],List,Ops):-
   find_related_op(Pre,List,Ops),!.



% select_tnode(LowestScoredTNode) :- gvar_list(tnodeSORTED,retract,LowestScoredTNode),!.
/*
select_tnode(IncomingScoredNode) :-
  IncomingScoredNode = tp_node(TPid,Pre,Statics,Parents,Score,Dec),  
  random_tnode_FREE,
  ignore((
           env_call(tp_node(HPid,Pre,Statics,Parents,LScore,Dec)),
           nb_getval(tnodeLOWEST,tp_node(_,_,_,_,SScore,_)),
           LScore < SScore, nb_setval(tnodeLOWEST,tp_node(HPid,Pre,Statics,Parents,Score,Dec)),
      fail)),
  nb_getval(tnodeLOWEST,LowestScoredTNode),
  env_retract(LowestScoredTNode),!,
  must(IncomingScoredNode=LowestScoredTNode),
*/
/*
select_tnode(tp_node(TPid,Pre,Statics,Parents,Score,Dec)) :-
  random_tnode_FREE,
  ignore(((
  env_call(tp_node(HPid,Pre,Statics,Parents,Score,Dec)),
  nb_getval(tnodeLOWEST,tp_node(_,_,_,_,SScore,_)),
  Score < SScore,
  nb_setval(tnodeLOWEST,tp_node(HPid,Pre,Statics,Parents,Score,Dec)),fail))),

   nb_getval(tnodeLOWEST,tp_node(TPid,Pre,Statics,Parents,Score,Dec)),
   env_retract(tp_node(TPid,Pre,Statics,Parents,Score,Dec)),!,
   random_tnode_FORCED.
%   tell(user),nl,write('new level'),nl,told,!.
*/

select_tnode(tp_node(TPid,Pre,Statics,Parents,Score,Dec)) :-
  lowest_tnode_FORCED,
  nb_getval(tnodeLOWEST,tp_node(TPid,Pre,Statics,Parents,Score,Dec)),
   env_retract(tp_node(TPid,Pre,Statics,Parents,Score,Dec)),!,
   nb_delete(tnodeLOWEST).
%   tell(user),nl,write('new level'),nl,told,!.

random_tnode_FREE :- nb_current(tnodeLOWEST,_)->true;random_tnode_FORCED.

random_tnode_FORCED:- 
  env_call(tp_node(HPid,Pre,Statics,Parents,Score,Dec)),
  nb_setval(tnodeLOWEST,tp_node(HPid,Pre,Statics,Parents,Score,Dec)),!.

lowest_tnode_FORCED:-
  random_tnode_FORCED,
    ignore(((
        nb_getval(tnodeLOWEST,tp_node(_,_,_,_,SScore,_)),
        env_call(tp_node(HPid,Pre,Statics,Parents,Score,Dec)), 
        Score < SScore,
        nb_setval(tnodeLOWEST,tp_node(HPid,Pre,Statics,Parents,Score,Dec)),
        fail))).
  

% env_assert assert_tnode(TP,OP,PR,Score,Post,Statics1,Steps1),
%if goal achieved, assert solved_node
assert_tnode(TP,OP,PR,Score,Post,Statics,[]):-!.
assert_tnode(TP,OP,PR,Score,Post,Statics,Steps):-
   tp_goal(Pre,Goal,Statics1),
   state_achieved(Goal,Post,Statics),
   combine_exp_steps(Post,Steps,OneStep),
   env_assert(solved_node(Statics,OneStep)),!.
assert_tnode(TP,OP,PR,Score,Post,Statics,Steps):-
   existing_node(Post,Statics),!.
assert_tnode(TP,OP,PR,Score,Post,Statics,Steps):-
   get_score(PR,Post,Steps,Score),
%   op_score(OP,SS),
%   Score is Score1-SS,
   gensym_special(tp,TP1),
%   write(TP1),nl,
%   write(Steps),nl,
   env_assert(tp_node(TP1,Post,Statics,from(TP),Score,Steps)),!.



assert_tnode(TP,OP,PR,Score,Post,Statics,Steps):-
   get_score(PR,Post,Steps,Score),
%   op_score(OP,SS),
%   Score is Score1-SS,
   gensym_special(tp,TP1),
%   write(TP1),nl,
%   write(Steps),nl,
  TNODEFULL = tp_node(TP1,Post,Statics,from(TP),Score,Steps),  
   ((nb_current(tnodeLOWEST,tp_node(_,_,_,_,SScore,_)), Score < SScore)
    ->  
      true;
      (nb_setval(tnodeLOWEST,TNODEFULL), 
                      env_shadow(asserta,TNODEFULL))),!,
  assert_tnode_into_sorted_list(Score,Post,TNODEFULL).

assert_tnode_into_sorted_list(Score,Post,TNODEFULL):-
  (nb_getval(tnodeSORTED,NODES) ->   
   (NODES = [] -> 
     nb_setval(tnodeSORTED,[TNODEFULL]);
      ((
         [FrontNode|RightNodes] = NODES,
         must(FrontNode = tp_node(_,FPost,_,_,FScore,_)),
         (Post == FPost -> true ;
            ((FScore > Score) 
                -> nb_setval(tnodeSORTED,[TNODEFULL|NODES]) ;
                      insert_to_list(Score,Post,TNODEFULL,RightNodes,NODES))))));

    nb_setval(tnodeSORTED,[TNODEFULL])).


insert_to_list(_,_,TNODEFULL,[],NODES):-nb_setarg(2,NODES,[TNODEFULL]),!.
insert_to_list(Score,Post,TNODEFULL,AllNodes,NODES):- 
   AllNodes = [FrontNode|RightNodes], 
   FrontNode = tp_node(_,FPost,_,_,FScore,_),!,
    (Post = FPost -> true ;
      ((FScore > Score) -> (  env_asserta(TNODEFULL),nb_setarg(2,NODES,[TNODEFULL|AllNodes])) ; 
         (insert_to_list(Score,Post,TNODEFULL,RightNodes,AllNodes)))).
insert_to_list(Score,Post,TNODEFULL,AllNodes,NODES):- 
   AllNodes = [_|RightNodes],  
   insert_to_list(Score,Post,TNODEFULL,RightNodes,AllNodes).
   

combine_exp_steps(Post,Steps,step(HP,achieve(Goal),Pre,Post,exp(TN))):-
   tp_goal(Pre,Goal,Statics),
   get_action_list(Steps,[],ACTls),
   make_temp(ACTls,[],Temp),
   gensym_special(hp,HP),
   make_tn(TN,achieve(Goal),Pre,Post,Temp,Steps),!.

% get the temperal from an ordered steps
get_action_list([],ACTls,ACTls):-!.
get_action_list([step(HP,_,_,_,_)|Steps],List,ACTls):-
    append_cut(List,[HP],List1),
    get_action_list(Steps,List1,ACTls),!.

make_temp([HP|[]],Temp,Temp):-!.
make_temp([HP1|[HP2|Rest]],List,Temp):-
    append_cut(List,[before(HP1,HP2)],List1),
    make_temp([HP2|Rest],List,Temp),!.

existing_node(Post,_Statics):-
    env_call(tp_node(_,Post,_,_,_,_)).
existing_node(Post,_Statics):-
    closed_node(_,Post,_,_,_,_).
% ------------------related goals------------------

assert_goal_related_init(Pre,[],Statics):-!.
%assert_goal_related_init(Pre,[se(Sort,Obj,SE)|Post],Statics):-
%    state_achieved([se(Sort,Obj,SE)],Pre,Statics),!.
assert_goal_related_init(Pre,[se(Sort,Obj,SE)|Post],Statics):-
    ground(Obj),
    is_of_primitive_sort(Obj,SortP),
    env_assert(goal_related(se(SortP,Obj,SE),[],0)),
    assert_goal_related_init(Pre,Post,Statics),!.
assert_goal_related_init(Pre,[se(Sort,Obj,SE)|Post],Statics):-
    assert_related_goals_varible(Sort,Obj,SE,goal,0),
    assert_goal_related_init(Pre,Post,Statics),!.

% find_all_related_goals: backward search
% until all preconditions have found
find_all_related_goals(Pre,Statics,N,N):-
    get_all_state(States),
    all_found(States,Pre,Statics),
    env_assert(goal_related_search(succ)),
    find_all_related_goals_final(Statics,N),!.
find_all_related_goals(Pre,Statics,I,N):-
    I1 is I-1,
    goal_related(_,_,I1),
    find_related_goal(Statics,I1,I),
    I2 is I+1,
    find_all_related_goals(Pre,Statics,I2,N),!.
find_all_related_goals(Pre,Statics,N,N):-
    not(goal_related(_,_,N)),
    env_assert(goal_related_search(fail)),
    write('related goal search failed'),
    env_retractall(goal_related(_,_,_)),!.
    %fail to find out, don't search any more
    % fwsearch use all the ground ops.


% final find the actions to recover initial states:
% in case the initial states was deleted by other actions
find_all_related_goals_final(Statics,N):-
    N1 is N-1,
    goal_related(Pre,_,N1),
    find_related_goal(Statics,N1,N),!.
find_all_related_goals_final(Statics,N):-!.

% get all the found goal related states
get_all_state(States):-
   setof(Goal, Statics^Level^OP^goal_related(Goal,OP,Level),States11),
   put_one_obj_together(States11,[],States),!.

put_one_obj_together([],States,States):-!.
put_one_obj_together([se(Sort,Obj,ST)|States1],List,States):-
   put_one_obj_together1(se(Sort,Obj,ST),List,List1),
   put_one_obj_together(States1,List1,States),!.

put_one_obj_together1(se(Sort,Obj,ST),[],[se(Sort,Obj,ST)]):-!.
put_one_obj_together1(se(Sort,Obj,ST),[se(Sort,Obj,ST00)|List],[se(Sort,Obj,ST1)|List]):-
   set_append_e(ST,ST00,ST1),!.
put_one_obj_together1(se(Sort,Obj,ST),[se(Sort1,Obj1,ST1)|List],[se(Sort1,Obj1,ST1)|List1]):-
   Obj\==Obj1,
   put_one_obj_together1(se(Sort,Obj,ST),List,List1),!.

% all the Precondition states in backward search can reach initial states
all_found([],States,Statics):-!.
all_found([se(Sort,Obj,ST)|States],Pre,Statics):-
   member(se(Sort,Obj,SPre),Pre),
   subtract(SPre,ST,Diff),
   isemptylist(Diff),
   all_found(States,Pre,Statics),!.

% find all the states that can achieve the goal state
% separete ground operators to related-op and unrelated op
find_related_goal(Statics,I1,I):-
    gOperator(OPID,ID,operator(Name,Prev,Nec,Cond)),
    find_related_goal_nec(OPID,Name,Prev,Nec,Statics,I1,I),
    find_related_goal_cond(OPID,Name,Prev,Nec,Cond,Statics,I1,I),
    fail.
find_related_goal(Statics,I1,I).

find_related_goal_nec(ID,Name,Prev,Nec,Statics,I1,I):-
    goal_related(se(Sort,Obj,SE),Ops,I1),
    member(sc(Sort,Obj,Lhs=>Rhs),Nec),
    state_match(Sort,Obj,SE,Rhs),
    statics_consist(Statics),
%    assert_op_score(ID,OPs),
    assert_goal_related(Prev,Nec,ID,I).
find_related_goal_cond(ID,Name,Prev,Nec,[],Statics,I1,I):-
    !.
find_related_goal_cond(ID,Name,Prev,Nec,Cond,Statics,I1,I):-
    goal_related(se(Sort,Obj,SE),Ops,I1),
    member(sc(Sort0,Obj,LHS=>RHS),Cond),
    is_of_sort(Obj,Sort0),
    is_of_sort(Obj,Sort),%Sort is a primitive sort changed at init
    filterInvars(LHS,LInVars,LIsOfSorts,LNEs,FLHS),
    filterInvars(RHS,RInVars,RIsOfSorts,RNEs,FRHS),
    can_achieve_g([se(Sort,Obj,FRHS)],[se(Sort,Obj,SE)],Statics),
    statics_consist(Statics),
    checkInVars(LInVars),
    checkInVars(RInVars),
    checkIsOfSorts(LIsOfSorts),
    checkIsOfSorts(RIsOfSorts),
    obeysNEs(LNEs),
    obeysNEs(RNEs),
%    assert_op_score(ID,OPs),
    assert_goal_related(Prev,[sc(Sort,Obj,FLHS=>FRHS)|Nec],ID,I).

% filter out invars, is_of_sorts and nes from a state list
filterInvars([],[],[],[],[]):-!.
filterInvars([is_of_sort(A,B)|State],InVars,[is_of_sort(A,B)|IsOfSorts],NEs,FState):-	
    !,
    filterInvars(State,InVars,IsOfSorts,NEs,FState).	
filterInvars([ne(A,B)|State],InVars,IsOfSorts,[ne(A,B)|NEs],FState):-  dif(A,B),
    !,
    filterInvars(State,InVars,IsOfSorts,NEs,FState).	
filterInvars([is_of_primitive_sort(A,B)|State],InVars,[is_of_sort(A,B)|IsOfSorts],NEs,FState):-	
    !,
    filterInvars(State,InVars,IsOfSorts,NEs,FState).
filterInvars([Pred|State],[Pred|InVars],IsOfSorts,NEs,FState):-
    functor(Pred,FF,NN),
    functor(Pred1,FF,NN),
    atomic_invariantsC(Atom),
    member_cut(Pred1,Atom),!,
    filterInvars(State,InVars,IsOfSorts,NEs,FState).
filterInvars([Pred|State],InVars,IsOfSorts,NEs,[Pred|FState]):-
    filterInvars(State,InVars,IsOfSorts,NEs,FState).

% filter out nes from a state list
filterNes([],[],[]):-!.
filterNes([ne(A,B)|State],[ne(A,B)|NEs],FState):-  dif(A,B),  
    !,
    filterNes(State,NEs,FState).
filterNes([Pred|State],NEs,[Pred|FState]):-
    filterNes(State,NEs,FState).	

assert_related_op(OP,I):-
    related_op(OP,_),!.
assert_related_op(OP,I):-
    env_asserta(related_op(OP,I)),!.

% State2 can be achieved by State1
can_achieve_g([],State2,Statics):-!.
can_achieve_g(State1,State2,Statics):-
    can_achieve_g(State1,State2),
    statics_consist(Statics).

can_achieve_g([se(Sort,Obj,ST1)|State1],[se(Sort,Obj,ST2)]):-
    state_match(Sort,Obj,ST2,ST1).
can_achieve_g([Head|State1],State2):-
    can_achieve_g(State1,State2).

% assert goal_related(Pre,Post,Op,DistanseFromGoal)
assert_goal_related(Prev,Nec,OP,I):-
    assert_goal_related1(Prev,OP,I),!,
    assert_goal_related1(Nec,OP,I).

assert_goal_related1([],Op,I):-!.
assert_goal_related1([se(Sort,Obj,SE)|Prev],Op,I):-
    assert_goal_related2(se(Sort,Obj,SE),Op,I),
    assert_goal_related1(Prev,Op,I),!.
assert_goal_related1([sc(Sort,Obj,LH=>RH)|Nec],Op,I):-
    ground(Obj),%because conditional didn't ground, so the Sort maybe nonprim
    is_of_primitive_sort(Obj,PSort),!,
    assert_goal_related2(se(PSort,Obj,LH),Op,I),
    assert_goal_related1(Nec,Op,I).
assert_goal_related1([sc(Sort,Obj,LH=>RH)|Nec],Op,I):-
    var(Obj),
    assert_related_goals_varible(Sort,Obj,LH,Op,I),
    assert_goal_related1(Nec,Op,I).

assert_goal_related2(se(Sort,Obj,SE),goal,I):-
    env_assert(goal_related(se(Sort,Obj,SE),[],I)),!.
assert_goal_related2(se(Sort,Obj,SE),Op,I):-
    goal_related(se(Sort,Obj,SE1),Ops,I),
    not(is_diff(SE,SE1)),
    env_retract(goal_related(se(Sort,Obj,SE),Ops,I)),
    env_assert(goal_related(se(Sort,Obj,SE),[Op|Ops],I)),!.
assert_goal_related2(se(Sort,Obj,SE),Op,I):-
    env_assert(goal_related(se(Sort,Obj,SE),[Op],I)),!.

assert_related_goals_varible(Sort,Obj,SE,Op,I):-
    find_prim_sort(Sort,PSorts),
    member(Sort1,PSorts),
    assert_goal_related2(se(Sort1,Obj,SE),Op,I),
    fail.
assert_related_goals_varible(Sort,Obj,SE,Op,I).

%env_assert score for Op, the further from goal, the higher the score
assert_op_score(OP,OPB):-
     op_score(OP,_),!.
assert_op_score(OP,OPB):-
     op_score(OPB,I),
     I1 is I+1,
     env_assert(op_score(OP,I1)),!.

get_score(PR,Post,Steps,Score):-
    tp_goal(Pre,Goal,Statics),
    get_distance(Pre,Post,Goal,0,Dis),%length from Present to Goal
%    length(Pre,Obj_Num),
    get_tnode_length(PR,1,Len),
%    Num1 is Obj_Num*Dis,%distanse the smaller the better
%    Num2 is Obj_Num*Len1,%length of the plan the smaller the better
%    Score is Num1+Num2,!.
    Score is Dis+Len,!.

get_distance(Pre,[],Goal,Dis,Dis):-!.
get_distance(Pre,[se(Sort,Obj,SE)|Post],Goal,Dis1,Dis):-
    member(se(Sort,Obj,SE0),Goal),
    state_match(Sort,Obj,SE0,SE),%if it achieved goal
    get_distance(Pre,Post,Goal,Dis1,Dis),!.
get_distance(Pre,[se(Sort,Obj,SE)|Post],Goal,Dis1,Dis):-
    goal_related(se(Sort,Obj,SE0),_,Level),
    state_match(Sort,Obj,SE0,SE),
    Dis2 is Dis1+Level,
    get_distance(Pre,Post,Goal,Dis2,Dis),!.
get_distance(Pre,[se(Sort,Obj,SE)|Post],Goal,Dis1,Dis):-
    member(se(Sort,Obj,SE0),Pre),
    state_match(Sort,Obj,SE,SE0),%if it does't change initial state
    Dis2 is Dis1+1,
    get_distance(Pre,Post,Goal,Dis2,Dis),!.
get_distance(Pre,[se(Sort,Obj,SE)|Post],Goal,Dis1,Dis):-
    Dis2 is Dis1+100,
    get_distance(Pre,Post,Goal,Dis2,Dis),!.

get_tnode_length(init,Len,Len):-!.
get_tnode_length(TP,Len1,Len):-
    closed_node(TP,_,_,from(PR),_,_),
    Len2 is Len1+1,
    get_tnode_length(PR,Len2,Len),!.


% the states that can achieve a state
% that is:
% for a state in the rhs of operator
% all the states in the lhs
find_relate_state:-
   operatorC(A,Pre,Post,Cond,ST),
   assert_related_states(A,Pre,Post,Cond,ST),
   fail.
find_relate_state.

assert_related_states(A,Pre,Post,Cond,ST):-
   assert_related_states1(A,Pre,Post,ST),
   assert_related_states2(A,Pre,Cond,ST).
% find relate in nec
% the sorts here are primitive
assert_related_states1(A,Pre,[],ST):-!.
%when prev
assert_related_states1(A,Pre,[se(Sort,Obj,SE)|Post],ST):-
   u_mem_cut(se(Sort,Obj,SE),Pre),
   assert_related_states1(A,Pre,Post,ST),!.
%when nec
assert_related_states1(A,Pre,[se(Sort,Obj,SE)|Post],ST):-
   env_assert(produce(se(Sort,Obj,SE),A,Pre,ST)),
   assert_related_states1(A,Pre,Post,ST),!.

% find relate in conditional
% the sorts here are not primitive
assert_related_states2(A,Pre,SC,ST):-
   make_sc_primitive(SC,PSC),
   assert_related_states21(A,Pre,PSC,ST).

assert_related_states21(A,Pre,[],ST):-!.
assert_related_states21(A,Pre,[sc(Sort,Obj,SE=>SS)|Trans],ST):-
   rem_statics([se(Sort,Obj,SE)],[se(Sort,Obj,SER)],St1),
   rem_statics([se(Sort,Obj,SS)],[se(Sort,Obj,SSR)],St2),
   append_cut(ST,St1,ST1),
   append_cut(ST1,St2,ST21),
   remove_unneed(ST21,[],ST2),
   append_cut(Pre,[se(Sort,Obj,SER)],Pre1),
   env_assert(produce(se(Sort,Obj,SSR),A,Pre1,ST2)),
   assert_related_states21(A,Pre,Trans,ST),!.

%-------------------------------------------
% remove HP1 from the temp list
% if  HP1<HP2, then all HP3<HP1 => HP3<HP2
% if  HP2<HP1, then all HP1<HP3 => HP2<HP3
remove_temp([],HP1,List,List):-!.
remove_temp([before(HP1,HP2)|Temp],HP1,List,Temp1):-
    remove_temp_before(List,before(HP1,HP2),List2),
    remove_temp(Temp,HP1,List2,Temp1),!.
remove_temp([before(HP2,HP1)|Temp],HP1,List,Temp1):-
    remove_temp_after(List,before(HP2,HP1),List2),
    remove_temp(Temp,HP1,List2,Temp1),!.
remove_temp([before(HPX,HPY)|Temp],HP1,List,Temp1):-
    remove_temp(Temp,HP1,List,Temp1),!.

% if  HP1<HP2, remove HP1<HP2, and change all HP3<HP1 => HP3<HP2
remove_temp_before([],before(HP1,HP2),[]):-!.
remove_temp_before([before(HP1,HP2)|T],before(HP1,HP2),T1):-
   remove_temp_before(T,before(HP1,HP2),T1),!.
remove_temp_before([before(HP3,HP1)|T],before(HP1,HP2),[before(HP3,HP2)|T1]):-
   remove_temp_before(T,before(HP1,HP2),T1),!.
remove_temp_before([before(HPX,HPY)|T],before(HP1,HP2),[before(HPX,HPY)|T1]):-
   remove_temp_before(T,before(HP1,HP2),T1),!.
% if  HP2<HP1, remove HP2<HP1, and change all HP1<HP3 => HP2<HP3
remove_temp_after([],before(HP1,HP2),[]):-!.
remove_temp_after([before(HP2,HP1)|T],before(HP2,HP1),T1):-
   remove_temp_after(T,before(HP2,HP1),T1),!.
remove_temp_after([before(HP1,HP3)|T],before(HP2,HP1),[before(HP2,HP3)|T1]):-
   remove_temp_after(T,before(HP2,HP1),T1),!.
remove_temp_after([before(HPX,HPY)|T],before(HP2,HP1),[before(HPX,HPY)|T1]):-
   remove_temp_after(T,before(HP2,HP1),T1),!.

remove_dec(HPid,[],[]):-!.
remove_dec(HPid,[step(HPid,_,_,_,_)|Dec],Dec1):-
   remove_dec(HPid,Dec,Dec1),!.
remove_dec(HPid,[step(A,B,C,D,F)|Dec],[step(A,B,C,D,F)|Dec1]):-
   remove_dec(HPid,Dec,Dec1),!.
   
/******************************************************/
% State2 is achieved by State1
% the two states need to be primitive
state_achieved(undefd,State,Statics):-!.
state_achieved([],State2,Statics):-!.
state_achieved(State1,State2,Statics):-
    state_achieved(State1,State2),
    statics_consist(Statics).

state_achieved(undefd,State):-!.
state_achieved([],State2).
state_achieved([se(Sort,Obj,ST1)|State1],State2):-
    member(se(Sort,Obj,ST2),State2),
    is_of_sort(Obj,Sort),
    state_match(Sort,Obj,ST1,ST2),
    list_take(State2,[se(Sort,Obj,ST2)],State21),
    state_achieved(State1,State21).
state_achieved([se(Sort,Obj,ST1)|State1],State2):-
    not(member(se(Sort,Obj,ST2),State2)),
    state_achieved(State1,State2),!.

/************ states ST matchs ST1  ********/
% state_match: ST is achieved by ST1
% ST=ST1
state_match(Sort,Obj,ST,ST1):-
    not(is_diff(ST,ST1)),!.
% when ST is the subset of ST1,
% in some domain, one substateclass is anothers's subset
% they cann't consider as match each other
% for example [on_block(a,b)] and [on_block(a,b),clear(a)]
state_match(Sort,Obj,ST,ST1):-
    is_achieved(ST,ST1),
    gsubstate_classes(Sort,Obj,Substateclasses),
    not(in_different_states(ST,ST1,Substateclasses)),!.
% when ST is not the subset of ST1,
% in hierarchical domain, maybe one is inhiered by the upperlevel
state_match(Sort,Obj,ST,ST1):-
    not(is_achieved(ST,ST1)),    
    set_append(ST,ST1,ST0),
    gsubstate_classes(Sort,Obj,Substateclasses),
    in_same_sub_states(ST0,Substateclasses),!.

% in_same_sub_states: check if ST1+ST2 in one states
in_same_sub_states(ST0,[State|SCls]):-
    is_achieved(ST0,State),!.
in_same_sub_states(ST0, [State|SCls]):-
    in_same_sub_states(ST0,SCls),!.

% in_different_states: check if ST,ST1 in different states
in_different_states(ST,ST1, [State|SCls]):-
    max_member(ST,Substateclasses,MSub, _),
    max_member(ST1,Substateclasses,MSub1, _),
    MSub\==MSub1,!.

max_member(State, Stateclass, MSub, Others):-
    max_member1(State, Stateclass, 0, [],MSub),
    subtract(State,MSub,Others),!.

% find out the biggest same items
max_member1(State, [], Num, MSub, MSub):-!.
% find it out the biggest set of common items in substateclass and State
max_member1(State, [State1|SCls], Num, MSub1, MSub):-
    same_items(State1,State,MSSt),
    length(MSSt,Len),
    Len > Num,
    max_member1(State, SCls, Len, MSSt, MSub),!.
max_member1(State, [State1|SCls], Num, MSub1,MSub):-
    max_member1(State, SCls, Num, MSub1,MSub),!.

% find it out the same items in two list
same_items([],List2,[]):-!.
same_items([X|List1],List2,[X|Same]):-
    member(X,List2),
    same_items(List1,List2,Same),!.
same_items([X|List1],List2,Same):-
    same_items(List1,List2,Same),!.


% all the element in list1 are static or in list2
is_achieved([],_):-!.
is_achieved([H|T], State) :-
    is_statics(H),
    is_achieved(T,State),!.
is_achieved([H|T], State) :-
    member(H,State),
    is_achieved(T,State),!.

% check if a predicate is statics or not
is_statics(ne(A,B)):-!.
is_statics(is_of_sort(A,B)):-!.
is_statics(is_of_primitive_sort(A,B)):-!.
is_statics(Pred):-
    functor(Pred,FF,NN),
    functor(Pred1,FF,NN),
    atomic_invariantsC(Atom),
    member_cut(Pred1,Atom),!.

/************ state changes by actions ********/
% on the condition that:
% an object's state meet action's precondition
% it change to the postcondition
% Pre is the current ground states(Sort is primitive)
% Pre0 and Post0 are from an Operator or Method(
% Sorts are all primitive
state_change([],Pre0,Post0,[]):-!.
state_change(Pre,[],[],Pre):-!.
state_change([se(Sort,Obj,SPre)|Pre],Pre0,Post0,[se(Sort,Obj,STPost)|Post]):-
    state_achieved([se(Sort,Obj,SPre)],Pre0),
    state_change0(Sort,Obj,SPre,Pre0,Post0,Pre1,Post1,STPost),
    state_change(Pre,Pre1,Post1,Post).
state_change([se(Sort,Obj,SPre)|Pre],Pre0,Post0,[se(Sort,Obj,STPost)|Post]):-
    not(member(se(Sort,Obj,SPre0),Pre0)),
    state_change(Pre,Pre1,Post1,Post).
		 
% change the obj's post state with action's post
state_change0(Sort,Obj,SPre,[],[],[],[],SPre):-!.
state_change0(Sort,Obj,SPre,[se(Sort,Obj,SPre0)|Pre0],[se(Sort,Obj,SPost0)|Post0],Pre0,Post0,STPost):-
    state_change1(SPre,SPre0,SPost0,STPost).
state_change0(Sort,Obj,SPre,[se(Sort1,Obj1,SPre0)|Pre0],[se(Sort1,Obj1,SPost0)|Post0],[se(Sort1,Obj1,SPre0)|Pre1],[se(Sort1,Obj1,SPost0)|Post1],STPost):-
    Obj\==Obj1,
    state_change0(Sort,Obj,SPre,Pre0,Post0,Pre1,Post1,STPost).

state_change1([],SPre0,SPost0,SPost0):-!.
state_change1(Pre,[],[],Pre):-!.
%if the pre state in action's pre, not in post, remove that
state_change1([Head|SPre],SPre0,SPost0,STPost):-
    member(Head,SPre0),
    not(member(Head,SPost0)),
    state_change1(SPre,SPre0,SPost0,STPost).
% if the pre state is not action's pre, neither in post, add that
state_change1([Head|SPre],SPre0,SPost0,[Head|STPost]):-
    not(member(Head,SPre0)),
    not(member(Head,SPost0)),
    state_change1(SPre,SPre0,SPost0,STPost),!.
% if the pre state is in post, don't need to add
% because it will be add at last
state_change1([Head|SPre],SPre0,SPost0,STPost):-
    member(Head,SPost0),
    state_change1(SPre,SPre0,SPost0,STPost).

% rough change the obj's post state with action's post
rough_state_change(Pre,[],[],Pre):-!.
rough_state_change([],_,_,[]):-!.
rough_state_change([se(Sort,Obj,SE)|Pre],Pre0,Post0,[se(Sort,Obj,SS0)|Post]):-
    member(se(Sort,Obj,SE0),Pre0),
    member(se(Sort,Obj,SS0),Post0),
    is_of_sort(Obj,Sort),
    state_achieved([se(Sort,Obj,SE0)],[se(Sort,Obj,SE)]),
    list_take(Pre0,[se(Sort,Obj,SE0)],Pre01),
    list_take(Post0,[se(Sort,Obj,SS0)],Post01),
    rough_state_change(Pre,Pre01,Post01,Post),!.
rough_state_change([se(Sort,Obj,SE)|Pre],Pre0,Post0,[se(Sort,Obj,SE)|Post]):-
    rough_state_change(Pre,Pre0,Post0,Post),!.

% a simple state_change for ground operators
state_changeG([],Pre0,Post0,[]):-!.
state_changeG([se(Sort,Obj,SE)|Pre],Pre0,Post0,[se(Sort,Obj,RHS)|State]):-
   member(se(Sort,Obj,LHS),Pre0),
   member(se(Sort,Obj,RHS),Post0),
   state_match(Sort,Obj,SE,LHS),
   state_changeG(Pre,Pre0,Post0,State),!.
state_changeG([se(Sort,Obj,SE)|Pre],Pre0,Post0,[se(Sort,Obj,SE)|State]):-
   not(member(se(Sort,Obj,LHS),Pre0)),
   state_changeG(Pre,Pre0,Post0,State),!.

find_lower_sort(Sort,Sort,Sort):-!.
find_lower_sort(Sort,Sort1,Sort1):-
    subsorts(Sort,Sortls),
    member(Sort1,Sortls),!.
find_lower_sort(Sort,Sort1,Sort):-
    subsorts(Sort1,Sortls),
    member(Sort,Sortls),!.
%-------------------------------------------------
/************ state changes by necessery changes ********/
% for all the object's state meet the precondition
% it change to the postcondition
% this is only used in apply grounded operators
nec_state_change([],Nec,[]):-!.
nec_state_change([se(Sort,Obj,SE)|Pre],Nec,[se(Sort,Obj,Post)|State]):-
    member(sc(Sort,Obj,Lhs=>Rhs),Nec),
    state_match(Sort,Obj,Lhs,SE),
    state_change1(SE,Lhs,Rhs,Post),
    nec_state_change(Pre,Nec,State),!.
nec_state_change([se(Sort,Obj,SE)|Pre],Nec,[se(Sort,Obj,SE)|State]):-
    not(member(sc(Sort,Obj,Lhs=>Rhs),Nec)),
    nec_state_change(Pre,Nec,State),!.
%-------------------------------------------------
/************ state changes by conditions ********/
% for all the object's state meet the precondition
% it change to the postcondition
cond_state_change([],Cond,[]):-!.
cond_state_change(State,[],State):-!.
cond_state_change([se(Sort,Obj,SE)|Pre],Cond,[NewSS|State]):-
    member(sc(Sort1,Obj1,SE0=>SS0),Cond),
%    var(Obj1),
    subsorts(Sort1,Subsorts),
    member(Sort,Subsorts),
    copy_states(se(Sort1,Obj1,SE0),se(Sort,Obj,SE2)),
    copy_states(se(Sort1,Obj1,SS0),se(Sort,Obj,SS2)),
%    state_match(Sort,Obj,SE,SE0),
    filterInvars(SE2,LInVars,LIsOfSorts,LNEs,FSE),
    filterInvars(SS2,RInVars,RIsOfSorts,RNEs,FSS),
    state_match(Sort,Obj,SE,FSE),
    state_change([se(Sort,Obj,SE)],[se(Sort,Obj,FSE)],
                              [se(Sort,Obj,FSS)],[NewSS]),
    checkInVars(LInVars),
    checkInVars(RInVars),
    checkIsOfSorts(LIsOfSorts),
    checkIsOfSorts(RIsOfSorts),
    obeysNEs(LNEs),
    obeysNEs(RNEs),    
    cond_state_change(Pre,Cond,State),!.
cond_state_change([se(Sort,Obj,SE)|Pre],Cond,[se(Sort,Obj,SE)|State]):-
    cond_state_change(Pre,Cond,State),!.

% copy the states so that the Obj won't be instiated
copy_states(se(Sort1,Obj1,SE0),se(Sort,Obj,SE2)):-
    copy_states1(Obj1,SE0,Obj,SE2),!.
copy_states1(Obj1,[],Obj,[]):-!.
copy_states1(Obj1,[Pred|SE0],Obj,[Pred2|SE2]):-
     functor(Pred,FF,NN),
     functor(Pred2,FF,NN),
     Pred=..[Name|Vars],
     Pred2=..[Name|Vars2],
     copy_pred(Obj1,Obj,Vars,Vars2),
     copy_states1(Obj1,SE0,Obj,SE2),!.

copy_pred(Obj1,Obj,[],[]):-!.
copy_pred(Obj1,Obj,[Var|Vars],[Var2|Vars2]):-
     Obj1==Var,
     Var2=Obj,
     copy_pred(Obj1,Obj,Vars,Vars2),!.
copy_pred(Obj1,Obj,[Var|Vars],[Var|Vars2]):-
     copy_pred(Obj1,Obj,Vars,Vars2),!.
%-------------------------------------------
% every states in List1 is achieved by List2
all_achieved(undefd,Statics,List2):-!.
all_achieved([],Statics,List2):-!.
all_achieved(List1,Statics,List2):-
    all_achieved(List1,List2),
    statics_consist(Statics).

all_achieved([],List2).
all_achieved([se(Sort,Obj,SL)|List1],List2):-
    member(se(Sort1,Obj,SR),List2),
    is_of_sort(Obj,Sort1),
    is_of_sort(Obj,Sort),
    is_of_primitive_sort(Obj,PSort),
    state_match(PSort,Obj,SL,SR),
    all_achieved(List1,List2).
%-------------------------------------------
% may_achieved: every states in Pre is not conflict with Post
may_achieved(undefd,Statics,Post):-!.
may_achieved([],Statics,Post):-!.
may_achieved(Pre,Statics,Post):-
    may_achieved(Pre,Post),
    statics_consist(Statics),!.
may_achieved([],Post).
may_achieved([se(Sort,Obj,SL)|Pre],Post):-
    member(se(Sort1,Obj,SR),Post),
    is_of_sort(Obj,Sort1),
    is_of_sort(Obj,Sort),
    is_of_primitive_sort(Obj,PSort),
    state_may_achieved(PSort,Obj,SL,SR),
    may_achieved(Pre,Post),!.

% if the ST1 is a subset of ST2
state_may_achieved(Sort,Obj,[],ST2):-!.
state_may_achieved(Sort,Obj,ST1,ST2):-
    is_achieved(ST1,ST2),!.
%-------------------------------------------
% instantiate a bit
% use action's state change include the postcondition
post_instant(Post0,Cond,Statics,undefd):-!.
post_instant(Post0,Cond,Statics,[]):-!.
post_instant(Post0,Cond,Statics,[se(Sort,Obj,SE)|Post]):-
    member(se(Sort,Obj,SE0),Post0),
    statics_consist(Statics).
post_instant(Post0,Cond,Statics,[se(Sort,Obj,SE)|Post]):-
    member(sc(Sort,Obj,SE1=>SS),Cond),
    statics_consist(Statics).
post_instant(Post0,Cond,Statics,[se(Sort,Obj,SE)|Post]):-
    member(sc(Sort0,Obj,SE1=>SS),Cond),
    not(objectsC(Sort0,_)),
    subsorts(Sort0,Sortls),
    not(not(member(Sort,Sortls))),
    statics_consist(Statics).
post_instant(Post0,Cond,Statics,[se(Sort,Obj,SE)|Post]):-
    post_instant(Post0,Cond,Statics,Post),!.

/********* check for statics consist without instanciate them***/
% only instance the variable when there is one choice of from the ground lists
statics_consist([]):-!.
statics_consist(Statics):-
   get_invariants(Invs),
   statics_consist(Invs,Statics),!.
statics_consist(Invs,[]):-!.
statics_consist(Invs,[ne(A,B)|Statics]):- dif(A,B),
   not(A==B),!,
   statics_consist(Invs,Statics).
statics_consist(Invs,[is_of_sort(Obj,Sort)|Statics]):-
   not(not(is_of_sort(Obj,Sort))),!,
   statics_consist(Invs,Statics).
statics_consist(Invs,[is_of_primitive_sort(Obj,Sort)|Statics]):-
   not(not(is_of_primitive_sort(Obj,Sort))),!,
   statics_consist(Invs,Statics).
statics_consist(Invs,[Pred|Statics]):-
   pred_member(Pred,Invs),!,
   statics_consist(Invs,Statics).

/*********check for statics consist and instanciate them***/
statics_consist_instance([]):-!.
statics_consist_instance(Statics):-
   get_invariants(Invs),
   statics_consist_instance(Invs,Statics).

statics_consist_instance(Invs,[]):-!.
statics_consist_instance(Invs,[is_of_sort(Obj,Sort)|Atom]):-
   ground(Obj),
   is_of_sort(Obj,Sort),!,
   statics_consist_instance(Invs,Atom).
statics_consist_instance(Invs,[is_of_sort(Obj,Sort)|Atom]):-
   var(Obj),
   is_of_sort(Obj,Sort),
   statics_consist_instance(Invs,Atom).
statics_consist_instance(Invs,[is_of_primitive_sort(Obj,Sort)|Atom]):-
   ground(Obj),
   is_of_primitive_sort(Obj,Sort),!,
   statics_consist_instance(Invs,Atom).
statics_consist_instance(Invs,[is_of_primitive_sort(Obj,Sort)|Atom]):-
   var(Obj),
   is_of_primitive_sort(Obj,Sort),
   statics_consist_instance(Invs,Atom).
statics_consist_instance(Invs,[ne_back(A,B)|Atom]):-
   A\==B, dif(A,B),
   statics_consist_instance(Invs,Atom).
statics_consist_instance(Invs,[ne(A,B)|Atom]):-
   append_dcut(Atom,[ne_back(A,B)],Atom1),!,
   statics_consist_instance(Invs,Atom1).
statics_consist_instance(Invs,[Pred|Atom]):-
   ground(Pred),
   member(Pred,Invs),!,
   statics_consist_instance(Invs,Atom).
statics_consist_instance(Invs,[Pred|Atom]):-
   not(ground(Pred)),
   member(Pred,Invs),
   statics_consist_instance(Invs,Atom).



/*********************Initial process *********************/
%node(Name, Precond, Decomps, Temp, Statics)
% When inputting new methods etc filter all statics into
% static slot

make_problem_into_node(I,goal(L,TM,STATS),  NN) :-
     make_problem_up(L, STEPS),
     make_num_hp(TM,Temp),
     sort_steps(STEPS,Temp,STEPS1),
     make_ss_to_se(I,I_Pre),
     NN = node(root,I_Pre,STEPS1 ,Temp, STATS),!.
make_problem_into_node(I,L,  NN) :-
     make_problem_up([achieve(L)], STEPS),
     make_num_hp(TM,Temp),
     sort_steps(STEPS,Temp,STEPS1),
     make_ss_to_se(I,I_Pre),
     NN = node(root,I_Pre,STEPS1 ,Temp, STATS),!.

% make problem to steps
make_problem_up([],[]):-!.
make_problem_up([achieve(L)|R],[step(HP,achieve(L1),undefd,[L1],unexp)|RS]):- 
                             %preconditon here is undefd
    make_ss_to_se([L],[L1]),
    gensym_special(hp,HP),
    make_problem_up(R, RS),!.
make_problem_up([achieve(L)|R],[step(HP,achieve(L1),undefd,L1,unexp)|RS]):- 
                             %preconditon here is undefd
    make_ss_to_se(L,L1),
    gensym_special(hp,HP),
    make_problem_up(R, RS),!.
make_problem_up([O|R],[step(HP,O,undefd,undefd,unexp)|RS]):-
    methodC(O,Pre,Post,Statics1,Temp,ACH,Dec),
    gensym_special(hp,HP),
    make_problem_up(R, RS),!.
make_problem_up([O|R],     
           [step(HP,O,undefd,undefd,unexp)|RS]):-
    operatorC(O,Pre,Post,Cond,Statics1),
    gensym_special(hp,HP),
    make_problem_up(R, RS),!.

make_num_hp([],[]):-!.
make_num_hp([before(N1,N2)|TM],[before(H1,H2)|Temp]):-
    gensym_num(hp,N1,H1),
    gensym_num(hp,N2,H2),
    make_num_hp(TM,Temp),!.

%**************sort steps*********************************
% sort steps by temporal constraints.
sort_steps(Steps,[],Steps):-!.
sort_steps([Steps|[]],[],[Steps]):-!.
sort_steps(Steps,Temp,OrderedST):-
   steps_in_temp(Temp,[],ST),
   sort_steps1(Temp,ST,OrderedSTID),
   sort_steps2(Steps,OrderedSTID,[],OrderedST),!.

% find out the steps in temporal constraints.
steps_in_temp([],ST,ST):-!.
steps_in_temp([before(H1,H2)|TT],List,ST):-
   set_append_e(List,[H1,H2],List1),
   steps_in_temp(TT,List1,ST),!.

% sort the steps_id(hps) by temporal constraints.
sort_steps1(Temp,[],[]):-!.
sort_steps1(Temp,[HP1|TST],[HPF|OST]):-
   earliest_step(HP1,HPF,Temp,TST,TST1),
   sort_steps1(Temp,TST1,OST),!.
   
earliest_step(HPF,HPF,Temp,[],[]):-!.
earliest_step(HP1,HPF,Temp,[HP2|TST],[HP1|TST1]):-
   member(before(HP2,HP1),Temp),
   earliest_step(HP2,HPF,Temp,TST,TST1),!.
earliest_step(HP1,HPF,Temp,[HP2|TST],[HP2|TST1]):-
   earliest_step(HP1,HPF,Temp,TST,TST1),!.

% sort the steps, put the unordered steps in the front
sort_steps2(OtherST,[],OrderedST1,OrderedST):-
   append_dcut(OrderedST1,OtherST,OrderedST),!.
sort_steps2(Steps,[HP|THPS],List,OrderedST):-
   member(step(HP,N,Pre,Post,F),Steps),
   append_dcut(List,[step(HP,N,Pre,Post,F)],List1),
   list_take(Steps,[step(HP,N,Pre,Post,F)],Steps1),
   sort_steps2(Steps1,THPS,List1,OrderedST),!.
sort_steps2(Steps,[HP|THPS],List,OrderedST):-
   sort_steps2(Steps,THPS,List,OrderedST),!.
%*******************************************************

% replace ss to se
make_ss_to_se([],[]):-!.
make_ss_to_se([ss(Sort,Obj,Post)|TPost],[se(Sort,Obj,Post)|TPre]):-
     make_ss_to_se(TPost,TPre),!.
make_ss_to_se([se(Sort,Obj,Post)|TPost],[se(Sort,Obj,Post)|TPre]):-
     make_ss_to_se(TPost,TPre),!.

%*******************************************************
% extract_solution(Node,..
% recurvise routine to work down tree and
% print out a linearisation of it
extract_solution(Node,PHPs,SIZE1,TNList) :-
       % its the name of a hierarchical op......
   getN_decomp(Node, HPs),
   push_to_primitive(HPs,[],PHPs,[],TNList),
   pprint(PHPs,1,SIZE),
   SIZE1 is SIZE -1,!.

/************ change_op_representation ***********/
% make pre and post explicit
% filter out statics and put in a new slot
change_op_representation :-    
    method(A,B,C,Stat,T,Dec),
    make_ss_to_se(B,B0),
    make_se_primitive(B0,B1),
    make_sc_primitive(C,C1),
    get_preconditions(C1,B1,Pre,Post),
    rem_statics(Post, PostR,St1),
    rem_statics(Pre, PreR,St2),
    append_cut(St1,St2,Statics),
    append_cut(Stat,Statics,Statics1),
    remove_unneed(Statics1,[],Statics2),
    get_achieval(A,Dec,T,Dec1,T1,ACH),
    env_assert(methodC(A,PreR,PostR,Statics2,T1,achieve(ACH),Dec1)),
    fail.
change_op_representation :-
    operator(A,B,C,D),
    make_ss_to_se(B,B0),
    make_se_primitive(B0,B1),
    make_sc_primitive(C,C1),
%    make_sc_primitive(D,D1),
	%can't do that because it narrow the conditional change 
    get_preconditions(C1,B1,Pre,Post),
    rem_statics(Post, PostR,St1),
    rem_statics(Pre, PreR,St2),
    append_cut(St1,St2,Statics1),
    remove_unneed(Statics1,[],Statics),
    statics_consist(Statics),
    env_assert(operatorC(A,PreR,PostR,D,Statics)),
    fail.
change_op_representation:-
    env_retractall(current_num(sm,_)),!.

get_preconditions([],Prev,Prev,Prev) :-!.
get_preconditions([sc(S,X,From =>To)|Rest],Prev,[se(S,X,From1)|Pre],[se(S,X,To1)|Post]):-
     member_e(se(S,X,PSE),Prev),
     append_dcut(PSE,From,From1),
     append_dcut(PSE,To,To1),
     list_take(Prev,[se(S,X,PSE)],Prev1),
     get_preconditions(Rest,Prev1, Pre,Post),!.
get_preconditions([sc(S,X,From =>To)|Rest],Prev,[se(S,X,From)|Pre],[se(S,X,To)|Post]):-
     get_preconditions(Rest,Prev, Pre,Post),!.
get_preconditions([],Prev,Prev,Prev) :-!.

% get all achieve goals out
get_achieval(A,Dec,T,Dec1,T1,Achieval):-
     env_retractall(current_num(sm,_)),
     make_dec(A,Dec,Dec1,T,T1,[],Achieval),!.
make_dec(A,[],[],Temp,Temp,Achieval,Achieval):-!.
make_dec(A,[HD|TD],TD1,Temp,Temp1,Achieval,Achieval1):-
     HD=..[achieve|Goal],
     current_num(sm,Num),
     replace_achieval_temp(Temp,Temp0,Num),
     make_ss_to_se(Goal,Goal0),
     append_dcut(Achieval,Goal0,Achieval0),
     make_dec(A,TD,TD1,Temp0,Temp1,Achieval0,Achieval1),!.
make_dec(A,[HD|TD],TD1,Temp,Temp1,Achieval,Achieval1):-
     HD=..[achieve|Goal],
     not(current_num(sm,_)),
     replace_achieval_temp(Temp,Temp0,1),
     make_ss_to_se(Goal,Goal0),
     append_dcut(Achieval,Goal0,Achieval0),
     make_dec(A,TD,TD1,Temp0,Temp1,Achieval0,Achieval1).
make_dec(A,[HD|TD],[HD|TD1],Temp,Temp1,Achieval,Achieval1):-
     HD=..[DecName|Goal],
     DecName\==achieve,
     gensym_special(sm,SM),
     current_num(sm,Num),
     make_dec(A,TD,TD1,Temp,Temp1,Achieval,Achieval1),!.

% get rid of the achievals in temp orders
replace_achieval_temp(Temp,Temp1,Num):-
     change_all_numbers(Temp,Num,Temp00),
     tidy_temp(Temp00,Temp1).

change_all_numbers([],Num,[]):-!.
change_all_numbers([HTemp|TTemp],Num,[HTemp00|TTemp00]):-
     HTemp=..[before|Nums],
     change_nums(Nums,Num,Nums1),
     HTemp00=..[before|Nums1],
     change_all_numbers(TTemp,Num,TTemp00).

change_nums([],Num,[]):-!.
change_nums([Num1|TN],Num,[Num1|TN1]):-
    Num1<Num,
    change_nums(TN,Num,TN1),!.
change_nums([Num1|TN],Num,[Num2|TN1]):-
    Num1>Num,
    Num2 is Num1-1,
    change_nums(TN,Num,TN1),!.
change_nums([Num|TN],Num,[0|TN1]):-
    change_nums(TN,Num,TN1),!.

% since assumed achieval only happen at first, so only change the after ones
tidy_temp(Temp,Temp1):-
     member(before(Num,0),Temp),
     list_take(Temp,[before(Num,0)],Temp0),
     change_laters(Temp0,Num,Temp01),
     tidy_temp(Temp01,Temp1).
tidy_temp([],[]):-!.
tidy_temp([before(0,Num)|Temp],Temp0):-
     tidy_temp(Temp,Temp0),!.
tidy_temp([before(Num1,Num2)|Temp],[before(Num1,Num2)|Temp0]):-
     tidy_temp(Temp,Temp0),!.

change_laters([before(0,Num2)|Temp],Num,[before(Num,Num2)|Temp0]):-
     change_laters(Temp,Num,Temp0).
change_laters([before(Num1,0)|Temp],Num,[before(Num1,0)|Temp0]):-
     change_laters(Temp,Num,Temp0).
change_laters([before(Num1,Num2)|Temp],Num,[before(Num1,Num2)|Temp0]):-
     change_laters(Temp,Num,Temp0).

% change the states to primitive states
make_se_primitive([],[]).
make_se_primitive([se(Sort,Obj,ST)|SE],[se(Sort,Obj,ST)|SE0]):-
    objectsC(Sort,Objls),!,
    make_se_primitive(SE,SE0).
make_se_primitive([se(Sort,Obj,ST)|SE],[se(PSort,Obj,ST)|SE0]):-
    find_prim_sort(Sort,PSorts),
    member(PSort,PSorts),
    make_se_primitive(SE,SE0).

% change the state changes to primitive states
make_sc_primitive([],[]).
make_sc_primitive([sc(Sort,Obj,SE1=>SE2)|ST],[sc(Sort,Obj,SE1=>SE2)|ST0]):-
    objectsC(Sort,Objls),!,
    make_sc_primitive(ST,ST0).
make_sc_primitive([sc(Sort,Obj,SE1=>SE2)|ST],[sc(PSort,Obj,SE1=>SE2)|ST0]):-
    find_prim_sort(Sort,PSorts),
    member(PSort,PSorts),
    make_sc_primitive(ST,ST0).


% ------------ end of change operator ----------------------
/********make_tn: save the expansion results*****/
make_tn(TN,Name,Pre,Post,Temp,Dec):-
    find_only_changed(Pre,Post,[],Pre1,[],Post1),
    not(isemptylist(Post1)),
    not(exist_tn(Pre,Post)),
    gensym_special(tn,TN),
%    tell(user),nl,write(tn(TN,Name,Pre1,Post1,Temp,Dec)),nl,told,
    env_assert(tn(TN,Name,Pre1,Post1,Temp,Dec)),!.

exist_tn(Pre,Post):-
    env_call(tn(_,_,Pre,Post1,_,_)),
    state_achieved(Post,Post1),!.
find_only_changed([],[],Pre,Pre,Post,Post):-!.
% just a lazy check if they are in exactly same sequence
find_only_changed([se(Sort,Obj,ST)|Pre],[se(Sort,Obj,ST)|Post],Pre0,Pre1,Post0,Post1):-
    find_only_changed(Pre,Post,Pre0,Pre1,Post0,Post1),!.
find_only_changed([se(Sort,Obj,ST)|Pre],Post,Pre0,Pre1,Post0,Post1):-
    member(se(Sort,Obj,ST1),Post),
    list_take(Post,[se(Sort,Obj,ST1)],Post2),
    append_changed(se(Sort,Obj,ST),se(Sort,Obj,ST1),Pre0,Pre3,Post0,Post3),
    find_only_changed(Pre,Post2,Pre3,Pre1,Post3,Post1),!.
find_only_changed([se(Sort,Obj,ST)|Pre],Post,Pre0,Pre1,Post0,Post1):-
    member(se(SortN,Obj,ST1),Post),
    list_take(Post,[se(SortN,Obj,ST1)],Post2),
    append_changed(se(Sort,Obj,ST),se(SortN,Obj,ST1),Pre0,Pre3,Post0,Post3),
    find_only_changed(Pre,Post2,Pre3,Pre1,Post3,Post1),!.
% other fail. 

% append_dcut  only changed states
% state_match here means not changed
append_changed(se(Sort,Obj,ST),se(Sort1,Obj,ST1),Pre0,Pre0,Post0,Post0):-
    state_match(Sort,Obj,ST,ST1),!.
append_changed(se(Sort,Obj,ST),se(Sort1,Obj,ST1),Pre0,Pre3,Post0,Post3):-
    append_dcut(Pre0,[se(Sort,Obj,ST)],Pre3),
    append_dcut(Post0,[se(Sort,Obj,ST1)],Post3),!.

%***********print out solution**************************   
push_to_primitive([],PHPs,PHPs,TNLst,TNLst) :-!.
push_to_primitive([step(HPID,_,_,_,exp(TN))|HPs],List,PHPs,TNSoFar,TNFinal) :-
   env_call(tn(TN,Name,Pre,Post,Temp,Dec)),
   push_to_primitive(Dec,List,Dec1,[tn(TN,Name,Pre,Post,Temp,Dec)|TNSoFar],TNNext),
   push_to_primitive(HPs,Dec1,PHPs,TNNext,TNFinal),!.
push_to_primitive([step(HPID,_,_,_,exp(Name))|HPs],List,PHPs,TNSoFar,TNFinal):-
   append_dcut(List,[Name],List1),
   push_to_primitive(HPs,List1,PHPs,TNSoFar,TNFinal),!.

/*********** TEMPORAL AND DECLOBBERING ************/

possibly_before(I,J,Temps) :-
    \+ necessarily_before(J,I,Temps), !.

necessarily_before(J,I,Temps) :-
    member(before(J,I),Temps),!.
necessarily_before(J,I,Temps) :-
    member(before(J,Z),Temps),
    necessarily_before(Z,I,Temps),!.

select_node(node(Name,Pre,Temp,Decomp,Statics)) :-
   env_retract(node(Name,Pre,Temp,Decomp,Statics)),
%   nl,nl,write(Name),write(' RETRACTED'),nl,nl,
%   tell(user),
%   nl,nl,write(Name),write(' RETRACTED'),nl,nl,
%   tell(FF),
    !.

get_obj_prim_sort([],[]):-!.
get_obj_prim_sort([HSort|TV],[HObj|TS]):-
     is_of_primitive_sort(HObj,HSort),
     get_obj_prim_sort(TV,TS),!.
/*
is_of_primitive_sort(X,Y) :-
    objectsC(Y,L),member(X,L).
is_of_sort(X,Y) :-
    is_of_primitive_sort(X,Y).
is_of_sort(X,Y) :-
    sorts(Y,SL),member(Z,SL),is_of_sort(X,Z).
*/
find_all_upper([],[]).
find_all_upper([HVars|TV],[HSorts|TS]):-
     uppersorts(HSorts,Upsorts),
     member(HVars,Upsorts),
     find_all_upper(TV,TS).
     
% find out primitive sorts of a sort.
find_prim_sort(Sort,PS):-
  subsorts(Sort,Subsorts),
  split_prim_noprim(Subsorts,PS,NP),!.

% find out the objects of a sort
get_sort_objects(Sort,Objs):-
   find_prim_sort(Sort,PSorts),
   get_objects1(PSorts,Objls),
   flatten(Objls,[],Objs),!.

get_objects1([],[]):-!.
get_objects1([PS1|RS],[Objls1|Objls]):-
   objectsC(PS1,Objls1),
   get_objects1(RS,Objls),!.

% find subsorts of a sort(exclude).
subsortse(Sort,Subsorts):-
  subsorts(Sort,Subsorts1),
  subtract(Subsorts1,[Sort],Subsorts),!.
% find subsorts of a sort(include).
subsorts(Sort,Subsorts):-
  sort_down([Sort],[],Subsorts),!.

sort_down([],Subsorts,Subsorts):-!.
sort_down([HOpen|TOpen],List,Subsorts):-
  objectsC(HOpen,Objls),
  append_dcut(List,[HOpen],List1),
  sort_down(TOpen,List1,Subsorts),!.
sort_down([HOpen|TOpen],List,Sortslist):-
  sorts(HOpen,Sorts),
  sort_down(Sorts,List,List2),
  sort_down(TOpen,[HOpen|List2],Sortslist),!.
sort_down([HOpen|TOpen],List,Sortslist):-
  sort_down(TOpen,List,Sortslist),!.

% find uppersorts of a sort(excludes).
uppersortse(Sort,Uppersorts):-
  uppersorts(Sort,Uppersortsf),
  subtract(Uppersortsf,[Sort],Uppersorts),!.  
% find uppersorts of a sort or object(include).
uppersorts(Sort,Uppersorts):-
  objectsC(Sort,Objls),
  sort_up(Sort,[Sort],Uppersorts),!.
uppersorts(Sort,Uppersorts):-
  sorts(Sort,Sortls),
  sort_up(Sort,[Sort],Uppersorts),!.
uppersorts(Obj,Sortls):-
  objectsC(Sort,Objls),
  member(Obj, Objls),
  sort_up(Sort,[Sort],Sortls),!.

sort_up(Sort, List,Sortslist):-
  sorts(NPSort, NPSortls),
  not((special_sorts(PS), NPSort == PS )),  
  member(Sort,NPSortls),
  sort_up(NPSort,[NPSort|List],Sortslist).
sort_up(Sort, List,List):-!.

special_sorts(primitive_sorts).
special_sorts(non_primitive_sorts).


% sametree: Sort1 and Sort2 are in same sort tree.
sametree(Sort1,Sort2):-
     Sort1==Sort2,!.
sametree(Sort1,Sort2):-
     var(Sort1),!.
sametree(Sort1,Sort2):-
     var(Sort2),!.
sametree(Sort1,Sort2):-
     uppersorts(Sort2,Sortls),
     member(Sort1,Sortls),!.
sametree(Sort1,Sort2):-
     uppersorts(Sort1,Sortls),
     member(Sort2,Sortls),!.

% split a sortlist to  primitive sorts and non-primitive sorts.
split_prim_noprim([],[],[]):-!.
split_prim_noprim([HS|TS],[HS|TP],NP):-
     objectsC(HS,Obj),
     split_prim_noprim(TS,TP,NP),!.		
split_prim_noprim([HS|TS],PS,[HS|NP]):-
     split_prim_noprim(TS,PS,NP),!.

/***************** local utils *****************/

/*********** DOMAIN MODEL FUNCTIONS *****************/
get_invariants(Invs) :-
    atomic_invariantsC(Invs),!.

rem_statics([sc(S,X,Lhs=>Rhs)|ST], [sc(S,X,LhsR=>RhsR)|STR],Rt1) :-
    split_st_dy(Lhs,[],LR, [],LhsR),
    split_st_dy(Rhs,[],RR,[],RhsR),
    append_dcut(LR,RR,R),
    rem_statics(ST, STR,Rt),
    append_dcut(Rt,[is_of_sort(X,S)|R],Rt1),!.
rem_statics([ss(S,X,Preds)|Post], [ss(S,X,PredR)|PostR],Rt1) :-
    split_st_dy(Preds,[],R, [],PredR),
    rem_statics(Post, PostR,Rt),
    append_dcut(Rt,[is_of_sort(X,S)|R],Rt1),!.
rem_statics([se(S,X,Preds)|Post], [se(S,X,PredR)|PostR],Rt1) :-
    split_st_dy(Preds,[],R, [],PredR),
    rem_statics(Post, PostR,Rt),
    append_dcut(Rt,[is_of_sort(X,S)|R],Rt1),!.
rem_statics([], [],[]) :-!.


% ----------------------utilities---------------------

isemptylist([]):-!.

%instantiate variables
/*
not(X):- \+X.
member(X,[X|_]).
member(X,[_|L]) :- member(X,L).
*/

member_cut(X,[X|_]) :- !.
member_cut(X,[_|Y]) :- member_cut(X,Y),!.

% member_e: X is the exact memeber of List
member_e(X,[Y|_]):-
     X==Y,!.
member_e(X,[Y|L]):-
     var(Y),
     member_e(X,L),!.
member_e(ss(Sort,Obj,SE),[ss(Sort,Obj1,SE)|_]):-
     Obj==Obj1,!.
member_e(se(Sort,Obj,SE),[se(Sort,Obj1,SE)|_]):-
     Obj==Obj1,!.
member_e(sc(Sort,Obj,SE1=>SE2),[sc(Sort,Obj1,SE1=>SE2)|_]):-
     Obj==Obj1,!.
member_e(X,[Y|L]):- member_e(X,L),!.


% u_mem in ob_utils is SLOW!?.
% this is a fast impl.
u_mem_cut(_,[]):-!,fail.
u_mem_cut(X,[Y|_]) :- X == Y,!.
u_mem_cut(X,[_|L]) :- u_mem_cut(X,L),!.
% check if object X is a member of a objects list
% 1. if it is not a variable, check if it is in the list
% 2. X is a variable, and the list only has one objects, make X as that obj
% 3. X is a variable, but the list has more than one objects, leave X unchange
obj_member(X,[X|[]]):-!. 
obj_member(X,List):-     
    obj_member0(X,List),!.
obj_member0(X,[Y|_]):-
    var(X),!.%if X is var, but Y not, the leave X as that variable
obj_member0(X,[Y|_]):-
    X==Y,!.
obj_member0(X,[_|Y]) :- obj_member0(X,Y),!.


% check if a predicate is a member of a ground predicate list,
% just used in binding the predicates to a sort without instantiate it
% for efficiency, instantiate the variable if the list only have one atom
pred_member(X,List):-
    ground(X),
    member(X,List),!.
pred_member(X,List):-
    setof(X,member(X,List),Refined),
    pred_member0(X,Refined),!.

pred_member0(X,[X|[]]):-!.
pred_member0(X,Y):-
    pred_member1(X,Y),!.
pred_member1(X,[Y|_]):-
    X=..[H|XLs],
    Y=..[H|YLs],
    vequal(XLs,YLs),!.
pred_member1(X,[_|Y]):- pred_member1(X,Y),!.

statics_append([],L,L):-
    statics_consist(L),!.
statics_append(L,[],L):-
    statics_consist(L),!.
statics_append(List1,List2,L):-
    statics_consist(List1),
    statics_consist(List2),
    statics_append1(List1,List2,[],L),
    statics_consist(L),!.

statics_append1([],List2,L1,L):-
    append_dcut(List2,L1,L),!.
statics_append1([H|List1],List2,L,Z) :-
    statics_append0(H,List2,L,L1),
    statics_append1(List1,List2,L1,Z),!.

statics_append0(H,[],L,[H|L]):-!.
statics_append0(H,[H|Z],L,L):-!.
statics_append0(H,[X|Z],L1,L):-
    statics_append0(H,Z,L1,L),!.

append_dcut([],L,L):-!.
append_dcut([H|T],L,[H|Z]) :- append_dcut(T,L,Z),!.

append_cut([],L,L) :- !.
append_cut([H|T],L,[H|Z]) :- append_cut(T,L,Z),!.

% append_st: append_dcut two statics
% remove the constants that no need
% instanciate the viables that all ready been bind
% ------------------------------------------
append_st(ST1,ST2,ST):-
    append_cut(ST1,ST2,ST0),
    remove_unneed(ST0,[],ST),!.

% remove the constants that no need
% instanciate the variables that all ready been bind
remove_unneed([],C,C):-!.
remove_unneed([A|B], Z, C):-
    var(A),
    member_e(A,Z),
    remove_unneed(B, Z, C),! .
remove_unneed([A|B], Z, C):-
    var(A),
    append_dcut(Z,[A],D),
    remove_unneed(B, D, C),!.
remove_unneed([A|B], Z, C):-
    ground(A),
    remove_unneed(B, Z, C),!.
remove_unneed([A|B], Z, C):-
    A=..[ne|Paras],
    append_dcut(Z,[A],D),
    remove_unneed(B, D, C),!.
remove_unneed([A|B], Z, C):-
    A=..[Pred|Paras],
    same_var_member(A,Z),
    remove_unneed(B, Z, C),!.
remove_unneed([A|B], Z, C):-
    append_dcut(Z,[A],D),
    remove_unneed(B, D, C),!.

same_var_member(Pred,[Pred1|List]):-
     var(Pred1),
     same_var_member(Pred,List),!.
same_var_member(Pred,[Pred1|List]):-
     Pred==Pred1,!.
same_var_member(Pred,[Pred1|List]):-
     Pred=..[H|T],
     Pred1=..[H|T1],
     same_var_member1(T,T1),!.
same_var_member(Pred,[Pred1|List]):-
     same_var_member(Pred,List),!.

same_var_member1([],[]):-!.
same_var_member1([H1|T],[H2|T]):-
     var(H1),
     H1==H2,!.
same_var_member1([H|T1],[H|T2]):-
     var(T1),
     T1==T2,!.
same_var_member1([H1|T1],[H2|T2]):-
     H1==H2,
     same_var_member1(T1,T2),!.

% two states or lists are equal
is_equal_list(List1,List2):-
    List1==List2,!.
is_equal_list([],[]):-!.
is_equal_list(List1,List2):-
    length(List1,L),
    length(List2,L),
    is_equal_list1(List1,List2),!.
is_equal_list1([],[]):-!.
is_equal_list1([Head1|List1],[Head2|List2]):-
    Head1==Head2,
    is_equal_list1(List1,List2),!.
is_equal_list1([se(Sort,Obj,Head1)|List1],[se(Sort,Obj,Head2)|List2]):-
    is_equal_list(Head1,Head2),
    is_equal_list1(List1,List2),!.
is_equal_list1([Head1|List1],[Head2|List2]):-
    Head1=..[FF|Var1],
    Head2=..[FF|Var2],
    FF\==se,
    vequal(Var1,Var2),
    is_equal_list1(List1,List2),!.
is_equal_list1([Head1|List1],List2):-
    member(Head1,List2),
    append_cut(List1,[Head1],List10),
    is_equal_list1(List10,List2),!.

% two states or lists are different
is_diff(List1,List2):-
    length(List1,L1),
    length(List2,L2),
    L1\==L2,!.
is_diff([Head|List1],List2):-
    not_exist(Head,List2),!.
is_diff([Head|List1],List2):-
    list_take(List2,[Head],List21),
    is_diff(List1,List21),!.

not_exist(Pred,List2):-
    not(member(Pred,List2)),!.
not_exist(se(Sort,Obj,Head1),List2):-
    not(member(se(Sort,Obj,Head),List2)),!.
not_exist(se(Sort,Obj,Head1),List2):-
    member(se(Sort,Obj,Head2),List2),
    is_diff(Head1,Head2),!.

% set_append: list1 + list2 -> list
% no duplicate, do instanciation
% ------------------------------------------
set_append([], Z, Z):-! .
set_append([A|B], Z, C) :-
        not(not(member(A, Z))) ,
        set_append(B, Z, C),! .
set_append([A|B], Z, [A|C]) :-
        set_append(B, Z, C) .

% set_append_e: list1 + list2 -> list
% no duplicate, no instanciation
% ------------------------------------------
set_append_e(A,B,C):-
    append_cut(A,B,D),
    remove_dup(D,[],C),!.

% remove duplicate
remove_dup([],C,C):-!.
remove_dup([A|B],Z,C) :-
    member_e(A, Z),
    remove_dup(B, Z, C),! .
remove_dup([A|B], Z, C):-
    append_dcut(Z,[A],D),
    remove_dup(B, D, C),!.

% two atom lists equals (without instantiate variables)
vequal([],[]):-!.
vequal([X|XLs],[Y|YLs]):-
    X==Y,	
    vequal(XLs,YLs),!.
vequal([X|XLs],[Y|YLs]):-
    var(X),
    vequal(XLs,YLs),!.
vequal([X|XLs],[Y|YLs]):-
    var(Y),
    vequal(XLs,YLs),!.


% subtract(A,B,C): subtract B from A
% -------------------------------------
/*
subtract([],_,[]):-!.
subtract([A|B],C,D) :-
        member(A,C),
        subtract(B,C,D),!.
subtract([A|B],C,[A|D]) :-
        subtract(B,C,D),!.
*/

/* arg1 - arg2 = arg3 */

list_take(R,[E|R1],R2):-
        remove_el(R,E,RR),
        list_take(RR,R1,R2),!.
list_take(R,[_|R1],R2):-
        list_take(R,R1,R2),!.
list_take(A,[],A) :- !.

% remove_el: list * el -> list-el 
% ----------------------------------
remove_el([],_,[]) :- ! .
remove_el([A|B],A,B) :- ! .
remove_el([A|B],C,[A|D]) :-
        remove_el(B,C,D) .

/* generate symbol predicate  (from file futile)*/

gensym_special(Root,Atom) :-
                        getnum(Root,Num),
                        name(Root,Name1),
                        name(Num,Name2),
                        append_dcut(Name1,Name2,Name),
                        name(Atom,Name).

getnum(Root,Num) :-
                        env_retract(current_num(Root,Num1)),!,
                        Num is Num1+1,
                        env_asserta(current_num(Root,Num)).

getnum(Root,1) :- env_asserta(current_num(Root,1)).

gensym_num(Root,Num,Atom):-
     name(Root,Name),
     name(Num,Name1),
     append_dcut(Name,Name1,Name2),
     name(Atom,Name2),!.


pprint([],SIZE,SIZE):-!.
pprint([HS|TS],Size0,SIZE):-
    is_list(HS),
    pprint(HS,Size0,Size1),
    pprint(TS,Size1,SIZE),!.
pprint([HS|TS],Size0,SIZE):-
%    write('step '),write(Size0),write(': '),
%    write(HS),nl,
    Size1 is Size0+1,
    pprint(TS,Size1,SIZE),!.

/* split static and dynamic from states*/

split_st_dy([],ST,ST,DY,DY):-!.
split_st_dy([Pred|TStates],ST0,ST,DY0,DY):-
  is_statics(Pred),
  append_cut(ST0,[Pred],ST1),
  split_st_dy(TStates,ST1,ST,DY0,DY),!.
split_st_dy([Pred|TStates],ST0,ST,DY0,DY):-
  append_cut(DY0,[Pred],DY1),
  split_st_dy(TStates,ST0,ST,DY1,DY),!.

% list of lists -> list

flatten([HO|TO], List, O_List):-
	append_dcut(HO, List, List_tmp),
	flatten(TO, List_tmp, O_List),!.
flatten([H|TO], List,O_List):-
	append_dcut([H], List, List_tmp),
	flatten(TO, List_tmp, O_List).
flatten([], [HList|T], O_List):-
	HList = [],
	flatten(T, [], O_List).
flatten([], [HList|T], O_List):-
	is_list(HList),
	flatten([HList|T],[], O_List),!.
flatten([], L,L):-!.

% flatten with no duplicate
set_flatten([HO|TO], List, O_List):-
	set_append_e(HO, List, List_tmp),
	set_flatten(TO, List_tmp, O_List),!.
set_flatten([H|TO], List,O_List):-
	set_append_e([H], List, List_tmp),
	set_flatten(TO, List_tmp, O_List).
set_flatten([], [HList|T], O_List):-
	HList = [],
	set_flatten(T, [], O_List).
set_flatten([], [HList|T], O_List):-
	is_list(HList),
	set_flatten([HList|T],[], O_List),!.
set_flatten([], L,L):-!.


% list: [el1,el2, ...] --> bool
% -----------------------------
/*
list(A) :-
        var(A) ,
        ! ,
        fail .
list(A) :-
        functor(A,'.',_).
*/

reverse_unused(L,RL) :-
	revSlave(L,[],RL).

revSlave([],RL,RL).
revSlave([H|T],Sofar,Final) :-
	revSlave(T,[H|Sofar],Final).

% ***********************for multy tasks*****************
:- assert_if_new(time_taken(0)).
:- assert_if_new(sum(0)).
:- assert_if_new(soln_size(0)).

solve(N,FN):-
   N < FN,
   nl,write('task '), write(N),write(': '),nl,
   solve(N),
   Ni is N+1,
   solve(Ni,FN).
solve(FN,FN):-
   nl,write('task '), write(FN),write(': '),nl,
   solve(FN),
   retractall(sum(_)),
   assert(sum(0)),
   sum_time(CP),
   retractall(sum(_)),
   assert(sum(0)),
   sum_size(SIZE),
   TIM is CP /1000,
   retractall(time_taken(_)),
   retractall(soln_size(_)),
   nl,write('total time '),write(TIM),write(' seconds'),
   nl,write('total size '),write(SIZE),nl.
solve(N,N).

sum_time(TIM):-
   time_taken(CP),
   env_retract(sum(N)),
   N1 is N +CP,
   assert(sum(N1)),
   fail.
sum_time(TIM):-
   sum(TIM).
sum_size(SIZE):-
   soln_size(S),
   retract(sum(N)),
   N1 is N +S,
   assert(sum(N1)),
   fail.
sum_size(SIZE):-
   sum(SIZE).

stoppoint.
% State1 has relation with State2
state_related(Post,Cond,undefd):-!.
state_related(Post,Cond,[]):-!.
state_related(Post,Cond,State2):-
     append_cut(Post,Cond,State1),
     state_related(State1,State2).

% all states in necc are primitive
% so does the goal state--State2
state_related([se(Sort,Obj,SE1)|State1],State2):-
     member(se(Sort,Obj,SE2),State2),
     state_related0(SE1,SE2).
% states in Cond are not neccessary primitive
state_related([sc(Sort1,Obj,SE1=>SS1)|State1],State2):-
     member(se(Sort,Obj,SE2),State2),
     is_of_sort(Obj,Sort1),
     is_of_sort(Obj,Sort).
state_related([se(Sort,Obj,SE)|State1],State2):-
     state_related(State1,State2),!.
state_related([sc(Sort,Obj,SE=>SS)|State1],State2):-
     state_related(State1,State2),!.

%instatiate abit the variables
state_related0([],SE2):-!.
state_related0([Head|SE1],SE2):-
     member(Head,SE2),
     state_related0(SE1,SE2).
state_related0([Head|SE1],SE2):-
     state_related0(SE1,SE2).

% change_obj_list: narrow down objects
% by just using the objects occure in initial states(world state)
change_obj_list(I):-
    find_dynamic_objects(I),
    collect_dynamic_obj,
    change_obj_list1,
    change_atomic_inv,!.

change_obj_list1:-
    objects(Sort,OBjls),
    change_obj_list2(Sort),
    fail.
change_obj_list1.

% only keep the dynamic objects that used in tasks
change_obj_list2(Sort):-
    objectsC(Sort,Objls),!.
% statics objects: keep
change_obj_list2(Sort):-
    objects(Sort,Objls),
    env_assert(objectsC(Sort,Objls)),!.

% only keep the dynamic objects in atomic_invariants
change_atomic_inv:-
    atomic_invariants(Atom),
    change_atomic_inv1(Atom,Atom1),
    env_assert(atomic_invariantsC(Atom1)),!.
change_atomic_inv.

change_atomic_inv1([],[]).
change_atomic_inv1([Pred|Atom],[Pred|Atom1]):-
    Pred=..[Name|Objs],
    just_dynamic_objects(Objs),
    change_atomic_inv1(Atom,Atom1).
change_atomic_inv1([Pred|Atom],Atom1):-
    change_atomic_inv1(Atom,Atom1).

just_dynamic_objects([]).
just_dynamic_objects([Head|Objs]):-
    objectsC(Sort,Objls),
    member(Head,Objls),!,
    just_dynamic_objects(Objs).

find_dynamic_objects([]):-!.
find_dynamic_objects([SE|Rest]):-
    find_dynamic_objects(SE),
    find_dynamic_objects(Rest),!.
find_dynamic_objects(ss(Sort,Obj,_)):-
    env_assert(objectsD(Sort,Obj)),!.

collect_dynamic_obj:-
    objectsD(Sort,_),
    setof(Obj, objectsD(Sort,Obj), Objls),
    env_retractall(objectsD(Sort,_)),
    env_assert(objectsC(Sort,Objls)),
    fail.
collect_dynamic_obj.

get_preconditions_g([],Prev,Prev,Prev):-!.
get_preconditions_g([sc(S,X,From =>To)|Rest],Prev,[se(S,X,From)|Pre],[se(S,X,To)|Post]):-
     !,
     get_preconditions_g(Rest,Prev, Pre,Post).

% ********************************************************************
% ground all operators% enumerateOps

ground_op :-
	assert_sort_objects,
	enumerateOps,
	instOps,
	flag(opCounter,Top,Top),
	write(opCounter = Top),nl.

enumerateOps :-
	flag(opCounter,_,1),
	enumOps.

enumOps :-
	operator(Name,Prev,Nec,Cond),
	flag(opCounter,Count,Count),
	containsInvars(operator(Name,Prev,Nec,Cond),InVars,IsOfSorts,FPrev,FNec), 
						%Find the atomic_invariants
	findVarsAndTypes(operator(Name,Prev,Nec,Cond),VT,NEs),
	env_assert(opParent(Count,operator(Name,FPrev,FNec,Cond),VT,NEs,InVars,IsOfSorts)),
	Next is Count + 1,
	flag(opCounter,Count,Next),
	fail.

enumOps.


% *********************************************************************
% findVarsAndTypes - collect a list of all variables and their
%                    types as they occur in an operator
%                    also collect the list of "ne" constraints
%                    that apply to variables
%                    [<Type>,<Variable>|<Rest>]
%
% findVarsAndTypes(+Operator,-TypeVarList,-Nes)


findVarsAndTypes(operator(_,Pre,Nec,Cond),Vars,NEs) :-
	vtPrevail(Pre,PreVars,PreNEs),
	vtEffects(Nec,NecVars,NecNEs),
	append_dcut(PreVars,NecVars,Vars),
	append_dcut(PreNEs,NecNEs,NEs),
	!.

% collect all Vars and types in a changes clause
%vtEffects(+EffectsClause,-VarsTypes,-NEClauses).

vtEffects([],[],[]).

vtEffects([sc(Type,Obj1,Preds)|Rest],VT,NEs) :-
	vtPreds(Preds,Related,NEs1),
	append_dcut([Type,Obj1],Related,Obj1VT),
	vtEffects(Rest,RestVT,RestNEs),
	append_dcut(Obj1VT,RestVT,VT),
	append_dcut(NEs1,RestNEs,NEs).

% collect all Vars and types in a Prevail clause
%vtPrevail(+PrevailClause,-VarsTypes,-NEClauses).

vtPrevail([],[],[]).

vtPrevail([se(Type,Obj1,Preds)|Rest],VT,NEs) :-
	vtPLst(Preds,Related,NEs1),
	append_dcut([Type,Obj1],Related,Obj1VT),
	vtPrevail(Rest,RestVT,RestNEs),
	append_dcut(Obj1VT,RestVT,VT),
	append_dcut(NEs1,RestNEs,NEs).

% Deal with the change predicates in a changes clause
% vtPreds(+ChangeProps,-VarsTypes,-NEClauses).

vtPreds((Pre => Add),Res,NEs) :-
	vtPLst(Pre,VTPre,NEs1),
	vtPLst(Add,VTAdd,NEs2),
	append_dcut(VTPre,VTAdd,Res),
	append_dcut(NEs1,NEs2,NEs).

% Deal with a list of literals
% vtPLst(+Literals,-VarTypes,-NEClauses).

vtPLst([],[],[]).

vtPLst([ne(X,Y)|Rest],Res,[ne(X,Y)|RestNEs]) :-
	!,
	vtPLst(Rest,Res,RestNEs).

vtPLst([Pred|Preds],Res,NEs) :-
	functor(Pred,_,1),
	!,
	vtPLst(Preds,Res,NEs).

vtPLst([is_of_sort(_,_)|Preds],Res,NEs) :-
	!,
	vtPLst(Preds,Res,NEs).

% here is the hard bit, Create a dummy literal - instantiate it with
% the OCL predicate list to find the types then
% match up the type with the original literal variables.

vtPLst([Pred|Preds],Res,NEs) :-
	functor(Pred,Name,Arity),
	Pred =.. [Name,Obj1|Rest],
	VNeeded is Arity - 1,
	createVarList(VNeeded,VN),
	DummyPred =.. [Name,X|VN],
	predicates(PList),
	member(DummyPred,PList),
	pair(VN,Rest,This),
	vtPLst(Preds,RestPre,NEs),
	append_dcut(This,RestPre,Res).

% Create a list of new uninstantiated variables
% createVarList(+NoOfVariablesNeeded, -ListOfvariables).

createVarList(1,[X]) :-
	!.

createVarList(N,[X|Rest]) :-
	Next is N - 1,
	createVarList(Next,Rest).

% merge the list of variables and the list of types
% pair(+TypeList,+VarList,-varTypeList).

pair([],[],[]).

pair([Type|Types],[Var|Vars],[Type,Var|Rest]) :-
	pair(Types,Vars,Rest).	



% **********************************************************************
% Top Level Routine to instantiate / ground operators in all legal ways
%
% instOps

instOps :-
	flag(opCounter,_,1),
	opParent(No,Operator,VT,NEs,InVars,IsOfSorts),
	checkIsOfSorts(IsOfSorts),
	checkInVars(InVars),
	chooseVals(VT,NEs,InVars,Vals),
	obeysNEs(NEs),	
    flag(opCounter,Count,Count),
	operator(Name,Prev,Nec,Cond) = Operator,
	filterSE(Prev,FPrev),
	filterSC(Nec,FNec),
	env_assert(gOperator(Count,No,operator(Name,FPrev,FNec,Cond))),
	Next is Count + 1,
    flag(opCounter,Count,Next),    
	fail.

instOps.


checkInVars([]):- !.
checkInVars(Preds):-
	atomic_invariantsC(Invars),
	doCheckInvars(Preds,Invars).

doCheckInvars([],_).
doCheckInvars([Pred|Rest],Invars) :-
	member(Pred,Invars),
	doCheckInvars(Rest,Invars).

checkIsOfSorts([]).
checkIsOfSorts([is_of_sort(V,Sort)|Rest]) :-
	objectsOfSort(Sort,Objs),
	member(V,Objs),
	checkIsOfSorts(Rest).
	

% filterSE - remove ne and is_of_sort clauses

filterSE([],[]) :- !.
filterSE([se(Sort,Id,Preds)|Rest],[se(Sort,Id,FPreds)|FRest]) :-
	filterPreds(Preds,FPreds),!,
	filterSE(Rest,FRest).

% filterSC - remove ne and is_of_sort clauses

filterSC([],[]) :- !.
filterSC([sc(Sort,Id,(Pre => Post))|Rest],[sc(Sort,Id,(FPre => FPost))|FRest]) :-
	filterPreds(Pre,FPre),
	filterPreds(Post,FPost),
	!,
	filterSC(Rest,FRest).

% FilterPreds - remove ne and is_of_sort clauses

filterPreds([],[]).
filterPreds([ne(_,_)|Rest],FRest) :-
	!,
	filterPreds(Rest,FRest).
filterPreds([is_of_sort(_,_)|Rest],FRest) :-
	!,
	filterPreds(Rest,FRest).
%filterPreds([Pred|Rest],FRest) :-
%	atomic_invariantsC(Invars),
%	member(Pred,Invars),
%	!,
%	filterPreds(Rest,FRest).
filterPreds([H|T],[H|FT]) :-
	filterPreds(T,FT).


% Collect all possible ways of instantiating the conditional effects

collectAllConds(_,_,_,_,[],[]) :- !.

collectAllConds(CondVT,NEs,InVars,CondVals,Cond,_) :-
	env_retractall(temp_assertIndivConds(_)),
	chooseVals(CondVT,NEs,InVars,Vals),
	assertIndivConds(Cond),
	fail.

collectAllConds(_,_,_,_,_,NewConds) :-
	setof(Cond,env_call(temp_assertIndivConds(Cond)),NewConds),
        dmsg(collectAllConds=NewConds),!.

assertIndivConds([]) :- !.

assertIndivConds([H|T]) :-
	env_assert(temp_assertIndivConds(H)),
	assertIndivConds(T).

% Find the atomic_invariants in the Operator 

containsInvars(operator(Name,Prev,Nec,Cond),InVars,IsOfSorts,FPrev,FNec) :-
	prevInvars(Prev,PInVars,PIsOfSorts,FPrev),
	necInvars(Nec,NecInVars,NIsOfSorts,FNec),
	append_dcut(NecInVars,PInVars,InVars),
	append_dcut(PIsOfSorts,NIsOfSorts,IsOfSorts),
	!.

prevInvars([],[],[],[]).
prevInvars([se(Type,Obj,Props)|Rest],InVars,IsOfSorts,[se(Type,Obj,FProps)|RFPrev]) :-
	   propsInvars(Props,PInvars,PIsOfSorts,FProps),
	   prevInvars(Rest,RInVars,RIsOfSorts,RFPrev),
	   append_dcut(PInVars,RInVars,InVars),
	   append_dcut([is_of_sort(Obj,Type)|PIsOfSorts],RIsOfSorts,IsOfSorts).

necInvars([],[],[],[]).
necInvars([sc(Type,Obj,(Props => Adds))|Rest],Invars,IsOfSorts,[sc(Type,Obj,(FProps => FAdds))|RFNec]) :-
	   propsInvars(Props,PInvars,PIsOfSorts,FProps),
	   propsInvars(Adds,AInvars,AIsOfSorts,FAdds),
	   necInvars(Rest,RInvars,RIsOfSorts,RFNec),
	   append_dcut(AInvars,PInvars,Temp),
	   append_dcut(Temp,RInvars,Invars),
	   append_dcut(PIsOfSorts,AIsOfSorts,SortsTemp),
	   append_dcut([is_of_sort(Obj,Type)|SortsTemp],RIsOfSorts,IsOfSorts).

propsInvars([],[],[],[]).
propsInvars([Prop|Props],[Prop|Rest],IsOfSorts,FProps) :-
	isInvariant(Prop),
	!,
	propsInvars(Props,Rest,IsOfSorts,FProps).
propsInvars([is_of_sort(X,Y)|Props],InVars,[is_of_sort(X,Y)|IsOfSorts],FProps):- 
	!,
	propsInvars(Props,InVars,IsOfSorts,FProps).

propsInvars([Pred|Props],Rest,IsOfSorts,[Pred|FProps]) :-
	propsInvars(Props,Rest,IsOfSorts,FProps).

isInvariant(Prop) :-
	atomic_invariantsC(Invars),
	functor(Prop,Name,Arity),
	createVarList(Arity,VN),
	Pred =.. [Name | VN],
	member(Pred,Invars).

% Select values for the variables in the operator
%
% chooseVals(+TypeVarList,+NEList,+Invariants,-VarValueList)

chooseVals([],_,_,[]).

chooseVals([Type,Var|TypeVars],NEs,InVars,Vals) :-
	ground(Var),
	!,
	chooseVals(TypeVars,NEs,InVars,Vals).

chooseVals([Type,Var|TypeVars],NEs,InVars,[Var|Vals]) :-
	objectsOfSort(Type,AllVals),
	member(Var,AllVals),
	chooseVals(TypeVars,NEs,InVars,Vals).

	

%% For hierarchical domains assert the objects that belong to every sort 
%% including hierarchical sorts.

assert_sort_objects :-
	objectsC(Type,Objects),
	env_assert(objectsOfSort(Type,Objects)),
	fail.

assert_sort_objects :-
	sorts(Type,SubTypes),
        not((special_sorts(PS), Type == PS )),
	all_objects(Type,Objs),
	env_assert(objectsOfSort(Type,Objs)),
	fail.

assert_sort_objects.

all_objects(Type,Objs) :-
	objectsC(Type,Objs),
	!.
all_objects(Type,Objs) :-
	sorts(Type,SubSorts),
	!,
	collect_subsort_objects(SubSorts,Objs).

collect_subsort_objects([],[]).
collect_subsort_objects([Sort|Rest],Objs ) :-
	all_objects(Sort,SortObjs),
	!,
	collect_subsort_objects(Rest,RestObjs),
	append_dcut(SortObjs,RestObjs,Objs).

obeysNEs([]).

obeysNEs([ne(V1,V2)|Rest]) :-
	V1 \== V2, dif(V1,V2), % add corroutine 
	obeysNEs(Rest),!.

obeysInVars([]).
obeysInVars([Prop|Rest]) :-
	atomic_invariantsC(Invars),
	member(Prop,Invars),
	!.

% **********************************************************************
% prettyPrinting Routines for ground OCL operators 
% long and boring


% prettyPrintOp(+<Ground Operator>)

prettyPrintOp(gOperator(No,Par,Op)) :-
	write('gOperator('),
	write(No),write(','),
	write(Par),write(','),nl,
	writeOp(4,Op),
	!.

writeOp(TabVal,operator(Name,Prev,Nec,Cond)) :-
	tab(TabVal),
	write('operator('),write(Name),write(','),nl,
	tab(8),write('% Prevail'),nl,
        tab(8),write('['),nl,
        writePrevailLists(8,Prev),
	tab(8),write('],'),nl,
	tab(8),write('% Necessary'),nl,
        tab(8),write('['),nl,
	writeChangeLists(10,Nec),
	tab(8),write('],'),nl,
	tab(8),write('% Conditional'),nl,
        tab(8),write('['),nl,
	writeChangeLists(10,Cond),
	tab(8),write('])).'),nl.
	
writePropList(TabVal,[]) :-
	tab(TabVal),
	write('[]').

writePropList(TabVal,[ne(_,_)|Props]) :-
	!,
	writePropList(Indent,Props).

writePropList(TabVal,[Prop|Props]) :-
	atomic_invariantsC(Invars),
	member(Prop,Invars),
	writePropList(TabVal,Props).

writePropList(TabVal,[Prop|Props]) :-
	tab(TabVal),
	write('['),
	write(Prop),
	Indent is TabVal + 1,
	writePList(Indent,Props).

writePList(TabVal,[]) :-
	nl,
	tab(TabVal),
	write(']').

writePList(TabVal,[ne(_,_)]) :-
	!,
	nl,
	tab(TabVal),
	write(']').

writePList(TabVal,[Prop]) :-
	atomic_invariantsC(Invars),
	member(Prop,Invars),
	!,
	nl,
	tab(TabVal),
	write(']').

writePList(TabVal,[Prop]) :-
	write(','),
	nl,
	tab(TabVal),
	write(Prop),
	write(']').

writePList(TabVal,[ne(_,_),P2|Rest]) :-
	!,
	writePList(TabVal,[P2|Rest]).

writePList(TabVal,[Prop,P2|Rest]) :-
	atomic_invariantsC(Invars),
	member(Prop,Invars),
	!,
	writePList(TabVal,[P2|Rest]).

writePList(TabVal,[P1,P2|Rest]) :-
	write(','),
	nl,
	tab(TabVal),
	write(P1),
	writePList(TabVal,[P2|Rest]).

writeChangeLists(_,[]).

writeChangeLists(TabVal,[sc(Type,Obj,(Req => Add))|Rest]) :-
	tab(TabVal),
	write('sc('),write(Type),write(','),write(Obj),write(',('),nl,
	Indent is TabVal + 12,
	writePropList(Indent,Req),
	nl,
	tab(Indent),
	write('=>'),
	nl,
	writePropList(Indent,Add),
	write('))'),writeComma(Rest),
	nl,
	writeChangeLists(TabVal,Rest).

writeComma([]).
writeComma(_) :-
	write(',').

writePrevailLists(_,[]).

writePrevailLists(TabVal,[se(Type,Obj,Props)|Rest]) :-
	tab(TabVal),
	write('se('),write(Type),write(','),write(Obj),write(','),nl,
	Indent is TabVal + 12,
	writePropList(Indent,Props),
	write(')'),writeComma(Rest),
	nl,
	writePrevailLists(TabVal,Rest).


assert_is_of_sort :-
	objectsOfSort(Type,Objects),
	member(Obj,Objects),
	assert_is_of_sort1(Type,Obj),
	fail.
assert_is_of_sort :-
	objectsC(Type,Objects),
	member(Obj,Objects),
	assert_is_of_primitive_sort(Type,Obj),
	fail.
assert_is_of_sort.

assert_is_of_sort1(Type,Obj):- env_assert(is_of_sort(Obj,Type)),!.
assert_is_of_primitive_sort(Type,Obj):-
	env_assert(is_of_primitive_sort(Obj,Type)),!.

% change substate_class to primary sort level
% assert in prolog database as gsubstate_class(Sort,Obj,States)
prim_substate_class:-
     substate_classes(Sort,Obj,Substate),
     find_prim_sort(Sort,PS),
     assert_subclass(PS,Obj,Substate),
     fail.
prim_substate_class:-
     collect_prim_substates.

assert_subclass([],Obj,Substate).
assert_subclass([HS|TS],Obj,Substate):-
     env_assert(gsstates(HS,Obj,Substate)),
     assert_subclass(TS,Obj,Substate).

collect_prim_substates:-
     gsstates(Sort,Obj,_),
     setof(SStates,gsstates(Sort,Obj,SStates),GSStates),
     env_retractall(gsstates(Sort,Obj,_)),
     all_combined(GSStates,GSStates0),
     env_assert(gsubstate_classes(Sort,Obj,GSStates0)),
     fail.
collect_prim_substates.

all_combined(SStates,CSStates):-
     xprod(SStates,CSStates1),
     flat_interal(CSStates1,CSStates),!.

flat_interal([],[]):-!.
flat_interal([HSS1|TSS1],[HSS|TSS]):-
     flatten(HSS1,[],HSS),
     flat_interal(TSS1,TSS),!.

% xprod: list * list --> (list X list)
% -----------------------------------
xprod(A,B,C) :-
        xprod([A,B],C) .
 
xprod([],[]).
xprod(A,E) :-
        xprod(A,B,C,D) ,
        F =..[^,C,D] ,
        call(setof(B,F,E)) .
 
xprod([X],[A],A,member(A,X)) .
xprod([X,Y],[A,B],C,(D,E)) :-
        C =..[^,A,B] ,
        D =..[member,A,X] ,
        E =..[member,B,Y] .
xprod([X|Y],[A|E],D,(F,G)) :-
        D =..[^,A,C] ,
        F =..[member,A,X] ,
        xprod(Y,E,C,G).


:-retractall(solution_file(_)).
:-asserta(solution_file(user)).

% :-sleep(1).
% :-tell(user),run_header_tests.












end_of_file.


%:-expects_dialect(ifprolog).

% :-ifprolog_term_expansion(assign_alias(debug,user_error),Call),Call.

clause_asserted(C):- as_clause(C,H,B),!,clause_asserted(H,B).
clause_asserted(H,B):- predicate_property(H,number_of_clauses(N)),N>0,copy_term(H:B,HH:BB),!, clause(HH, BB, Ref),clause(Head, Body, Ref),H=@=Head,Body=@=B,!.
as_clause( ((H :- B)),H,B):-!.
as_clause( H,  H,  true).

assert_if_new(C):-notrace(clause_asserted(C)->true;assert(C)).
:- dynamic((time_taken/1,sum/1,soln_size/1)).
:- assert_if_new(time_taken(0)).
:- assert_if_new(sum(0)).
:- assert_if_new(soln_size(0)).



failOnError(Call):-catch(Call,_,fail).

fresh_line:-current_output(Strm),fresh_line(Strm),!.
fresh_line(Strm):-failOnError((stream_property(Strm,position('$stream_position'(_,_,POS,_))),(POS>0 ->nl(Strm);true))),!.
fresh_line(Strm):-failOnError(nl(Strm)),!.
fresh_line(_).

% ===================================================================
% Substitution based on ==
% ===================================================================

% Usage: subst(+Fml,+X,+Sk,?FmlSk)

subst_eq(A,B,C,D):- nd_subst(A,B,C,D),!.
subst_eq(A,B,C,D):- trace, nd_subst(A,B,C,D),!.

nd_subst(  Var, VarS,SUB,SUB ) :- Var==VarS,!.
nd_subst(  Var, _,_,Var ) :- var(Var),!.
nd_subst(  P, X,Sk, P1 ) :- functor(P,_,N),nd_subst1( X, Sk, P, N, P1 ).

nd_subst1( _,  _, P, 0, P  ).
nd_subst1( X, Sk, P, N, P1 ) :- N > 0,
            P =.. [F|Args], 
            nd_subst2( X, Sk, Args, ArgS ),
            nd_subst2( X, Sk, [F], [FS] ),  
            P1 =.. [FS|ArgS].

nd_subst2( _,  _, [], [] ).
nd_subst2( X, Sk, [A|As], [Sk|AS] ) :- X == A, !, nd_subst2( X, Sk, As, AS).
nd_subst2( X, Sk, [A|As], [A|AS]  ) :- var(A), !, nd_subst2( X, Sk, As, AS).
nd_subst2( X, Sk, [A|As], [Ap|AS] ) :- nd_subst( A,X,Sk,Ap ),nd_subst2( X, Sk, As, AS).
nd_subst2( _X, _Sk, L, L ).

:- meta_predicate(with_assertions(+,0)).
with_assertions( [],Call):- !,Call.
with_assertions( [With|MORE],Call):- !,with_assertions(With,with_assertions(MORE,Call)).
with_assertions( (With,MORE),Call):- !,with_assertions(With,with_assertions(MORE,Call)).
with_assertions( (With;MORE),Call):- !,with_assertions(With,Call);with_assertions(MORE,Call).
with_assertions( -TL:With,Call):- !,with_no_assertions(TL:With,Call).
with_assertions( +TL:With,Call):- !,with_assertions(TL:With,Call).
with_assertions( not(With),Call):- !,with_no_assertions(With,Call).
with_assertions( -With,Call):- !,with_no_assertions(With,Call).
with_assertions( +With,Call):- !,with_assertions(With,Call).

% with_assertions(THead,Call):- functor(THead,F,_),b_setval(F,THead).
with_assertions(THead,Call):- 
 must(to_thread_head(THead,M,_Head,H)),
   copy_term(H,  WithA), !,
   ( M:WithA -> Call ; setup_call_cleanup(M:asserta(WithA),Call,must(M:retract(WithA)))).

with_assertions(THead,Call):- 
 must(to_thread_head(THead,M,_Head,H)),
   copy_term(H,  WithA), !,
   with_assertions(M,WithA,Call).
   
:- meta_predicate(with_assertions(+,+,0)).
with_assertions(M,WithA,Call):- M:WithA,!,Call.
with_assertions(M,WithA,Call):-
   setup_call_cleanup(M:asserta(WithA),Call,must(M:retract(WithA))).

:-meta_predicate(with_no_assertions(+,0)).
with_no_assertions(THead,Call):-
 must(to_thread_head((THead:-!,fail),M,_Head,H)),
   copy_term(H,  WithA), !, setup_call_cleanup(M:asserta(WithA),Call,must(M:retract(WithA))).


to_thread_head((H:-B),TL,(HO:-B),(HH:-B)):-!,to_thread_head(H,TL,HO,HH),!.
to_thread_head(thglobal:Head,thglobal,thglobal:Head,Head):- slow_sanity((predicate_property(thglobal:Head,(dynamic)),not(predicate_property(thglobal:Head,(thread_local))))).
to_thread_head(TL:Head,TL,TL:Head,Head):-!, slow_sanity(( predicate_property(TL:Head,(dynamic)),must(predicate_property(TL:Head,(thread_local))))).
to_thread_head(Head,thlocal,thlocal:Head,Head):-!, slow_sanity(( predicate_property(thlocal:Head,(dynamic)),must(predicate_property(thlocal:Head,(thread_local))))).
to_thread_head(Head,tlbugger,tlbugger:Head,Head):- slow_sanity(( predicate_property(tlbugger:Head,(dynamic)),predicate_property(tlbugger:Head,(thread_local)))).

slow_sanity(X):-must(X).


%se/cond == se. state == ss. trans == sc. dif == ne.  operator == operator
term_expansion_hyhtn(In,Out):-nonvar(In),term_expansion_alias(In,Out).

term_expansion_alias(In,Out):-term_expansion_alias([],In,Out).
term_expansion_alias(Not,In,Out):-term_alias(I,O),not(member(I,Not)),subst_eq(In,I,O,M), In\=@=M,!, term_expansion_alias([I|Not],M,Out).
term_expansion_alias(_Not,InOut,InOut).

/*
term_alias(cond,se).
term_alias(se,se).
term_alias(state,ss).
term_alias(trans,sc).
term_alias(ne,dif).
term_alias(neq,dif).*/
% term_alias(htn_task,planner_task).
term_alias(startOcl,start).
term_alias(startOCL,start).

:- use_module(library(pce)).
:- use_module(library(gui_tracer)).


:- thread_local tlbugger:inside_loop_check/1.
:- module_transparent(tlbugger:inside_loop_check/1).

:- thread_local tlbugger:inside_loop_check_local/2.
:- module_transparent(tlbugger:inside_loop_check_local/2).


make_key(CC,KeyA):- notrace(ground(CC)->KeyA=CC ;(copy_term(CC,Key,_),numbervars(Key,0,_))),!,KeyA=Key. % ,term_to_atom(Key,KeyA).
loop_check(B):- loop_check(B,fail).
loop_check(B, TODO):- make_key(B,BC),!, loop_check_term(B,BC,TODO).

loop_check_term(B,BC,TODO):-  ( \+(tlbugger:inside_loop_check(BC)) -> setup_call_cleanup(asserta(tlbugger:inside_loop_check(BC)),B, retract((tlbugger:inside_loop_check(BC)))) ;call(TODO) ).


must(E):-E *-> true ; (trace,E).

functor_h(P,F,A):-var(P),!,(number(A)->functor(P,F,A);((mpred_arity(F,A);throw(var_functor_h(P,F,A))))).
functor_h(F/A,F,A):-number(A),!,( atom(F) ->  true ; mpred_arity(F,A)).
functor_h(':'(_,P),F,A):-nonvar(P),!,functor_h(P,F,A).
functor_h(':-'(P),F,A):-!,functor_h(P,F,A).
functor_h(':-'(P,_),F,A):-!,functor_h(P,F,A).
functor_h(kb(P),F,A):- atom(P),!, ( P=F -> mpred_arity(F,A) ; env_mpred(P,F,A)).
functor_h(P,F,A):-functor(P,F,A).

decl_mpred(ENV,Var):- (var(ENV);var(Var)),!, trace,throw(var_env_learn_pred(ENV,Var)).
decl_mpred(ENV,(A,B)):-!, decl_mpred(ENV,A), decl_mpred(ENV,B).
decl_mpred(ENV,[A|B]):-!, decl_mpred(ENV,A), decl_mpred(ENV,B).
decl_mpred([],_):- !.
decl_mpred(_,[]):- !.
decl_mpred([H|T],P):- !, decl_mpred(H,P),decl_mpred(T,P).
decl_mpred((H,T),P):- !, decl_mpred(H,P),decl_mpred(T,P).
decl_mpred(call(ENV),P):- functor_h(P,F,A),call(ENV,F/A),!.
decl_mpred(ENV,P):- functor_h(P,F,A),!,decl_mpred_fa(ENV,F,A).

decl_mpred_fa(ENV,F,A):- env_mpred(ENV,F,A),!.
decl_mpred_fa(ENV,F,A):- assert_if_new(mpred_arity(F,A)),assert_if_new(env_kb(ENV)),assert(env_mpred(ENV,F,A)), doall(decl_mpred_fa_hooks(ENV,F,A)).



 
count(1_000_000).
 
my_asserta(N) :- asserta(asserted_a(N)).
my_assertz(N) :- assertz(asserted_z(N)).
my_recorda(N) :- recorda(recorded_a, N).
my_recordz(N) :- recordz(recorded_z, N).
my_flag(N) :- flag(some_flag, _, N).
 
my_setval(N) :-
    b_getval(global_variable, Old),
    b_setval(global_variable, [N|Old]).
 
bench :-
    count(Count),
    ns_op(many(Count, my_asserta)),
    ns_op(many(Count, my_assertz)),
    ns_op(many(Count, my_recorda)),
    ns_op(many(Count, my_recordz)),
    ns_op(many(Count, my_flag)),
    ns_op(many(Count, my_setval)),
    clear.
 
ns_op(Goal) :-
    get_time(Start),
    call(Goal),
    get_time(Done),
    count(Count),
    Ns is (Done - Start) / Count * 1_000_000_000,
    'format'("~w: ~1f ns/op~n", [Goal, Ns]).
 
many(N, Goal) :-
    ( N > 0 ->
        call(Goal, N),
        succ(N0, N),
        many(N0, Goal)
    ; true
    ).
 
clear :-
    ns_op(retractall(asserted_a(_))),
    ns_op(retractall(asserted_z(_))),
    ns_op(eraseall(recorded_a)),
    ns_op(eraseall(recorded_z)),
    ns_op(b_setval(global_variable, [])).
 
eraseall(Key) :-
    foreach( recorded(Key,_,Ref), erase(Ref) ).


dmsg(Term):-dmsg(debug,Term).
dmsg(Color,Term):-   tell(user),fresh_line, sformat(S,Term,[],[]),print_message_lines(user_output,kind(Color),[S-[]]),fresh_line,told,!.
/*
dmsg(Color,Term):- current_prolog_flag(tty_control, true),!,  tell(user),fresh_line,to_petty_color(Color,Type),
   call_cleanup(((sformat(S,Term,[],[]),print_message(Type,if_tty([S-[]])))),told).
*/

sformat(O,T,_Vs,_Opts):- (true;functor(T,':-',_)),with_output_to(chars(Codes),portray_clause(':-'(T))),
  append([_,_,_],PrintCodes,Codes),'sformat'(O,'~s',[PrintCodes]),!.
sformat(O,T,Vs,Opts):- with_output_to(chars(Codes),(current_output(CO),pp_termclause(CO,':-'(T),Vs,Opts))),
  append([_,_,_],PrintCodes,Codes),'sformat'(O,'~s',[PrintCodes]),!.

pp_termclause(O,T,Vs,Options):- prolog_listing:do_portray_clause(O,T,[variable_names(Vs),numbervars(true),character_escapes(true),quoted(true)|Options]),!.

to_petty_clause(V,('VARIABLE':-V)):-var(V),!.
to_petty_clause((H:-B),(H:-B)):-!.
to_petty_clause((':-'(B)),(':-'(B))):-!.
to_petty_clause(((B)),(':-'(B))):-!.
to_petty_color(X,X).

nop(_P).
doall(G):-ignore((G,fail)).
one_must(Call,Else):- trye(Call)*->true;Else.

:-dynamic((env_mpred/3, mpred_arity/2, env_kb/1)).

:-include(dbase_i_hyhtn).


