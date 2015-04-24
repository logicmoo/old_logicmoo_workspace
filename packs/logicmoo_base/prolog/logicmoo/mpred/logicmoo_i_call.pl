/** <module> 
% File used as storage place for all predicates which change as
% the world is run.
%
% props(Obj,height(ObjHt))  == k(height,Obj,ObjHt) == rdf(Obj,height,ObjHt) == height(Obj,ObjHt)
% padd(Obj,height(ObjHt))  == padd(height,Obj,ObjHt,...) == add(QueryForm)
% kretract[all](Obj,height(ObjHt))  == kretract[all](Obj,height,ObjHt) == pretract[all](height,Obj,ObjHt) == del[all](QueryForm)
% keraseall(AnyTerm).
%
%
% Dec 13, 2035
% Douglas Miles
*/


:-meta_predicate_transparent(mpred_call(0)).

% oncely later will throw an error if there where choice points left over by call
:-meta_predicate(mpred_call(0)).
:-export(mpred_call/1).
oncely(:-(Call)):-!,Call,!.
oncely(:-(Call)):-!,req(Call).
oncely(Call):-once(Call).
% ================================================
% mpred_op/2
% ================================================

/*
query(t, req, G):- mpred_call(G).
query(_, _, Op, G):- dtrace, mpred_call(call(Op,G)).
once(A,B,C,D):-trace_or_throw(once(A,B,C,D)).
*/


:-meta_predicate(deducedSimply(0)).
:-export(deducedSimply/1).
deducedSimply(Call):- clause(deduce_facts(Fact,Call),Body),not_asserted((Call)),nonvar(Fact),Body,dmsg((deducedSimply2(Call):-Fact)),!,show_call((is_asserted(Fact),ground(Call))).

% deducedSimply(Call):- clause(deduce_facts(Fact,Call),Body),nonvar(Fact),Body,ground(Call),dmsg((deducedSimply1(Call):-Fact)),show_call((is_asserted(Fact),ground(Call))).


mpred_op(Op,     H ):- (var(Op);var(H)),!,trace_or_throw(var_database_call(Op,  H )).
mpred_op(is_asserted,H):-!,is_asserted(H).
mpred_op(Op,     H ):- once(fully_expand(Op,H,HH)),H\=@=HH,!,mpred_op(Op, HH).
mpred_op(neg(_,Op),  H ):- !, show_call(not(mpred_op(Op,  H ))).
mpred_op(change(assert,Op),H):-!,must(mpred_modify(change(assert,Op),H)),!.
mpred_op(change(retract,Op),H):-!,must(mpred_modify(change(retract,Op),H)),!.
mpred_op(query(t,Ireq),  H ):-!, mpred_op(Ireq,H).
mpred_op(query(Dbase_t,_Ireq),  H ):-!, mpred_op(Dbase_t,H).
mpred_op(call(Op),H):-!,mpred_op(Op,H).
mpred_op(Op,((include(A)))):- with_no_assertions(thlocal:already_in_file_term_expansion,mpred_op(Op,((load_data_file(A))))),!.
mpred_op(Op, call(H)):- nonvar(H),!, mpred_op(Op,H).
mpred_op(Op,  not(H)):- nonvar(H),!, mpred_op(neg(not,Op),H).
mpred_op(Op,'\\+'(H)):- nonvar(H),!, mpred_op(neg(('\\+'),Op),H).
mpred_op(Op,    ~(H)):- nonvar(H),!, mpred_op(neg(~,Op),H).
mpred_op(Op,     {H}):- nonvar(H),!, mpred_op(Op,H).

mpred_op(must,Call):- !,must(mpred_op(req,Call)).
mpred_op(once,Call):- !,once(mpred_op(req,Call)).

mpred_op(assertedOnly,Call):- !,with_assertions(thlocal:infInstanceOnly(Call),mpred_op(req,Call)).
mpred_op(_ , clause(H,B) ):- !, is_asserted(H,B).
mpred_op(_ , clause(H,B,Ref) ):- !,  is_asserted(H,B,Ref).
mpred_op(_ , (H :- B) ):- !, is_asserted(H,B).
mpred_op(clauses(Op),  H):-!,mpred_op((Op),  H).
mpred_op(_,C):- mpred_call(C).

