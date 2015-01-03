/** <module> 
% Common place to reduce redundancy World utility prediates
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
% Special thanks to code written on
% May 18, 1996
% written by John Eikenberry
% interface by Martin Ronsdorf
% general assistance Dr. Donald Nute
%
*/

%:-swi_module(world, [
:-swi_export((
        call_agent_command/2,
       % call_agent_action/2,
            %mud_isa/2,
            isa_any/2,
            put_in_world/1,
            get_session_id/1,
            pathBetween_call/3,
            obj_memb/2,
            prop_memb/2,            
            move_dir_target/3,
            create_instance/2,create_instance/3,
            create_agent/1,
            create_agent/2,
            in_world_move/3, check_for_fall/3,
            agent_into_corpse/1, display_stats/1,
            reverse_dir/2,
            
            round_loc/8,
            round_loc_target/8,
            dir_offset/5,
            number_to_dir/3,
            list_agents/1,
            
            agent_list/1,
            check_for_fall/3,
            list_object_dir_sensed/4,
            list_object_dir_near/3,
            num_near/3,
            asInvoked/2,
            decl_type/1,
            
                       
         init_location_grid/1,
         grid_dist/3,
         to_3d/2,
         is_3d/1,
         in_grid/2,
         loc_to_xy/4,
         grid_size/4,
         doorLocation/5,
         foc_current_player/1,
         locationToRegion/2,
         init_location_grid/2,
         
         do_act_affect/3,
         spread/0,
         growth/0,
         isaOrSame/2,
         current_agent_or_var/1)).
 % ]).


:-discontiguous create_instance_0/3.

:-swi_export((
          create_instance/2,
          create_instance/3,
          create_instance_0/3,
          create_agent/1,
          create_agent/2)).

:- dynamic  agent_list/1.


:- include(logicmoo('vworld/moo_header.pl')).
:- register_module_type(utility).


:- include(logicmoo('vworld/world_2d.pl')).
:- include(logicmoo('vworld/world_agent.pl')).
:- include(logicmoo('vworld/world_text.pl')).
:- include(logicmoo('vworld/world_effects.pl')).
:- include(logicmoo('vworld/world_events.pl')).
:- if_file_exists(ensure_loaded(logicmoo('vworld/world_spawning.pl'))).

:-export(isaOrSame/2).
isaOrSame(A,B):-A==B,!.
isaOrSame(A,B):-mudIsa(A,B).

intersect(A,EF,B,LF,Tests,Results):-findall( A-B, ((member(A,EF),member(B,LF),once(Tests))), Results),[A-B|_]=Results.
% is_property(P,_A),PROP=..[P|ARGS],CALL=..[P,Obj|ARGS],req(CALL).
obj_memb(E,L):-member(E,L).
isa_any(E,L):-flatten([E],EE),flatten([L],LL),!,intersect(A,EE,B,LL,isaOrSame(A,B),_Results).
prop_memb(E,L):-flatten([E],EE),flatten([L],LL),!,intersect(A,EE,B,LL,isaOrSame(A,B),_Results).

exisitingThing(O):-tItem(O).
exisitingThing(O):-tAgentGeneric(O).
exisitingThing(O):-tRegion(O).
anyInst(O):-tCol(O).
anyInst(O):-exisitingThing(O).

/*

:-decl_type(metaclass).

metaclass(formattype).
metaclass(regioncol).
metaclass(agentcol).
metaclass(itemcol).
% isa(metaclass,metaclass).

% argsIsaInList(typeGenls(col,metaclass)).

% decl_database_hook(assert(_),typeGenls(_,MC)):-assert_isa(MC,metaclass).

% deduce_facts(typeGenls(T,MC),deduce_facts(subclass(S,T),isa(S,MC))).

typeGenls(region,regioncol).
typeGenls(agent,agentcol).
typeGenls(item,itemcol).
*/
mudSubclass(tSillyitem,tItem).

/*
isa(region,regioncol).
isa(agent,agentcol).
isa(item,itemcol).
*/

