% =======================================================
/** <module> 
% This is mainly used by the moo_loader but also needed everywhere
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/
% =======================================================
/*
:-swi_module(dbase_formattypes, [
          any_to_dir_ns/2,
          any_to_number/2,
          any_to_value/2,
          argIsa_call/4,
          argIsa_call_0/3,
          atom_to_value/2,
         % formattype/1,
          term_is_ft/2,
          pl_arg_type/2,
          p2c_dir2/2
          ]).
*/

:- include(logicmoo('vworld/moo_header.pl')).


:-decl_type(tFormattype).
:-decl_type(tValuetype).

capAtom(Type):-name(Type,[S|_]),char_type(S,upper).

% TODO OPTIMISE
:-export(typename_to_iname/3).
typename_to_iname(I,OType,IType):-atom_concat(act,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,OType,IType):-atom_concat(cmd,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,OType,IType):-atom_concat(mud,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,OType,IType):-atom_concat(prop,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,OType,IType):-atom_concat(vt,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,OType,IType):-atom_concat(ft,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,OType,IType):-atom_concat(t,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,OType,IType):-atom_concat(i,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,OType,IType):-atom_concat(v,Type,OType),capAtom(Type),typename_to_iname(I,Type,IType),!.
typename_to_iname(I,Type,IType):-atom_concat(I,Type,IType).


:-export(split_name_type/3).
:- '$hide'(split_name_type/3).
split_name_type(Suggest,InstName,Type):- must_det(split_name_type_0(Suggest,NewInstName,NewType)),!,must((NewInstName=InstName,NewType=Type)),!.

split_name_type_0(S,P,C):- string(S),!,atom_string(A,S),split_name_type_0(A,P,C),!.
split_name_type_0(FT,FT,tFormattype):-tFormattype(FT),dmsg(trace_or_throw(tFormattype(FT))),fail.
split_name_type_0(T,T,C):- compound(T),functor(T,C,_),!.
split_name_type_0(T,T,C):- notrace((once(atomic_list_concat_safe([CO,'-'|_],T)),atom_string(C,CO))).
split_name_type_0(T,T,C):- notrace((atom(T),atom_codes(T,AC),last(AC,LC),is_digit(LC),append(Type,Digits,AC),ccatch(number_codes(_,Digits),_,fail),atom_codes(CC,Type),!,typename_to_iname(t,CC,C))).
split_name_type_0(C,P,C):- var(P),atom(C),typename_to_iname(i,C,I),gensym(I,P),!.

% formattype(S):-   is_asserted(ft_info(S,_)).
% formattype(S):-   is_asserted(subft(S,_)).

formattype_guessable(S):- mudFtInfo(S,_).

term_is_ft(Term,Type):- var(Type),var(Term),!,member(Type,[var,prolog]).
term_is_ft(Term,Type):- var(Term),!,member(Type,[var,ftTerm,prolog]).
term_is_ft(Term,Type):- nonvar(Term),var(Type),!,formattype_guessable(Type),term_is_ft(Term,Type).
term_is_ft(Term,Type):- must_det(tFormattype(Type)),
   once(trans_subft_info(Type,How)),   
   correctFormatType(query(_HLDS,_OldV),Term,How,NewTerm),!,
   sameArgTypes(NewTerm,Term).

ft_info_how(FT,tFormatted(FT)):-mudFtInfo(FT,tFormatted).
ft_info_how(FT,self_call(Info)):-mudFtInfo(FT,Info),Info\=tFormatted.

trans_subft_info(FT,Info):-ft_info_how(FT,Info).
trans_subft_info(FT,Info):-trans_subft(Sub,FT),ft_info_how(Sub,Info),!.
trans_subft_info(FT,Info):-trans_subft(FT,Sub),ft_info_how(Sub,Info),!.
trans_subft(FT,Sub):-mudSubft(FT,Sub).
trans_subft(FT,Sub):-mudSubft(FT,A),mudSubft(A,Sub).
trans_subft(FT,Sub):-mudSubft(FT,A),mudSubft(A,B),mudSubft(B,Sub).

sameArgTypes(A,C):-same(A,C);(pl_arg_type(C,CT),pl_arg_type(A,AT),!,colsOverlap(AT,CT)).
colsOverlap(AT,AT).