:-export(whenAnd/2).
whenAnd(A,B):-A,ground(B),once(B).


%user:agent_text_command(_Agent,_Text,_AgentTarget,_Cmd):-fail.
:-asserta((user:agent_call_command(_Gent,actGrep(Obj)):- term_listing(Obj))).


% =======================================
% Transforming DBASE OPs
% ========================================

reduce_mpred_op(Op,Op2):-must(notrace(transitive(how_to_op,Op,Op2))),!.
reduce_mpred_op(A,A).

how_to_op(assert(a),asserta_new).
how_to_op(assert(z),assertz_if_new).
how_to_op(retract(one),retract).
how_to_op(retract(all),retract_all).
how_to_op(retract(all),retractall).
how_to_op(change(assert,z),assertz_if_new).
how_to_op(change(assert,_),asserta_if_new).
how_to_op(change(retract,one),retract).
how_to_op(change(retract,_),retract_all).
how_to_op(asserta,asserta_new).
how_to_op(assertz,assertz_if_new).
how_to_op(call(W),W).
how_to_op(clauses(W),W).
how_to_op(assert,assert_if_new).
how_to_op(assert(_),asserta_new).
how_to_op(retract(_),retract_all).
how_to_op(conjecture,call).
how_to_op(query(t, req),mpred_call).
how_to_op(query(t, Req),Req).
how_to_op(change(Op,HOW),O):- !, O=..[Op,HOW].
how_to_op(HowOP,HowOP).


lookup_inverted_op(retract,assert,-).
lookup_inverted_op(retractall,assert,-).
lookup_inverted_op(assert_if_new,retract,+).
lookup_inverted_op(assert_new,retract,+).
lookup_inverted_op(assertz_if_new,retract,+).
lookup_inverted_op(assertz_new,retract,+).
lookup_inverted_op(asserta_if_new,retract,+).
lookup_inverted_op(asserta_new,retract,+).


% ================================================
% is_callable/mpred_call/naf
% ================================================

%:-dynamic(naf/1).
:-meta_predicate(naf(0)).
:-export(naf/1).
naf(Goal):-not(mpred_call(Goal)).

:-meta_predicate(is_callable(0)).
:-export(is_callable/1).
is_callable(C):-current_predicate(_,C),!.

:-meta_predicate(mpred_call(0)).
:-export(mpred_call/1).
mpred_call(call(X)):-!,mpred_call(X).
mpred_call((X,Y)):-!,mpred_call(X),mpred_call(Y).
mpred_call((X;Y)):-!,mpred_call(X);mpred_call(Y).
mpred_call(call(X,Y)):-!,append_term(X,Y,XY),!,mpred_call(XY).
mpred_call(call(X,Y,Z)):-!,append_term(X,Y,XY),append_term(XY,Z,XYZ),!,mpred_call(XYZ).
mpred_call(Call):- 
 show_call_success(( thlocal:assert_op_override(OvOp), OvOp\=change(assert, _))),fail,
   must((reduce_mpred_op(OvOp,OvOpR),lookup_inverted_op(OvOpR,_,OverridePolarity),
     must((Call=..[Was|Apply],lookup_inverted_op(Was,InvertCurrent,_WasPol))),
   ((OverridePolarity ==('-') -> debugOnError(show_call(apply(InvertCurrent,Apply))) ; debugOnError(show_call(apply(Was,Apply))))))).

mpred_call(Call):-fully_expand(query(t,mpred_call),Call,Expand),!,mpred_call_0(Expand).

mpred_call_0(Call):-predicate_property(Call,foreign),!,Call.
mpred_call_0(Call):- one_must(mpred_call_1(Call),mpred_call_2(Call)).

mpred_call_1(Call):-current_predicate(_,Call),debugOnError(loop_check(Call)).
mpred_call_1(Call):-clause(prolog_xref:process_directive(D, Q),_),nonvar(D),D=Call,!, trace,show_call((prolog_xref:process_directive(Call,Q),fmt(Q))).
mpred_call_2(Call):-predicate_property(Call,dynamic),!,is_asserted(Call).
mpred_call_2(Call):-debugOnError(loop_check(Call)).

% https://gist.githubusercontent.com/vwood/662109/raw/dce9e9ce9505443a82834cdc86163773a0dccc0c/ecldemo.c



