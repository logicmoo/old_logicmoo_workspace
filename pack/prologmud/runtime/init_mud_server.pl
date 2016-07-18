#!/usr/bin/env swipl
/** <module> MUD server startup script in SWI-Prolog

*/
/*
:- set_prolog_flag(access_level,system).

:- if( \+ current_module(prolog_stack)).
:- system:use_module(library(prolog_stack)).
 prolog_stack:stack_guard(none).
:- endif.

:- use_module(library(prolog_history)).
:- use_module(library(base32)).
:- set_prolog_flag(report_error,true).
:- set_prolog_flag(compile_meta_arguments,false).
:- set_prolog_flag(debug_on_error,true).
:- set_prolog_flag(debugger_write_options,[quoted(true), portray(true), max_depth(1000), attributes(portray)]).
:- set_prolog_flag(generate_debug_info,true).
*/

:- system:ensure_loaded(setup_paths).
:- if(( system:use_module(library('logicmoo/util/logicmoo_util_clause_expansion.pl')), push_modules)). 
:- endif.
% :- module(init_mud_server,[]).
% restore entry state
:- reset_modules.

:- set_prolog_flag(access_level,system).

:- 
 op(1190,xfx,('::::')),
 op(1180,xfx,('==>')),
 op(1170,xfx,'<==>'),  
 op(1160,xfx,('<-')),
 op(1150,xfx,'=>'),
 op(1140,xfx,'<='),
 op(1130,xfx,'<=>'), 
 op(600,yfx,'&'), 
 op(600,yfx,'v'),
 op(350,xfx,'xor'),
 op(300,fx,'~'),
 op(300,fx,'-'),
 op(1199,fx,('==>')).

:- set_prolog_flag(access_level,user).

:- multifile
        prolog:message//1,
        prolog:message_hook/3.

% prolog:message(ignored_weak_import(Into, From:PI))--> { nonvar(Into),Into \== system,dtrace(dmsg(ignored_weak_import(Into, From:PI))),fail}.
% prolog:message(Into)--> { nonvar(Into),functor(Into,_F,A),A>1,arg(1,Into,N),\+ number(N),dtrace(wdmsg(Into)),fail}.
% prolog:message_hook(T,error,Warn):- dtrace(wdmsg(nessage_hook(T,warning,Warn))),fail.
% prolog:message_hook(T,warning,Warn):- dtrace(wdmsg(nessage_hook(T,warning,Warn))),fail.

:- set_prolog_flag(dialect_pfc,false).
:- set_prolog_stack(global, limit(16*10**9)).
:- set_prolog_stack(local, limit(16*10**9)).
:- set_prolog_stack(trail, limit(16*10**9)).
:- set_prolog_flag(unsafe_speedups,true).
% ==========================================================
% Sanity tests that first run whenever a person stats the MUD to see if there are regressions in the system
% ==========================================================

:- system:ensure_loaded(library(prolog_server)).
:- prolog_server(4001, [allow(_)]).
:- system:ensure_loaded(library(logicmoo_utils)).
:- if(exists_source(library(eggdrop))).
:- ensure_loaded(library(eggdrop)).
:- egg_go.
:- endif.
%:- use_listing_vars.
% :- [run].
:- forall(debugging(X),nodebug(X)).
:- system:ensure_loaded(logicmoo_repl).
:- forall(debugging(X),nodebug(X)).
%:- set_prolog_flag(logicmoo_debug,true).
%:- set_prolog_flag(unsafe_speedups,false).

:-assert_isa(iRR7,tRR).
:-ain(genls(tRR,tRRP)).
:-must( isa(iRR7,tRRP) ).
:-must( tRRP(iRR7) ).
:-kb_dynamic(lmconf:sanity_test/0).
:-kb_dynamic(lmconf:regression_test/0).
:-kb_dynamic(lmconf:feature_test/0).
:- kb_dynamic((        
        lmconf:feature_test/0,
        lmconf:mud_test/2,
        lmconf:regression_test/0,
        lmconf:sanity_test/0,
        agent_call_command/2,
        action_info/2,
        type_action_info/3)).


%:- ensure_webserver(3020).
:- initialization(ensure_webserver(3020)).
:- initialization(ensure_webserver(3020),now).
:- initialization(ensure_webserver(3020),restore).

:- set_prolog_flag(dialect_pfc,false).