pl_arg_type_or_functor(Arg,Type):- pl_arg_type(Arg,T) , (T==compound -> functor(Arg,Type,_); ( (T==ftList,T=[_|_])-> T=[Type|_] ;Type=T)) .

pl_arg_type(Arg,Type):- 
      var(Arg) -> Type =var;
      integer(Arg) -> Type =integer;
      number(Arg) -> Type =float;
      string(Arg) -> Type =string;
      atom(Arg) -> Type =atom;
      is_list(Arg) -> Type =ftList;
      compound(Arg) -> Type =compound;
         Arg = Type.

mpred_arity_pred(P):- nonvar(P),arg(_,a(arity,arityMax,arityMin),P).
mpred_arity_pred(mpred_arity).

as_one_of(Types,Type):-nonvar(Type),tCol(Type),!,member(Type,Types).
as_one_of([Type],TypeO):-!,same_arg(same_or(mudSubclass),Type,TypeO).
as_one_of(Types,oneOf(Types)).


argIsa_call(Op,_:F,N,Type):-!,argIsa_call(Op,F,N,Type),!.
argIsa_call(Op,F/_,N,Type):- !,argIsa_call(Op,F,N,Type),!.
argIsa_call(Op,Func,N,Type):- compound(Func),!,functor(Func,F,_),argIsa_call(Op,F,N,Type),!.
argIsa_call(Op,F,N,Type):-hotrace((loop_check((argIsa_call_nt(Op,F,N,Type),!),Type=ftTerm),must(nonvar(Type)))).

argIsa_call_nt(_O,F,N,Type):-argIsa_call_nt(F,N,Type).

:-decl_mpred_hybrid(argIsa/3).


argIsa(F,N,Isa):-argIsa_call(F,N,Isa).

:-swi_export(argIsa_call/3).
argIsa_call(F,N,Type):- argIsa_call_0(F,N,Type),!.
argIsa_call(F,N,Type):- argIsa_asserted(F,N,Type),!.
argIsa_call(F,N,Type):- argIsa_call_1(F,N,Type),!.


argIsa_call_nt(F,N,Type):- once(var(F);not(number(N))),dtrace,once(var(F);not(number(N))),trace_or_throw(once(var(F);not(number(N)))->argIsa_call(F,N,Type)).
argIsa_call_nt(F,N,Type):- argIsa_call(F,N,Type),!.
argIsa_call_nt(F,N,Type):- findall(T,argIsa_call_0(F,N,Type),T),Types=[_|_],!,as_one_of(Types,Type),!.


:-dynamic_multifile_exported(argIsa_call_0/3).
argIsa_call_0(argIsa,1,tRelation).
argIsa_call_0(argIsa,2,ftInt).
argIsa_call_0(argIsa,3,tCol).
argIsa_call_0(comment,2,string).
argIsa_call_0(directions,2,ftList(vtDirection)).
argIsa_call_0(mudFacing,1,tObj).
argIsa_call_0(mudFacing,2,vtDirection).
argIsa_call_0(mudColor,1,tObj).
argIsa_call_0(mudColor,2,color_value).
argIsa_call_0(mudFtInfo,1,tFormattype).
argIsa_call_0(mudFtInfo,2,ftTerm).
argIsa_call_0(localityOfObject,1,tObj).
argIsa_call_0(localityOfObject,2,tSpatialthing).
argIsa_call_0(mudIsa,1,ftTerm).
argIsa_call_0(mudIsa,2,tCol).
argIsa_call_0(mudMemory,2,ftTerm).
argIsa_call_0(mpred_prop,1,tMpred).
argIsa_call_0(mpred_prop,2,ftVoprop).
argIsa_call_0(predicates,1,ftList(ftTerm)).
argIsa_call_0(resultIsa,2,tCol).
argIsa_call_0(type_max_charge,1,tCol).
argIsa_call_0(type_max_charge,2,ftInt).
argIsa_call_0(type_max_health,1,tCol).
argIsa_call_0(type_max_health,2,ftInt).
argIsa_call_0(ask_module,1,tMpred).
argIsa_call_0(ask_module,2,atom).
argIsa_call_0(agent_text_command,ftTerm).
argIsa_call_0(equivRule,ftTerm).
argIsa_call_0(F,N,Type):-between(1,2,N),argIsa_call_3(F,Type).
argIsa_call_0(class_template,N,Type):- (N=1 -> Type=tCol;Type=ftList(ftVoprop)).
argIsa_call_0(Arity,N,T):-mpred_arity_pred(Arity),!,arg(N,vv(tMpred,ftInt,tCol),T).
argIsa_call_0(F,2,string):-member(F,[descriptionHere,nameStrings,mudKeyword]).
argIsa_call_0(F,N,Type):-colDeclarer(F),!,(N=1 -> Type=F ; Type=ftTerm(ftVoprop)).

