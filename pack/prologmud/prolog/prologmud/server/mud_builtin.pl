/** <module>
% ===================================================================
% File 'logicmoo_i_builtin.pl'
% Purpose: Emulation of OpenCyc for SWI-Prolog
% Maintainer: Douglas Miles
% Contact: $Author: dmiles $@users.sourceforge.net ;
% Version: 'interface' 1.0.0
% Revision: $Revision: 1.9 $
% Revised At: $Date: 2002/06/27 14:13:20 $
% ===================================================================
% File used as storage place for all predicates which change as
% the world is run.
%
% props(Obj,height(ObjHt)) == holds(height,Obj,ObjHt) == rdf(Obj,height,ObjHt) == height(Obj,ObjHt)
% padd(Obj,height(ObjHt)) == padd(height,Obj,ObjHt,...) == moo(QueryForm)
% kretract[all](Obj,height(ObjHt)) == kretract[all](Obj,height,ObjHt) == pretract[all](height,Obj,ObjHt) == del[all](QueryForm)
% keraseall(AnyTerm).
%
%
% Dec 13, 2035
% Douglas Miles
*/

:-assert_until_end_of_file(infSupertypeName).
:-onEndOfFile(dmsg(infSupertypeName)).
:- pfc_begin.

:- op(500,fx,'~').
:- op(1050,xfx,('=>')).
:- op(1050,xfx,'<=>').
:- op(1050,xfx,('<=')).
:- op(1100,fx,('=>')).
:- op(1150,xfx,('::::')).
tCol(meta_argtypes).
tCol(functorDeclares).
tCol(prologMultiValued).
tCol(prologSingleValued).
tCol(tCol).
tCol(tFunction).
tCol(tInferInstanceFromArgType).
tCol(tPred).
tCol(tRelation).
tCol(meta_argtypes).
tCol(ttSpatialType).
tCol(ttTypeType).


tCol(tWorld).
tWorld(iWorld7).

tCol(ftProlog).

tCol(tWorld).
isa(iWorld7,tWorld).

% => neg(arity(bordersOn,1)).

%user:ruleRewrite(isa(isInstFn(Sub),Super),genls(Sub,Super)):-ground(Sub:Super),!.



%:-rtrace.
typeGenls(tAgent,ttAgentType).
%:-nortrace.
typeGenls(tItem,ttItemType).
typeGenls(tObj,ttObjectType).
typeGenls(tPred,ttPredType).
typeGenls(tRegion,ttRegionType).
typeGenls(ttAgentType,tAgent).
typeGenls(ttFormatTypeType,ttFormatType).
typeGenls(ttItemType,tItem).
typeGenls(ttObjectType,tObj).
typeGenls(ttPredType,tPred).
typeGenls(ttRegionType,tRegion).
typeGenls(ttSpatialType,tSpatialThing).
genls(tSpatialThing,tTemporalThing).
genls(ttSpatialType,ttTemporalType).
 
ttUnverifiableType(ftDice).
ttUnverifiableType(vtDirection).

((typeGenls(TypeType,Super), genls(Type,Super)) => isa(Type,TypeType)).



/*
disjointWith(A,B):- A=B,!,fail.
disjointWith(A,B):- disjointWithT(A,B).
disjointWith(A,B):- disjointWithT(AS,BS),transitive_subclass_or_same(A,AS),transitive_subclass_or_same(B,BS).
disjointWith(A,B):- once((type_isa(A,AT),type_isa(B,BT))),AT \= BT.
*/
disjointWith(Sub, Super) => disjointWith( Super, Sub).
disjointWith(tObj,tRegion).
disjointWith(tRegion,tObj).
disjointWith(ttSpatialType,ttAbstractType).




isa(arity,tBinaryPredicate).

(arity(Pred,2),tPred(Pred)) <=> isa(Pred,tBinaryPredicate).
prologHybrid(relationMostInstance(tBinaryPredicate,tCol,vtValue)).
relationMostInstance(BP,_,_)=>(tBinaryPredicate(BP),tRolePredciate(BP)).
prologHybrid(relationAllInstance(tBinaryPredicate,tCol,vtValue)).
relationAllInstance(BP,_,_)=>tBinaryPredicate(BP).

((isa(Inst,ttSpatialType), tCol(Inst)) => genls(Inst,tSpatialThing)).

% (isa(Inst,Type), tCol(Inst)) => isa(Type,ttTypeType).
% (isa(TypeType,ttTypeType) , isa(Inst,TypeType), genls(SubInst,Inst)) => isa(SubInst,TypeType).

(ttFormatType(FT),{compound(FT)})=>meta_argtypes(FT).

=> tCol(vtDirection).

disjointWith(Sub, Super) => disjointWith( Super, Sub).
disjointWith(tObj,tRegion).
disjointWith(ttSpatialType,ttAbstractType).


genls(tPartofObj,tItem).

tSet(tPlayer).

% dividesBetween(tItem,tPathway).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tTemporalThing,tObj,tRegion).
dividesBetween(tAgent,tPlayer,tNpcPlayer).
%:-export(repl_to_string(tAgent,ftTerm)).
%:-export(repl_writer/2).
%:-export(repl_writer(tAgent,ftTerm)).
%prologHybrid(typeProps(tCol,ftVoprop)).

% defined more correctly below dividesBetween(S,C1,C2) => (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).
dividesBetween(tItem,tMassfull,tMassless).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tSpatialThing,tObj,tRegion).
formatted_resultIsa(ftDice(ftInt,ftInt,ftInt),ftInt).
(dividesBetween(tAgent,tMale,tFemale)).

% dividesBetween(tItem,tPathways).
dividesBetween(tItem,tMassfull,tMassless).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tSpatialThing,tObj,tRegion).
dividesBetween(tAgent,tPlayer,tNpcPlayer).

% dividesBetween(S,C1,C2) => (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).

% disjointWith(P1,P2) => ((neg(isa(C,P1))) <=> isa(C,P2)).

% isa(Col1, ttObjectType) => neg(isa(Col1, ttFormatType)).

=> tCol(tCol).
=> tCol(tPred).
=> tCol(tFunction).
=> tCol(tRelation).
=> tCol(ttSpatialType).
=> tCol(ttFormatType).
=> tCol(functorDeclares).
% tCol(ArgsIsa):-user:mpred_is_trigger(ArgsIsa).
% TODO decide if OK
%tCol(F):-t(functorDeclares,F).
=> tCol(ttFormatType).
=> tSpec(vtActionTemplate).
=> tCol(tRegion).
=> tCol(tContainer).

%(mpred_prop(_,meta_argtypes(ArgTypes)),{is_declarations(ArgTypes)}) => meta_argtypes(ArgTypes).


