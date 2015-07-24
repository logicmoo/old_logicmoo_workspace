/** <module> 
% ===================================================================
% File 'logicmoo_i_cyc.pl'
% Purpose: Emulation of OpenCyc for SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'interface.pl' 1.0.0
% Revision:  $Revision: 1.9 $
% Revised At:   $Date: 2002/06/27 14:13:20 $
% ===================================================================
% File used as storage place for all predicates which make us more like Cyc
%
% Dec 13, 2035
% Douglas Miles
*/
%:- module(tiny_kb,['TINYKB-ASSERTION'/5, 'TINYKB-ASSERTION'/6]).

:-if_file_exists(user:ensure_loaded(logicmoo(ext/moo_ext_cyc_new))).

isa_db(I,C):-clause(isa(I,C),true).

mpred_to_cyc(tCol,'Collection').
mpred_to_cyc(ttFormatType,'CycLExpressionType').
mpred_to_cyc(ttFormatType,'ExpressionType').
mpred_to_cyc(tPred,'Predicate').
mpred_to_cyc(tFunction,'Function-Denotational').
mpred_to_cyc(ftVar,'CycLVariable').
mpred_to_cyc(ftVar,'Variable').


mpred_to_cyc(D,C):-var(D),mpred_t_type(C),atom_concat('t',C,D).
mpred_to_cyc(D,C):-var(D),mpred_t_type(C),atom_concat('t',C,D).
mpred_to_cyc(D,C):-nonvar(D),atom_concat('t',C,D),mpred_t_type(C).

mpred_t_type('Relation').
mpred_ft_type(X):- tinyKB(isa(X,ttFormatType)).
mpred_ft_type(X):- tinyKB(isa(X,'SubLExpressionType')).
mpred_ft_type(X):- tinyKB(genls(X,'SubLExpression')).
mpred_ft_type(X):- tinyKB(genls(X,'CycLExpression')).
mpred_ft_type('Relation').

%cyc_to_pfc_idiom(different,dif).
cyc_to_pfc_idiom(equiv,(<=>)).
cyc_to_pfc_idiom(implies,(=>)).
cyc_to_pfc_idiom('CycLTerm','CycLExpression').
cyc_to_pfc_idiom(not,(neg)).
cyc_to_pfc_idiom(I,O):-transitive_lc(cyc_to_pfc_idiom0,I,O)).

cyc_to_pfc_idiom0(C,P):-atom_concatM('CycLSentence-',Type,C),!,cyc_to_pfc_idiom0(Type,P).
cyc_to_pfc_idiom0(C,P):-atom_concatM('Expression-',Type,C),!,atom_concat('Expression',Type,P).
cyc_to_pfc_idiom0(C,P):-atom_concatM('CycL',Type,C),!,cyc_to_pfc_idiom0(Type,P).
cyc_to_pfc_idiom0(C,P):-atom_concatM('SubL',Type,C),!,cyc_to_pfc_idiom0(Type,P).
cyc_to_pfc_idiom0(C,P):-atom_concatM('Cyclist',Type,C),!,atom_concat('Author',Type,P).
cyc_to_pfc_idiom0(C,P):-atom_concatM('Cyc',Type,C),!,cyc_to_pfc_idiom0(Type,P).
cyc_to_pfc_idiom0(C,P):-atom_concatM('FormulaicSenten',Type,C),!,atom_concat('Senten',Type,P).
cyc_to_pfc_idiom0(C,P):-atom_concatM('SExpressi',Type,C),!,atom_concat('Expressi',Type,P).
cyc_to_pfc_idiom0(C,P):-mpred_to_cyc(P,C),!.

atom_concatM(B,R,In):-atom_concat(B,R,In),atom_length(R,L),!,L>1.



cyc_to_pfc_idiom([Conj|MORE],Out):-fail, not(is_ftVar(Conj)),!,cyc_to_pfc_sent_idiom_2(Conj,Pred,_),
  with_assertions(thocal:outer_pred_expansion(Conj,MORE),
    ( maplist(cyc_to_pfc_expansion,MORE,MOREL), 
       with_assertions(thocal:outer_pred_expansion(Pred,MOREL),       
         list_to_ops(Pred,MOREL,Out)))),!.

