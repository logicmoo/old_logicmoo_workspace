/** <module> 
% A MUD testing API is defined here
% 
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/
:-module(mud_testing,[]).

/*
:- maplist(export,
	[run_mud_tests/0,
        run_mud_test/2,
        test_name/1,
        test_true/1,
        run_mud_test/1,
        test_false/1,
        
        test_call/1]).
*/

% :- include(prologmud(mud_header)).

:- dynamic(lmcache:last_test_name/1).

:- thread_local was_test_name/1.
:- multifile(lmconf:mud_regression_test/0).
:- multifile(lmconf:mud_test_local/0).
:- multifile(lmconf:mud_test_full/0).

:- discontiguous(lmconf:mud_regression_test/0).
:- discontiguous(lmconf:mud_test_local/0).
:- discontiguous(lmconf:mud_test_full/0).

:- meta_predicate test_call(+).
:- meta_predicate run_mud_test(+,+).
:- meta_predicate test_true(+).
:- meta_predicate test_true_req(+).
:- meta_predicate test_false(+).
:- meta_predicate run_mud_test(+).

% :- trace,leash(+all),meta_predicate run_mud_tests().

:- include(prologmud(mud_header)).
% :- register_module_type (utility).

% do some sanity testing (expects the startrek world is loaded)
run_mud_tests:-
  forall(lmconf:mud_test(Name,Test),run_mud_test(Name,Test)).

action_info(actTests,"run run_mud_tests").

agent_command(_Agent,actTests) :- scan_updates, run_mud_tests.


action_info(actTest(ftTerm),"run tests containing term").

agent_command(Agent,actTest(Obj)):-foc_current_agent(Agent),run_mud_test(Obj).


test_name(String):-fmt(start_moo_test(mudNamed(String))),asserta(was_test_name(String)).
lmcache:last_test_name(String):- was_test_name(String),!.
lmcache:last_test_name(unknown).

test_result(Result):-test_result(Result,true).

test_result(Result,SomeGoal):- lmcache:last_test_name(String),fmt(Result:test_mini_result(Result:String,SomeGoal)).

from_here(_:SomeGoal):-!,functor(SomeGoal,F,_),atom_concat(actTest,_,F).
from_here(SomeGoal):-!,functor(SomeGoal,F,_),atom_concat(actTest,_,F).

test_call(X):- var(X),!, throw(var(test_call(X))).
test_call(meta_callable(String,test_name(String))):-!,string(String).
test_call(meta_call(X)):- show_call(test_call0(X)).
test_call(Goal):-  meta_interp(test_call,Goal).

test_call0(SomeGoal):- from_here(SomeGoal),!,req1(SomeGoal).
test_call0(SomeGoal):- dmsg(req1(SomeGoal)), catch(SomeGoal,E,(test_result(error(E),SomeGoal),!,fail)).

test_true_req(Req):- test_true(req1(Req)).
test_true(SomeGoal):- test_call(SomeGoal) *-> test_result(passed,SomeGoal) ;  test_result(failed,SomeGoal).
test_false(SomeGoal):- test_true(not(SomeGoal)).

run_mud_test(Filter):-
   doall((
   member(F/A,[lmconf:mud_test/0,lmconf:mud_test/1,lmconf:mud_test/2]),   
   current_predicate(M:F/A),
   functor(H,F,A),
   not(predicate_property(M:H,imported_from(_))),
   clause(M:H,B),
   term_matches_hb(Filter,M:H,B),
   once(run_mud_test_clause(M:H,B)),
   fail)).

run_mud_test_clause(M:mud_test,B):- must((contains_term(test_name(Name),nonvar(Name)))),!, M:run_mud_test(Name,B).
run_mud_test_clause(M:mud_test(Name),B):- !, M:run_mud_test(Name,B).
run_mud_test_clause(M:mud_test(Name,Test),B):- forall(B,M:run_mud_test(Name,Test)).
run_mud_test(Name,Test):-
   fmt(begin_mud_test(Name)),
   once(catch((test_call(Test),fmt(completed_mud_test(Name))),E,fmt(error_mud_test(E, Name)));fmt(actTests(incomplet_mud_test(Name)))).





% define tests locally


%:- mpred_trace_exec.
%:- set_prolog_flag(logicmoo_debug,true).