% tCol(Type),(tBinaryPredicate(Pred)/(functor(G,Pred,2),G=..[Pred,isInstFn(Type),Value])), G => relationMostInstance(Pred,Type,Value).


isa(tRegion,ttSpatialType).
isa(tRelation,ttAbstractType).

genlPreds(genls,equals).
% genls(A, B):- tCol(A),{A=B}.

% rtrace(Goal):- Goal. % (hotrace((visible(+all),visible(+unify),visible(+exception),leash(-all),leash(+exception))),(trace,Goal),leash(+all)).

% :- gutracer.


tCol(tFly).

prologHybrid(localityOfObject(tObj,tSpatialThing)).


(tCol(Inst), {isa_from_morphology(Inst,Type)}) => isa(Inst,Type).

% HOW TO MAKE THIS FAST? isa(Inst,Type) <= {isa_from_morphology(Inst,Type)}.

%((disjointWith(P1,P2) , genls(C1,P1), {dif:dif(C1,P1)}) =>    disjointWith(C1,P2)).
% (disjointWith(C1,P2) <= (genls(C1,P1), {dif:dif(C1,P1)}, disjointWith(P1,P2))).

tCol(completelyAssertedCollection).
tCol(completeIsaAsserted).
% genls(completeIsaAsserted,tSpatialThing).
genls(completelyAssertedCollection,tCol).
completelyAssertedCollection(tItem).
completelyAssertedCollection(tRegion).
completelyAssertedCollection(tObj).
% :-rtrace.
completelyAssertedCollection(tAgent).
completelyAssertedCollection(tCarryAble).
completelyAssertedCollection(vtVerb).
% :-rnotrace.

genls(ttTypeByAction,completelyAssertedCollection).

% dividesBetween(tItem,tPathway).
dividesBetween(tItem,tMassfull,tMassless).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tSpatialThing,tObj,tRegion).
dividesBetween(tAgent,tPlayer,tNpcPlayer).


((dividesBetween(S,C1,C2),{ground(S:C1:C2)}) => ((disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)))).

isa(Col1, ttObjectType) => ~isa(Col1, ttFormatType).

neg(isa(I,Super)) <= {ground(isa(I,Super))}, (isa(I,Sub), disjointWith(Sub, Super)).
% disjointWith(P1,P2) => {\+(isa(P1,ttNonGenled)),\+(isa(P2,ttNonGenled))},(neg(isa(C,P1)) <=> isa(C,P2)).


=> tCol(ttSpatialType).

% Representations
vtActionTemplate(ArgTypes)/is_declarations(ArgTypes) => meta_argtypes(ArgTypes).

meta_argtypes(ArgTypes)/get_functor(ArgTypes,F),vtVerb(F)=>vtActionTemplate(ArgTypes).



argIsa(aDirectionsFn,2,ftListFn(vtDirection)).
argIsa(apathFn,1,tRegion).
argIsa(apathFn,2,vtDirection).
argIsa(localityOfObject,1,tObj).
argIsa(localityOfObject,2,tSpatialThing).
argIsa(mudColor,1,tObj).
argIsa(mudColor,2,vtColor).
argIsa(mudFacing,1,tObj).
argIsa(mudFacing,2,vtDirection).
argIsa(mudMemory,2,ftTerm).

/*
tms_reject_why(mudAtLoc(iArea1025, _),isa(iArea1025,tRegion)).
tms_reject_why(localityOfObject(iArea1025, iOfficeRoom7),isa(iArea1025,tRegion)).
tms_reject_why(localityOfObject(R,_),isa(R,tRegion)):- isa(R,tRegion).
tms_reject_why(mudFacing(R,_),isa(R,tRegion)):- isa(R,tRegion).
tms_reject_why(mudAtLoc(R,_),isa(R,tRegion)):- isa(R,tRegion).

%deduce_facts_forward(localityOfObject(_,Region),isa(Region,tSpatialThing)).
deduce_facts_forward(localityOfObject(Obj,_),isa(Obj,tObj)).
fix_argIsa(F,N,vtDirection(Val),vtDirection):-add(user:mpred_prop(F,argSingleValueDefault(N,Val))),!.

*/

tCol(tChannel).
tCol(tItem).
tCol(vtVerb).

% predIsFlag(tAgent(ftID),[predIsFlag]).
% prologOnly(createableSubclassType/2).
% alt_forms1(none_AR,localityOfObject(P,R),mudAtLoc(P,L)):-ground(localityOfObject(P,R)),is_asserted(mudAtLoc(P,L)),nonvar(L),once(locationToRegion(L,R)).
% alt_forms1(none_AR,mudAtLoc(P,L),localityOfObject(P,R)):-ground(mudAtLoc(P,L)),once(locationToRegion(L,R)),nonvar(R).
% argsIsa(mudFacing,ftTerm).
% we need a way to call this: maxCapacity
% we need a way to call this: typeMaxCapacity
%:- compile_predicates([isa/2]).
%prologHybrid(repl_to_string(tAgent,term),[prologSingleValued,argSingleValueDefault(2,default_repl_obj_to_string)]).
% prologHybrid(repl_writer(tAgent,term),[prologSingleValued,argSingleValueDefault(2,default_repl_writer)]).
%:- forall(ttPredType(F),dynamic(F/1)).
%:- foreach(retract(isa(I,C)),assert_hasInstance(C,I)).
%isa(AT,ttAgentType):- genls(AT,ttAgentGeneric).
%genls(AT,ttAgentGeneric):- isa(AT,ttAgentType).
%subFormat(ftTextType,ftText).
predIsFlag(tItem(ftID),[predIsFlag]).
%predIsFlag(tRegion(ftID),[predIsFlag]).
predIsFlag(tRegion(ftID),tCol).
predIsFlag(tThinking(tAgent),[predIsFlag]).
prologHybrid(isEach(mudLastCommand/2,mudNamed/2, mudSpd/2,mudStr/2,typeGrid/3)).
prologHybrid(isEach((mudContains/2))).
prologHybrid(isEach((mudLastCmdSuccess/2 ))).