cyc_to_pfc_sent_idiom_2(and,(','),trueSentence).

list_to_ops(_,V,V):-is_ftVar(V),!.
list_to_ops(Pred,[],Out):-cyc_to_pfc_sent_idiom_2(_,Pred,Out),!.
list_to_ops(Pred,In,Out):-not(is_list(In)),!,cyc_to_pfc_expansion(In,Mid),cyc_to_pfc_sent_idiom_2(_,Pred,ArityOne),Out=..[ArityOne,Mid].
list_to_ops(_,[In],Out):-!,cyc_to_pfc_expansion(In,Out).
list_to_ops(Pred,[H,T],Body):-!,
    cyc_to_pfc_expansion(H,HH),
    cyc_to_pfc_expansion(T,TT),
    (is_list(TT)-> Body=..[Pred,HH|TT]; Body=..[Pred,HH,TT]).

list_to_ops(Pred,[H|T],Body):-!,
    list_to_ops(Pred,H,HH),
    list_to_ops(Pred,T,TT),
    (is_list(TT)-> Body=..[Pred,HH|TT]; Body=..[Pred,HH,TT]).

kw_to_vars(KW,VARS):-subsT_each(KW,[':ARG1'=_ARG1,':ARG2'=_ARG2,':ARG3'=_ARG3,':ARG4'=_ARG4,':ARG5'=_ARG5,':ARG6'=_ARG6],VARS).
make_kw_functor(F,A,CYCL):-make_kw_functor(F,A,CYCL,':ARG'),!.
make_kw_functor(F,A,CYCL,PREFIX):-make_functor_h(CYCL,F,A),CYCL=..[F|ARGS],label_args(PREFIX,1,ARGS).

label_args(_PREFIX,_,[]).
label_args(PREFIX,N,[ARG|ARGS]):-atom_concat(PREFIX,N,TOARG),ignore(TOARG=ARG),!,N2 is N+1,label_args(PREFIX,N2,ARGS).

:-thread_local thocal:outer_pred_expansion/2.

cyc_to_pfc_expansion_entry(I,O):-fail,cyc_to_pfc_expansion(I,M),!,must((functor(I,FI,_),functor(M,MF,_),FI==MF)),O=M.

cyc_to_pfc_expansion(V,V):-is_ftVar(V),!.
cyc_to_pfc_expansion(I,O):-cyc_to_pfc_idiom(I,O),!.
cyc_to_pfc_expansion(V,V):-not(compound(V)),!.
cyc_to_pfc_expansion([H|T],[HH|TT]):-!,cyc_to_pfc_expansion(H,HH),cyc_to_pfc_expansion(T,TT),!.
cyc_to_pfc_expansion(HOLDS,HOLDSOUT):-HOLDS=..[F|HOLDSL],
  with_assertions(thocal:outer_pred_expansion(F,HOLDSL),cyc_to_pfc_expansion([F|HOLDSL],HOLDSOUTL)),!,
  (is_list(HOLDSOUTL)-> must(HOLDSOUT=..HOLDSOUTL) ; HOLDSOUT=HOLDSOUTL),!.