argIsa_call_3(WP,tMpred(arity(2))):-member(WP,[retract_with_pred,mudAssertWithPred,query_with_pred,genlPreds,genlInverse]).
argIsa_call_3(disjointWith,tCol).
argIsa_call_3(mudTermAnglify,ftTerm).
argIsa_call_3(mudFacing,ftTerm).
argIsa_call_3(tFormatted,ftTerm).
argIsa_call_3(mudSubclass,tCol).
argIsa_call_3(mudSubft,tFormattype).

% argIsa_call_0(HILOG,_,term):-hilog_functor(HILOG).

argIsa_asserted(F,N,Type):- dbase_t(argIsa,F,N,Type),!.
argIsa_asserted(F,N,Type):- argIsa_call_0(F,N,Type),!.
argIsa_asserted(F,N,Type):- get_mpred_prop(F,argIsa(N,Type)),nonvar(Type),add(argIsa(F,N,Type)),!.
argIsa_asserted(F,N,Type):- grab_argsIsa(F,Types),arg(N,Types,Type),nonvar(Type),add(argIsa(F,N,Type)),!.
argIsa_asserted(F,N,Type):- grab_argsIsa2(F,Types),arg(N,Types,Type),nonvar(Type),!.

grab_argsIsa(resultIsa,resultIsa(tFpred,tCol)).
% grab_argsIsa(F,Types):- call_typelect([flag(+firstValue),+debugOnError,+deducedSimply],mpred_prop(F,argsIsaInList(Types))).
grab_argsIsa(F,Types):- mpred_prop(F,argsIsaInList(Types)).
grab_argsIsa(F,Types):- is_asserted(argsIsaInList(F,Types)).
grab_argsIsa2(F,Types):- fail,deducedSimply(mpred_prop(F,argsIsaInList(Types))).

argIsa_call_1(Var,2,ftTerm):-tCol(Var),trace_or_throw( argIsa_call_1(Var,2,ftTerm)),fail.
argIsa_call_1(Prop,N1,Type):- is_2nd_order_holds(Prop),dmsg(todo(define(argIsa_call(Prop,N1,'Second_Order_TYPE')))),dumpST,dtrace,
   Type=argIsaFn(Prop,N1).
argIsa_call_1(F,_,ftTerm(prolog)):-member(F/_,
                                [
                                argIsa/3,
                                mudAssertWithPred/2,
                                 negate_wrapper0/2,
                                registered_module_type/2,       
                                hybrid_rule/2,
                                formatted_resultIsa/2,
                                bracket/3]).
argIsa_call_1(Prop,N1,Type):- dmsg(todo(define(argIsa_call(Prop,N1,'_TYPE')))),must( Type=argIsaFn(Prop,N1)).
argIsa_call_1(_,_,ftTerm).
argIsa_call_1(mudFacing,_,ftTerm).

:-swi_export(db_quf/4).
db_quf(Op,M:C,Pretest,Template):-var(C),!,throw(var(db_quf(Op,M:C,Pretest,Template))).
db_quf(Op,_:C,Pretest,Template):-nonvar(C),!,db_quf(Op,C,Pretest,Template).
db_quf(Op,','(C,D),','(C2,D2),','(C3,D3)):-!,db_quf(Op,C,C2,C3),db_quf(Op,D,D2,D3).
db_quf(Op,C,Pretest,Template):- C=..[Holds,OBJ|ARGS],is_holds_true(Holds),atom(OBJ),!,C1=..[OBJ|ARGS],db_quf(Op,C1,Pretest,Template).
db_quf(_Op,C,true,C):- C=..[Holds,OBJ|_],is_holds_true(Holds),var(OBJ),!.
db_quf(Op,C,Pretest,Template):- C=..[Prop,OBJ|ARGS],
      functor(C,Prop,A),
      translate_args(Op,Prop,A,OBJ,2,ARGS,NEWARGS,true,Pretest),
      Template =.. [Prop,OBJ|NEWARGS].