:- dynamic(mudDescription/2).
:- dynamic((tItem/1, tRegion/1, instVerbOverride/3,mudNamed/2, determinerString/2, mudKeyword/2 ,descriptionHere/2, mudToHitArmorClass0/2, tThinking/1, tDeleted/1, mudWeight/2, mudPermanence/3, act_term/2, mudAgentTurnnum/2, mudAtLoc/2, mudEnergy/2, mudHealth/2, mudDescription/2, mudFacing/2, mudCmdFailure/2, mudSpd/2, typeGrid/3, mudHeight/2, mudMemory/2, isa/2, pathName/3, mudPossess/2, mudScore/2, mudStm/2, mudStr/2, wearsClothing/2)).
:- dynamic((mudArmorLevel/2, mudLevelOf/2, mudToHitArmorClass0/2, mudBareHandDamage/2, chargeCapacity/2, mudEnergy/2, tCol/1, tAgent/1, tItem/1, tRegion/1, instVerbOverride/3,mudNamed/2, determinerString/2, mudKeyword/2 ,descriptionHere/2, tThinking/1, mudWeight/2, mudPermanence/3, act_term/2, mudAgentTurnnum/2, mudAtLoc/2, mudEnergy/2, mudHealth/2, mudDescription/2, mudFacing/2, failure/2, gridValue/4, mudHeight/2, mudMemory/2, isa/2, pathName/3, mudPossess/2, mudScore/2, mudStm/2, mudStr/2, mudWearing/2)).



prologMultiValued(mudDescription(ftTerm,ftString),[prologOrdered,prologHybrid]).
prologMultiValued(mudDescription(ftTerm,ftText), [predProxyAssert(add_description),predProxyRetract(remove_description),predProxyQuery(query_description)],prologHybrid).
prologMultiValued(mudDescription(ftTerm,ftText),[predProxyAssert(add_description),prologHybrid]).
prologMultiValued(mudKeyword(ftTerm,ftString),prologHybrid).
prologMultiValued(mudMemory(tAgent,ftTerm),prologHybrid).
prologMultiValued(mudNamed(ftTerm,ftTerm),prologHybrid).
prologMultiValued(mudPossess(tObj,tObj),prologHybrid).
prologMultiValued(nameStrings(ftTerm,ftString),prologHybrid).
prologMultiValued(pathDirLeadsTo(tRegion,vtDirection,tRegion),prologHybrid).
prologMultiValued(pathName(tRegion,vtDirection,ftString),prologHybrid).
prologMultiValued(genls(tCol,tCol),prologHybrid).
prologMultiValued(typeGrid(tCol,ftInt,ftListFn(ftString)),prologHybrid).
prologMultiValued(verbAsWell(ftTerm,ftAction,ftAction),prologHybrid).

prologNegByFailure(mudNeedsLook(tObj,ftBoolean),prologHybrid).
prologNegByFailure(tAgent(ftID),prologHybrid).
prologNegByFailure(tCol(ftID),prologHybrid).
prologNegByFailure(tItem(ftID),prologHybrid).
prologNegByFailure(tRegion(ftID),prologHybrid).
prologNegByFailure(tThinking(tAgent),prologHybrid).
pathName(Region,Dir,Text)=>mudDescription(apathFn(Region,Dir),Text).

prologSingleValued(chargeCapacity(tChargeAble,ftInt),prologHybrid).
prologSingleValued(location_center(tRegion,xyzFn(tRegion,ftInt,ftInt,ftInt)),prologHybrid).
prologSingleValued(mudAgentTurnnum(tAgent,ftInt),[argSingleValueDefault(2,0)],prologHybrid).
prologSingleValued(mudArmor(tObj,ftInt),prologHybrid).
prologSingleValued(mudArmorLevel(tWearAble,ftInt),prologHybrid).
prologSingleValued(mudAtLoc(tObj,xyzFn(tRegion,ftInt,ftInt,ftInt)),prologHybrid).
prologSingleValued(mudAttack(tObj,ftInt),prologHybrid).
prologSingleValued(mudBareHandDamage(tAgent,ftInt),prologHybrid).
% prologSingleValued(mudBareHandDamage(tAgent,ftDice),prologHybrid).
% prologSingleValued(mudEnergy(tChargeAble,ftInt(90)),prologHybrid).
prologSingleValued(mudEnergy(tChargeAble,ftInt),prologHybrid).
prologSingleValued(mudEnergy(tObj,ftInt),[argSingleValueDefault(2,90)],prologHybrid).
prologSingleValued(mudFacing(tObj,vtDirection(vNorth)),prologHybrid).
prologSingleValued(mudFacing(tObj,vtDirection),[argSingleValueDefault(2,vNorth)],prologHybrid).
prologSingleValued(mudHealth(tObj,ftInt),prologHybrid).
prologSingleValued(mudHeight(tObj,ftInt),prologHybrid).
prologSingleValued(mudHeight(tSpatialThing,ftInt),prologHybrid).
prologSingleValued(mudID(tObj,ftID),prologHybrid).
prologSingleValued(mudLastCommand(tAgent,ftAction),prologHybrid).
prologSingleValued(mudLevelOf(tCarryAble,ftInt),prologHybrid).
prologSingleValued(mudMaxHitPoints(tAgent,ftInt),[prologHybrid],prologHybrid).
prologSingleValued(mudMoveDist(tAgent,ftInt),[argSingleValueDefault(2,1)]).
prologSingleValued(mudNeedsLook(tAgent,ftBoolean),argSingleValueDefault(2,vFalse),prologHybrid).
prologSingleValued(mudPermanence(tItem,vtVerb,vtPerminance),prologHybrid).
prologSingleValued(mudScore(tObj,ftInt),prologHybrid).
prologSingleValued(mudSpd(tAgent,ftInt),prologHybrid).
prologSingleValued(mudStm(tAgent,ftInt),prologHybrid).
prologSingleValued(mudStr(tAgent,ftInt),prologHybrid).
prologSingleValued(mudToHitArmorClass0(tAgent,ftInt),prologHybrid).
prologSingleValued(mudWeight(tObj,ftInt),prologHybrid).
% prologSingleValued(spawn_rate(isPropFn(genls(tObj)),ftInt)).
prologSingleValued(spawn_rate(tCol,ftInt)).
prologSingleValued(stat_total(tAgent,ftInt)).
prologSingleValued(typeGrid(tCol,ftInt,ftListFn(ftString))).
resultIsa(apathFn,tPathway).
% '<=>'(isa(Whom,tNpcPlayer),whenAnd(isa(Whom,tPlayer),naf(isa(Whom,tHumanPlayer)))).
'<=>'(mudDescription(apathFn(Region,Dir),Text),pathName(Region,Dir,Text)).
'<=>'(nameStrings(apathFn(Region,Dir),Text),pathName(Region,Dir,Text)).

ttPredAndValueType("size").
ttPredAndValueType("texture").
ttPredAndValueType("color").
ttPredAndValueType("shape").
ttPredAndValueType("material").

vtValue(Val)/(atom(Val),i_name_lc(Val,KW))=>mudKeyword(Val,KW).

ttPredAndValueType(Str)/(i_name('mud',Str,Pred),i_name('vt',Str,VT)) => (tRolePredicate(Pred),ttValueType(VT),mudKeyword(VT,Str),mudKeyword(Pred,Str),argIsa(Pred,2,VT),argIsa(Pred,1,tTemporalThing)).

