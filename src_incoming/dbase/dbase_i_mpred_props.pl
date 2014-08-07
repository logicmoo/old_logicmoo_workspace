/** <module> 
% ===================================================================
% File 'dbase_db_preds.pl'
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
% ========================================
% decl_mpred_hybrid/1/2/3
% ========================================

:- dynamic_multifile_exported mpred_arity/2.
:- dynamic_multifile_exported mpred_prop/2.

hook:decl_database_hook(assert(_),Fact):- ignore((compound(Fact),Fact=..[F,Arg1|PROPS],argsIsaProps(F),decl_mpred(Arg1,[F|PROPS]))).
hook:decl_database_hook(assert(_),mpred_prop(F,P)):- decl_mpred(F,P).
hook:decl_database_hook(assert(_),isa(F,P)):- argsIsaProps(P),decl_mpred(F,P).
hook:decl_database_hook(assert(_),mpred_prop(F,stubType(Stub))):-mpred_arity(F,A),declare_dbase_local(F,A,Stub).

mpred_prop(mpred_prop,prologOnly).
mpred_prop(mpred_arity,prologOnly).
mpred_prop(subft, extentKnown).
mpred_prop(ft_info, extentKnown).
mpred_arity(argsIsa,1).
mpred_arity(mpred_prop,2).
mpred_arity(mpred_arity,2).
mpred_arity(singleValued,1).
mpred_arity(term_anglify,2).
mpred_arity(equivRule,2)

:-op(0,fx,((decl_mpred_hybrid))).
:-export((decl_mpred_hybrid)/1).


scan_missing_stubs(F):-
   ignore((forall(mpred_missing_stubs(F,Stub),(mpred_arity(F,A),show_call(declare_dbase_local(F,A,Stub)))))).


decl_mpred_pi(PI):-ignore((ground(PI),compound(PI),decl_mpred(PI))).
decl_mpred_mfa(_,M:F,A):-atom(M),!,decl_mpred_mfa(M,F,A).
decl_mpred_mfa(M,FF,A):-
   get_functor(FF,F,_),
   must_det_l([
     ignore((var(M),context_module(M),dmsg(decl_mpred_mfa(M,F,A)))),
     ignore((nonvar(M),asserta_if_new(mpred_prop(F,def_module(M))))),
     assert_arity(F,A),
     declare_dbase_local(F,A),        
    '@'((
     (static_predicate(M,F,A)->true;M:dynamic(F/A)), 
     M:export(F/A),
     M:multifile(M:F/A)),M),
     scan_missing_stubs(F) ]).

decl_mpred_stubtype(F,StubType):-decl_mpred(F,stubType(StubType)),decl_mpred(F,StubType).

decl_mpred_hybrid(M):- with_pi(M,decl_mpred_hybrid).
decl_mpred_hybrid(F,A):-
     decl_mpred(F,A),
     decl_mpred_pi(F),
     decl_mpred_stubtype(F,prologHybrid),
     get_functor(F,FF,_),
     must_det((mpred_arity(FF,AR),decl_mpred_mfa(_,F,AR))).
decl_mpred_hybrid(M,PI,F/A):-
     decl_mpred(F,A),  
     decl_mpred_pi(PI),       
     decl_mpred_stubtype(F,prologHybrid),
     decl_mpred_mfa(M,F,A).


:-op(1150,fx,decl_mpred_hybrid).


% ========================================
% mpred_props database
% ========================================
get_body_functor(Var,_,call):-var(Var),!.
get_body_functor((M:BODY),BodyFunctor,A):-atom(M),!,get_body_functor(BODY,BodyFunctor,A).
get_body_functor((!,BODY),BodyFunctor,A):-!,get_body_functor(BODY,BodyFunctor,A).
get_body_functor(call(BODY),BodyFunctor,A):-!,get_body_functor(BODY,BodyFunctor,A).
get_body_functor(once(BODY),BodyFunctor,A):-!,get_body_functor(BODY,BodyFunctor,A).
get_body_functor((BODY1;BODY2),BodyFunctor,A):-!, (get_body_functor(BODY1,BodyFunctor,A);get_body_functor(BODY2,BodyFunctor,A)).
get_body_functor((BODY1,BODY2),BodyFunctor,A):-!, (get_body_functor(BODY1,BodyFunctor,A);get_body_functor(BODY2,BodyFunctor,A)).
get_body_functor(BODY,BodyFunctor,A):-functor(BODY,BodyFunctor,A).

ensure_clause(HEAD,_,_,_):-functor_safe(HEAD,F,_),mpred_prop(F,prologOnly),!,trace_or_throw(mpred_prop(F,prologOnly)).
ensure_clause(HEAD,_,_,BODY):- clause_asserted(HEAD , BODY),!.
% ensure_clause(HEAD,F,A,_):-pred_as_is(F,A), !.
ensure_clause(HEAD,F,_A,BODY):- assertz((HEAD:-BODY)),
   get_body_functor(BODY,BodyFunctor,_),
   add_w_hooks(mpred_prop(F,prologHybrid)),
   add_w_hooks(mpred_prop(F,hasStub(BodyFunctor))),
   % this is just to catch asserts at these predicates that are supposed to be contained.. We dont really want them compiled
   nop(((compile_predicates([HEAD])),must_det(static_predicate(HEAD)))).


:-export(argsIsaProps/1).
argsIsaProps(Prop):- 
	arg(_,v(argsIsa,multiValued,singleValued,assertionMacroHead,prologBuiltin,nonGroundOK,prologOnly,
		negationByFailure,formatted,prologHybrid,mpred,listValued),Prop).

mpred_arity(Prop,1):-argsIsaProps(Prop).
:-dynamic_multifile_exported(dbase_t/2).
% dbase_t(type,Prop):-mpred_arity(Prop,1).

:-forall(argsIsaProps(F),dynamic(F/1)).

% pass 2
declare_dbase_local(F):- not(mpred_arity(F,A)),trace_or_throw(not(mpred_arity(F,A))).
declare_dbase_local(F):- must_det(mpred_arity(F,A)),declare_dbase_local(F,A).

declare_dbase_local(F,A):- assert_arity(F,A),fail.
declare_dbase_local(F,_):- mpred_prop(F,prologOnly),!.
declare_dbase_local(F,A):- forall(mpred_prop(F,stubType(Stub)),declare_dbase_local(F,A,Stub)).
%declare_dbase_local(F,A):- declare_dbase_local(F,A,prologHybrid),!.

declare_dbase_local(F,A,_Stub):- assert_arity(F,A),fail.
declare_dbase_local(F,_,_):- mpred_prop(F,prologOnly),!. % retractall(mpred_prop(F,stubType(_Stub))).
declare_dbase_local(F,_,Stub):- mpred_prop(F,hasStub(Stub)),!.
declare_dbase_local(F,_,Stub):- add_w_hooks(mpred_prop(F,stubType(Stub))),fail.
declare_dbase_local(F,_,Stub):- add_w_hooks(mpred_prop(F,hasStub(Stub))),fail.
declare_dbase_local(F,A,prologHybrid):- must_det(declare_dbase_local_dynamic(F,A)),!.
declare_dbase_local(F,A,Stub):- trace_or_throw(unknown_stubtype_declare_dbase_local(F,A,Stub)).

mpred_missing_stubs(F,Stub):-mpred_arity(F,_),mpred_prop(F,stubType(Stub)),not(mpred_prop(F,hasStub(Stub))).


cannot_override(F,A,prologBuiltin(F,A)):-mpred_prop(F,prologBuiltin).
cannot_override(F,A,prologOnly(F,A)):-mpred_prop(F,prologOnly).
cannot_override(F,A,Why):-functor_safe(P,F,A),cannot_override(P,F,A,Why).

cannot_override(P,F,A,static_predicate(P)):-static_predicate(moo,F,A).
cannot_override(P,_,_,predicate_property(P,foreign)):-predicate_property(P,foreign),!.
cannot_override(P,_,_,predicate_property(P,builtin)):-predicate_property(P,builtin),!.
cannot_override(P,_,_,predicate_property(P,imported_from(system))):-predicate_property(P,imported_from(system)).


:-export(declare_dbase_local_dynamic/1).
declare_dbase_local_dynamic(F):- must_det(mpred_arity(F,A)),declare_dbase_local(F,A,prologHybrid).
:-export(declare_dbase_local_dynamic/2).
declare_dbase_local_dynamic(F,A):- dbase_mod(M), M:declare_dbase_local_dynamic(M,F,A).

:-export(declare_dbase_local_dynamic/3).
declare_dbase_local_dynamic(M,F,0):- trace_or_throw(illegal_argument_declare_dbase_local_dynamic(M,F,0)).
declare_dbase_local_dynamic(M,F,A):- cannot_override(F,A,Why),!,dmsg(todo(cannot_override(F,A,Why))),nop(listing(M:F/A)).
declare_dbase_local_dynamic(M,F,A):- declare_dbase_local_dynamic_really(M,F,A).

declare_dbase_local_dynamic_really(M,F,A):- functor(HEAD,F,A),'@'(clause_safe(HEAD,(hook:body_req(F,A,HEAD,_))),M),!.
declare_dbase_local_dynamic_really(M,F,A):- mpred_prop(F,prologOnly),!,trace_or_throw(declare_dbase_local_dynamic_really(M,F,A)).
declare_dbase_local_dynamic_really(M,F,A):-
   functor_catch(HEAD,F,A),
   HEAD=..[F|ARGS],
   HEAD_T=..[dbase_t,F|ARGS],
   '@'(ensure_clause(HEAD,F,A,(hook:body_req(F,A,HEAD,HEAD_T))),M),!,
   dynamic_multifile_exported(M:F/A),
   nop(compile_predicates([HEAD])).

declare_dbase_local_dynamic_plus_minus_2(F,AMinus2):-   
   decl_mpred(F,arity(AMinus2)),
   declare_dbase_local(F,AMinus2).
   
declare_dbase_local_dynamic_plus_2(F,A2):- once(( AMinus2 is A2 -2, declare_dbase_local_dynamic_plus_minus_2(F,AMinus2))),fail.

declare_dbase_local_dynamic_plus_2(F,A2):- cannot_override(F,A2,Why),!,dmsg(cannot_override_plus_2(F,A2,Why)).
declare_dbase_local_dynamic_plus_2(F,A2):- 
   functor(HEAD,F,A2),
   HEAD=..[F|ARGS],
   append(ARGSMinus2,[_,_],ARGS),
   HEADMinus2=..[F|ARGSMinus2],
   AMinus2 is A2 -2,
   ensure_clause(HEAD,F,AMinus2,HEADMinus2),!,
  % compile_predicates([HEAD]),
   dbase_mod(M),
   decl_mpred_hybrid(M,F,A2).

   



user_export(_):- dbase_mod(user),!.
user_export(Prop/Arity):- 
   dbase_mod(M), '@'( M:export(Prop/Arity) , M).



% ============================================
% DBASE to Cyc Predicate Mapping
% ============================================

mpred_arity('abbreviationString-PN', 2).

make_functorskel(F,_):- fskel(F,_,_,_,_,_,_),!.
make_functorskel(F,N):- mpred_arity(F,N),make_functorskel(F,N,SKEL),asserta(SKEL),!.
make_functorskel(F,N):- ignore(mpred_arity(F,A)),dmsg(todo(trace_or_throw(illegal_make_functorskel(F,N,A)))).

dbase2pred2svo(DBASE,PRED,svo(A,F,RGS)):-fskel(F,DBASE,PRED,A,RGS,_,_),!.
dbase2pred2svo(DBASE,PRED,svo(A,F,RGS)):-compound(PRED),functor_catch(PRED,F,N),make_functorskel(F,N),!,fskel(F,DBASE,PRED,A,RGS,_,_),!.
dbase2pred2svo(DBASE,PRED,svo(A,F,RGS)):-compound(DBASE),!,arg(1,DBASE,F),must_det(mpred_arity(F,N)),make_functorskel(F,N),!,fskel(F,DBASE,PRED,A,RGS,_,_),!.
dbase2pred2svo(DBASE,PRED,svo(A,F,RGS)):-nonvar(F),must(mpred_arity(F,N)),make_functorskel(F,N),!,fskel(F,DBASE,PRED,A,RGS,_,_),!.

typical_mtvars([_,_]).

% arity 1 person
make_functorskel(Person,1,fskel(Person,dbase_t(Person,A),Call,A,[],MtVars,Call2)):-typical_mtvars(MtVars),Call=..[Person,A],Call2=..[Person,A|MtVars]. 
% arity 2 likes
make_functorskel(Likes,2,fskel(Likes,dbase_t(Likes,A,B),Call,A,B,MtVars,Call2)):- typical_mtvars(MtVars),Call=..[Likes,A,B],Call2=..[Likes,A,B|MtVars]. 
% arity 3 between
make_functorskel(Between,3,fskel(Between,dbase_t(Between,A,B,C),Call,A,[B,C],MtVars,Call2)):- typical_mtvars(MtVars),Call=..[Between,A,B,C],Call2=..[Between,A,B,C|MtVars]. 
% arity 4 xyz
make_functorskel(Xyz,4,fskel(Xyz,dbase_t(Xyz,I,X,Y,Z),Call,I,[X,Y,Z],MtVars,Call2)):- typical_mtvars(MtVars),Call=..[Xyz,I,X,Y,Z],Call2=..[Xyz,I,X,Y,Z|MtVars]. 
% arity 5 rxyz
make_functorskel(RXyz,5,fskel(RXyz,dbase_t(RXyz,I,R,X,Y,Z),Call,I,[R,X,Y,Z],MtVars,Call2)):-typical_mtvars(MtVars),Call=..[RXyz,I,R,X,Y,Z],Call2=..[RXyz,I,R,X,Y,Z|MtVars]. 
% arity >6 
make_functorskel(F,N,fskel(F,DBASE,Call,I,NList,MtVars,Call2)):-typical_mtvars(MtVars),functor_catch(Call,F,N),Call=..[F,I|NList],DBASE=..[dbase_t,F,I|NList],append([F,I|NList],MtVars,CALL2List),Call2=..CALL2List.

% ============================================
% Prolog to Cyc Predicate Mapping
%
%  the following will all do the same things:
%
% :- decl_mpred('BaseKB':isa/2). 
% :- decl_mpred('BaseKB':isa(_,_)). 
% :- decl_mpred(isa(_,_),'BaseKB'). 
% :- decl_mpred('BaseKB',isa,2). 
%
%  Will make calls 
% :- isa(X,Y)
%  Query into #$BaseKB for (#$isa ?X ?Y) 
%
% decl_mpred/N
%
% ============================================
:-export(registerCycPredPlus2/1).

registerCycPredPlus2_3(_M,_PI,F/A2):-   
  A is A2 - 2, decl_mpred_hybrid(F/A),decl_mpred(F,cycPlus2(A2)),decl_mpred(F,cycPred(A)).


registerCycPredPlus2(P):-!,with_pi(P,registerCycPredPlus2_3).

get_mpred_prop(F,genlInverse(P)):-!,genlInverse(F,P).
get_mpred_prop(F,genlPreds(P)):-!,genlPreds(F,P).
get_mpred_prop(F,P):-mpred_prop(F,P),!.

get_mpred_prop(F,_A,P):-get_mpred_prop(F,P).

assert_arity(F,A):-not(atom(F)),trace_or_throw(assert_arity(F,A)).
assert_arity(F,A):-not(integer(A)),trace_or_throw(assert_arity(F,A)).
assert_arity(F,A):-mpred_arity(F,A),assert_if_new(mpred_prop(F,arity(A))),!.
assert_arity(F,A):-mpred_arity(F,1),dmsg(trace_or_throw(was_one_assert_arity(F,A))),!.
assert_arity(argsIsa,2):-trace_or_throw(assert_arity_argsIsa(argsIsa,2)).
assert_arity(ArgsIsa,0):-trace_or_throw(assert_arity(ArgsIsa,0)).
assert_arity(F,A):-loop_check(assert_arity_lc(F,A),true).

assert_arity_lc(F,A):-
  retractall(mpred_prop(F,arity(_))),
  retractall(mpred_arity(F,_)),
   must_det(atom(F)),
    add_w_hooks(mpred_arity(F,A)),add_w_hooks(mpred_prop(F,arity(A))),assert_if_new(mpred_arity(F,A)),must_det(make_functorskel(F,A)),!.
   % ignore((forall(mpred_missing_stubs(F,Stub),show_call(declare_dbase_local(F,A,Stub))))).
   


:-export(rescan_missing_stubs/0).
rescan_missing_stubs:-loop_check(rescan_missing_stubs_lc,true).
rescan_missing_stubs_lc:-notrace(ignore((forall(mpred_missing_stubs(F,Stub),(mpred_arity(F,A),show_call(declare_dbase_local(F,A,Stub))))))).

first_mpred_props(arity(_)).
first_mpred_props(argsIsa(_)).

mpred_prop_ordered(Pred,Prop):-first_mpred_props(Prop),mpred_prop(Pred,Prop),not(mpred_prop(Pred,prologOnly)).
mpred_prop_ordered(Pred,Prop):-mpred_prop(Pred,Prop),not(first_mpred_props(Prop)),not(mpred_prop(Pred,prologOnly)).

:-export(rescan_mpred_props/0).

rescan_mpred_props:- loop_check(rescan_mpred_props_lc,true).
rescan_mpred_props_lc:-rescan_duplicated_facts(moo,mpred_prop(_,_)),fail.
rescan_mpred_props_lc:-forall(mpred_prop_ordered(Pred,Prop),add_w_hooks(mpred_prop(Pred,Prop))),fail.
rescan_mpred_props_lc:-rescan_missing_stubs.
rescan_mpred_props_lc.


:- dynamic_multifile_exported((decl_mpred/1)).

decl_mpred((A,B)):-decl_mpred(A),decl_mpred(B).
decl_mpred(M):-loop_check(with_pi(M,decl_mpred_1),true).
decl_mpred_1(_,F,F/0):-!,assert_if_new(dbase_t(mpred,F)).
decl_mpred_1(M,PI,F/A):-
   decl_mpred(F,A),
   ignore((ground(PI),compound(PI),decl_mpred(F,argsIsa(PI)))),
   decl_mpred(F,[ask_module(M)]).

:-dynamic_multifile_exported(decl_mpred/2).
decl_mpred(C,More):- ignore(loop_check(decl_mpred_0(C,More),true)).

decl_mpred_0(C,More):- (var(C);var(More)), trace_or_throw(var_decl_mpred(C,More)).
decl_mpred_0(F,mpred):-!,assert_if_new(dbase_t(mpred,F)).
decl_mpred_0(_,[]):-!.
decl_mpred_0(M:FA,More):-atom(M),!,decl_mpred_0(FA,[ask_module(M)|More]).
decl_mpred_0(F/A,More):-atom(F),!,decl_mpred_1(F,arity(A)),decl_mpred(F,More),!.
decl_mpred_0(C,More):-compound(C),C=..[F,Arg1|PROPS],argsIsaProps(F),!,ground(Arg1),decl_mpred(Arg1,[F,PROPS,More]).
decl_mpred_0(C,More):-compound(C),!,functor_catch(C,F,A),decl_mpred_1(F,arity(A)),decl_mpred_0(F,More),!,ignore((ground(C),decl_mpred(F,argsIsa(C)))),!.
decl_mpred_0(F,A):-number(A),!,decl_mpred_1(F,arity(A)),!.
decl_mpred_0(F,[Prop|Types]):-!,decl_mpred_0(F,Prop),!,decl_mpred_0(F,Types),!.

decl_mpred_0(F,T):-doall(( decl_mpred_1(F,T) )).

decl_mpred_1(F,argsIsa(FARGS)):- functor(FARGS,_,A),decl_mpred(F,A),fail.
decl_mpred_1(_,argsIsa(FARGS)):- functor(FARGS,_,A),arg(A,FARGS,Arg),var(Arg),!.
decl_mpred_1(F,arity(A)):- assert_arity(F,A),fail.

decl_mpred_1(F,prologHybrid):- declare_dbase_local_dynamic(F).
decl_mpred_1(F,cycPlus2(A)):-declare_dbase_local_dynamic_plus_2(F,A).

decl_mpred_1(F,Prop):-mpred_prop(F,Prop),!.
decl_mpred_1(F,Prop):-add_w_hooks(mpred_prop(F,Prop)),fail.

decl_mpred_1(F,A):-once(decl_mpred_2(F,A)).

decl_mpred_2(F,external(Module)):- dmsg(decl_mpred(F,external(Module))),not(dbase_mod(Module)),must_det(mpred_arity(F,A)),functor_catch(HEAD,F,A),must_det(predicate_property(Module:HEAD,_)),!.
decl_mpred_2(F,_):- once((not((mpred_prop(F,external(Module)),not(dbase_mod(Module)))),declare_dbase_local(F))),!.
% decl_mpred_2(F,A):- declare_dbase_local_dynamic(F,A).


decl_mpred(Mt,F,A):-decl_mpred(F,A),ignore((nonvar(Mt),decl_mpred(F,mt(Mt)))).

:-op(0,fx,decl_mpred_prolog).
:-export(decl_mpred_prolog/1).
decl_mpred_prolog(P):- with_pi(P,decl_mpred_prolog).
:-op(1120,fx,decl_mpred_prolog).

decl_mpred_prolog(M,PI,F/A):-
  must_det_l([   
   % retractall(mpred_prop(F,_)),
   assert_arity(F,A),
   decl_mpred(F,prologOnly),   
   decl_mpred(F,prologBuiltin),
    decl_mpred(F,as_is(M:F/A)),
    decl_mpred(F,ask_module(M)),
   ignore((ground(PI),decl_mpred(PI))),
   decl_mpred(F,A)]).


% :- decl_mpred((nameStrings/2,grid_key/1,on_world_load/0,label_type/2,creatableType/2)).
% :- decl_mpred posture/1.
% :- dynamic_multifile_exported((decl_mpred/1)).

:-dmsg_hide(game_assert).
%:-dmsg_hide(db_op_exact).

functor_check_univ(M:G1,F,List):-atom(M),member(M,[dbase,moo]),!,functor_check_univ(G1,F,List),!.
functor_check_univ(G1,F,List):-must_det(compound(G1)),must_det(G1 \= _:_),must_det(G1 \= _/_),G1=..[F|List],!.

:-export(glean_pred_props_maybe/1).
glean_pred_props_maybe(_:G):-!,compound(G),glean_pred_props_maybe(G).
glean_pred_props_maybe(G):-compound(G),G=..[F,Arg1|RGS],argsIsaProps(F),!,add_mpred_prop_gleaned(Arg1,[F|RGS]),!.

add_mpred_prop_gleaned(M:Arg1,FRGS):-atom(M),!,add_mpred_prop_gleaned(Arg1,FRGS).
add_mpred_prop_gleaned(Arg1,FRGS):-functor_check_univ(Arg1,F,ARGSISA),add_mpred_prop_gleaned_4(Arg1,F,ARGSISA,FRGS).
add_mpred_prop_gleaned_4(Arg1,_F,[ARG|_],FRGS):-nonvar(ARG),!,decl_mpred(Arg1,[argsIsa(Arg1)|FRGS]).
add_mpred_prop_gleaned_4(Arg1,_F,_,FRGS):-decl_mpred(Arg1,FRGS).

user:term_expansion(G,_):- notrace((once(glean_pred_props_maybe(G)),fail)).