translate_args(_O,_Prop,_A,_OBJ,_N,[],[],GIN,GIN).
translate_args(Op,Prop,A,OBJ,N1,[ARG|S],[NEW|ARGS],GIN,GOALS):-
   must(argIsa_call(Op,Prop,N1,Type)),
   translateOneArg(Op,Prop,OBJ,Type,ARG,NEW,GIN,GMID),
   N2 is N1 +1,
   translate_args(Op,Prop,A,OBJ,N2,S,ARGS,GMID,GOALS).

:-swi_export(infix_op/2).
infix_op(OP,_):-comparitiveOp(OP).
infix_op(OP,_):-additiveOp(OP).

:-swi_export(comparitiveOp/1).
comparitiveOp((\=)).
comparitiveOp((\==)).
comparitiveOp((=)).
comparitiveOp((=:=)).
comparitiveOp((==)).
comparitiveOp((<)).
comparitiveOp((>)).
comparitiveOp((=<)).
comparitiveOp((>=)).

:-swi_export(additiveOp/1).
additiveOp((is)).
additiveOp((*)).
additiveOp(+).
additiveOp(-).
additiveOp((/)).

% var
translateOneArg(_Op,_Prop,_Obj,_Type,VAR,VAR,G,G):-var(VAR),!.

% not an expression
translateOneArg(_O,_Prop,_Obj,_Type,ATOMIC,ATOMIC,G,G):-atomic(ATOMIC),!.
% translateOneArg(_O,_Prop,_Obj,Type,ATOMIC,ATOMICUSE,G,(G,same_arg(col(Type),ATOMIC,ATOMICUSE))):-atomic(ATOMIC),!.

% translateOneArg(_O,_Prop,_Obj,Type,VAR,VAR,G,G):-ignore(isa(VAR,Type)),!.

% props(Obj,size < 2).
translateOneArg(_O,Prop,Obj,Type,ARG,OLD,G,(GETTER,COMPARE,G)):-
       functor(ARG,F,2), comparitiveOp(F),!,
       ARG=..[F,Prop,VAL],
       GETTER=..[Prop,Obj,OLD],
       COMPARE= compare_op(Type,F,OLD,VAL),!.

% props(Obj,oneOf(Sz,[size+1,2])).
translateOneArg(Op,Prop,O,Type,oneOf(VAL,LIST),VAL,G,(GO,G)):-
   translateListOps(Op,Prop,O,Type,VAL,LIST,G,GO).

% db_op(Op, Obj,size + 2).
translateOneArg(_O,Prop,Obj,_Type,ARG,NEW,G,(GETTER,STORE,G)):-
       functor(ARG,F,2), additiveOp(F),!,
       ARG=..[F,Prop,VAL],
       GETTER=..[Prop,Obj,OLD],
       STORE= update_value(OLD,VAL,NEW),!.

translateOneArg(_O,_Prop,_Obj,_Type,NART,NART,G,G):-!.
translateOneArg(_O,_Prop,_Obj,Type,ATOMIC,ATOMICUSE,G,(G,ignore(same_arg(tCol(Type),ATOMIC,ATOMICUSE)))).

translateListOps(_O,_Prop,_Obj,_Type,_VAL,[],G,G).
translateListOps(Op,Prop,Obj,Type,VAL,[L|LIST],G,GO2):-
   translateOneArg(Op,Prop,Obj,Type,L,VAL,G,GO),
   translateListOps(Op,Prop,Obj,Type,VAL,LIST,GO,GO2).

compare_op(Type,F,OLD,VAL):-nop(Type),show_call((call(F,OLD,VAL))),!.

% start of database
% These will all be deleted at start of run

:-swi_export(inverse_args/2).
inverse_args([AR,GS],[GS,AR]):-!.
inverse_args([AR,G,S],[S,G,AR]):-!.
inverse_args([A,R,G,S],[S,R,G,A]):-!.
inverse_args([P,A,R,G,S],[S,A,R,G,P]):-!.

% =======================================================
% correctArgsIsa/3
% =======================================================


decl_coerce(A,Type,AA):- correctAnyType(change(_,_),A,Type,AA).

:-swi_export(same_vars/2).
same_vars(T1,T2):-term_variables(T1,V1),term_variables(T2,V2),!,V1==V2.