/*

sterm_to_pterm(VAR,'$VAR'(V)):-atom(VAR),atom_concat('?',_,VAR),clip_qm(VAR,V),!.
sterm_to_pterm(VAR,kw((V))):-atom(VAR),atom_concat(':',V2,VAR),clip_qm(V2,V),!.
sterm_to_pterm(VAR,VAR):-is_ftVar(VAR),!.
sterm_to_pterm([VAR],VAR):-is_ftVar(VAR),!.
sterm_to_pterm([X],Y):-!,nonvar(X),sterm_to_pterm(X,Y).

sterm_to_pterm([S|TERM],dot_holds(PTERM)):- not(is_list(TERM)),!,sterm_to_pterm_list([S|TERM],(PTERM)),!.
sterm_to_pterm([S|TERM],PTERM):-is_ftVar(S),
            sterm_to_pterm_list(TERM,PLIST),            
            PTERM=..[holds,S|PLIST].

sterm_to_pterm([S|TERM],PTERM):-number(S),!,
            sterm_to_pterm_list([S|TERM],PTERM).            
	    
sterm_to_pterm([S|TERM],PTERM):-nonvar(S),atomic(S),!,
            sterm_to_pterm_list(TERM,PLIST),            
            PTERM=..[S|PLIST].

sterm_to_pterm([S|TERM],PTERM):-!,  atomic(S),
            sterm_to_pterm_list(TERM,PLIST),            
            PTERM=..[holds,S|PLIST].

sterm_to_pterm(VAR,VAR):-!.

sterm_to_pterm_list(VAR,VAR):-is_ftVar(VAR),!.
sterm_to_pterm_list([],[]):-!.
sterm_to_pterm_list([S|STERM],[P|PTERM]):-!,
              sterm_to_pterm(S,P),
              sterm_to_pterm_list(STERM,PTERM).
sterm_to_pterm_list(VAR,[VAR]).

*/

clip_us(A,AO):-concat_atom(L,'-',A),concat_atom(L,'_',AO).
clip_qm(QA,AO):-atom_concat('??',A1,QA),!,atom_concat('_',A1,A),clip_us(A,AO).
clip_qm(QA,AO):-atom_concat('?',A,QA),!,clip_us(A,AO).
clip_qm(A,AO):-clip_us(A,AO).

fixvars(P,_,[],P):-!.
fixvars(P,N,[V|VARS],PO):-  
     atom_string(Name,V),clip_qm(Name,NB),Var = '$VAR'(NB),
     subst(P,'$VAR'(N),Var,PM0),
     subst(PM0,'$VAR'(Name),Var,PM),
   %  nb_getval('$variable_names', Vs),
  %   append(Vs,[Name=Var],NVs),
  %   nb_setval('$variable_names', NVs),
     N2 is N + 1,fixvars(PM,N2,VARS,PO).


:-dynamic(argIsa/3).
:-multifile(argIsa/3).
:-dynamic(argGenl/3).
:-multifile(argGenl/3).
:-dynamic(argQuotedIsa/3).
:-multifile(argQuotedIsa/3).
/*
isa(I,C):-exactlyAssertedEL(isa,I,C,_,_).
genls(I,C):-exactlyAssertedEL(genls,I,C,_,_).
arity(I,C):-exactlyAssertedEL(arity,I,C,_,_).
argIsa(P,N,C):-exactlyAssertedEL(argIsa,P,N,C,_,_).
argGenl(P,N,C):-exactlyAssertedEL(argGenl,P,N,C,_,_).
argQuotedIsa(P,N,C):-exactlyAssertedEL(argQuotedIsa,P,N,C,_,_).
*/
% queuedTinyKB(CycL,MT):- (tUndressedMt(MT);tDressedMt(MT)),(STR=vStrMon;STR=vStrDef),  tinyKB_All(CycL,MT,STR),\+ clause(exactlyAssertedEL(CycL,_,_,_),true).
% queuedTinyKB(CycL):-tUndressedMt(MT),queuedTinyKB(CycL,MT).
% queuedTinyKB(ist(MT,CycL)):-tDressedMt(MT),queuedTinyKB(CycL,MT).


ist(MT,P):-tinyKB(P,MT,vStrMon).
ist(MT,P):-tinyKB(P,MT,vStrDef).

tinyKB(P):-tUndressedMt(MT),tinyKB(P,MT,_).
tinyKB(ist(MT,P)):-tDressedMt(MT),tinyKB(P,MT,_).


tinyKB(PO,MT,STR):- %fwc,  
  (tUndressedMt(MT);tDressedMt(MT)),(STR=vStrMon;STR=vStrDef), 
  tinyKB_All(PO,MT,STR).

tinyKB_All(V,MT,STR):- tinyAssertion(V,MT,STR).
tinyKB_All(PO,MT,STR):- current_predicate('TINYKB-ASSERTION'/5),!,
    tiny_kb_ASSERTION(PLISTIn,PROPS),
        once((sterm_to_pterm(PLISTIn,P),
               memberchk(amt(MT),PROPS),
               memberchk(str(STR),PROPS), 
              (member(vars(VARS),PROPS)->(nb_setval('$variable_names', []),fixvars(P,0,VARS,PO));PO=P ))).

