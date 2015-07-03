
/* ========================================================================
   File Search Paths
 */

file_search_path(semlib,     'src/prolog/lib').
file_search_path(boxer,      'src/prolog/boxer').
file_search_path(lex,        'src/prolog/boxer/lex').


/* ========================================================================
   VerbNet
 */

:- dynamic roles/2.


/* ========================================================================
   Modules
 */

:- use_module(library(lists),[reverse/2,member/2,append/3]).
:- use_module(boxer(slashes)).
:- use_module(lex(verbnet)).


/* ========================================================================
   Generate
 */

generate([],_).

generate([X|L],V):-
   length(X,Len),
   format('~p ~p ~q~n',[V,Len,X]),
   generate(L,V).


/* ========================================================================
   Process
 */

process([]).

process([V1|L]):-
   setof(Roles,C^(verbnet(V2,C,Roles),V1==V2),Rs),
   generate(Rs,V1),
   process(L).


/* ========================================================================
   Main
 */

run:-
   setof(V,A^B^(verbnet(V,A,B),nonvar(V)),L),
   process(L),
   halt.

:- run.