:-swi_export(correctArgsIsa/2).
correctArgsIsa(In,Out):- correctArgsIsa(query(must,dbase_t),In,Out),!.

:-swi_export(correctArgsIsa/3).
correctArgsIsa(_,A,A):- bad_idea,!.
% correctArgsIsa(_,A,A):- is_release,!.
correctArgsIsa(_,NC,NC):-not(compound(NC)),!.
correctArgsIsa(Op,M:A,MAA):- nonvar(M),!,correctArgsIsa(Op,A,AA),M:AA=MAA.
correctArgsIsa(_Op,G,G):- functor(G,F,A),arg(_,vv(mudSubclass/_,mudIsa/_,':-'/_
                                                               ),F/A),!.

correctArgsIsa(_,A,A):- need_to_be_fast, !.
correctArgsIsa(change(assert, add),A,AA):-true, ground(A),!,must(A=AA).
correctArgsIsa(Op,A,AA):- correctArgsIsa0(Op,A,AA),nonvar(AA),!.
correctArgsIsa(Op,A,AA):- grtrace,correctArgsIsa0(Op,A,AA).

:-swi_export(correctArgsIsa/4).
correctArgsIsa(Op,A,Type,AA):- trace_or_throw(warn(not(correctArgsIsa(Op,A,Type,AA)))).

need_to_be_fast.

list_to_callform([P|ARGS],_,CALL):-atom(P),!,CALL=..[P|ARGS].
list_to_callform(ARGS,Functor,CALL):-CALL=..[Functor|ARGS].

correctArgsIsa0(Op,[PRED|ARGS],RESULT):-!,correctArgsIsa00(Op,[PRED|ARGS],RESULT).
correctArgsIsa0(Op,A,RESULTC):-A=..[PRED|ARGS],!,correctArgsIsa00(Op,[PRED|ARGS],RESULT), list_to_callform(RESULT,dbase_t,RESULTC).

correctArgsIsa00(_ ,[Prop|Args],AA):-stack_check(1000), var(Prop),!,AA=[Prop|Args].
correctArgsIsa00(Op,[KP,Prop|Args],AA):-is_holds_true(KP),!,correctArgsIsa00(Op,[Prop|Args],AA).
correctArgsIsa00(Op,[KP,Prop|Args],[KP|AArgs]):-logical_functor(KP),!,correctAnyType(Op,[Prop|Args],ftList(askable),AArgs).
correctArgsIsa00(Op,[KP,Prop|Args],[KP|AA]):-is_holds_false(KP),!,correctArgsIsa00(Op,[KP,Prop|Args],AA).
correctArgsIsa00(_ ,[Prop,Arg],[Prop,Arg]):- !.
correctArgsIsa00(Op,[Prop,ArgI],[Prop,ArgO]):- !, correctAnyType(Op,ArgI,Prop,ArgO).
correctArgsIsa00(Op,[Prop|Args],[Prop|AArgs]):- discoverAndCorrectArgsIsa(Op,Prop,1,Args,AArgs).

discoverAndCorrectArgsIsa(_O,_Prop,_N1,[],[]):-!.
discoverAndCorrectArgsIsa(Op,Prop,N1,[A|Args],Out):-
   must((argIsa_call(Op,Prop,N1,Type),correctAnyType(Op,A,Type,AA))),
   N2 is N1+1,
   discoverAndCorrectArgsIsa(Op,Prop,N2,Args,AArgs),
    Out = [AA|AArgs].

:-swi_export(correctAnyType/4).

% correctAnyType(_,A,_,A):-is_release.

correctAnyType(_Op,A,_Type,AA):- var(A),!,must_det(var(AA)),must_det(A=AA),!.
correctAnyType(Op,A,Type,AA):- var(A),correctType(Op,A,Type,AA),must_det(var(AA)),must_det(A==AA),!.
correctAnyType(Op,A,Type,AA):- var(Type),trace_or_throw(correctAnyType(Op,A,Type,AA)).
% TODO snags on new tpyes correctAnyType(Op,A,Type,AA):- correctType(Op,A,Type,AA),nonvar(AA),!.
correctAnyType(Op,A,Type,AA):- one_must(correctType(Op,A,Type,AA),A=AA).
correctAnyType(Op,A,Type,A):- dtrace,dmsg(warn(not(correctAnyType(Op,A,Type)))).