lmconf:mud_test(test_fwc_1,
  (on_x_debug(ain(tAgent(iExplorer1))),
   nop(mpred_fwc(tAgent(iExplorer1))),
   % test_false(mudFacing(iExplorer1,vSouth)),
   test_true(mudFacing(iExplorer1,vNorth)),
   ain(mudFacing(iExplorer1,vSouth)),
   test_false(mudFacing(iExplorer1,vNorth)),
   test_true(mudFacing(iExplorer1,vSouth)))).

lmconf:mud_test(test_fwc_2,
  (ain(tAgent(iExplorer1)),
    mpred_fwc1(tAgent(iExplorer1)),
   mpred_remove(mudFacing(iExplorer1,vSouth)),
   test_true(mudFacing(iExplorer1,vNorth)),
   test_false(mudFacing(iExplorer1,vSouth)))).


lmconf:mud_test(test_movedist,
 (
  foc_current_agent(P),
   test_name("teleport to main enginering"),
   do_agent_action('tp self to Area1000'),
  test_name("now we are really somewhere"),
   test_true(req1(mudAtLoc(P,_Somewhere))),
  test_name("in main engineering?"),
   test_true(req1(localityOfObject(P,'Area1000'))),
   test_name("set the move dist to 5 meters"),
   do_agent_action('@set mudMoveDist 5'),
   test_name("going 5 meters"),
   % gets use out of othre NPC path
   do_agent_action('move e'),
   do_agent_action('move n'),
   test_name("must be now be in corridor"),
   test_true(req1(localityOfObject(P,'Area1002'))),
   do_agent_action('@set mudMoveDist 1'),
   call_n_times(5, do_agent_action('s')),
   do_agent_action('move s'),
   test_name("must be now be back in engineering"),
   test_true(req1(localityOfObject(P,'Area1000'))))).

mud_test_level2(create_gensym_named,
  with_all_dmsg(((do_agent_action('create food999'),
  foc_current_agent(P),
  must(( req1(( mudPossess(P,Item),isa(Item,food))))))))) .

mud_test_level2(drop_take,
  with_all_dmsg(((do_agent_action('create food'),
  do_agent_action('drop food'),
  do_agent_action('take food'),
  do_agent_action('eat food'))))).


:- catch(noguitracer,_,true).

% [Optionally] load and start sparql server
%:- at_start(start_servers)

% [Optionaly] Add some game content
:- if_flag_true(was_runs_tests_pl, declare_load_dbase(logicmoo('rooms/startrek.all.pfc.pl'))).

lmconf:mud_test_local:-
   test_name("tests to see if we have: player1"),
   test_true(show_call(foc_current_agent(_Agent))).

lmconf:mud_test_local:-
   test_name("tests to see if we have: mudAtLoc"),
   test_true((foc_current_agent(Agent),show_call(mudAtLoc(Agent,_Where)))).

lmconf:mud_test_local:- 
   test_name("tests to see if we have: localityOfObject"),
   test_true((foc_current_agent(Agent),show_call(localityOfObject(Agent,_Where)))).

lmconf:mud_test_local:- 
   test_name("tests to see if our clothing doesnt: mudAtLoc"),
   test_false(mudAtLoc('iGoldUniform775',_X)).
    
lmconf:mud_test_local:- 
   foc_current_agent(Agent),
   test_name("tests to see if we have: argIsas on mudEnergy"),
   test_true(correctArgsIsa(mudEnergy(Agent,_),_)).

lmconf:mud_test_local:- 
   test_name("tests to see if we have: singleValued on mudMoveDist"),
   foc_current_agent(Agent),
   must(ain(mudMoveDist(Agent,3))),
   test_true(must((findall(X,mudMoveDist(Agent,X),L),length(L,1)))).

lmconf:mud_test_local:- 
      test_name("nudity test"), 
      foc_current_agent(Agent),
       test_true_req(wearsClothing(Agent, 'ArtifactCol1003-Gold-Uniform775')).

lmconf:mud_test_local:- 
      test_name("genlInverse test"), 
      foc_current_agent(Agent),
       test_true_req(mudPossess(Agent, 'ArtifactCol1003-Gold-Uniform775')).

lmconf:mud_test_local:- 
   test_name("Tests our action templates"), doall((get_all_templates(Templates),dmsg(get_all_templates(Templates)))).