tinyKB:-forall(tinyKB(P,MT,STR),((print_assertion(P,MT,STR),pfc_add(P)))).

print_assertion(P,MT,STR):- P=..PL,append([exactlyAssertedEL|PL],[MT,STR],PPL),PP=..PPL, portray_clause(current_output,PP,[numbervars(false)]).


tUndressedMt('UniversalVocabularyImplementationMt').
tUndressedMt('LogicalTruthImplementationMt').
tUndressedMt('CoreCycLImplementationMt').
tUndressedMt('UniversalVocabularyMt').
tUndressedMt('LogicalTruthMt').
tUndressedMt('CoreCycLMt').
tUndressedMt('BaseKB').
tDressedMt('BookkeepingMt').
tDressedMt('EnglishParaphraseMt').
tDressedMt('TemporaryEnglishParaphraseMt').

call_el_stub(V,MT,STR):-into_mpred_form(V,M),!,M=..ML,((ML=[t|ARGS]-> true; ARGS=ML)),CALL=..[exactlyAssertedEL|ARGS],!,call(CALL,MT,STR).
make_el_stub(V,MT,STR,CALL):-into_mpred_form(V,M),!,M=..ML,((ML=[t|ARGS]-> true; ARGS=ML)),append(ARGS,[MT,STR],CARGS),CALL=..[exactlyAssertedEL|CARGS],!.

tinyAssertion(V,MT,STR):- 
 nonvar(V) -> call_el_stub(V,MT,STR);
  (tinyAssertion0(W,MT,STR),once(into_mpred_form(W,V))).

tinyAssertion0(t(A,B,C,D,E),MT,STR):-exactlyAssertedEL(A,B,C,D,E,MT,STR).
tinyAssertion0(t(A,B,C,D),MT,STR):-exactlyAssertedEL(A,B,C,D,MT,STR).
tinyAssertion0(t(A,B,C),MT,STR):-exactlyAssertedEL(A,B,C,MT,STR).
tinyAssertion0(t(A,B),MT,STR):-exactlyAssertedEL(A,B,MT,STR).


addTinyCycL(CycLIn):- into_mpred_form(CycLIn,CycL),
  ignore((tiny_support(CycL,_MT,CALL),retract(CALL))),!,
  addCycL(CycL),!.


% tiny_support(CycL,MT,CALL):- CycL=..[F|Args], append(Args,[MT,_STR],WMT),CCALL=..[exactlyAssertedEL,F|WMT],!,((clause(CCALL,true), CCALL=CALL) ; clause(CCALL,(CALL,_))).

make_functor_h(CycL,F,A):- length(Args,A),CycL=..[F|Args].

is_simple_gaf(V):-not(compound(V)),!.
is_simple_gaf(V):-needs_canoncalization(V),!,fail.
is_simple_gaf(V):-functor(V,F,A),member(F/A,[isa/2,genls/2,argQuotedIsa/3,afterAdding/2,afterRemoving/2]),!.
is_simple_gaf(V):-needs_indexing(V),!,fail.
is_simple_gaf(_).

needs_indexing(V):-compound(V),arg(_,V,A),not(is_simple_arg(A)),!,fail.

is_simple_arg(A):-not(compound(A)),!.
is_simple_arg(A):-functor(A,Simple,_),tEscapeFunction(Simple).

'tEscapeFunction'('TINYKB-ASSERTION').
'tEscapeFunction'('SubLQuoteFn').
'tEscapeFunction'(X):- 'UnreifiableFunction'(X).

needs_canoncalization(CycL):-is_ftVar(CycL),!,fail.
needs_canoncalization(CycL):-functor(CycL,F,_),isa_db(F,'SentenceOperator').
needs_canoncalization(CycL):-needs_indexing(CycL).