%  @set movedist 4

:-swi_export(correctFormatType/4).
correctFormatType(Op,A,Type,AA):- var(A),correctType(Op,A,Type,AA),must_det(var(AA)),must_det(A==AA),!.
correctFormatType(Op,A,Type,AA):- var(Type),trace_or_throw(correctFormatType(Op,A,Type,AA)).
correctFormatType(Op,A,Type,AA):- correctType(Op,A,Type,AA),nonvar(AA),!.
correctFormatType(Op,A,Type,AA):- grtrace,correctType(Op,A,Type,AA).
correctFormatType(Op,A,Type,A):- dmsg(todo(not(correctFormatType(Op,A,Type)))).

:-swi_export(checkAnyType/4).

checkAnyType(Op,A,Type,AA):- var(A),correctType(Op,A,Type,AA),must_det(var(AA)),must_det(A==AA),!.
checkAnyType(Op,A,Type,AA):- correctType(Op,A,Type,AA),nonvar(AA),!.

:-decl_thlocal thlocal:can_coerce/1.
correctType_gripe(Op,A,Fmt,AA):- tFormattype(Fmt),!,trace_or_throw(correctType(is_ft_correctFormatType(Op,A,Fmt,AA))).
correctType_gripe(Op,A,Type,AA):- fail,atom(Type),must_equals(A,AA),
      dmsg(todo(isa_assert_type(Type))),
      % decl_type(Type),
      thlocal:can_coerce(Op),dmsg(warning(add(mudIsa(A,Type)))),dtrace,
      add(mudIsa(A,Type)),!.

correctType_gripe(Op,A,C,A):-must(ground(A)),dtrace, dmsg(todo(define(correctType(Op,A,C,'ConvertedArg')))),throw(retry(_)).
correctType_gripe(Op,A,Type,NewArg):-trace_or_throw(failure(correctType(Op,A,Type,NewArg))).

:- style_check(+singleton).

correctType(Op,A,Type,AA):- var(Type),trace_or_throw(correctType(Op,A,Type,AA)).
correctType(_O,A,Type,AA):- (var(A);var(Type)),!, must(must_equals(A,AA)).

correctType(Op,A,'&'(Type1,Type2),AA):-var(Type2),!,correctType(Op,A,Type1,AA).
correctType(Op,A,'&'(Type1,Type2),AAA):-!,correctType(Op,A,Type1,AA),correctType(Op,AA,Type2,AAA).

correctType(Op,+A,Type,+AA):-nonvar(A),!,correctType(Op,A,Type,AA).
correctType(Op,-A,Type,-AA):-nonvar(A),!,correctType(Op,A,Type,AA).
correctType(_O,A,vtDirection,AA):- any_to_dir(A,AA).
correctType(Op,A,integer,AA):-!,correctType(Op,A,ftInt,AA).
correctType(Op,A,askable,AA):-!,correctArgsIsa(Op,A,AA).

correctType(_O,A,ftInt,AA):- any_to_number(A,AA).
correctType(_O,A,number,AA):- must(any_to_number(A,AA)).
correctType(_O,A,prolog,AA):- must_equals(A,AA).
correctType(_O,A,string,AA):- must(any_to_string(A,AA)).
correctType(_O,A,ftTerm(_),AA):- must_equals(A,AA).
correctType(_O,Obj,argIsaFn(Prop,N),AA):-must_equals(Obj,AA),
   ignore((thlocal:deduceArgTypes(_),findall(OT,mudIsa(Obj,OT),OType),
         show_call(deduce_argN(Prop,N,Obj,OType,argIsaFn(Prop,N))))),!.
correctType(_O,A,ftTerm,AA):- must_equals(A,AA).
correctType(_O,A,ftText,AA):- must_equals(A,AA).

correctType(_O,A,tMpred,AA):- any_to_relation(A,AA).
correctType(_O,A,tFpred,AA):- any_to_relation(A,AA).
correctType(_O,A,tPred,AA):- any_to_relation(A,AA).

correctType(_O,A,tRelation,AA):- any_to_relation(A,AA).
correctType(_O,A,tFormatted,AA):- dtrace, must_equals(A,AA).
correctType(_O,A,atom,AA):- any_to_atom(A,AA).
correctType(change(_,_),A,tCol,AA):- atom(A),decl_type(A),must_equals(A,AA).
correctType(_O,A,tVerb,AA):- must_equals(A,AA).
correctType(_O,A,Type,AA):- compound(A),not(is_list(A)),atom(Type),functor_safe(A,Type,_), must_equals(A,AA).

