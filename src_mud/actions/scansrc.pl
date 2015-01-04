/** <module> 
% Very simple... but kept separate to maintain modularity
%
% Logicmoo Project PrologMUD: A MUD server written in Prolog
% Maintainer: Douglas Miles
% Dec 13, 2035
%
*/
%
:-swi_module(actScansrc, []).

:- include(logicmoo(vworld/moo_header)).

:- register_module_type(mtCommand).

:- swi_export(found_undef/3).
found_undef(_,_,_).
:- dynamic undef/2.

% when we import new and awefull code base (the previous )this can be helpfull
% we redfine list_undefined/1 .. this is the old version
:- swi_export(scansrc_list_undefined/1).
scansrc_list_undefined(_):-!.
scansrc_list_undefined(A):- real_list_undefined(A).

list_undefined:-real_list_undefined([]).

:- swi_export(real_list_undefined/1).
real_list_undefined(A):-
 merge_options(A, [module_class([user])], B),
        prolog_walk_code([undefined(trace), on_trace(found_undef)|B]),
        findall(C-D, retract(undef(C, D)), E),
        (   E==[]
        ->  true
        ;   print_message(warning, check(undefined_predicates)),
            keysort(E, F),
            group_pairs_by_key(F, G),
            maplist(check:report_undefined, G)
        ).


:- swi_export(remove_undef_search/0).
remove_undef_search:- ((
 '@'(use_module(library(check)),'user'),
 redefine_system_predicate(check:list_undefined(_)),
 abolish(check:list_undefined/1),
 assert((check:list_undefined(A):- not(thread_self(main)),!, ignore(A=[]))),
 assert((check:list_undefined(A):- reload_library_index,  update_changed_files,call(thread_self(main)),!, ignore(A=[]))),
 assert((check:list_undefined(A):- ignore(A=[]),scansrc_list_undefined(A))))).


action_info(actScansrc,"Scan for sourcecode modifed on filesystem and TeamSPoon. NOTE: only new files with this mask (src_incoming/*/?*.pl) are picked up on").
agent_call_command(Agent,actScansrc):-  once('@'(agent_call_safely(Agent,actScansrc),'user')).

:-swi_export(actScansrc/0).
actScansrc :- 
 ensure_loaded(library(make)),
 debugOnError((
  reload_library_index,
  %remove_undef_search,
  update_changed_files,
  include_moo_files_not_included('../src_mud/*/?*.pl'),
  include_moo_files_not_included('../src_game/*/?*.pl'),   
   % autoload,
   % include_moo_files_not_included('../src_incoming/*/*/?*.pl'),
   % make,
   % include_moo_files_not_included('../src_incoming/*/?*.plmoo'),
   rescandb,
   !)). 

include_moo_files_not_included(Mask):- 
   expand_file_name(Mask,X),
     forall(member(E,X),include_moo_file_ni(E)).

include_moo_file_ni(M):-absolute_file_name(M,EX,[expand(true),access(read),file_type(prolog)]),include_moo_file_ni_1(EX).

:-swi_export(mmake/0).
mmake:- update_changed_files.
:-swi_export(update_changed_files/0).
update_changed_files :-
        set_prolog_flag(verbose_load,true),
        ensure_loaded(library(make)),
	findall(File, make:modified_file(File), Reload0),
	list_to_set(Reload0, Reload),
	(   prolog:make_hook(before, Reload)
	->  true
	;   true
	),
	print_message(silent, make(reload(Reload))),
	maplist(make:reload_file, Reload),
	print_message(silent, make(done(Reload))),
	(   prolog:make_hook(after, Reload)
	->  true
	;   
           true %list_undefined,list_void_declarations
	).


include_moo_file_ni_1(M):- atomic_list_concat([_,_|_],'_i_',M),!.
include_moo_file_ni_1(M):- atomic_list_concat([_,_|_],'_c_',M),!.
include_moo_file_ni_1(M):- source_file_property(M,_),!.
include_moo_file_ni_1(M):- source_file_property(_,includes(M)),!.

include_moo_file_ni_1(M):- user_ensure_loaded(M).


:- include(logicmoo(vworld/moo_footer)).