%subclass(SubType,formattype):-isa(SubType,formattype).

cached(G):-ccatch(G,_,fail).


:-swi_export(create_meta/4).
% if SuggestedName was 'food666' it'd like the SuggestedClass to be 'food' and the stystem name will remain 'food666'
% if SuggestedName was 'food' it'd like the SuggestedClass to be 'food' and the stystem name will become a gensym like 'food1'
create_meta(SuggestedName,SuggestedClass,BaseClass,SystemName):-
   must_det(split_name_type(SuggestedName,SystemName,NewSuggestedClass)),
   ignore(SuggestedClass=NewSuggestedClass),   
   assert_subclass_safe(SuggestedClass,BaseClass),
   assert_subclass_safe(NewSuggestedClass,BaseClass),
   assert_isa_safe(SystemName,BaseClass),
   assert_isa_safe(SystemName,NewSuggestedClass),
   assert_isa_safe(SystemName,SuggestedClass).


nonCreatableType(ftInt).
nonCreatableType(ftTerm).

mudSubclass(tWearable,tItem).
mudSubclass(tLookable,tItem).
mudSubclass(tKnife,tItem).
mudSubclass(tFood,tItem).


createableType(FT):- nonvar(FT),tFormattype(FT),!,fail.
createableType(FT):- nonvar(FT),nonCreatableType(FT),!,fail.
createableType(tItem). %  col, formattype, 
createableType(SubType):-member(SubType,[tAgentGeneric,tItem,tRegion]).
createableType(S):- is_asserted(createableType(T)), impliedSubClass(S,T).

createableSubclassType(S,T):- createableType(T),is_asserted(mudSubclass(S,T)).
createableSubclassType(T,'TemporallyExistingThing'):- createableType(T).

mudIsa(ftInt,tFormattype).
mudIsa(ftDir,tValuetype).
mudIsa(number,tFormattype).
mudIsa(string,tFormattype).


create_agent(P):-create_agent(P,[]).
create_agent(P,List):-must_det(create_instance(P,tAgentGeneric,List)).

% decl_type(Spec):-create_instance(Spec,col,[]).

:-swi_export(create_instance/1).
create_instance(P):- must_det((mudIsa(P,What),createableType(What))),must_det(create_instance(P,What,[])).
:-swi_export(create_instance/2).
create_instance(Name,Type):-create_instance(Name,Type,[]).
:-swi_export(create_instance/3).
create_instance(What,Type,Props):- loop_check_local(time_call(create_instance_now(What,Type,Props)),dmsg(already_create_instance(What,Type,Props))).

create_instance_now(What,Type,Props):-
 with_assertions(thlocal:skip_db_op_hooks,
  with_assertions(thlocal:deduceArgTypes(_),
  with_no_assertions(thlocal:useOnlyExternalDBs,
   with_no_assertions(thlocal:noRandomValues(_),
     with_no_assertions(thlocal:insideIREQ(_),   
      with_no_assertions(thlocal:noDefaultValues(_),
        with_no_assertions(thglobal:use_cyc_database, 
     ((split_name_type(What,Inst,_WhatType),assert_isa(Inst,Type), create_instance_0(What,Type,Props)))))))))).

:-discontiguous create_instance_0/3.

:- swi_export(is_creating_now/1).
:- dynamic(is_creating_now/1).

create_instance_0(What,Type,List):- (var(What);var(Type);var(List)),trace_or_throw((var_create_instance_0(What,Type,List))).
create_instance_0(I,_,_):-is_creating_now(I),!.
create_instance_0(I,_,_):-asserta_if_new(is_creating_now(I)),fail.
create_instance_0(What,FormatType,List):- FormatType\==tCol, tFormattype(FormatType),!,trace_or_throw(tFormattype(FormatType,create_instance(What,FormatType,List))).
create_instance_0(SubType,tCol,List):-decl_type(SubType),padd(SubType,List).

createableType(tAgentGeneric).
mudSubclass(tActor,tAgentGeneric).
mudSubclass(tExplorer,tAgentGeneric).