:- file_begin(pl).
:- ensure_loaded(logicmoo(logicmoo_engine)).

% [Mostly Required] Load the Logicmoo Parser/Generator System
:- gripe_time(40,user:ensure_loaded(library(parser_all))).


% [Mostly Required] Load the Logicmoo Plan Generator System
:- with_no_mpred_expansions(if_file_exists(user:ensure_loaded(library(logicmoo/logicmoo_planner)))).


% [Required] Load the CYC Network Client and Logicmoo CycServer Emulator (currently server is disabled)
% :- with_no_mpred_expansions(if_file_exists(user:ensure_loaded(library(logicmoo/logicmoo_u_cyc_api)))).

% [Optional] NOT YET Load the Logicmoo RDF/OWL Browser System
% % :- with_no_mpred_expansions(if_file_exists(user:ensure_loaded(logicmoo(mpred_online/mpred_rdf)))).


% [Debugging] Normarily this set as 'true' can interfere with debugging
% :- set_prolog_flag(gc,true).
% Yet turning it off we cant even startup without crashing
% :- set_prolog_flag(gc,false).

:- doall(printAll(current_prolog_flag(_N,_V))).

% ==========================================================
% Regression tests that first run whenever a person stats the MUD on the public server
% ==========================================================

:- if((gethostname(ubuntu),fail)). % INFO this fail is so we can start faster
:- show_entry(gripe_time(40, doall(lmconf:regression_test))).
:- endif.


% ==============================
% MUD SERVER CODE LOADS
% ==============================

:- push_modules.
% [Required] load the mud system
:- show_entry(gripe_time(40,ensure_loaded(prologmud(mud_loader)))).
:- reset_modules.

%:- set_prolog_flag(logicmoo_debug,true).


% ==============================
% MUD SERVER CODE STARTS
% ==============================

:- file_begin(pfc).
:- set_prolog_flag(dialect_pfc,false).



:- set_prolog_flag(dialect_pfc,true).
%:- set_prolog_flag(logicmoo_debug,true).
%:- set_prolog_flag(unsafe_speedups,false).
:- forall(debugging(X),nodebug(X)).

% [Optional] Creates or suppliments a world

tCol(tRegion).
tCol(tLivingRoom).
genls(tLivingRoom,tRegion).
genls(tOfficeRoom,tRegion).


%genlsFwd(tLivingRoom,tRegion).
%genlsFwd(tOfficeRoom,tRegion).

% create some seats
tExplorer(iExplorer1).
tExplorer(iExplorer2).
tExplorer(iExplorer3).
tExplorer(iExplorer4).
tExplorer(iExplorer5).
tExplorer(iExplorer6).

(tHumanBody(skRelationAllExistsFn)==>{trace_or_throw(tHumanBody(skRelationAllExistsFn))}).

genls(tExplorer,tHominid).

:- ain(localityOfObject(P,_)==>{put_in_world(P)}).


tRegion(iLivingRoom7).
tRegion(iOfficeRoom7).

tExplorer(iExplorer7).
wearsClothing(iExplorer7,'iBoots773').
wearsClothing(iExplorer7,'iCommBadge774').
wearsClothing(iExplorer7,'iGoldUniform775').
mudStowing(iExplorer7,'iPhaser776').

:-onSpawn(localityOfObject(iExplorer7,tLivingRoom)).

pddlSomethingIsa('iBoots773',['tBoots','ProtectiveAttire','PortableObject','tWearAble']).
pddlSomethingIsa('iCommBadge774',['tCommBadge','ProtectiveAttire','PortableObject','tNecklace']).
pddlSomethingIsa('iGoldUniform775',['tGoldUniform','ProtectiveAttire','PortableObject','tWearAble']).
pddlSomethingIsa('iPhaser776',['tPhaser','Handgun',tWeapon,'LightingDevice','PortableObject','DeviceSingleUser','tWearAble']).

tMonster(iCommanderdata66).
tExplorer(iCommanderdata66).
mudDescription(iCommanderdata66,txtFormatFn("Very screy looking monster named ~w",[iCommanderdata66])).
tAgent(iCommanderdata66).
tHominid(iCommanderdata66).
wearsClothing(iCommanderdata66,'iBoots673').
wearsClothing(iCommanderdata66,'iCommBadge674').
wearsClothing(iCommanderdata66,'iGoldUniform675').
mudStowing(iCommanderdata66,'iPhaser676').

