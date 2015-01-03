/** <module> 
% This is simple example explorer for the maze world.
%
%
% monster.pl
% July 11, 1996
% John Eikenberry
%
% Dec 13, 2035
% Douglas Miles
%
% Declare the module name and the exported (public) predicates.
*/



% Declare the module name and the exported (public) predicates.
:-swi_module(tExplorer,[]).

:- include(logicmoo(vworld/moo_header)).
:- register_module_type(planning).

:-decl_type(tExplorer).

vette_idea(Agent,Act,Act):-var(Act),!,dmsg(vette_idea(Agent,Act)).
vette_idea(_,actSit,actSit):-!.
vette_idea(Agent,Act,Act):-dmsg(vette_idea(Agent,Act)).

mudLabelTypeProps('Px',tExplorer,[]).

world_agent_plan(_World,Agent,ActV):-
   tAgentGeneric(Agent),
  % isa(Agent,explorer),
   explorer_idea(Agent,Act),
   vette_idea(Agent,Act,ActV).

% Possible agent actions.
explorer_idea(Agent,actEat(Elixer)) :-
	mudHealth(Agent,Damage),
	Damage < 15,
   actInventory(Agent,List),
   obj_memb(Elixer,List),
   mudIsa(Elixer,tElixer).

explorer_idea(Agent,actEat(tFood)) :-
	mudCharge(Agent,Charge),
	Charge < 150,
   actInventory(Agent,List),
   obj_memb(Food,List),
   mudIsa(Food,tFood).

explorer_idea(Agent,actTake(Good)) :-
	get_feet(Agent,What),
        obj_memb(Good,What),
	isa_any(Good,[tGold,tElixer,tTreasure]).  

explorer_idea(Agent,actTake(Good)) :-
	get_feet(Agent,What),
        obj_memb(Good,What),
	isa_any(Good,[tFood,usefull,tItem]).

explorer_idea(Agent,actMove(1,Dir)) :-
	get_percepts(Agent,List),
	list_object_dir_sensed(_,List,tTreasure,Dir).

explorer_idea(Agent,actMove(3,Dir)) :-
	get_percepts(Agent,List),
	list_object_dir_sensed(_,List,tMonster,OppDir),
	reverse_dir(OppDir,Dir),
	number_to_dir(N,Dir,here),
        nth1(N,List,What),
	What == [].

explorer_idea(Agent,actMove(1,Dir)) :-
	get_percepts(Agent,List),
	list_object_dir_sensed(_,List,usefull,Dir).

explorer_idea(Agent,actMove(1,Dir)) :-
	get_percepts(Agent,List),
	list_object_dir_sensed(_,List,tAgentGeneric,Dir).

explorer_idea(Agent,actMove(5,Dir)) :-
	mudMemory(Agent,directions([Dir|_])),
	num_near(Num,Dir,here),
	get_near(Agent,List),
	nth1(Num,List,What),
	What == [].

explorer_idea(Agent,actAttack(Dir)) :-
	get_near(Agent,List),
	list_object_dir_near(List,tMonster(_),Dir).

explorer_idea(Agent,actLook) :-
        req(mudMemory(Agent,directions(Old))),
	del(mudMemory(Agent,directions(Old))),
	random_permutation(Old,New),
	add(mudMemory(Agent,directions(New))).


:- include(logicmoo(vworld/moo_footer)).