relationMostInstance(arg1Isa,tRolePredicate,tTemporalThing).
relationMostInstance(arg2QuotedIsa,tRolePredicate,ftTerm).

% mudKeyword(W,R) <= {atom(W),i_name_lc(W,R)}.

ttValueType(vtSize).
ttValueType(vtTexture).
ttValueType(vtColor).

ttValueType(VT)=>tInferInstanceFromArgType(VT).

prologOnly(user:verb_alias(ftString,vtVerb)).
prologHybrid(typeHasGlyph(tCol,ftString)).
prologHybrid(mudMaxHitPoints(tAgent,ftInt)).
prologHybrid(mudStowing(tAgent,tItem)).
:-dynamic((latitude/2, mudMoveDist/2, longitude/2)).
prologHybrid(typeHasGlyph,2).
prologHybrid(mudActAffect/3).
prologHybrid(mudAtLoc,2).
prologHybrid(mudColor/2).
prologHybrid(mudHealth,2).
prologHybrid(mudMaterial/2).
prologHybrid(mudNeedsLook,2).
prologHybrid(mudNeedsLook/2,[completeExtentAsserted]).
prologHybrid(mudShape/2).
prologHybrid(mudSize/2).
prologHybrid(mudTexture/2).
prologHybrid(pathDirLeadsTo/3).
prologOnly(mudMoveDist/2).
:- dynamic(mudMoveDist/2).
meta_argtypes(mudMoveDist(tAgent,ftInt)).
prologSingleValued(mudMoveDist,[mpred_module(user),query(call),argSingleValueDefault(2,1)]).
prologOnly(stat_total/2).
tCol(tContainer).
tCol(tRegion).
tCol(vtBasicDir).
tCol(vtBasicDirPlusUpDown).
tCol(vtDirection).
tCol(vtVerb).
:- dynamic stat_total/2.
:- dynamic(spawn_rate/2).
tCol(tMonster).
%prologOnly(user:action_info(vtActionTemplate,ftText)).
prologOnly(agent_call_command(tAgent,ftAction)).
prologSideEffects(agent_call_command(tAgent,ftAction)).
prologOnly(member(ftTerm,ftTerm)).
prologOnly(mud_test(ftTerm,ftCallable)).
prologOnly(use_action_templates(ftTerm)).


prologHybrid(typeHasGlyph(tCol,ftString)).
prologHybrid(mudColor(tSpatialThing,vtColor)).
prologHybrid(mudKnowing(tAgent,ftTerm)).
prologHybrid(mudLabelTypeProps(ftString,tCol,ftVoprop)).
prologHybrid(mudListPrice(tItem,ftNumber)).
:-dynamic(mudOpaqueness/2).
prologHybrid(mudOpaqueness(ftTerm,ftPercent)).
prologHybrid(mudPossess(tAgent,tObj)).
prologHybrid(mudShape(tSpatialThing,vtShape)).
prologHybrid(mudSize(tSpatialThing,ftTerm)).
prologHybrid(mudTextSame(ftText,ftText)).
prologHybrid(mudTexture(tSpatialThing,vtTexture)).
prologHybrid(typeGrid(tCol,ftInt,ftListFn(ftString))).
prologListValued(aDirectionsFn(ftTerm,ftListFn(ftTerm))).
prologListValued(mudGetPrecepts(tAgent,ftListFn(tSpatialThing)),[mpred_module(user)]).
prologListValued(mudNearFeet(tAgent,ftListFn(tSpatialThing)),[]).
prologListValued(mudNearReach(tAgent,ftListFn(tSpatialThing)),[mpred_module(user)]).
prologMultiValued(action_rules(tAgent,vtVerb,ftListFn(ftVar),ftVoprop)).
prologMultiValued(mudLastCmdSuccess(tAgent,ftAction)).
prologMultiValued(descriptionHere(ftTerm,ftString)).
prologMultiValued(descriptionHere(ftTerm,ftString),prologOrdered).
prologMultiValued(determinerString(ftTerm,ftString)).
prologMultiValued(typeHasGlyph(ftTerm,ftString)).
prologMultiValued(gridValue(tRegion,ftInt,ftInt,tObj)).
prologMultiValued(instVerbOverride(ftTerm,ftAction,ftAction)).
prologMultiValued(isa(ftTerm,tCol)).
prologMultiValued(mudActAffect(ftTerm,ftTerm,ftTerm)).
prologMultiValued(mudActAffect(tItem,vtVerb,ftTerm(ftVoprop))).
prologMultiValued(mudCmdFailure(tAgent,ftAction)).

tPred(isEach(tAgent/1, mudEnergy/2,mudHealth/2, mudAtLoc/2, failure/2, typeGrid/3, gridValue/4, isa/2, tItem/1, mudMemory/2, pathName/3, mudPossess/2, tRegion/1, mudScore/2, mudStm/2, mudFacing/2, localityOfObject/2, tThinking/1, mudWearing/2, mudFacing/2, mudHeight/2, act_term/2, nameStrings/2, mudDescription/2, pathDirLeadsTo/3, mudAgentTurnnum/2)).
prologHybrid(mudToHitArmorClass0 / 2).
prologHybrid(mudAtLoc/2).
prologOnly((agent_call_command/2)).
:-decl_mpred_hybrid(isEach(argIsa/3, formatted_resultIsa/2, typeHasGlyph/2, inRegion/2, mudContains/2, isa/2, mudLabelTypeProps/3, mudMemory/2, mudPossess/2, mudStowing/2, genls/2, mudToHitArmorClass0/2, 
 pddlSomethingIsa/2, resultIsa/2, subFormat/2, tCol/1, tRegion/1, completeExtentAsserted/1, ttFormatType/1, typeProps/2)).
prologHybrid(isEach(argIsa/3, formatted_resultIsa/2, typeHasGlyph/2, inRegion/2, mudContains/2, isa/2, mudLabelTypeProps/3, mudMemory/2, mudPossess/2, mudStowing/2, genls/2, mudToHitArmorClass0/2, 
 pddlSomethingIsa/2, resultIsa/2, subFormat/2, tCol/1, tRegion/1, completelyAssertedCollection/1, ttFormatType/1, typeProps/2)).