lmconf:mud_test_local:-
   test_name("tests to see if 'food' can be an item"),
      test_true(parseIsa(tItem, _, [food], [])).

lmconf:mud_test_local:-req1(cmdShowRoomGrid('Area1000')).


% more tests even
lmconf:mud_test_local :- call_u(do_agent_action("look")).
lmconf:mud_test_local :- forall(localityOfObject(O,L),dmsg(localityOfObject(O,L))).

% ---------------------------------------------------------------------------------------------

:-thread_local t_l:is_checking_instance/1.

:-ain_expanded(prologBuiltin(check_consistent(ftTerm,ftInt))).
% :-decl_mpred_prolog(check_consistent(ftTerm,ftInt)).
:-decl_mpred_prolog(is_instance_consistent(ftTerm,ftInt)).
:-decl_mpred_prolog(bad_instance(ftTerm,ftTerm)).
% :-decl_mpred_prolog(t_l:is_checking_instance(ftTerm)).

check_consistent(Obj,Scope):-var(Scope),!,check_consistent(Obj,0).
check_consistent(Obj,Scope):-is_instance_consistent(Obj,Was),!,Was>=Scope.
check_consistent(Obj,_):- t_l:is_checking_instance(Obj),!.
check_consistent(Obj,Scope):- w_tl(t_l:is_checking_instance(Obj),doall(check_consistent_0(Obj,Scope))).
check_consistent_0(Obj,Scope):- once((catch((doall(((clause(hooked_check_consistent(Obj,AvScope),Body),once(var(AvScope); (AvScope =< Scope) ),Body))),assert_if_new(is_instance_consistent(Obj,Scope))),E,assert_if_new(bad_instance(Obj,E))))),fail.
check_consistent_0(Type,Scope):- once(tSet(Type)),
 catch((forall(isa(Obj,Type),check_consistent(Obj,Scope)),
                                                   assert_if_new(is_instance_consistent(Type,Scope))),E,assert_if_new(bad_instance(Type,E))),fail.

hooked_check_consistent(Obj,20):-must(object_string(_,Obj,0-5,String)),dmsg(checked_consistent(object_string(_,Obj,0-5,String))).
% ---------------------------------------------------------------------------------------------
lmconf:mud_test_local:-
  test_name("Tests our types to populate bad_instance/2 at level 5"),
  retractall(is_instance_consistent(_,_)),
  retractall(bad_instance(_,_)),
  forall(genls(T,tSpatialThing),check_consistent(T,1000)),
  listing(bad_instance/2).


% lmconf:mud_test("local sanity tests",  do_mud_test_locals).

% w_tl/2

% :- 'mpred_hide_childs'(dbase:record_on_thread/2).

% [Manditory] This loads the game and initializes so test can be ran
:- if_flag_true(was_runs_tests_pl, at_start(run_setup)).

% the real tests now (once)
do_mud_test_locals:- forall(clause(lmconf:mud_test_local,B),must(B)).
:- if_flag_true(was_runs_tests_pl,at_start(must_det(run_mud_tests))).

% the local tests each reload (once)
:- if_flag_true(was_runs_tests_pl, do_mud_test_locals).

% halt if this was the script file
:- if_flag_true(was_runs_tests_pl, halt).



% the local tests each reload (once)
now_run_local_tests_dbg :- doall(lmconf:mud_test_local).

% nasty way i debug the parser
% :-repeat, trace, do_agent_action('who'),fail.
lmconf:mud_test_local :- call_u(do_agent_action('who')).

% lmconf:mud_test_local :-do_agent_action("scansrc").

% more tests even
lmconf:mud_test_local :- call_u(do_agent_action("look")).
lmconf:mud_test_local :-forall(localityOfObject(O,L),dmsg(localityOfObject(O,L))).

must_test("tests to see if poorly canonicalized code (unrestricted quantification) will not be -too- inneffienct",
   forall(mudAtLoc(O,L),fmt(mudAtLoc(O,L)))).

% the real tests now (once)
lmconf:mud_test_local :- at_start(must_det(run_mud_tests)).


% :- forall(clause(mud_regression_test,Call),must(Call)).




:- module_predicates_are_exported.

:- module_meta_predicates_are_transparent(mud_testing).
