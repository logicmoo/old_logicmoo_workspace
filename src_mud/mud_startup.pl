/** <module> 
% This file loads the world (world.pl), the map of the world, 
% the agents and their definitions.
% This file is used as a configuation file and a startup script.
%
% July 10,1996
% John Eikenberry
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/


:- set_prolog_flag(verbose_load,true).

:- include(mud_header).

:- set_prolog_flag(generate_debug_info, true).
% [Optionaly] Set the Prolog optimize/debug flags
:- set_prolog_flag(verbose_load,true).
:- use_module(library(gui_tracer)).
:- set_prolog_flag(gui_tracer, false).
:- set_prolog_flag(answer_write_options, [quoted(true), portray(true), max_depth(1000), spacing(next_argument)]).
:- catch(noguitracer,_,true).


% [Optionaly] Set up the Prolog optimize/debug flags
%:- set_prolog_flag(debug,false).
:- set_optimize(false).


% [Optionaly] load the mpred_online system
% :- if_file_exists(user:ensure_loaded(library(logicmoo/mpred_online))).

:- prolog_load_context(directory,Dir),asserta(user:file_search_path(prologmud,Dir)).

xyzFn(R,X,Y,Z):-dmsg(xyzFn(R,X,Y,Z)),trace_or_throw(xyzFn(R,X,Y,Z)).

:- multifile
	prolog:message/3.

prolog:message(git(update_versions),A,A):-!.

:- use_module(library(settings)).
% :- use_module(library(check)).
% :- make.
:- portray_text(true).

:-set_prolog_stack(global, limit(64*10**9)).
:-set_prolog_stack(local, limit(64*10**9)).
:-set_prolog_stack(trail, limit(64*10**9)).

:- ((current_prolog_flag(readline, true))->expand_file_name("~/.pl-history", [File|_]),(exists_file(File) -> rl_read_history(File); true),at_halt(rl_write_history(File));true).


:- multifile( entailment:rdf /3 ).

% [Optionaly] Solve the Halting problem
:-use_module(library(process)).
:-use_module(library(pce)).
:- has_gui_debug -> true ; remove_pred(pce_principal,send,2).
:- has_gui_debug -> true ; remove_pred(pce_principal,new,2).


unsafe_preds(M,F,A):-M=files_ex,current_predicate(M:F/A),member(X,[delete,copy]),atom_contains(F,X).
unsafe_preds(M,F,A):-M=process,current_predicate(M:F/A),member(X,[kill,create]),atom_contains(F,X).
unsafe_preds(M,F,A):-M=system,member(F,[shell,halt]),current_predicate(M:F/A).

:-forall(unsafe_preds(M,F,A),bugger:remove_pred(M,F,A)).

% [Optionaly] Solve the Halting problem
:-redefine_system_predicate(system:halt).
:-abolish(system:halt,0).
system:halt:- format('the halting problem is now solved!').

:- dmsg('the halting problem is now solved!').

add_game_dir(GAMEDIR,Else):- add_to_search_path_first(game, GAMEDIR),now_try_game_dir(Else).

now_try_game_dir(Else):-  enumerate_files(game('.'), GAMEDIR) *-> 
  ((exists_directory(GAMEDIR) -> 
    with_all_dmsg(( 
      % forall(enumerate_files(game('**/*.pl'),X),user:ensure_loaded(X)),
      forall(no_repeats_old(X,enumerate_files(game('**/*.plmoo'),X)),declare_load_dbase(X)))); (fmt(missing(GAMEDIR)),Else)));  (fmt(no_game_dir),Else).


:-context_module(CM),assert(user:loading_from_cm(CM)).
create_module(M):-context_module(CM),module(M),asserta(M:this_is_a_module(M)),writeq(switching_back_to_module(CM)),module(CM).
:-create_module(user).
:-create_module(hook).
:-create_module(thlocal).
:-create_module(thglobal).
%:-create_module(moo).