prologHybrid(isEach(tItem/1, tRegion/1, instVerbOverride/3,mudNamed/2, determinerString/2, mudKeyword/2 ,descriptionHere/2, mudToHitArmorClass0/2, tThinking/1, tDeleted/1, mudWeight/2, mudPermanence/3, act_term/2, mudAgentTurnnum/2, mudAtLoc/2, mudEnergy/2, mudHealth/2, mudDescription/2, mudFacing/2, mudCmdFailure/2, mudSpd/2, typeGrid/3, mudHeight/2, mudMemory/2, isa/2, pathName/3, mudPossess/2, mudScore/2, mudStm/2, mudStr/2, wearsClothing/2)).
prologHybrid(isEach( mudArmorLevel/2, mudLevelOf/2, mudToHitArmorClass0/2, mudBareHandDamage/2, chargeCapacity/2, mudEnergy/2, tCol/1, tAgent/1, tItem/1, tRegion/1, instVerbOverride/3,mudNamed/2, determinerString/2, mudKeyword/2 ,descriptionHere/2, tThinking/1, mudWeight/2, mudPermanence/3, act_term/2, mudAgentTurnnum/2, mudAtLoc/2, mudEnergy/2, mudHealth/2, mudDescription/2, mudFacing/2, failure/2, gridValue/4, mudHeight/2, mudMemory/2, isa/2, pathName/3, mudPossess/2, mudScore/2, mudStm/2, mudStr/2, mudWearing/2)).

:-must(fully_expand(prologHybrid(typeHasGlyph,2),(arity(typeHasGlyph, 2), prologHybrid(typeHasGlyph), tPred(typeHasGlyph)))).

arity(typeHasGlyph,2).
arity(mudTermAnglify,2).
arity(mudMaxHitPoints,2).


prologHybrid(instVerbOverride(ftTerm,ftAction,ftAction)).
%isa(localityOfObject,prologHybrid). 
%isa(mudActAffect, prologMultiValued).
%isa(mudMaxHitPoints,prologHybrid).
isa(vtDirection,ttValueType).

prologMultiValued(agent_text_command(tAgent,ftText,tAgent,ftAction)).

formatted_resultIsa(apathFn(tRegion,vtDirection),tPathway).

prologOnly(is_vtActionTemplate/1).

is_vtActionTemplate(C):-nonvar(C),get_functor(C,F),!,atom_concat(act,_,F).
defnSufficient(ftAction,is_vtActionTemplate).
defnSufficient(ftAction,vtVerb).
defnSufficient(ftTerm,vtValue).

genls('FemaleAnimal',tPlayer).
genls('MaleAnimal',tPlayer).
genls(isEach('PortableObject','ProtectiveAttire','SomethingToWear'),tCarryAble).
genls(isEach('ProtectiveAttire','SomethingToWear'),tWearAble).
genls(isEach(tRegion,tAgent),tChannel).

tCol(meta_argtypes).
meta_argtypes(aDirectionsFn(ftTerm,ftListFn(ftTerm))).
meta_argtypes(apathFn(tRegion,vtDirection)).
meta_argtypes(xyzFn(tRegion,ftInt,ftInt,ftInt)).



tCol(ttTypeByAction).
genls(ttTypeByAction,tCol).
(isa(X,ttTypeByAction) => isa(X,tCol)).


% (isa(Inst,Type),isa(Type,ttTypeByAction)) => isa(Inst,tHasAction).

genls(tAgent,tObj).
genls(tAgent,tSpatialThing).
genls(tCarryAble,tItem).
genls(tChargeAble,tItem).
genls(tContolDevice,tChargeAble).
genls(tDoor,tFurniture).
genls(tDoor,tItem).
genls(tDrinkAble,tItem).
genls(tEatAble,tItem).
genls(tFunction,tRelation).
genls(tFurniture,tObj).
genls(tFurniture,tPartofObj).
genls(tHumanPlayer,tPlayer).
genls(tItem,tObj).
genls(tItem,tSpatialThing).
genls(tMonster,ttAgentGeneric).
genls(tNpcPlayer,tPlayer).
genls(tObj,tSpatialThing).
genls(tPathway,tDoor).
genls(tPlayer,tAgent).
genls(tPred,tRelation).
genls(tRegion,tSpatialThing).
genls(ttObjectType,tCol).
genls(ttSpatialType,tCol).
genls(tUseAble,tItem).
genls(tWearAble,tItem).
genls(vtBasicDir,vtBasicDirPlusUpDown).
genls(vtBasicDirPlusUpDown,vtDirection).
genls(vtDirection,tTypevalue).
genls(vtPosture,vtVerb).





vtBasicDir(vEast).
vtBasicDir(vNorth).
vtBasicDir(vSouth).
vtBasicDir(vWest).
vtBasicDirPlusUpDown(vDown).
vtBasicDirPlusUpDown(vUp).
%localityOfObject(Above,HasSurface):- mudLocOnSurface(Above,HasSurface).
%localityOfObject(Clothes,Agent):- mudSubPart(Agent,Clothes).
%localityOfObject(Inner,Container):- mudInsideOf(Inner,Container).
%localityOfObject(Inner,Outer):- user:only_if_pttp, localityOfObject(Inner,Container),localityOfObject(Container,Outer).
nameStrings(apathFn(Region,Dir),Text):- pathName(Region,Dir,Text).
meta_argtypes(mudMaterial(tSpatialThing,vtMaterial)).
meta_argtypes(mudSize(tSpatialThing,vtSize)).
meta_argtypes(mudTexture(tSpatialThing,vtTexture)).
meta_argtypes(mudWearing(tAgent,tWearAble)).
meta_argtypes(pathName(tRegion,vtDirection,ftString)).
meta_argtypes(resultIsa(tFunction,tCol)).
meta_argtypes(wasSuccess(tAgent,ftBoolean)).
meta_argtypes(type_action_info(tCol,vtActionTemplate,ftText)).
%NEXT TODO predTypeMax(mudEnergy,tObj,130).
%NEXT TODO predTypeMax(mudHealth,tObj,500).

tCol(ttAgentType).

prologHybrid(pathDirLeadsTo(tRegion,vtDirection,tRegion)).
prologHybrid(bordersOn(tRegion,tRegion),tSymmetricRelation).

ttAgentType(tMonster).
% user:instTypeProps(apathFn(Region,_Dir),tPathway,[localityOfObject(Region)]).


=> tSpec(vtActionTemplate).
=> tCol(tRegion).
=> tCol(tContainer).
disjointWith(tObj,tRegion).
disjointWith(tObj,tRegion).
disjointWith(tRegion,tObj).


ttTemporalType(tAgent).
ttTemporalType(tItem).
ttTemporalType(tObj).
ttTemporalType(tRegion).
tCol(tChannel).
tChannel(A):- tAgent(A).
tChannel(A):- tRegion(A).
tChannel(iGossupChannel).
ttTypeFacet(tChannel).
typeGenls(tAgent,ttAgentType).
typeGenls(tItem,ttItemType).
typeGenls(tObj,ttObjectType).
:-add(isa(tObj,ttTemporalType)).
:-add(isa(tRegion,ttTemporalType)).
typeGenls(tRegion,ttRegionType).
typeGenls(ttAgentType,tAgent).
typeGenls(ttItemType,tItem).
typeGenls(ttObjectType,tObj).
typeGenls(ttRegionType,tRegion).
% cycAssert(A,B):- trace_or_throw(cycAssert(A,B)).




