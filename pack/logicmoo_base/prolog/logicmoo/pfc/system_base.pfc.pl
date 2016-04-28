/* <module>
% =============================================
% File 'system_base.pfc'
% Purpose: Agent Reactivity for SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'interface' 1.0.0
% Revision: $Revision: 1.9 $
% Revised At: $Date: 2002/06/27 14:13:20 $
% =============================================
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
%
% props(Obj,[height(ObjHt)]) == t(height,Obj,ObjHt) == rdf(Obj,height,ObjHt) == t(height(Obj,ObjHt)).
% pain(Obj,[height(ObjHt)]) == prop_set(height,Obj,ObjHt,...) == ain(height(Obj,ObjHt))
% [pdel/pclr](Obj,[height(ObjHt)]) == [del/clr](height,Obj,ObjHt) == [del/clr]svo(Obj,height,ObjHt) == [del/clr](height(Obj,ObjHt))
% keraseall(AnyTerm).
%
%                      ANTECEEDANT                                   CONSEQUENT
%
%         P =         test nesc true                         assert(P),retract(~P) , enable(P).
%       ~ P =         test nesc false                        assert(~P),retract(P), disable(P)
%
%   ~ ~(P) =         test possible (via not impossible)      retract( ~(P)), enable(P).
%  \+ ~(P) =         test impossiblity is unknown            retract( ~(P))
%   ~ \+(P) =        same as P                               same as P
%     \+(P) =        test naf(P)                             retract(P)
%
% Dec 13, 2035
% Douglas Miles
*/

:- file_begin(pfc).

:- set_mpred_module(baseKB).


% catching of misinterpreations
(mpred_mark(pfcPosTrigger,F,A)/(fa_to_p(F,A,P), P\={_}, predicate_property(P,static))) ==> {break,trace_or_throw(warn(pfcPosTrigger,P,static))}.
(mpred_mark(pfcNegTrigger,F,A)/(fa_to_p(F,A,P),  P\={_}, predicate_property(P,static))) ==> {dmsg(warn(pfcNegTrigger,P,static))}.
(mpred_mark(pfcBcTrigger,F,A)/(fa_to_p(F,A,P), predicate_property(P,static))) ==> {dmsg(warn(pfcNegTrigger,P,static))}.


%(mpred_mark(pfcPosTrigger,F,A)/(fa_to_p(F,A,P), \+ predicate_property(P,_))) ==> {kb_dynamic(tbox:F/A)}.
%(mpred_mark(pfcNegTrigger,F,A)/(fa_to_p(F,A,P), \+ predicate_property(P,_))) ==> {kb_dynamic(tbox:F/A)}.

:- dynamic(marker_supported/2).
:- dynamic(mpred_mark/3).

:- dynamic(mpred_mark_C/1).


:- kb_dynamic(tCol/1).
:- kb_dynamic(subFormat/2).
:- kb_dynamic(singleValuedInArg/2).
:- kb_dynamic(ptReformulatorDirectivePredicate/1).
:- kb_dynamic(support_hilog/2).
:- kb_dynamic(mpred_undo_sys/3).
:- kb_dynamic(arity/2).

:- dynamic(arity/2).

arity(apathFn,2).
arity(isKappaFn,2).
arity(isInstFn,1).
arity(ftListFn,1).
arity(xyzFn,4).
arity(arity,2).
arity(is_never_type,1).
arity(argIsa, 3).
arity(Prop,1):-ttPredType(Prop).
arity(meta_argtypes,1).
arity(arity,2).
arity(is_never_type,1).
arity(prologSingleValued,1).
arity('<=>',2).
arity(F,A):- cwc, is_ftNameArity(F,A), current_predicate(F/A),A>1.
arity(F,1):- cwc, is_ftNameArity(F,1), current_predicate(F/1),\+((dif:dif(Z,1), arity(F,Z))).


prologHybrid(arity/2).



% this mean to leave terms at EL:  foo('QuoteFn'([cant,touch,me])).

quasiQuote('QuoteFn').

argsQuoted('loop_check_term').
argsQuoted('loop_check_term_key').
argsQuoted('QuoteFn').
argsQuoted('$VAR').
baseKB:arity('$VAR',1).

argsQuoted(ain).
argsQuoted(meta_argtypes).
argsQuoted(ttFormated).
argsQuoted(ruleRewrite).
argsQuoted(mpred_action).
argsQuoted(ain).
argsQuoted(mpred_rem).
argsQuoted(added).
argsQuoted(call).
argsQuoted(call_u).
argsQuoted(member).
argsQuoted(=..).
argsQuoted({}).
argsQuoted(second_order).
% argsQuoted((':-')).


% ~(tCol({})).

:- unload_file(library(yall)).

((prologBuiltin(P)/get_arity(P,F,A),arity(F,A))==>{make_builtin(F/A)}).

meta_argtypes(support_hilog(tRelation,ftInt)).

((tPred(F),arity(F,A)/(is_ftNameArity(F,A),A>1), ~prologBuiltin(F)) ==> (~(tCol(F)),support_hilog(F,A))).

:- kb_dynamic(support_hilog/2).

(((support_hilog(F,A)/(F\='$VAR',is_ftNameArity(F,A),\+ static_predicate(F/A), \+ prologDynamic(F)))) ==>
   (hybrid_support(F,A), 
    {% functor(Head,F,A) ,Head=..[F|TTs], TT=..[t,F|TTs],
    %  (CL = (Head :- cwc, call(second_order(TT,CuttedCall)), ((CuttedCall=(C1,!,C2)) -> (C1,!,C2);CuttedCall)))
    CL = arity(F,A)
    },
   (CL))).


