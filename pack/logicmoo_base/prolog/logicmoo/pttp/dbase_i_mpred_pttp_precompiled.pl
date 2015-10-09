

%% subst_each(+In,+List,-Out).
subst_each(In,[],In).
subst_each(In,[B=A|List],Out):-
  subst1(In,B,A,Mid),
  subst_each(Mid,List,Out),!.

subst1(  Var, VarS,SUB,SUB ) :- Var==VarS,!.
subst1(  Var, _,_,Var ) :- \+compound(Var),!.
subst1([H|T],B,A,[HH|TT]):- !,
   subst1(H,B,A,HH),
   subst1(T,B,A,TT).
subst1(HT,B,A,HHTT):- HT=..FARGS,subst1(FARGS,B,A,[FM|MARGS]),
   (atom(FM)->HHTT=..[FM|MARGS];univ_tl(FM,MARGS,HHTT)).

univ_tl(Call,EList,CallE):-must((compound(Call),is_list(EList))), Call=..LeftSide, append(LeftSide,EList,ListE), CallE=..ListE.



:-multifile was_pttp_functor/3.
:-dynamic was_pttp_functor/3.


% -- CODEBLOCK


%ODD was_pttp_functor(base, both_t,3).
%ODD was_pttp_functor(base, either_t,3).

was_pttp_functor(base, askable_t,2-6).
was_pttp_functor(base, asserted_t,2-6).
was_pttp_functor(base, fallacy_t,2-6).
was_pttp_functor(base, possible_t,2-6).
% was_pttp_functor(base, not_true_t,2-6).
was_pttp_functor(base, true_t,2-6).
was_pttp_functor(base, unknown_t,2-6).

was_pttp_functor(base, isa,2-2).
was_pttp_functor(base, pred_isa_t,2-2).
was_pttp_functor(base, pred_t,3-3).


% -- CODEBLOCK

user: use_mpred_t.

:- dynamic t/3.
:- multifile t/3.
:- dynamic t/4.
:- multifile t/4.

% -- CODEBLOCK  int_asserted_t

% generates  int_asserted_t 9-15

map_int_functors(EXT,CALLF,A,PREREQ):-
  atom_concat('int_',EXT,INT),  
  functor(I_A_T,INT,A),
   I_A_T=..[INT|ARGS],
   T_T=..[CALLF|ARGS],
   A_T=..[EXT|ARGS],
  subst_each((i_a_t(H, I, D, E, F, J, G) :- 
    pretest_call((PREREQ,D=E)),
    F=[K, [a_t, G, H, I]|L], J=[K|L]),
    [i_a_t = I_A_T,a_t=A_T,call_t=T_T],NEW),
  assert_if_new(NEW).


:- forall(was_pttp_functor(base, asserted_t,Begin-End),
        forall(between(Begin,End,A),
           map_int_functors(asserted_t,t,A,(use_mpred_t,user: call_t)))).


% -- CODEBLOCK

:- dynamic int_pred_t/10.
:- multifile int_pred_t/10.

:- map_int_functors(pred_t,t,3,((use_mpred_t, G=call_t,arg(1,G,B),arg(2,G,C),dif(B,C),G))).
/*
int_pred_t(A, B, C, H, I, D, E, F, J, G) :-
   pretest_call((use_mpred_t, dif(B,C), user: t(A, B, C),D=E)),
  F=[K, [pred_t(A, B, C), G, H, I]|L], J=[K|L].
*/

% :-listing(int_pred_t).

:- dynamic int_not_pred_t/10.
:- multifile int_not_pred_t/10.

:- map_int_functors(pred_t,t,3,((use_mpred_t, G=call_t,arg(1,G,B),arg(2,G,C),dif(B,C),G))).
int_not_pred_t(A, B, C, H, I, D, E, F, J, G) :- 
   pretest_call((use_mpred_t,not(user: t(A, B, C)), dif(B,C),D=E)),
 F=[K, [not_pred_t(A, B, C), G, H, I]|L], J=[K|L].


% -- CODEBLOCK

:- dynamic int_not_true_t/10.
:- multifile int_not_true_t/10.

int_not_true_t(A, B, C, H, I, D, E, F, J, G) :- 
   pretest_call((is_extent_known(A),use_mpred_t,not(user: t(A, B, C)), dif(B,C),D=E)),
 F=[K, [not_true_t(A, B, C), G, H, I]|L], J=[K|L].