prologHybrid(dividesBetween(tCol,tCol,tCol)).

% defined more correctly below dividesBetween(S,C1,C2) => (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).
dividesBetween(tItem,tMassfull,tMassless).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tTemporalThing,tObj,tRegion).
formatted_resultIsa(ftDice(ftInt,ftInt,ftInt),ftInt).
(dividesBetween(tAgent,tMale,tFemale)).

% dividesBetween(tItem,tPathways).
dividesBetween(tItem,tMassfull,tMassless).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tTemporalThing,tObj,tRegion).
dividesBetween(tAgent,tPlayer,tNpcPlayer).


isa(tRegion,ttTemporalType).

completelyAssertedCollection(tCol).
completelyAssertedCollection(ttFormatType).
completelyAssertedCollection(tItem).
completelyAssertedCollection(tRegion).
completelyAssertedCollection(tObj).
completelyAssertedCollection(tAgent).
completelyAssertedCollection(tCarryAble).
completelyAssertedCollection(vtVerb).
genls(ttTypeByAction,completelyAssertedCollection).

arity(bordersOn,2).

bordersOn(R1,R2):-is_asserted(pathDirLeadsTo(R1,Dir,R2)),nop(Dir).
bordersOn(R1,R2):-is_asserted(pathDirLeadsTo(R2,Dir,R1)),nop(Dir).

ensure_some_pathBetween(R1,R2):- bordersOn(R1,R2),!.
ensure_some_pathBetween(R1,R2):- random_path_dir(Dir), \+(is_asserted(pathDirLeadsTo(R1,Dir,_))),must(reverse_dir(Dir,Rev)),\+(is_asserted(pathDirLeadsTo(R2,Rev,_))),!, 
   must((add(pathDirLeadsTo(R1,Dir,R2)),add(pathDirLeadsTo(R2,Rev,R1)))),!.
ensure_some_pathBetween(R1,R2):- must((add(pathDirLeadsTo(R1,aRelatedFn(vtDirection,R1,R2),R2)),add(pathDirLeadsTo(R2,aRelatedFn(vtDirection,R2,R1),R1)))),!.

bordersOn(R1,R2)/ground(bordersOn(R1,R2)) => isa(R1,tRegion),isa(R2,tRegion), {ensure_some_pathBetween(R2,R1),ensure_some_pathBetween(R1,R2)}.


% ==================================================
% Classes of things
% ==================================================


genls(tAgent,tObj).
genls(tItem,tObj).
genls(tClothing, tWashAble).
genls(tClothing, tWearAble).
genls(tFood,tEatAble).
genls(tFood, tItem).
genls(tClothing, tItem).

genls( tCarryAble, tItem).
genls( tCarryAble, tDropAble).

genlsInheritable(tCol).
genlsInheritable(ttPredType).
genls(ttTypeType,genlsInheritable).

(genls(C,SC)/ground(genls(C,SC))=>(tCol(C),tCol(SC))).

(genls(C,SC)/ground(genls(C,SC)),nearestIsa(SC,W),\+ genlsInheritable(W) )=>isa(C,W).

% throw(sane_transitivity (genls( tCarryAble, tThrowAble))).
% genls( tCarryAble, tCarryAble).

genls(tPortableDevice,tCarryAble).

predIsFlag(spatialInRegion/1).

:-do_gc.

genls(tClothing, tFoldAble).
genls(tClothing, tWearAble).

genls(tLiquidContainer, tDrinkAble).
genls(tLiquidContainer, tCarryAble).


genls(tFoldAble, tCarryAble).
% genls(tThrowAble, tCarryAble).
genls(tPortableDevice,tCarryAble).
genls(tPortableDevice,tPhysicalDevice).
genls(tPhysicalDevice,tUseAble).
genls(tWearAble, tCarryAble).
genls(tFood,tCarryAble).
genls(tCarryAble,tObj).
genls(tPartofObj,tNotTakAble).
genls(tBodyPart,tPartofObj).
genls(tSpatialThing,tLookAble).
genls(tFurnature,tOntoAble).
genls(tFurnature,tItem).

genls(tPartofFurnature,tPartofObj).






%(isa(I,Sub), disjointWith(Sub, Super)) => neg(isa(I,Super)).


genls(tPartofObj,tItem).

% dividesBetween(tItem,tPathways).
dividesBetween(tItem,tMassfull,tMassless).
dividesBetween(tObj,tItem,tAgent).
dividesBetween(tObj,tMassfull,tMassless).
dividesBetween(tSpatialThing,tObj,tRegion).
dividesBetween(tAgent,tPlayer,tNpcPlayer).

% dividesBetween(S,C1,C2) => (disjointWith(C1,C2) , genls(C1,S) ,genls(C2,S)).

% disjointWith(P1,P2) => (not(isa(C,P1)) <=> isa(C,P2)).

% isa(Col1, ttObjectType) => ~isa(Col1, ttFormatType).

=> tCol(tCol).
=> tCol(tPred).
=> tCol(tFunction).
=> tCol(tRelation).
=> tCol(ttSpatialType).
=> tCol(ttFormatType).
% => tCol(functorDeclares).
% tCol(ArgsIsa):-ttPredType(ArgsIsa).
% TODO decide if OK
%tCol(F):-t(functorDeclares,F).
=> tCol(ttFormatType).
=> tSpec(vtActionTemplate).
=> tCol(tRegion).
=> tCol(tContainer).

isa(tRegion,ttSpatialType).
isa(tRelation,ttAbstractType).
typeProps(tTorso,[mudColor(isLikeFn(mudColor,tSkin)),mudShape(vUnique)]).
typeProps(tSkin,[mudColor(vUnique),mudShape(vUnique)]).

%Empty Location
% You *have* to use 0 as the id of the empty location. (no way!)
mudLabelTypeProps(--,ftVar,[]).

%NEXT TODO predTypeMax(mudEnergy,tAgent,120).

typeProps(tAgent,[predInstMax(mudHealth,500)]).
genls('IndoorsIsolatedFromOutside',tRegion).
genls('SpaceInAHOC',tRegion).

typeProps(tAgent,[mudMoveDist(1)]).
% isRandom(vtBasicDir)
typeProps(tAgent,[predInstMax(mudHealth,500), predInstMax(mudEnergy,200), mudHealth(500), mudEnergy(90),  mudFacing(vNorth), mudAgentTurnnum(0), mudScore(1), 
    mudMemory(aDirectionsFn([vNorth,vSouth,vEast,vWest,vNE,vNW,vSE,vSW,vUp,vDown]))]).