%:- kb_dynamic(hybrid_support/2).
%prologBuiltin(resolveConflict/1).


((prologHybrid(F),arity(F,A)/is_ftNameArity(F,A))==>hybrid_support(F,A)).
(hybrid_support(F,A)/is_ftNameArity(F,A))==>prologHybrid(F),arity(F,A).


pfcControlled(X)/get_pifunctor(X,C)==>({kb_dynamic(C),get_functor(C,F,A)},arity(F,A),pfcControlled(F),support_hilog(F,A)).
prologHybrid(X)/get_pifunctor(X,C)==>({\+ static_predicate(C), kb_dynamic(C),get_functor(C,F,A)},arity(F,A),prologHybrid(F)).

prologBuiltin(X)/get_pifunctor(X,C)==>({decl_mpred_prolog(C),get_functor(C,F,A)},arity(F,A),prologBuiltin(F)).
prologDynamic(X)/get_pifunctor(X,C)==>({kb_dynamic(C),decl_mpred_prolog(C),get_functor(C,F,A)},arity(F,A),prologDynamic(F)).

isa(F,pfcMustFC) ==> pfcControlled(F).



pfcControlled(C)==>prologHybrid(C).

:- dynamic(hybrid_support/2).

mpred_mark(S1, F, A)/(ground(S1),is_ftNameArity(F,A))==>(tSet(S1),arity(F,A),isa(F,S1)).
mpred_mark(pfcPosTrigger,F, A)/(is_ftNameArity(F,A))==>marker_supported(F,A).
mpred_mark(pfcNegTrigger,F, A)/(is_ftNameArity(F,A))==>marker_supported(F,A).
mpred_mark(pfcBcTrigger,F, A)/(is_ftNameArity(F,A))==>marker_supported(F,A).
mpred_mark(pfcRHS,F, A)/(is_ftNameArity(F,A))==>marker_supported(F,A).
mpred_mark(pfcCreates,F, A)/(is_ftNameArity(F,A))==>{functor(P,F,A),make_dynamic(P)}.
mpred_mark(pfcCreates,F, A)/(is_ftNameArity(F,A))==>marker_supported(F,A).
mpred_mark(pfcCallCode,F, A)/((is_ftNameArity(F,A)), 
  predicate_is_undefined_fa(F,A))==> marker_supported(F,A).


(marker_supported(F,A)/is_ftNameArity(F,A))==>(prologHybrid(F),hybrid_support(F,A)).


%mpred_mark(pfcPosTrigger,F,A)/(integer(A),functor(P,F,A)) ==> pfcTriggered(F/A),afterAdding(F,lambda(P,mpred_enqueue(P,(m,m)))).
%mpred_mark(pfcNegTrigger,F,A)/(integer(A),functor(P,F,A)) ==> pfcTriggered(F/A), afterRemoving(F,lambda(P,mpred_enqueue(~P,(m,m)))).

/*
mpred_mark(pfcRHSF,1)/(fail,atom(F),functor(Head,F,1), 
 \+ argsQuoted(F),
 \+ prologDynamic(F),
 \+ ~(tCol(F)),
 \+ specialFunctor(F),
 \+ predicate_property(Head,built_in))==>completelyAssertedCollection(F).
*/
% mpred_mark(Type,F,A)/(integer(A),A>1,F\==arity,Assert=..[Type,F])==>arity(F,A),Assert.

mpred_mark_C(G) ==> {map_mpred_mark_C(G)}.
map_mpred_mark_C(G) :-  map_literals(lambda(P,(get_functor(P,F,A),ain([isa(F,pfcControlled),arity(F,A)]))),G).
mpred_mark(pfcRHS,F,A)/(is_ftNameArity(F,A),F\==arity)==>tPred(F),arity(F,A),pfcControlled(F).

% (hybrid_support(F,A) ==>{\+ static_predicate(F/A), must(kb_dynamic(F/A))}).


%:- meta_predicate(mp_test_agr(?,+,-,*,^,:,0,1,5,9)).
%mp_test_agr(_,_,_,_,_,_,_,_,_,_).
%:- mpred_test(predicate_property(mp_test_agr(_,_,_,_,_,_,_,_,_,_),meta_predicate(_))).
% becomes         mp_test_agr(+,+,-,?,^,:,0,1,0,0)


((marker_supported(F,A)/is_ftNameArity(F,A),prologHybrid(F))==>hybrid_support(F,A)).
(hybrid_support(F,A) ==>{ must(kb_dynamic(F/A))}).

((hybrid_support(F,A)/(is_ftNameArity(F,A), \+ prologDynamic(F),\+ static_predicate(F/A))) ==>
  ({    
    functor(G,F,A),
     (var(M)->must(get_user_abox(M));true),
     (var(M)->ignore(( current_predicate(F,M:G), \+ predicate_property(M:G,imported_from(_))));true),
     (var(M)->predicate_property(M:G,exported);true),
     % must(rebuild_pred_into(G,G,ain,[+dynamic,+multifile,+discontiguous])),         
     % (predicate_property(M:G,dynamic)->true;must(convert_to_dynamic(M,F,A))),
     kb_dynamic(M:F/A),
     show_failure(hybrid_support, \+ static_predicate(F/A))}),
     prologHybrid(F),
    arity(F,A)).


prologHybrid(defnIff(ttExpressionType,ftTerm)).

defnIff(X,_)==>ttExpressionType(X).