is_better_backchained(CycL):-is_ftVar(CycL),!,fail.
is_better_backchained(CycL):-functor(CycL,F,_),isa_db(F,'SentenceOperator').
is_better_backchained(V):-unnumbervars(V,FOO),(((each_subterm(FOO,SubTerm),nonvar(SubTerm),isa_db(SubTerm,tAvoidForwardChain)))),!.


as_cycl(VP,VE):-subst(VP,('-'),(neg),V0),subst(V0,('v'),(or),V1),subst(V1,('exists'),(thereExists),V2),subst(V2,('&'),(and),VE),!.


:-dynamic(addTiny_added/1).
addCycL(V):-addTiny_added(V),!.
addCycL(V):-into_mpred_form(V,M),V\=@=M,!,addCycL(M),!.
addCycL(V):-defunctionalize('implies',V,VE),V\=@=VE,!,addCycL(VE).
addCycL(V):-cyc_to_pfc_expansion(V,VE),V\=@=VE,!,addCycL(VE).
addCycL(V):-is_simple_gaf(V),!,addCycL0(V),!.
addCycL(V):-kif_to_boxlog(V,VB),boxlog_to_prolog(VB,VP),V\=@=VP,!,as_cycl(VP,VE),show_call(addCycL0(VE)).
addCycL(V):-addCycL0(V),!.

addCycL0(V):-addCycL1(V).

addCycL1(V):-into_mpred_form(V,M),V\=@=M,!,addCycL0(M),!.
addCycL1(V):-cyc_to_pfc_expansion(V,VE),V\=@=VE,!,addCycL0(VE).
addCycL1((TRUE=>V)):-is_true(TRUE),addCycL0(V),!.
addCycL1((V<=TRUE)):-is_true(TRUE),addCycL0(V),!.
addCycL1((V :- TRUE)):-is_true(TRUE),addCycL0(V),!.
addCycL1((V :- A)):- show_call(addCycL0((A => V))).
addCycL1((A => (V1 , V2))):-not(is_ftVar(V1)),!,show_call(addCycL0((A => V1))) , show_call(addCycL0((A => V2))).
addCycL1((V1 , V2)):-!,addCycL0(V1),addCycL0(V2),!.
addCycL1([V1 | V2]):-!,addCycL0(V1),addCycL0(V2),!.
addCycL1(V):-addTiny_added(V),!.
addCycL1(V):-asserta(addTiny_added(V)),unnumbervars(V,VE),pfc_add(VE),remQueuedTinyKB(VE).


sent_to_conseq(CycLIn,Consequent):- into_mpred_form(CycLIn,CycL), ignore((tiny_support(CycL,_MT,CALL),retract(CALL))),must(cycLToMpred(CycL,Consequent)),!.

:-dynamic(addTiny_added/1).

cycLToMpred(V,CP):-into_mpred_form(V,M),V\=@=M,!,cycLToMpred(M,CP),!.
cycLToMpred(V,CP):-cyc_to_pfc_expansion(V,VE),V\=@=VE,!,cycLToMpred(VE,CP).
cycLToMpred(V,CP):-is_simple_gaf(V),!,cycLToMpred0(V,CP),!.
cycLToMpred(V,CP):-defunctionalize('implies',V,VE),V\=@=VE,!,cycLToMpred(VE,CP).
cycLToMpred(V,CP):-kif_to_boxlog(V,VB),boxlog_to_prolog(VB,VP),V\=@=VP,!,as_cycl(VP,VE),show_call(cycLToMpred0(VE,CP)).
cycLToMpred(V,CP):-cycLToMpred0(V,CP),!.