% -- CODEBLOCK
is_extent_known(wearsClothing).
is_extent_known(Pred):-wrapper_for(Pred,pred_t).


% -- CODEBLOCK

wrapper_for(reflexive,pred_isa_t).
wrapper_for(irreflexive,pred_isa_t).
wrapper_for(tSymmetricRelation,pred_isa_t).
wrapper_for(antisymmetric,pred_isa_t).

wrapper_for(genls,pred_t).
wrapper_for(genls,pred_t).

wrapper_for(skolem,call_builtin).

wrapper_for(genlInverse,pred_t).
wrapper_for(genlPreds,pred_t).
wrapper_for(disjointWith,pred_t).
wrapper_for(negationPreds,pred_t).
wrapper_for(negationInverse,pred_t).




pttp_logic(logicmoo_kb_logic,
          ((
           uses_logic(logicmoo_kb_refution),

          (( genls(C1,C2) & pred_isa_t(C1,P) => pred_isa_t(C2,P) )),
          (( pred_t(genls,C1,C2) & isa(I,C1) => isa(I,C2) )),

          (( pred_t(disjointWith,C1,C2) =>  pred_isa_t(C1,P) v pred_isa_t(C2,P) )),
          (( pred_t(disjointWith,C1,C2) =>  isa(I,C1) v isa(I,C2) )),

          (( pred_t(genlPreds,P,PSuper) & true_t(P,A,B) => true_t(PSuper,A,B) )),
          (( pred_t(genlPreds,P,PSuper) & not_true_t(PSuper,A,B) => not_true_t(P,A,B) )),
          (( pred_t(genlInverse,P,PSuper) & true_t(P,A,B) => true_t(PSuper,B,A) )),
          (( pred_t(negationPreds,P,PSuper) & true_t(P,A,B) => not_true_t(PSuper,A,B) )),
          (( pred_t(negationInverse,P,PSuper) & true_t(P,A,B) => not_true_t(PSuper,B,A) )),

      %    (( pred_isa_t(predTransitive,P) & true_t(P,A,B) & true_t(P,B,C) => true_t(P,A,C) )),
      %    (( pred_isa_t(predReflexive,P) & true_t(P,A,B) => true_t(P,A,A) & true_t(P,B,B) )),
      %    (( pred_isa_t(predSymmetric,P) & true_t(P,A,B) => true_t(P,B,A)  ))
          (( pred_isa_t(predIrreflexive,P) &  true_t(P,A,B) => not_true_t(P,B,A) ))
       %   (( pred_isa_t(predIrreflexive,PSuper) & pred_t(genlInverse,PSuper,P) => pred_isa_t(predIrreflexive,P) )),
       %   (( pred_isa_t(predIrreflexive,PSuper) & pred_t(genlPreds,P,PSuper) => pred_isa_t(predIrreflexive,P) ))
       ))).


% all questions (askable_t) to the KB are 

pttp_logic(logicmoo_kb_refution,
          ((

           % TODO define askable_t
           (( asserted_t(P,A,B) => true_t(P,A,B) )),
           (( true_t(P,A,B) => assumed_t(P,A,B) )),
           (( assumed_t(P,A,B) => -not_true_t(P,A,B) & -fallacy_t(P,A,B)  )),
           (( possible_t(P,A,B) => -not_true_t(P,A,B) & -fallacy_t(P,A,B)  )),            

           (( true_t(P,A,B) & not_true_t(P,A,B) => fallacy_t(P,A,B) )),
           
           (( true_t(P,A,B) =>  -not_true_t(P,A,B) & possible_t(P,A,B) & -unknown_t(P,A,B) )),
           (( not_true_t(P,A,B) <=> -true_t(P,A,B) & -possible_t(P,A,B) & -unknown_t(P,A,B) )),
           (( askable_t(P,A,B) => true_t(P,A,B) v unknown_t(P,A,B) v not_true_t(P,A,B)  )),
           (( answerable_t(P,A,B) <=> askable_t(P,A,B) & -unknown_t(P,A,B) )),
           (( askable_t(P,A,B) <=> -fallacy_t(P,A,B) )),
           (( answerable_t(P,A,B) => true_t(P,A,B) v not_true_t(P,A,B)  )),
           (( true_t(P,A,B) v unknown_t(P,A,B) v not_true_t(P,A,B)  ))



           % TODO define askable_t
/*
         (( fallacy_t(P,A,B) => not_true_t(P,A,B) & true_t(P,A,B) & -unknown_t(P,A,B) & -possible_t(P,A,B) )),   
         
           (( unknown_t(P,A,B) =>  -true_t(P,A,B) & possible_t(P,A,B) & -asserted_t(P,A,B) & -not_true_t(P,A,B) )),
         
            (( -unknown_t(P,A,B) => true_t(P,A,B) v not_true_t(P,A,B)  )),
            (( -asserted_t(P,A,B) => possible_t(P,A,B) v not_true_t(P,A,B) v fallacy_t(P,A,B) )),
            (( -true_t(P,A,B) =>  not_true_t(P,A,B) v fallacy_t(P,A,B) v possible_t(P,A,B) )),
            (( -possible_t(P,A,B) => not_true_t(P,A,B) v fallacy_t(P,A,B) )),
            (( -not_true_t(P,A,B) => fallacy_t(P,A,B) v unknown_t(P,A,B) v true_t(P,A,B) )),
            (( -fallacy_t(P,A,B) =>  unknown_t(P,A,B) v not_true_t(P,A,B) v true_t(P,A,B) ))

            */

          %  (( askable_t(P,A,B) v fallacy_t(P,A,B) )),

       ))).



