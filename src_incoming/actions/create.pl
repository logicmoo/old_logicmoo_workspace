% :- module(user). 
:- module(create, []).
/** <module> A command to  ...
% charge(Agent,Chg) = charge (amount of charge agent has)
% damage(Agent,Dam) = damage
% cmdsuccess(Agent,Suc) = checks success of last action (actually checks the cmdfailure predicate)
% score(Agent,Scr) = score
% to do this.
% Douglas Miles 2014
*/
:- include(logicmoo(vworld/moo_header)).

:- moo:register_module_type(command).



% ====================================================
% item rez (to stowed inventory)
% ====================================================

:-export(rez_to_inventory/3).
rez_to_inventory(Agent,NameOrType,NewName):-   
   create_meta(NameOrType,Clz,item,NewName),
   padd(Agent,stowed(NewName)),
   show_call(add(isa(NewName,Clz))),
   padd(NewName,authorWas(rez_to_inventory(Agent,NameOrType,NewName))),
   add_missing_instance_defaults(NewName).


moo:action_info(rez(term),"Rezes a new 'item' of some NameOrType into stowed inventory").
moo:agent_call_command(Agent,rez(NameOrType)):- nonvar(NameOrType),rez_to_inventory(Agent,NameOrType,_NewName).

% ====================================================
% object/type creation
% ====================================================
moo:action_info(create(list(term)), "Rezes a new 'spatialthing' or creates a new 'type' of some NameOrType and if it's an 'item' it will put in stowed inventory").

moo:agent_call_command(Agent,create(SWhat)):- with_all_dmsg(must_det(create_new_object(Agent,SWhat))).

:-decl_mpred_prolog(authorWas(term,term)).
:-decl_mpred_prolog(current_pronoun(agent,string,term)).

:-export(create_new_object/2).

create_new_object(Agent,[type,NameOfType|DefaultParams]):-!,create_new_type(Agent,[NameOfType|DefaultParams]).

create_new_object(Agent,[NameOrType|Params]):-
   create_meta(NameOrType,NewType,spatialthing,NewName),
   assert_isa(NewName,NewType),
   padd(NewName,authorWas(create_new_object(Agent,[NameOrType|Params]))),
   padd(Agent,current_pronoun("it",NewName)),   
   getPropInfo(Agent,NewName,Params,2,PropList),!,
   padd(NewName,PropList),
   ignore((isa(NewName,item),padd(Agent,stowed(NewName)))),
   add_missing_instance_defaults(NewName).

:-export(create_new_type/2).
create_new_type(Agent,[NewName|DefaultParams]):-
   decl_type(NewName),
   padd(NewName,authorWas(create_new_type(Agent,[NewName|DefaultParams]))),
   padd(Agent,current_pronoun("it",NewName)),
   getPropInfo(Agent,NewName,DefaultParams,2,PropList),!,
   add(default_type_props(NewName,PropList)).


getPropInfo(_Agent,_NewName,PropsIn,N,[comment(text(need,to,parse,PropsIn,N))]).



:- include(logicmoo(vworld/moo_footer)).