cycLToMpred0(V,CP):-into_mpred_form(V,M),V\=@=M,!,cycLToMpred0(M,CP),!.
cycLToMpred0(V,CP):-cyc_to_pfc_expansion(V,VE),V\=@=VE,!,cycLToMpred0(VE,CP).
cycLToMpred0((TRUE=>V),CP):-is_true(TRUE),cycLToMpred0(V,CP),!.
cycLToMpred0((V<=TRUE),CP):-is_true(TRUE),cycLToMpred0(V,CP),!.
cycLToMpred0((V :- TRUE),CP):-is_true(TRUE),cycLToMpred0(V,CP),!.
cycLToMpred0((V :- A),CP):- show_call(cycLToMpred0((A => V))).
cycLToMpred0((A => (V1 , V2)),CP):-not(is_ftVar(V1)),!,cycLToMpred0((A=> (V1/consistent(V2))),V1P),cycLToMpred0((A=> (V2/consistent(V1))),V2P) ,!,conjoin(V1P,V2P,CP).
cycLToMpred0((V1 , V2),CP):-!,cycLToMpred0(V1,V1P),cycLToMpred0(V2,V2P),!,conjoin(V1P,V2P,CP).
cycLToMpred0([V1 | V2],CP):-!,cycLToMpred0(V1,V1P),cycLToMpred0(V2,V2P),!,conjoin(V1P,V2P,CP).
cycLToMpred0(V,V).

%  cycLToMpred( (grandparent('$VAR'('G'),'$VAR'('C')) => thereExists('$VAR'('P'), and(parent('$VAR'('G'),'$VAR'('P')),parent('$VAR'('P'),'$VAR'('C'))))),O).



% :-onEachLoad(loadTinyAssertions2).

% ============================================
% DBASE to Cyc Predicate Mapping
% ============================================
/*
arity('abbreviationString-PN', 2).

typical_mtvars([_,_]).

% arity 1 person
make_functorskel(Person,1,fskel(Person,t(Person,A),Call,A,[],MtVars,Call2)):-typical_mtvars(MtVars),Call=..[Person,A],Call2=..[Person,A|MtVars]. 
% arity 2 likes
make_functorskel(Likes,2,fskel(Likes,t(Likes,A,B),Call,A,B,MtVars,Call2)):- typical_mtvars(MtVars),Call=..[Likes,A,B],Call2=..[Likes,A,B|MtVars]. 
% arity 3 between
make_functorskel(Between,3,fskel(Between,t(Between,A,B,C),Call,A,[B,C],MtVars,Call2)):- typical_mtvars(MtVars),Call=..[Between,A,B,C],Call2=..[Between,A,B,C|MtVars]. 
% arity 4 xyz
make_functorskel(Xyz,4,fskel(Xyz,t(Xyz,I,X,Y,Z),Call,I,[X,Y,Z],MtVars,Call2)):- typical_mtvars(MtVars),Call=..[Xyz,I,X,Y,Z],Call2=..[Xyz,I,X,Y,Z|MtVars]. 
% arity 5 rxyz
make_functorskel(RXyz,5,fskel(RXyz,t(RXyz,I,R,X,Y,Z),Call,I,[R,X,Y,Z],MtVars,Call2)):-typical_mtvars(MtVars),Call=..[RXyz,I,R,X,Y,Z],Call2=..[RXyz,I,R,X,Y,Z|MtVars]. 
% arity >6 
make_functorskel(F,N,fskel(F,DBASE,Call,I,NList,MtVars,Call2)):-typical_mtvars(MtVars),functor(Call,F,N),Call=..[F,I|NList],DBASE=..[t,F,I|NList],append([F,I|NList],MtVars,CALL2List),Call2=..CALL2List.

*/

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

:-dynamic(isCycUnavailable_known/1).
:-dynamic(isCycAvailable_known/0).

:-export(isCycAvailable/0).
isCycAvailable:-isCycUnavailable_known(_),!,fail.
isCycAvailable:-isCycAvailable_known,!.
isCycAvailable:-checkCycAvailablity,isCycAvailable.

:-export(isCycUnavailable/0).
isCycUnavailable:-isCycUnavailable_known(_),!.
isCycUnavailable:-isCycAvailable_known,!,fail.
isCycUnavailable:-checkCycAvailablity,isCycUnavailable.

:-export(checkCycAvailablity/0).
checkCycAvailablity:- (isCycAvailable_known;isCycUnavailable_known(_)),!.
checkCycAvailablity:- ccatch((ignore((invokeSubL("(+ 1 1)",R))),(R==2->assert_if_new(isCycAvailable_known);assert_if_new(isCycUnavailable_known(R)))),E,assert_if_new(isCycUnavailable_known(E))),!.