:-module_transparent parser_chat80_module/1.
:-multifile parser_chat80_module/1.
:-export((parser_chat80_module/1)).
parser_chat80_module(moo).


:-export(prolog_repl/0).
prolog_repl:- with_all_dmsg((nl,fmt("Press Ctrl-D to start the mud!"),nl,'@'(prolog,'user'))).

:- set_prolog_flag(gui,false).
:- set_prolog_flag(history,1000).


:-export(within_user/1).
:-export(is_startup_file/1).

is_startup_file(Name):- current_prolog_flag(os_argv,ArgV),member(Named,ArgV),atom(Named),atom_concat(Name,_,Named),!.

within_user(Call):- '@'(Call,'user').

% ======================================================
% Configure the logicmoo utilities into the file path
% :- include('logicmoo_util/logicmoo_util_header').
% :- user_use_module('logicmoo_util/logicmoo_util_all.pl').
% And adds the local directories to file search path of logicmoo(..)
% ======================================================

:- user_use_module(library(settings)).

:- user:file_search_path(cliopatria,SP),
   exists_directory(SP),
   writeq(user:file_search_path(cliopatria,SP)),nl.
   %set_setting_default(cliopatria_binding:path, SP).
   %save_settings('moo_settings.db').
   %%setting(cliopatria_binding:path, atom, SP, 'Path to root of cliopatria install'),!.

% :- user_use_module(logicmoo('http/user_page')).

:- meta_predicate(user:if_version_greater(?,0)).

user:if_version_greater(V,Goal):- current_prolog_flag(version,F), ((F > V) -> call(Goal) ; true).

% set to false because we don't want to use the mudconsole
:- if_flag_true(false, user:if_version_greater(70109,user_use_module(logicmoo('mudconsole/mudconsolestart')))).

% [Optionaly 1st run] tell where ClioPatria is located and restart for the 2nd run
%:- set_setting(cliopatria_binding:path, '/devel/ClioPatria'), save_settings('moo_settings.db').

start_boxer:-
   threads,
   ensure_loaded(logicmoo(candc/parser_boxer)),
   % make,   
   at_start(prolog_repl).


% We don't start cliopatria we here. We have to manually start
%  with  ?- start_servers.
hard_work:-!.
hard_work:-
   with_no_term_expansions(with_assertions(op(200,fy,'@'),
   ((
 %  use_module('t:/devel/cliopatria/rdfql/sparql_runtime.pl'),
  % ensure_loaded(logicmoo(launchcliopatria)),
  % ensure_loaded(logicmoo(testwebconsole)),
  % kill_term_expansion, 
   ensure_loaded(swish(logicmoo_run_swish))
   )))),!.

% [Required] load the mud PFCs
:- user:ensure_loaded(prologmud(server/mud_builtin)).


slow_work:- with_assertions( prevent_transform_moo_preds , within_user(at_start(hard_work))).

thread_work:- thread_property(X, status(running)),X=loading_code,!.
thread_work:- thread_create(slow_work,_,[alias(loading_code)]).

% start_servers :- user:if_version_greater(70111,thread_work).
start_servers :- user:if_version_greater(70111,slow_work).

enqueue_player_command(C):-enqueue_player_command(_,C).
enqueue_player_command(P,C):-foc_current_player(P),assertz_if_new(thglobal:player_command_stack(P,C)).


user:run_setup_now:-
   within_user((
      finish_processing_world      
   % TO UNDO register_timer_thread(npc_ticker,90,npc_tick)
   )).

run_setup:- within_user(at_start(user:run_setup_now)).

run:- within_user(at_start(login_and_run)).




% [Optionaly] load and start sparql server
% starts in forground
%:- at_start(slow_work).
% starts in thread (the the above was commented out)
%:- at_start(start_servers).
% commented out except on run

debug_repl_w_cyc(Module,CallFirst):- !,         
          with_assertions(thlocal:useOnlyExternalDBs,
            with_assertions(thglobal:use_cyc_database,
               ((decl_type(person),          
                ensure_plmoo_loaded(logicmoo('rooms/startrek.all.plmoo')),
                module(Module),
                show_call(CallFirst), 
                prolog_repl)))).