correctType(_O,A,Type,AA):- compound(Type),contains_var(Type,self),predicate_property(Type,_),!,
   subst(Type,self,A,Call1),
   subst(Call1,value,AA,Call2),!,
      show_call(Call2),ignore(AA=A).

correctType(query(HLDS,Must),A,xyzFn(Region, ftInt, ftInt, ftInt),xyzFn(AA, _, _, _)):-atom(A),correctAnyType(query(HLDS,Must),A,Region,AA).
correctType(_Op,A,ftList(_),AA):- A == [],!,A=AA.
correctType(Op,[A|AA],ftList(T),[L|LIST]):-!, correctType(Op,A,T,L), correctType(Op,AA,ftList(T),LIST).
correctType(Op,A,ftList(T),[OT]):-!,correctAnyType(Op,A,T,OT).
correctType(_O,A,same(T),AA):-must_equals(T,AA),must_equals(A,AA).
correctType(Op,A,oneOf(List),AA):-!,member(Type,List),correctType(Op,A,Type,AA).

correctType(_O,A,self_call(Call),AA):-subst(Call,self,A,NewCall),!,NewCall,must_equals(A,AA).

correctType(_O,[],tFormatted([]),[]):-!.
correctType(Op,[H|T],tFormatted([H2|T2]),[H3|T3]):-
   correctType(Op,H,H2,H3),
   correctType(Op,T,tFormatted(T2),T3).

correctType(Op,Args,tFormatted(Types),NewArgs):- compound(Args),compound(Types),
   functor(Args,F,N),functor(Types,F,N),functor(NewArgs,F,N),
   Args=..[F|ArgsL],
   Types=..[F|TypesL],
   NewArgs=..[F|NewArgsL],!,   
   correctType(Op,ArgsL,TypesL,NewArgsL).

correctType(Op,[A|AA],ftList(T),LIST):-!,findall(OT,((member(O,[A|AA]),correctAnyType(Op,O,T,OT))),LIST).
correctType(Op,A,ftList(T),[OT]):-!,correctAnyType(Op,A,T,OT).
correctType(_O,[],[],[]):-!.
correctType(Op,[H|T],[H2|T2],[H3|T3]):-!, correctAnyType(Op,H,H2,H3),correctType(Op,T,T2,T3).

correctType(Op,Args,Types,NewArgs):-compound(Args), compound(Types),
   functor(Args,F,N),functor(Types,F,N),functor(NewArgs,F,N),
   Args=..[F|ArgsL],
   Types=..[F|TypesL],
   NewArgs=..[F|NewArgsL],
   correctAnyType(Op,ArgsL,TypesL,NewArgsL).





correctType(Op,A,Fmt,AA):- mudFtInfo(Fmt,tFormatted),!,correctFormatType(Op,A,tFormatted(Fmt),AA).
correctType(_O,A,Fmt,A):- mudFtInfo(Fmt,Code),!,subst(Code,self,A,Call),with_assertions(thlocal:no_arg_type_error_checking,show_call_failure(req(Call))).   
correctType(Op,A,Super,AA):- tFormattype(Super),req(mudSubft(Sub,Super)),Sub\=Super,correctType(Op,A,Sub,AA).

correctType(Op,Arg,Props,NewArg):- compound(Props),
   Props=..[F|TypesL],
   C=..[F,Arg|TypesL],
   correctArgsIsa(Op,C,CC),
   CC=..[F,NewArg|_].

correctType(_O,A,Type,AA):-not(tFormattype(Type)),tCol(Type),mudIsa(A,Type),!,must_equals(A,AA).



% :- style_check(+singleton).

must_equals(A,AA):-must_det(A=AA).

  
:- style_check(+singleton).

:-swi_export(any_to_value/2).
any_to_value(Var,Var):-var(Var),!.
any_to_value(V,Term):-atom(V),!,atom_to_value(V,Term).
any_to_value(A,V):-any_to_number(A,V).
any_to_value(A,A).


