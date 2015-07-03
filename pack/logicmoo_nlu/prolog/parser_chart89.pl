/* <module>
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Both A Bottom Up and Top Down Chart Parser
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%      from the book "Natural Language Processing in Prolog"            %
%                      published by Addison Wesley                      %
%        Copyright (c) 1989, Gerald Gazdar & Christopher Mellish.       %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/

:-module(parser_chart89, [chart89/0,test_chart89_regressions/0]).

% :- ensure_loaded(logicmoo(mpred/logicmoo_i_header)).
% :- user:ensure_loaded(library(logicmoo/util/logicmoo_util_bugger)).
% :- register_module_type(utility).


:- style_check(+discontiguous).

:- user:call(op(0,xfx,'/')).
:- user:call(op(0,fx,'-')).
:- user:call(op(200,fy,'-')).
:- user:call(op(500,yfx,'-')).
:- user:call(op(600,xfy,':')).
:- user:call(op(400,yfx,'/')).

:- asserta((thlocal:enable_src_loop_checking)).

:-multifile(user:type_action_info/3).
:-multifile(user:agent_call_command/2).
:-multifile(user:mud_test/2).

% ===========================================================
% CHART89 command
% ===========================================================
user:type_action_info(human_player,chart89(ftListFn(ftTerm)),"Development test CHART-89 Text for a human.  Usage: CHART89 Cant i see the blue backpack?").

user:agent_call_command(_Gent,chart89([])):- chart89.
user:agent_call_command(_Gent,chart89(StringM)):-nonvar(StringM), chart89(StringM).  

% its i do that much with my numbers.. i avoid calling is/2 until its needed (i can build up 

% ===========================================================
% CHART89 REPL
% ===========================================================
:-thread_local thlocal:chart89_interactive/0.
chart89 :- with_assertions(tracing80,
           with_assertions(thlocal:chart89_interactive,
            with_no_assertions(thlocal:useOnlyExternalDBs,
             with_no_assertions(thglobal:use_cyc_database,
              (told, repeat, prompt_read('CHART89> ',U),  
                            to_word_list(U,WL),((WL==[bye];WL==[end,'_',of,'_',file];(mmake,once(chart89(WL)),fail)))))))).

:- multifile(thlocal:into_form_code/0).
:- asserta(thlocal:into_form_code).

% :- ensure_loaded(logicmoo(parsing/chart89/dcgtrans)).	%  generator
% :- retract(thlocal:into_form_code).

:- include(chart89/buchart2).	% toplevel

%:-export(test_chart89_regressions/0).
test_chart89_regressions:- time((test1,test2)).
:- retract(thlocal:into_form_code).

:- retractall(thlocal:enable_src_loop_checking).


user:mud_test(chart89_regressions,test_chart89_regressions).

% :- context_module(CM),module_predicates_are_exported(CM).
% :- context_module(CM),quiet_all_module_predicates_are_transparent(CM).
% :- context_module(CM),module_property(CM, exports(List)),moo_hide_show_childs(List).

% :- ensure_loaded(logicmoo('vworld/moo_footer.pl')).