:-dynamic_multifile_exported(max_health/2).
:-dynamic_multifile_exported(max_charge/2).
:-dynamic_multifile_exported(type_max_charge/2).
%:-dynamic_multifile_exported(type_max_health/2).

max_charge(T,NRG):- fallback, type_max_charge(AgentType,NRG),mudIsa(T,AgentType).
%max_health(T,Dam):- type_max_health(AgentType,Dam),isa(T,AgentType).

punless(Cond,Action):- once((call(Cond);call(Action))).

create_instance_0(T,tAgentGeneric,List):-
  must_det_l([
   retractall(agent_list(_)),
   create_meta(T,_,tAgentGeneric,P),
   mreq(mudIsa(P,tAgentGeneric)),
   padd(P,List),   
   % punless(possess(P,_),rez_to_inventory(P,food,_Food)),
   rez_to_inventory(P,tFood,_Food),
   %reset_values(P),   
   padd(P, [ max_health(500),
                       max_charge(200),
                       mudHealth(500),
                       mudCharge(200),
                       mudAgentTurnnum(0),
                       mudScore(1)]),   
   % set_stats(P,[]),
   put_in_world(P),
   add_missing_instance_defaults(P)]).
   
/*
reset_values(I):- forall(valueReset(To,From),reset_value(I,To,From)).

reset_value(I,To,From):- prop(I,From,FromV), padd(I,To,FromV),!.
reset_value(I,To,From):- prop(I,From,FromV), padd(I,To,FromV),!.
   
   (contains_var(V,value),get_value(P,V,Result)) -> subst(V,P,self)
   argIsa(P,SVArgNum,Type),
   is_term_ft(V,Type),

valueReset(score,0).
valueReset(health,max_health).
valueReset(charge,max_charge).

*/

createableType(tRegion).

create_instance_0(T, tItem, List):-
   mudIsa(T,What),What\=tItem, createableType(What),!,create_instance_0(T, What, List).

create_instance_0(T,Type,List):-
  createableSubclassType(Type,MetaType),
  must_det_l([
   create_meta(T,Type,MetaType,P),
   padd(P,List),
   add_missing_instance_defaults(P)]). 

create_instance_0(T,MetaType,List):-  
  must_det_l([
   create_meta(T,_Type,MetaType,P),
   padd(P,List),
   add_missing_instance_defaults(P)]). 


create_instance_0(T,MetaType,List):-
 dmsg(create_instance_0(T,MetaType,List)),
leash(+call),trace,
  must_det_l([
   create_meta(T,_Type,MetaType,P),
   padd(P,List),
   put_in_world(P),   
   add_missing_instance_defaults(P)]). 

create_instance_0(What,Type,Props):- leash(+call),trace,dtrace,trace_or_throw(dmsg(assumed_To_HAVE_creted_isnance(What,Type,Props))),!.

%createableType(col).



:-decl_mpred_hybrid(kwLabel(ftTerm,ftTerm)).
:-decl_mpred_hybrid(mudOpaqueness(ftTerm,ftPercent)).
default_type_props(tRegion,mudOpaqueness(1)).
default_type_props(tObj,mudOpaqueness(100)).
:-decl_mpred_hybrid(listPrice(tItem,number)).
default_type_props(tItem,listPrice(0)).
default_type_props(tAgentGeneric,mudLastCommand(actStand)).
default_type_props(tAgentGeneric,[
                       max_health(500),
                       max_charge(200),
                       mudHealth(500),
                       mudCharge(200),
                       mudFacing("n"),
                       mudAgentTurnnum(0),
                       mudScore(1),
                       mudMemory(directions([n,s,e,w,ne,nw,se,sw,u,d]))]).




% already convered possess(Who,Thing):-genlInverse(W,possess),into_mpred_form(dbase_t(W,Thing,Who),Call),call_mpred(Call).
% already convered possess(Who,Thing):-genlPreds(possess,W),into_mpred_form(dbase_t(W,Who,Thing),Call),call_mpred(Call).


:- include(logicmoo(vworld/moo_footer)).