pddlSomethingIsa('iBoots673',['tBoots','ProtectiveAttire','PortableObject','tWearAble']).
pddlSomethingIsa('iCommBadge674',['tCommBadge','ProtectiveAttire','PortableObject','tNecklace']).
pddlSomethingIsa('iGoldUniform675',['tGoldUniform','ProtectiveAttire','PortableObject','tWearAble']).
pddlSomethingIsa('iPhaser676',['tPhaser','Handgun',tWeapon,'LightingDevice','PortableObject','DeviceSingleUser','tWearAble']).
:-onSpawn(localityOfObject(iCommanderdata66,tOfficeRoom)).
  

mpred_argtypes(bordersOn(tRegion,tRegion)).


:- call_u(onSpawn(bordersOn(tLivingRoom,tOfficeRoom))).
:- nortrace,notrace.

:- set_prolog_flag(dialect_pfc,false).

:- file_begin(pl).

%:- ensure_loaded(logicmoo(plarkc/logicmoo_i_cyc_kb)).


% [Optionaly] Start the telent server % iCommanderdata66
start_telnet:- on_x_log_cont(start_mud_telnet_4000).

% :- if_startup_script(initialization(start_telnet)).
:- rl_add_history( 'start_telnet.' ).
:- rl_add_history( 'user:ensure_loaded(run_mud_game).' ).
:- rl_add_history( 'login_and_run.' ).


% :-  statistics(globallimit,G),statistics(locallimit,L),statistics(traillimit,T), qsave_program(run_mud_server,[map('run_mud_server.sav'),global(G),trail(T),local(L)]).

:- write('\n?- user:ensure_loaded(run_mud_game). % to begin loading mud worlds').
% :- user:ensure_loaded(start_mud_server).

lar:- login_and_run.

:- initialization(ensure_webserver(3020),now).

:- set_prolog_flag(unsafe_speedups,true).
% isa(starTrek,mtCycL).
% :- starTrek:force_reload_mpred_file('../games/src_game_startrek/*.pfc.pl').
:- force_reload_mpred_file('../games/src_game_startrek/*.pfc.pl').
:- set_prolog_flag(unsafe_speedups,false).

:- must_det(argIsa(genlPreds,2,_)).

%:- ensure_loaded(logicmoo(plarkc/logicmoo_i_cyc_kb)).
%:- initialization(ltkb1,now).
:- initialization(lar).
:- initialization(lar,restore).

end_of_file.




Warning: baseKB:list_to_atomics_list/2, which is referenced by
Warning:        /root/lib/swipl/pack/prologmud/prolog/prologmud/vworld/world_text.pl:130:75: 1-st clause of baseKB:join_for_string/2
Warning: baseKB:logOnFailureIgnore/1, which is referenced by
Warning:        /root/lib/swipl/pack/prologmud/prolog/prologmud/parsing/simple_decl_parser.pl:218:1: 1-st clause of baseKB:assert_text_now/3
Warning: baseKB:member_eq/2, which is referenced by
Warning:        /root/lib/swipl/pack/prologmud/prolog/prologmud/parsing/parser_imperative.pl:176:18: 8-th clause of baseKB:save_fmt_e/2
Warning: baseKB:prevent_transform_moo_preds/0, which is referenced by
Warning:        /root/lib/swipl/pack/prologmud/prolog/prologmud/mud_loader.pl:201:20: 1-st clause of baseKB:slow_work/0
Warning: baseKB:replace_nth_arglist/5, which is referenced by
Warning:        /root/lib/swipl/pack/prologmud/prolog/prologmud/vworld/world_text.pl:68:65: 1-st clause of baseKB:term_anglify_args/6
Warning: baseKB:show_load_call/1, which is referenced by
Warning:        /root/lib/swipl/pack/prologmud/prolog/prologmud/vworld/world_text.pl:363:64: 3-th clause of baseKB:add_description_kv/3
Warning: baseKB:tag_pos/2, which is referenced by
Warning:        /root/lib/swipl/pack/prologmud/prolog/prologmud/parsing/simple_decl_parser.pl:241:106: 1-st clause of baseKB:translation_for/5
Warning: kellerStorage:kellerStorageTestSuite/0, which is referenced by
Warning:        2-nd clause of lmconf:mud_test_local/0: 2-nd clause of lmconf:mud_test_local/0