:-swi_export(any_to_number/2).
any_to_number(N,N):- number(N),!.
any_to_number(ftDice(A,B,C),N):- ground(A),roll_dice(A,B,C,N),!.
any_to_number(A,N):-atom(A),atom_to_value(A,V),A\=V,any_to_number(V,N).
any_to_number(A,N):- ccatch(number_string(N,A),_,fail).

:-swi_export(atom_to_value/2).
atom_to_value(V,Term):-not(atom(V)),!,any_to_value(V,Term).
% 56
atom_to_value(V,Term):- ccatch((read_term_from_atom(V,Term,[variable_names([])])),_,fail),!.
% 18d18+4000
atom_to_value(V,ftDice(T1,T2,+T3)):- atomic_list_concat_safe([D1,'d',D2,'+',D3],V), atom_to_value(D1,T1),atom_to_value(D2,T2),atom_to_value(D3,T3),!.
atom_to_value(V,ftDice(T1,T2,-T3)):- atomic_list_concat_safe([D1,'d',D2,'-',D3],V), atom_to_value(D1,T1),atom_to_value(D2,T2),atom_to_value(D3,T3),!.



any_to_relation(A,F):-atomic(A),!,any_to_atom(A,F).
any_to_relation(A,F):-functor_h(A,F).

roll_dice(Rolls,_,Bonus,Result):- Rolls < 0, !, Result is Bonus.
roll_dice(Rolls,Sided,Bonus,Result):- LessRolls is Rolls-1, roll_dice(LessRolls,Sided, Bonus + random(Sided) +1, Result).



learnArgIsa(P,N,_):-argIsa_asserted(P,N,_),!.
learnArgIsa(P,N,T):-dmsg((skipping(learnArgIsa(P,N,T)))),!.
learnArgIsa(P,N,T):-grtrace, add(argIsa(P,N,T)).

learnArgIsaInst(K,Num,Arg):-integer(Arg),!,learnArgIsa(K,Num,ftInt).
learnArgIsaInst(K,Num,Arg):-number(Arg),!,learnArgIsa(K,Num,number).
learnArgIsaInst(_,_,_).



deduce_facts(Fact,mudIsa(Arg,Type)):- slow_kb_op(deduce_argIsa_facts(Fact,Arg,Type)).

call_argIsa_ForAssert(F,N,Type):-argIsa_call(F,N,Type),atom(Type),!,not(nonusefull_deduction_type(Type)),tCol(Type).

nonusefull_deduction_type(ftTerm).
nonusefull_deduction_type(ftVoprop).
nonusefull_deduction_type(vtDirection).
nonusefull_deduction_type(Type):-createableType(Type),!,fail.
nonusefull_deduction_type(tObj).
nonusefull_deduction_type(Type):-is_asserted(tFormattype(Type)).

assert_deduced_arg_isa_facts(Fact):- !, ignore(((ground(Fact),forall(deduce_argIsa_facts(Fact,Arg,Type),add(mudIsa(Arg,Type)))))).

assert_deduced_arg_isa_facts(Fact):- slow_kb_op(assert_deduced_arg_isa_facts_0(Fact)),!.
assert_deduced_arg_isa_facts_0(Fact):- ignore(((ground(Fact),forall(deduce_argIsa_facts(Fact,Arg,Type),add(mudIsa(Arg,Type)))))).


deduce_argIsa_facts(Fact,Arg,Type):- ground(Fact), functor(Fact,F,A),A>1, deduce_from_predicate(F), arg(N,Fact,Arg),ground(Arg),
   call_argIsa_ForAssert(F,N,Type),must_det(atom(Type)),must_det(ground(Arg)).

never_deduce_from_predicate(mudIsa).
never_deduce_from_predicate(mpred_prop).
never_deduce_from_predicate(mpred_arity).
never_deduce_from_predicate(mudSubclass).
never_deduce_from_predicate(default_type_props).
never_deduce_from_predicate(P):-mpred_arity(P,1).
never_deduce_from_predicate(P):-mpred_prop(P,prologCall).
never_deduce_from_predicate(P):-argIsa_asserted(P,_,tCol).
never_deduce_from_predicate(P):-argIsa_asserted(P,_,ftVoprop).

deduce_from_predicate(Never):-never_deduce_from_predicate(Never),!,fail.
deduce_from_predicate(P):-mpred_prop(P,_).
deduce_from_predicate(_).


:- include(logicmoo('vworld/moo_footer.pl')).