% -- CODEBLOCK
   
make_base(BF,A):-   
   negated_functor(BF,NF),
   negated_functor(NF,PF),
   atom_concat('int_',PF,IPF),
   atom_concat('int_',NF,INF),
   EA is A + 6,
   IA is A + 7,   
   dynamic(IPF/IA),dynamic(INF/IA),dynamic(PF/EA),dynamic(NF/EA),
   export(IPF/IA),export(INF/IA),export(PF/EA),export(NF/EA),

   functor(PFB,PF,A),
   PFB=..[PF|ARGS],
   NFB=..[NF|ARGS],
   IPFB=..[IPF|ARGS],
   INFB=..[INF|ARGS],
   SUBST_L=[pfb=PFB,nfb=NFB,ipfb=IPFB,infb=INFB],

   subst_each(
[was_pttp_functor(internal,IPF,IA),
 was_pttp_functor(internal,INF,IA),
 was_pttp_functor(external,PF,EA),
 was_pttp_functor(external,NF,EA),

 (pfb(F, E, H, G, I, J) :-
 D=nfb, ( identical_member_special_loop_check(D, E)
 -> fail
 ; ( identical_member_cheaper(D, F), !
 ; unifiable_member_cheaper(D, F)
 ), G=H, I=[K, [redn, D, F, E]|L], J=[K|L]
 ; ipfb(F, E, H, G, I, J, D)
 )),
(pfb(F, E, H, G, I, J) :-
 D=nfb, ( identical_member_special_loop_check(D, E)
 -> fail
 ; ( identical_member_cheaper(D, F), !
 ; unifiable_member_cheaper(D, F)
 ), G=H, I=[K, [redn, D, F, E]|L], J=[K|L]
 ; fail
 )),
(nfb(F, E, H, G, I, J) :-
 D=pfb, ( identical_member_special_loop_check(D, E)
 -> fail
 ; ( identical_member_cheaper(D, F), !
 ; unifiable_member_cheaper(D, F)
 ), G=H, I=[K, [redn, D, F, E]|L], J=[K|L]
 ; fail
 )),
(nfb(F, E, H, G, I, J) :-
 D=pfb, ( identical_member_special_loop_check(D, E)
 -> fail
 ; ( identical_member_cheaper(D, F), !
 ; unifiable_member_cheaper(D, F)
 ), G=H, I=[K, [redn, D, F, E]|L], J=[K|L]
 ; infb(F, E, H, G, I, J, D)
 ))],SUBST_L,NEW),
  must_maplist(assert_if_new,NEW).


% -- CODEBLOCK
:-forall(was_pttp_functor(base,F,S-E),forall(between(S,E,A),must(make_base(F,A)))).

%:-listing([answerable_t,int_answerable_t,not_answerable_t,int_not_answerable_t]).

%:-listing([asserted_t,int_asserted_t,not_asserted_t,int_not_asserted_t]).

%:-listing([pred_t,int_pred_t,not_pred_t,int_not_pred_t]).

%:-listing([true_t,int_true_t,not_true_t,int_not_true_t]).