% typeProps(tAgent,mudLastCommand(actStand)).
typeProps(tAgent,mudNeedsLook(vFalse)).

typeProps(tFood,[mudHeight(0)]).

typeProps(tItem,mudEnergy(140)).

typeProps(tItem,mudListPrice(0)).
typeProps(tObj,[mudOpaqueness(100)]).
typeProps(tRegion,[mudOpaqueness(1)]).
typeProps(tSpatialThing,mudHeight(0)).

% :-end_module_type(dynamic).

mudLabelTypeProps(Lbl,Type,Props)/ground(mudLabelTypeProps(Lbl,Type,Props))=> (typeHasGlyph(Type,Lbl) , typeProps(Type,Props)).

% Vacuum World example objects........
mudLabelTypeProps(wl,tWall,[mudHeight(3),mudWeight(4)]).

%TOO SLOW isa(I,SC)<=isa(I,C),genls(C,SC).

(wearsClothing(A,I)=>{add(tAgent(A)),add(tClothing(I))}).


genls(tBread, tFood).
typeProps(tCrackers,[mudColor(vTan),isa(tBread),mudShape(isEach(vCircular,vFlat)),mudSize(vSmall),mudTexture(isEach(vDry,vCoarse))]).

nonvar_must_be(V,G):- (var(V);G),!.

% TODO SPEED THIS UP 
% mudKeyword(I,Str)<= {(nonvar(I);nonvar(Str)), nonvar_must_be(I,\+tCol(I)), nonvar_must_be(Str,string(Str))}, isa(I,Type),mudKeyword(Type,Str).

mudKeyword(Type,Str),tSet(Type),isa(I,Type)/(atom(I),ftID(I)) => mudKeyword(I,Str).


user:action_info(C,_)=>vtActionTemplate(C).

argsQuoted(cachedPredicate).

cachedPredicate(Goal)=>{forall(Goal,pfc_add(Goal))}.

tCol(cachedPredicate).
cachedPredicate(vtActionTemplate(_)).

% from inform7
prologHybrid(mudRelating(ftID,ftID)).
prologHybrid(mudProviding(ftID,ftID)).
prologHybrid(mudContainment(ftID,ftID)).
prologHybrid(mudSupportsSpatially(ftID,ftID)).
prologHybrid(mudIncorporates(ftID,ftID)).
prologHybrid(mudEncloses(ftID,ftID)).

/*
An object has a text called printed name.
An object has a text called printed plural name.
An object has a text called an indefinite article.
An object can be plural-named or singular-named. An object is usually singular-named.
An object can be proper-named or improper-named. An object is usually improper-named.

A room can be privately-named or publically-named. A room is usually publically-named.
A room can be lighted or dark. A room is usually lighted.
A room can be visited or unvisited. A room is usually unvisited.
A room has a text called description.

Y [can] be C1 or C2.  
Y is [usually] C2.

A thing can be lit or unlit. A thing is usually unlit.
A thing can be edible or inedible. A thing is usually inedible.
A thing can be fixed in place or portable. A thing is usually portable.
A thing can be scenery.
A thing can be wearable.
A thing can be pushable between rooms.

The north is a direction.
The northeast is a direction.
The northwest is a direction.
The south is a direction.
The southeast is a direction.
The southwest is a direction.
The east is a direction.
A/sr1 - SR1 - Physical World Model �30 14
The west is a direction.
The up is a direction.
The down is a direction.
The inside is a direction.
The outside is a direction.
The north has opposite south. Understand "n" as north.
The northeast has opposite southwest. Understand "ne" as northeast.
The northwest has opposite southeast. Understand "nw" as northwest.
The south has opposite north. Understand "s" as south.
The southeast has opposite northwest. Understand "se" as southeast.
The southwest has opposite northeast. Understand "sw" as southwest.
The east has opposite west. Understand "e" as east.
The west has opposite east. Understand "w" as west.
Up has opposite down. Understand "u" as up.
Down has opposite up. Understand "d" as down.
Inside has opposite outside. Understand "in" as inside.
Outside has opposite inside. Understand "out" as outside.
The inside object translates into I6 as "in_obj".
The outside object translates into I6 as "out_obj".
The verb to be above implies the mapping up relation.
The verb to be mapped above implies the mapping up relation.
The verb to be below implies the mapping down relation.
The verb to be mapped below implies the mapping down relatio

A door has an object called other side.
The other side property translates into I6 as "door_to".
Leading-through relates one room (called the other side) to various doors.
The verb to be through implies the leading-through relation.
�33. Containers and supporters. The carrying capacity property is the exception to the remarks above
about the qualitative nature of the world model: here for the first and only time we have a value which can
be meaningfully compared.
Section SR1/6 - Containers
The specification of container is "Represents something into which portable
things can be put, such as a teachest or a handbag. Something with a really
large immobile interior, such as the Albert Hall, had better be a room
instead."
A container can be enterable.
A container can be opaque or transparent. A container is usually opaque.
A container has a number called carrying capacity.
The carrying capacity of a container is usually 100.
Include (- has container, -) when defining a container

The specification of supporter is "Represents a surface on which things can be
placed, such as a table."
A supporter can be enterable.
A supporter has a number called carrying capacity.
The carrying capacity of a supporter is usually 100.
A supporter is usually fixed in place.
Include (-
has transparent supporter
-) when defining a supporte

A door can be open or closed. A door is usually closed.
A door can be openable or unopenable. A door is usually openable.
A container can be open or closed. A container is usually open.
A container can be openable or unopenable. A container is usually unopenable.

Before rules is a rulebook. [20]
Instead rules is a rulebook. [21]
Check rules is a rulebook. [22]
Carry out rules is a rulebook. [23]
After rules is a rulebook. [24]
Report rules is a rulebook. [25]

Action-processing rules is a rulebook. [10]
The action-processing rulebook has a person called the actor.
Setting action variables is a rulebook. [11]
The specific action-processing rules is a rulebook. [12]
The specific action-processing rulebook has a truth state called action in world.
The specific action-processing rulebook has a truth state called action keeping silent.
The specific action-processing rulebook has a rulebook called specific check rulebook.
The specific action-processing rulebook has a rulebook called specific carry out rulebook.
The specific action-processing rulebook has a rulebook called specific report rulebook.
The specific action-processing rulebook has a truth state called within the player�s sight.
The player�s action awareness rules is a rulebook. [13]
�16. The rules on accessibility and visibility, which control whether an action is physically possible, have
named outcomes as a taste of syntactic sugar.
Accessibility rules is a rulebook. [14]
Reaching inside rules is an object-based rulebook. [15]
Reaching inside rules have outcomes allow access (success) and deny access (failure).
Reaching outside rules is an object-based rulebook. [16]
Reaching outside rules have outcomes allow access (success) and deny access (failure).
Visibility rules is a rulebook. [17]
Visibility rules have outcomes there is sufficient light (failure) and there is
insufficient light (success).
�17. Two rulebooks govern the processing of asking other people to carry out actions:
Persuasion rules is a rulebook. [18]
Persuasion rules have outcomes persuasion succeeds (success) and persuasion fails (failure).
Unsuccessful attempt by is a rulebook. [19

*/