debug_repl_wo_cyc(Module,CallFirst):- !,         
          with_no_assertions(thlocal:useOnlyExternalDBs,
            with_assertions(thglobal:use_cyc_database,
               ((decl_type(person),          
                ensure_plmoo_loaded(logicmoo('rooms/startrek.all.plmoo')),
                module(Module),
                show_call(CallFirst), 
                prolog_repl)))).

%  bug.. swi does not maintain context_module(CM) outside
%  of the current caller (so we have no idea what the real context module is!?!
debug_repl_m(Module,CallFirst):- 
        context_module(CM),
          call_cleanup(
            (module(Module),
              debug_repl_wo_cyc(Module,CallFirst)),
            module(CM)).

% [Required] Defines debug80
debug80:- parser_chat80_module(M),debug_repl_wo_cyc(M,M:t1).

% [Optionaly] Allows testing/debug of the chat80 system (withouyt loading the servers)
% :- parser_chat80:t1.

% [Required] Defines debug_e2c
debug_e2c:- debug_repl_wo_cyc(parser_e2c,cache_the_posms).


% [Required] Defines debug_talk
debug_talk:- debug_repl_wo_cyc(parser_talk,t3).


% [Optional] This loads boxer
% :- at_start(with_assertions(prevent_transform_moo_preds,within_user(ignore(catch(start_boxer,_,true))))).

% [Optional] Testing PTTP
% :-is_startup_file('run_debug.pl')->doall(do_pttp_test(_));true.

% Was this our startup file?
was_runs_tests_pl:-is_startup_file('run_tests.pl').

% [Optional] Interactively debug E2C
% :- debug_e2c.


mud_test_local :- current_predicate(kellerStorage:kellerStorageTestSuite/0) -> kellerStorage:kellerStorageTestSuite ; true.

% :-curt80.


% the real tests now (once)
mud_test_local :- if_flag_true(was_runs_tests_pl,at_start(must_det(run_mud_tests))).

 % :- if_flag_true(was_runs_tests_pl, doall(now_run_local_tests_dbg)).


% [Optionaly] Allows testing/debug of the chat80 system (withouyt loading the servers)
% :- debug80.
/*

explorer(player1)> prolog statistics
notice(you,begin(you,mpred_call(statistics)))
statistics.
188.523 seconds cpu time for 282,024,744 inferences
1,004,265 atoms, 14,959 functors, 11,578 predicates, 176 modules, 268,104,937 VM-codes

                       Limit    Allocated       In use
Local  stack :137,438,953,472      126,976       41,032 Bytes
Global stack :137,438,953,472  805,302,256  669,634,856 Bytes
Trail  stack :137,438,953,472      129,016        2,448 Bytes

1 garbage collections gained 41,528 bytes in 0.000 seconds.
2 atom garbage collections gained 19,741 atoms in 1.360 seconds.
Stack shifts: 4 local, 22 global, 20 trail in 0.038 seconds.
2 threads, 0 finished threads used 0.000 seconds.
true.

cmdresult(statistics,true)

*/

% :- kill_term_expansion.
% :- slow_work.
% :- prolog.
% :- now_run_local_tests_dbg.
% :- prolog.

% :-foc_current_player(P),assertz_if_new(thglobal:player_command_stack(P,chat80)).
:- if_flag_true(was_runs_tests_pl, at_start(run)).


% So scripted versions don't just exit
%:- if_flag_true(was_runs_tests_pl,at_start(prolog)).

%:- kill_term_expansion.
%:- prolog.

% :-proccess_command_line.

/*

PTTP input formulas:
  1  firstOrder(motherOf,joe,sue).
  2  not_firstOrder(motherOf,_,A);firstOrder(female,A).
  3  not_firstOrder(sonOf,B,A);firstOrder(motherOf,A,B);firstOrder(fatherOf,A,B).
  4  query:-firstOrder(female,_).
PTTP to Prolog translation time: 0.0028555670000001143 seconds

Prolog compilation time: 0.0004133299999997675 seconds
2.
Proof time: 4.34149999994915e-5 seconds
Proof:
length = 2, depth = 1
Goal#  Wff#  Wff Instance
-----  ----  ------------
  [0]    4   query :- [1].
  [1]    2      firstOrder(female,sue) :- [2].
  [2]    1         firstOrder(motherOf,joe,sue).
Proof end.
%                    succceeded(prove_timed(logicmoo_example1,query))
%                do_pttp_test(logicmoo_example1_holds)

PTTP input formulas:
  1  firstOrder(motherOf,joe,sue).
  2  not_firstOrder(motherOf,_,A);firstOrder(female,A).
  3  not_firstOrder(sonOf,B,A);firstOrder(motherOf,A,B);firstOrder(fatherOf,A,B).
  4  query:-firstOrder(female,_).
PTTP to Prolog translation time: 0.0024834679999994336 seconds

Prolog compilation time: 0.00039567500000003974 seconds
2.
Proof time: 3.7734999999372576e-5 seconds
Proof:
length = 2, depth = 1
Goal#  Wff#  Wff Instance
-----  ----  ------------
  [0]    4   query :- [1].
  [1]    2      firstOrder(female,sue) :- [2].
  [2]    1         firstOrder(motherOf,joe,sue).
Proof end.
%                    succceeded(prove_timed(logicmoo_example1_holds,query))
%                do_pttp_test(logicmoo_example2)


*/


% standard header used in all files that all modules are loaded (therefore useful for when(?) the day comes that modules *can*only*see their explicitly imported modules)
%:- prolog_flag(unknown,error,fail). % Not sure if this is needed for Quintus
%:- use_module(library(random)).
%:- use_module(library(date)).
% This one is for use with SWI
:- use_module(library(quintus)).


% logicmoo utils shared with other systems
:- set_prolog_flag(double_quotes, atom).
:- set_prolog_flag(double_quotes, string).
/*
:- '@'((ensure_loaded(library(logicmoo/util/logicmoo_util_bugger)),
         ensure_loaded(library(logicmoo/util/logicmoo_util_library)),
         use_module(library(logicmoo/util/logicmoo_util_ctx_frame)),
         ensure_loaded(library(logicmoo/util/logicmoo_util_strings)),
         use_module(library(logicmoo/util/logicmoo_util_terms)),
         use_module(library(logicmoo/util/logicmoo_util_dcg)),
         use_module(prologmud(server/mud))),'user').
*/


% logicmoo vworld mud server

:- user:ensure_loaded(logicmoo(logicmoo_base)).
:- user:ensure_loaded(prologmud(server/mud_telnet)).
:- user:ensure_loaded(prologmud(vworld/world)).

:- user:ensure_loaded(prologmud(server/mud_testing)).


/*

 First time you run this 2 million clauses are qcompiled 
 (I've excluded 7 million more clauses that are only available with spec ial C Y C  Liciens ing)

%     /devel/logicmoo/src_data/pldata/tiny_kb.pl *qcompiled* into tiny_kb 2.40 sec, 8,481 clauses
%     /devel/logicmoo/src_data/pldata/nldata_freq_pdat.pl *qcompiled* into nldata_freq_pdat 7.88 sec, 107,704 clauses
%     /devel/logicmoo/src_data/pldata/nldata_BRN_WSJ_LEXICON.pl *qcompiled* into nldata_BRN_WSJ_LEXICON 7.65 sec, 113,863 clauses
%     /devel/logicmoo/src_data/pldata/nldata_colloc_pdat.pl *qcompiled* into nldata_colloc_pdat 6.31 sec, 64,081 clauses
%     /devel/logicmoo/src_data/pldata/nldata_cycl_pos0.pl *qcompiled* into nldata_cycl_pos0 0.20 sec, 2,488 clauses
%     /devel/logicmoo/src_data/pldata/nldata_dictionary_some01.pl *qcompiled* into nldata_dictionary_some01 0.03 sec, 293 clauses
%     /devel/logicmoo/src_data/pldata/tt0_00022_cycl.pl *qcompiled* into tt0_00022_cycl 26.86 sec, 313,234 clauses
%     /devel/logicmoo/src_data/pldata/hl_holds.pl *qcompiled* into hl_holds 175.31 sec, 1,041,317 clauses
%     /devel/logicmoo/src_data/pldata/mworld0_declpreds.pl *qcompiled* into dbase 0.05 sec, 680 clauses
%     /devel/logicmoo/src_data/pldata/mworld0.pl *qcompiled* into mworld0 60.49 sec, 483,046 clauses

  It took several minutes on my 24 core machine with 128gb ram on all SSDs as you can see.. 

  But afterwards (the results next) .. it is able to load the system from .qlf in a mater of under 3 seconds!

  No other SQL clone has been able to beat this .. Prolog uses 80% less ram and 10x times faster than
    any SQL indexing strategy I've for a large database (wtf? secret is all atoms are keys)  
   (The atom table (pointers to strings) is of no interest/use during join ops obviouslly.. 
     in which i have to do millions of join ops per semantic parse)

%     logicmoo('pldata/tiny_kb') loaded into tiny_kb 0.02 sec, 9,016 clauses
%     logicmoo('pldata/nldata_freq_pdat') loaded into nldata_freq_pdat 0.10 sec, 107,709 clauses
%     logicmoo('pldata/nldata_BRN_WSJ_LEXICON') loaded into nldata_BRN_WSJ_LEXICON 0.09 sec, 113,868 clauses
%     logicmoo('pldata/nldata_colloc_pdat') loaded into nldata_colloc_pdat 0.06 sec, 64,086 clauses
%     logicmoo('pldata/nldata_cycl_pos0') loaded into nldata_cycl_pos0 0.00 sec, 2,479 clauses
%     logicmoo('pldata/nldata_dictionary_some01') loaded into nldata_dictionary_some01 0.00 sec, 264 clauses
%     logicmoo('pldata/tt0_00022_cycl') loaded into tt0_00022_cycl 0.28 sec, 313,287 clauses
%     logicmoo('pldata/hl_holds') loaded into hl_holds 1.31 sec, 1,041,321 clauses
%     logicmoo('pldata/mworld0_declpreds') loaded into dbase 0.00 sec, 679 clauses
%     logicmoo('pldata/mworld0') loaded into mworld0 0.60 sec, 483,058 clauses

*/

% done in 'user' to avoid reloading when we reload dbase
ensure_q_loaded(File):-
    expand_file_search_path(logicmoo('pldata/mworld0_declpreds.pl'),Path),exists_file(Path),!,                                 
   '@'(load_files(File,[if(not_loaded),qcompile(auto),expand(true),derived_from(Path)]),user).

make_qlfs:-
 %ensure_q_loaded(logicmoo('pldata/tiny_kb')),
 ensure_q_loaded(logicmoo('pldata/nldata_freq_pdat')),
 ensure_q_loaded(logicmoo('pldata/nldata_BRN_WSJ_LEXICON')),
 ensure_q_loaded(logicmoo('pldata/nldata_colloc_pdat')),
 ensure_q_loaded(logicmoo('pldata/nldata_cycl_pos0')),
 ensure_q_loaded(logicmoo('pldata/nldata_dictionary_some01')),
 % ensure_q_loaded(logicmoo('pldata/tt0_00022_cycl')),
 %ensure_q_loaded(logicmoo('pldata/hl_holds')),
 %ensure_q_loaded(logicmoo('pldata/mworld0')),
 %ensure_q_loaded(logicmoo('pldata/mworld0_declpreds')),
 catch(ensure_q_loaded(logicmoo('pldata/withvars_988')),_,true).

% :- catch(logicmoo('pldata/mworld0_declpreds.qlf'),_,make_qlfs).


/*

% done in 'user' to avoid reloading when we reload dbase

:- include_moo_files('../src_asserts/pldata/?*.pl').

*/
:-export(user_ensure_nl_loaded/1).
user_ensure_nl_loaded(F):-load_files([F],[expand(true),if(changed),qcompile(auto)]).

% :- user:ensure_loaded(logicmoo(pldata/tiny_kb)).
/*
:- user_ensure_nl_loaded(logicmoo(pldata/nldata_freq_pdat)).
:- user_ensure_nl_loaded(logicmoo(pldata/nldata_BRN_WSJ_LEXICON)).
:- user_ensure_nl_loaded(logicmoo(pldata/nldata_colloc_pdat)).
:- user_ensure_nl_loaded(logicmoo(pldata/nldata_cycl_pos0)).
:- user_ensure_nl_loaded(logicmoo(pldata/nldata_dictionary_some01)).
:- user_ensure_nl_loaded(logicmoo(pldata/nldata_talk_db_pdat)).
*/
% :- user:ensure_loaded(logicmoo(pldata/tt0_00022_cycl)).
% :- user:ensure_loaded(logicmoo(pldata/hl_holds)).
% :- user:ensure_loaded(logicmoo(pldata/mworld0)).
% :- user_ensure_nl_loaded(logicmoo(pldata/transform_dump)).
% :- catch(user:ensure_loaded(logicmoo(pldata/withvars_988)),_,true).
download_and_install_el:-
  shell('wget -N http://logicmoo.org/devel/LogicmooDeveloperFramework/TEMP~/www.logicmoo.org/downloads/datafiles/PlDataBinary.zip',_),
  shell('unzip -u -d ../src_assets/pldata/ PlDataBinary.zip'),
  catch(user:ensure_loaded(logicmoo(pldata/el_assertions)),E,fmt('Cant use el_assertions',E)).

%:- xperimental_big_data->catch(user:ensure_loaded(logicmoo(pldata/el_assertions)),_,download_and_install_el);true.

% :- asserta(loaded_external_kbs),show_call(kbp_to_mpred_t).

:- user:ensure_loaded(prologmud(vworld/world_agent)).
:- user:ensure_loaded(prologmud(parsing/parser_imperative)).
:- user:ensure_loaded(prologmud(vworld/world)).

/*
:- user:ensure_loaded(logicmoo(parsing/parser_talk)). 
:- user:ensure_loaded(logicmoo(parsing/parser_e2c)). 
:- user:ensure_loaded(logicmoo(parsing/parser_CURT)). 
:- user:ensure_loaded(logicmoo(parsing/parser_chat80)). 
*/

%:- user:ensure_loaded(logicmoo(dbase/mpred_ext_lisp)).
%:- user:ensure_loaded(logicmoo(dbase/mpred_ext_chr)).




% NPC planners
:- include_moo_files(prologmud(mobs/'?*.pl')).
:- include_moo_files('../src_assets/mobs/?*.pl').
:- xperimental->include_moo_files('../external/XperiMental/src_incoming/mobs/?*.pl');true.


% Action/Commands implementation
:- include_moo_files(prologmud(actions/'?*.pl')).
:- include_moo_files('../src_assets/actions/?*.pl').
:- xperimental->include_moo_files('../external/XperiMental/src_incoming/actions/?*.pl');true.

% New Objects
:- include_moo_files(prologmud(objs/'?*.pl')).
:- include_moo_files('../src_assets/objs/?*.pl').
:- xperimental->include_moo_files('../external/XperiMental/src_incoming/actions/?*.pl');true.


% Define the agents traits, both for your agent and the world inhabitants. 
% agent name and stats ([] = defaults).
% Agents with numbered names (eg. prey(1)) are able to be used multiple times.
% Just copy their line and increment the number to make more of them.
/*
:-create_agent(predator(1),[str(4),stm(2),height(2),spd(3)]).
:-create_agent(prey(1),[str(0),stm(-8),spd(1),height(1)]).
:-create_agent(prey(2),[str(0),stm(-8),spd(1),height(1)]).
:-create_agent(prey(3),[str(0),stm(-8),spd(1),height(1)]).
%:-create_agent(prey(4),[str(0),stm(-8),spd(1),height(1)]).
:-create_agent(monster(1),[str(6),stm(2),height(2),spd(1)]).
:-create_agent(monster(2),[str(6),stm(2),height(2),spd(1)]).
:-create_agent(explorer(1),[str(2),spd(4),stm(3),height(2)]).
:-create_agent(vacuum(1),[]).
:-create_agent(explorer(2),[]).
*/

:- begin_transform_moo_preds.

user:agent_text_command(Agent,["run",Term], Agent,actProlog(Term)):- ignore(Term=someCode).

%:-forall(make_tabled_perm(get_all_templates(TEMPL)),dmsg(TEMPL)).
%:-forall(make_tabled_perm(grab_argsIsa(F,Types)),dmsg(grab_argsIsa(F,Types))).


:- ensure_plmoo_loaded(prologmud(server/builtin)).

:- forall(filematch('*/*.plmoo', X),(dmsg(ensure_plmoo_loaded(X)),ensure_plmoo_loaded(X))).


% standard header used in all files that all modules are loaded (therefore useful for when(?) the day comes that modules *can*only*see their explicitly imported modules)
% :- include(prologmud(mud_header)).

% These contain the definition of the object cols.
% Load the map file appropriate for the world being used.
% Load the mud files appropriate for the mobs being used.
:- forall(filematch(prologmud('*/?*.plmoo'), X),dmsg(X)).
:- ensure_plmoo_loaded(prologmud('*/?*.plmoo')).
:- forall(filematch(prologmud('*/*/?*.plmoo'), X),dmsg(X)).
:- ensure_plmoo_loaded(prologmud('*/*/?*.plmoo')).

% puts world into running state
% :- must(old_setup).

% [Optionaly] Start the telnet server


% standard footer to clean up any header defined states
:- include(prologmud(mud_footer)).
/*
% Load datalog
:- if_flag_true(fullStart, ((use_module(logicmoo('des/des.pl')),
  flush_output,
  init_des,
  display_status,
 %  des,
   !))).

*/



% GOLOG SYSTEM WITHOUT FLUX (Default Commented Out)
%:- if_flag_true(fullStart,use_module(logicmoo('indigolog/indigolog_main_swi.pl'))).

% FLUX AGENT SYSTEM WITHOUT GOLOG (Default Commented Out)
%:- if_flag_true(fullStart,use_module(logicmoo('indigolog/flux_main_swi.pl'))).

% FLUX AGENT SYSTEM WITH GOLOG
% :- if_flag_true(true,use_module(logicmoo('indigolog/indigolog_main_swi_flux.pl'))).

% LOGICMOO DATABASE LOGIC ENGINE SERVER
%:- if_flag_true(true,use_module(logicmoo('database/logicmoo.swi'))).

% when we import new and awefull code base (the previous )this can be helpfull
% we redfine list_undefined/1 .. this is the old version
lundef :- A = [],
       check:( merge_options(A, [module_class([user])], B),
        prolog_walk_code([undefined(trace), on_trace(found_undef)|B]),
        findall(C-D, retract(undef(C, D)), E),
        (   E==[]
        ->  true
        ;   print_message(warning, check(undefined_predicates)),
            keysort(E, F),
            group_pairs_by_key(F, G),
            maplist(report_undefined, G)
        )).

% :- if_flag_true(fullStart,remove_undef_search).


/*
  ==
  ?- [library(mudconsole)].
  ?- mc_start.				% opens browser

   or else http_mud_server

  ?- mc_format('Hello ~w', [world]).
  ?- mc_html(p(['Hello ', b(world)])).
  ?- mc_ask([age(Age)], [p('How old are you'), input([name(age)])]).
  Age = 24.				% col 24 <enter>
  ==

*/

:-pfc_untrace.