tCol(random_path_dir).
random_path_dir(Dir):-nonvar(Dir),!,fail.
random_path_dir(Dir):-random_instance(vtBasicDir,Dir,true).
random_path_dir(Dir):-random_instance(vtBasicDirPlusUpDown,Dir,true).
random_path_dir(Dir):-random_instance(vtDirection,Dir,true).

prologOnly(ensure_some_pathBetween(tRegion,tRegion)).

prologOnly(onEachLoad).
argsQuoted(onEachLoad).
argsQuoted(must).

tCol(tStatPred).

prologHybrid(normalAgentGoal(tStatPred,ftTerm)).

normalAgentGoal(Pred,_)/atom(Pred) =>
 {AT=..[Pred,tAgent,ftPercent]},
  meta_argtypes(AT),prologHybrid(Pred),tRolePredicate(Pred),arity(Pred,2),
  singleValuedInArg(Pred,2).

normalAgentGoal(mudEnergy,90).
normalAgentGoal(mudNonHunger,90).
normalAgentGoal(mudHygiene,90).
normalAgentGoal(mudBladderEmpty,90).
normalAgentGoal(mudSecureRoom,90).
normalAgentGoal(mudFun,90).
normalAgentGoal(mudNonLonelinessSocial,90).
normalAgentGoal(mudSadToHappy,90).
normalAgentGoal(mudComfort,90).

typeProps(tAgent,[mudStr(2),mudHeight(2),mudStm(2),mudSpd(2)]).

normalAgentGoal(X,_)=>tStatPred(X).

((tStatPred(Pred)/((Val1=(-(_));Val1=( +(_))), Head1=..[Pred,Agent,Val1], Head2=..[Pred,Agent,Val2], Head3=..[Pred,Agent,Val3]))
 =>
   ((Head1,Head2/(Val1 \== Val2, catch((Val3 is Val1 + Val2),_,fail))) => 
     (( \+ Head1, Head3, \+ Head2 )))).

((tStatPred(Pred)/((Val1=(+(_));Val1=( -(_))), Head1=..[Pred,Agent,Val1], Head2=..[Pred,Agent,Val2], Head3=..[Pred,Agent,Val3]))
 =>
   ((Head1,Head2/(Val1 \== Val2, catch((Val3 is Val1 + Val2),_,fail))) => 
     (( \+ Head1, Head3, \+ Head2 )))).

((arity(Pred,Arity),singleValuedInArg(Pred,SV),
  {functor(Before,Pred,Arity),arg(SV,Before,B),replace_arg(Before,SV,A,After)})
  =>
   (({dif:dif(B,A)},After,{clause_asserted(Before), B\==A,\+ is_relative(B),\+ is_relative(A)}) 
     =>
      {pfc_rem2(Before)})).



%normalAgentGoal(Pred,Val)=>  (tAgent(A)=>agentGoals(A,Pred,((t(Pred,A,V),V>=Val)))).
%agentGoals(A,About,State)/State => \+ agentTODO(A,actImprove(About)).

prologHybrid(agentTODO(tAgent,vtActionType)).

normalAgentGoal(Pred,Val)=>  ( t(Pred,A,V)/(V<Val) => agentTODO(A,actImprove(Pred))).

normalAgentGoal(Pred,Val)=>  (tAgent(A)=>pfc_default(t(Pred,A,Val))).

genls(tRoom,tRegion).


/*

 the CycL language extends Prolog's first order logic capabilities with some higher order logics.  
 It also extrends prolog to show proofs.. one issue is the CycL language never signed up for cuts or other execution  orders.    
 PrologMUD extends the CycL language to allow preset program flow (unless a predicate is declared to not honor order of execution 
  (this is usually best!)).  PrologMUD  implements a new design of the cyc canonicalizer..   

 usually in Cyc the rules "(implies (and Axy Byz) (and Cwxyz Dwx))" are converted to DNF (Correct me if I am wrong.. 
 since i have heard it uses ConjuntiveNormalForm as well) ... the DNF generates Clausal forms..  The forms choosen 



?-  kif_to_boxlog(((parent('$VAR'('G'),'$VAR'('P')) & parent('$VAR'('P'),'$VAR'('C'))) => grandparent('$VAR'('G'),'$VAR'('C'))),O). 

O = [ (-parent(G, P):- -grandparent(G, C), parent(P, C)), 
      (-parent(P, C):- -grandparent(G, C), parent(G, P)), 
      (grandparent(G, C):-parent(G, P), parent(P, C))].


?- kif_to_boxlog( (grandparent('$VAR'('G'),'$VAR'('C')) => exists('$VAR'('P'), (parent('$VAR'('G'),'$VAR'('P')) & parent('$VAR'('P'),'$VAR'('C'))))),O).

    (-grandparent(G, C):- mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G)), (-parent(G, P) ; -parent(P, C))),   % You have proven G is not the grandparent of C when you have proven tha G has no children or that C has no parents
    (-mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G)):- grandparent(G, C), (-parent(G, P) ; -parent(P, C))), 
    (parent(G, P):-grandparent(G, C), mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G))), % if you prove G is grandparent of P somehow, you will have proved that G is parent to  parentOf P
    (parent(P, C):-grandparent(G, C), mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G))),
    (mudEquals(P, skUnkArg2OfParentArg1OfFn(KB, C, G)):- grandparent(G, C),  \+ (parent(G, P) , parent(P, C)))]  % We failed to find a true P


O = [ 
      (-grandparent(G, P):- -parent(G, _P) ; -parent(_P, P)),    
      parent(G, P):- grandparent(G, C), parent(P,C),   % if you prove G is grandparent of P somehow, you will have proved that G is parent to  parentOf P
      parent(P, C):- grandparent(G, C), parent(G,P))].   % if you prove G is grandparent of P somehow, you will have proved that G is parent to  parentOf P

*/

/*

(((meta_argtypes(Types)/
 (functor(Types,F,A), A >1, functor(Matcher,F,A),arity(F,A)))
  => 
    ((Matcher => {between(1,A,N),arg(N,Matcher,I),arg(N,Types,T),ground(I:T)},\+ttFormatType(T),isa(I,T),{dmsg(isa(I,T))})))).

((argQuotedIsa(Pred, _, 'CycLSentence') => 'SententialOperator'(Pred))).

*/