

:- dynamic(thread_current_input/2).
:- dynamic(thread_current_error_stream/2).
:- volatile(thread_current_input/2).
:- volatile(thread_current_error_stream/2).
save_streams:-
  thread_self(ID),
  current_input(In),asserta(thread_current_input(ID,In)),
  current_output(Err),asserta(thread_current_error_stream(ID,Err)).

:-initialization(save_streams).

thread_current_error_stream(Err):-thread_current_error_stream(main,Err).

format_to_error(F,A):-thread_current_error_stream(main,Err),!,format(Err,F,A).

% ==========================================================
% Sending Notes
% ==========================================================

:-thread_local( tlbugger: tlbugger:dmsg_match/2).
:-meta_predicate(with_all_dmsg(0)).
:-meta_predicate(with_show_dmsg(*,0)).

with_all_dmsg(Call):- always_show_dmsg,!,Call.
with_all_dmsg(Call):-
     with_assertions(set_prolog_flag(opt_debug,true),
       with_assertions( tlbugger:dmsg_match(show,_),Call)).
with_all_dmsg(Call):- always_show_dmsg,!,Call.
with_show_dmsg(TypeShown,Call):-
  with_assertions(set_prolog_flag(opt_debug,filter),
     with_assertions( tlbugger:dmsg_match(showing,TypeShown),Call)).

:-meta_predicate(with_no_dmsg(0)).
with_no_dmsg(Call):-with_assertions(set_prolog_flag(opt_debug,false),Call).
with_no_dmsg(TypeUnShown,Call):-with_assertions(set_prolog_flag(opt_debug,filter),
  with_assertions( tlbugger:dmsg_match(hidden,TypeUnShown),Call)).

% dmsg_hides_message(_):- !,fail.
dmsg_hides_message(_):- current_prolog_flag(opt_debug,false),!.
dmsg_hides_message(_):- current_prolog_flag(opt_debug,true),!,fail.
dmsg_hides_message(C):-  tlbugger:dmsg_match(HideShow,Matcher),matches_term(Matcher,C),!,HideShow=hidden.

dmsg_hide(isValueMissing):-!,set_prolog_flag(opt_debug,false).
dmsg_hide(Term):-set_prolog_flag(opt_debug,filter),must(nonvar(Term)),asserta_new( tlbugger:dmsg_match(hidden,Term)),retractall( tlbugger:dmsg_match(showing,Term)),nodebug(Term).
dmsg_show(isValueMissing):-!,set_prolog_flag(opt_debug,true).
dmsg_show(Term):-set_prolog_flag(opt_debug,filter),asserta_new( tlbugger:dmsg_match(showing,Term)),ignore(retractall( tlbugger:dmsg_match(hidden,Term))),debug(Term).
dmsg_showall(Term):-ignore(retractall( tlbugger:dmsg_match(hidden,Term))).



indent_e(0):-!.
indent_e(X):- X > 20, XX is X-20,!,indent_e(XX).
indent_e(X):- catchvv((X < 2),_,true),write(' '),!.
indent_e(X):-XX is X -1,!,write(' '), indent_e(XX).

% ===================================================================
% Lowlevel printng
% ===================================================================

fmt0(user_error,F,A):-!,thread_current_error_stream(main,Err),!,format(Err,F,A).
fmt0(current_error,F,A):-!,thread_current_error_stream(Err),!,format(Err,F,A).
fmt0(X,Y,Z):-catchvv((format(X,Y,Z),flush_output_safe(X)),E,dmsg(E)).
fmt0(X,Y):-catchvv((format(X,Y),flush_output_safe),E,dfmt(E:format(X,Y))).
fmt0(X):- (atomic(X);is_list(X)),catchvv(text_to_string(X,S),_,fail),!,'format'('~w',[S]),!.
fmt0(X):- (atom(X) -> catchvv((format(X,[]),flush_output_safe),E,dmsg(E)) ; (term_to_message_string(X,M) -> 'format'('~q~n',[M]);fmt_or_pp(X))).
fmt(X):-fresh_line,fmt_ansi(fmt0(X)).
fmt(X,Y):- fresh_line,fmt_ansi(fmt0(X,Y)),!.
fmt(X,Y,Z):- fmt_ansi(fmt0(X,Y,Z)),!.

fmt9(fmt0(F,A)):-catch(fmt0(F,A),_,fail),!.
fmt9(Msg):- portray_clause_w_vars(Msg).

% :-reexport(library(ansi_term)).

tst_fmt:- make,
 findall(R,(clause(ansi_term:sgr_code(R, _),_),ground(R)),List),
 ignore((
        ansi_term:ansi_color(FC, _),
        member(FG,[hfg(FC),fg(FC)]),
        % ansi_term:ansi_term:ansi_color(Key, _),
        member(BG,[hbg(default),bg(default)]),
        member(R,List),
        % random_member(R1,List),
    C=[reset,R,FG,BG],
  fresh_line,
  ansi_term:ansi_format(C,' ~q ~n',[C]),fail)).


fmt_ansi(Call):-ansicall([reset,bold,hfg(white),bg(black)],Call).

fmt_portray_clause(X):- unnumbervars(X,Y),!,snumbervars(Y), portray_clause(Y).
fmt_or_pp(portray((X:-Y))):-!,fmt_portray_clause((X:-Y)),!.
fmt_or_pp(portray(X)):-!,functor_safe(X,F,A),fmt_portray_clause((pp(F,A):-X)),!.
fmt_or_pp(X):-format('~q~n',[X]).

dfmt(X):- thread_current_error_stream(Err),with_output_to_stream(Err,fmt(X)).
dfmt(X,Y):- thread_current_error_stream(Err), with_output_to_stream(Err,fmt(X,Y)).

with_output_to_stream(Stream,Goal):-
    current_output(Saved),
   setup_call_cleanup(set_output(Stream),
         Goal,
         set_output(Saved)).

to_stderror(Call):- thread_current_error_stream(main,Err), with_output_to_stream(Err,Call).



:-dynamic dmsg_log/3.



:- thread_local is_with_dmsg/1.

with_dmsg(Functor,Goal):-
   with_assertions(is_with_dmsg(Functor),Goal).


:-use_module(library(listing)).
sformat(Str,Msg,Vs,Opts):- nonvar(Msg),functor_safe(Msg,':-',_),!,with_output_to(string(Str),portray_clause_w_vars(user_output,Msg,Vs,Opts)).
sformat(Str,Msg,Vs,Opts):- with_output_to(chars(Codes),(current_output(CO),portray_clause_w_vars(CO,':-'(Msg),Vs,Opts))),append([_,_,_],PrintCodes,Codes),'sformat'(Str,'   ~s',[PrintCodes]),!.


portray_clause_w_vars(Out,Msg,Vs,Options):- \+ \+ ((prolog_listing:do_portray_clause(Out,Msg,[variable_names(Vs),numbervars(true),character_escapes(true),quoted(true)|Options]))),!.
portray_clause_w_vars(Msg,Vs,Options):- portray_clause_w_vars(current_output,Msg,Vs,Options).
portray_clause_w_vars(Msg,Options):- source_variables_l(Vs),portray_clause_w_vars(current_output,Msg,Vs,Options).
portray_clause_w_vars(Msg):- source_variables_l(Vs),portray_clause_w_vars(current_output,Msg,Vs,[]).

prepend_strings(S,AC,O):-once(atomics_to_string(LL,'\n',S)),[L,'']=LL,atom(L),atom_concat(AC,_,L),O=S,!.
prepend_strings(S,AC,O):-atomics_to_string(Lines,'\n',S),!,atom_concat('\n',AC,Sep),atomics_to_string([''|Lines],Sep,O),!.
in_cmt(Call):- prepend_each_line('% ',Call).
with_current_indent(Call):- get_indent_level(Indent), indent_to_spaces(Indent,Space),prepend_each_line(Space,Call).

indent_to_spaces(1,' '):-!.
indent_to_spaces(0,''):-!.
indent_to_spaces(2,'  '):-!.
indent_to_spaces(3,'   '):-!.
indent_to_spaces(N,Out):- 1 is N rem 2,!, N1 is N-1, indent_to_spaces(N1,Spaces),atom_concat(' ',Spaces,Out).
indent_to_spaces(N,Out):- N2 is N div 2, indent_to_spaces(N2,Spaces),atom_concat(Spaces,Spaces,Out).

prepend_each_line(Prepend,Call):-with_output_to(string(Str),Call),prepend_strings(Str,Prepend,StrOut),format('~s',[StrOut]).

if_color_debug:-current_prolog_flag(dmsg_color,true).
if_color_debug(Call):- if_color_debug(Call, true).
if_color_debug(Call,UnColor):- if_color_debug->Call;UnColor.



:-swi_export((portray_clause_w_vars/4,color_dmsg/2,ansicall/3,ansi_control_conv/2)).

:-thread_local(tlbugger:skipDmsg/0).




dmsginfo(V):-dmsg(info(V)).
dmsg(V):- notrace(dmsg0(V)).
dmsg(F,A):-notrace(dmsg0(F,A)).
dmsg0(_,_):- is_hiding_dmsgs,!.
dmsg0(F,A):- is_sgr_on_code(F),!,dmsg(ansi(F,A)).
dmsg0(F,A):- dmsg(fmt0(F,A)).
vdmsg(L,F):-loggerReFmt(L,LR),loggerFmtReal(LR,F,[]).
dmsg(L,F,A):-loggerReFmt(L,LR),loggerFmtReal(LR,F,A).

user:portray(A) :- compound(A),functor(A,(:-),_),portray_clause_w_vars(A),!.

:-thread_local(tlbugger:in_dmsg/0).

dmsg0(V):- tlbugger:in_dmsg,!,format_to_error('~N% ~q~N',[dmsg0(V)]).
dmsg0(V):- asserta(tlbugger:in_dmsg,Ref),dmsg1(V),erase(Ref).

:-swi_export(dmsg1/1).
:-swi_export(dmsg2/1).
dmsg1(V):- is_with_dmsg(FP),!,FP=..FPL,append(FPL,[V],VVL),VV=..VVL,once(dmsg1(VV)).
dmsg1(_):- \+ always_show_dmsg, is_hiding_dmsgs,!.
dmsg1(V):- var(V),!,dmsg1(warn(dmsg_var(V))).
dmsg1(NC):- cyclic_term(NC),!,format_to_error('~N% ~q~N',[dmsg_cyclic_term(NC)]).
dmsg1(NC):- tlbugger:skipDmsg,!,format_to_error('~N% ~q~N',[skipDmsg(NC)]).

dmsg1(V):- once(dmsg2(V)), ignore((hook:dmsg_hook(V),fail)).

dmsg2(NC):- cyclic_term(NC),!,format_to_error('~N% ~q~N',[dmsg_cyclic_term(NC)]).
dmsg2(skip_dmsg(_)):-!.
%dmsg2(C):- \+ always_show_dmsg, dmsg_hides_message(C),!.
%dmsg2(trace_or_throw(V)):- dumpST(350),dmsg(warning,V),fail.
%dmsg2(error(V)):- dumpST(250),dmsg(warning,V),fail.
%dmsg2(warn(V)):- dumpST(150),dmsg(warning,V),fail.
dmsg2(ansi(Ctrl,Msg)):- !, ansicall(Ctrl,dmsg3(Msg)).
dmsg2(color(Ctrl,Msg)):- !, ansicall(Ctrl,dmsg3(Msg)).
dmsg2(Msg):- mesg_color(Msg,Ctrl),ansicall(Ctrl,dmsg3(Msg)).

dmsg3(C):-
  ((functor_safe(C,Topic,_),debugging(Topic,_True_or_False),logger_property(Topic,once,true),!,
      (dmsg_log(Topic,_Time,C) -> true ; ((get_time(Time),asserta(dmsg_log(todo,Time,C)),!,dmsg4(C)))))),!.

dmsg3(C):-dmsg4(C),!.

dmsg4(_):- show_source_location,fail.
% dmsg4(C):- not(ground(C)),copy_term(C,Stuff), snumbervars(Stuff),!,dmsg5(Stuff).
dmsg4(Msg):-dmsg5(Msg).

dmsg5(Msg):- to_stderror(in_cmt(fmt9(Msg))).


get_indent_level(Max) :- if_prolog(swi,((prolog_current_frame(Frame),prolog_frame_attribute(Frame,level,FD)))),Depth is FD div 5,Max is min(Depth,40),!.
get_indent_level(2):-!.


/*
ansifmt(+Attributes, +Format, +Args) is det
Format text with ANSI attributes. This predicate behaves as format/2 using Format and Args, but if the current_output is a terminal, it adds ANSI escape sequences according to Attributes. For example, to print a text in bold cyan, do
?- ansifmt([bold,fg(cyan)], 'Hello ~w', [world]).
Attributes is either a single attribute or a list thereof. The attribute names are derived from the ANSI specification. See the source for sgr_code/2 for details. Some commonly used attributes are:

bold
underline
fg(Color), bg(Color), hfg(Color), hbg(Color)
Defined color constants are below. default can be used to access the default color of the terminal.

black, red, green, yellow, blue, magenta, cyan, white
ANSI sequences are sent if and only if

The current_output has the property tty(true) (see stream_property/2).
The Prolog flag color_term is true.

ansifmt(Ctrl, Format, Args) :- ansifmt(current_output, Ctrl, Format, Args).

ansifmt(Stream, Ctrl, Format, Args) :-
     % we can "assume"
        % ignore(((stream_property(Stream, tty(true)),current_prolog_flag(color_term, true)))), !,
	(   is_list(Ctrl)
	->  maplist(ansi_term:sgr_code_ex, Ctrl, Codes),
	    atomic_list_concat(Codes, (';'), OnCode)
	;   ansi_term:sgr_code_ex(Ctrl, OnCode)
	),
	'format'(string(Fmt), '\e[~~wm~w\e[0m', [Format]),
        retractall(last_used_color(Ctrl)),asserta(last_used_color(Ctrl)),
	'format'(Stream, Fmt, [OnCode|Args]),
	flush_output,!.
ansifmt(Stream, _Attr, Format, Args) :- 'format'(Stream, Format, Args).

*/

:-use_module(library(ansi_term)).

:- swi_export(ansifmt/2).
ansifmt(Ctrl,Fmt):- colormsg(Ctrl,Fmt).
:- swi_export(ansifmt/3).
ansifmt(Ctrl,F,A):- colormsg(Ctrl,(format(F,A))).



:- swi_export(colormsg/2).



colormsg(d,Msg):- mesg_color(Msg,Ctrl),!,colormsg(Ctrl,Msg).
colormsg(Ctrl,Msg):- fresh_line,ansicall(Ctrl,fmt0(Msg)),fresh_line.

:- swi_export(ansicall/2).
ansicall(Ctrl,Call):- hotrace((current_output(Out), ansicall(Out,Ctrl,Call))).

ansi_control_conv([],[]):-!.
ansi_control_conv([H|T],HT):-!,ansi_control_conv(H,HH),!,ansi_control_conv(T,TT),!,flatten([HH,TT],HT),!.
ansi_control_conv(warn,Ctrl):- !, ansi_control_conv(warning,Ctrl),!.
ansi_control_conv(Level,Ctrl):- ansi_term:level_attrs(Level,Ansi),Level\=Ansi,!,ansi_control_conv(Ansi,Ctrl).
ansi_control_conv(Color,Ctrl):- ansi_term:ansi_color(Color,_),!,ansi_control_conv(fg(Color),Ctrl).
ansi_control_conv(Ctrl,CtrlO):-flatten([Ctrl],CtrlO),!.

is_tty(Out):- not(tlbugger:no_colors), is_stream(Out),stream_property(Out,tty(true)).

ansicall(Out,_,Call):- \+ is_tty(Out),!,Call.
ansicall(_Out,_,Call):- tlbugger:skipDmsg,!,Call.

ansicall(Out,CtrlIn,Call):- once(ansi_control_conv(CtrlIn,Ctrl)),  CtrlIn\=Ctrl,!,ansicall(Out,Ctrl,Call).
ansicall(_,_,Call):- in_pengines,!,Call.
ansicall(Out,Ctrl,Call):-
   retractall(last_used_color(_)),asserta(last_used_color(Ctrl)),ansicall0(Out,Ctrl,Call),!.

ansicall0(Out,[Ctrl|Set],Call):-!, ansicall0(Out,Ctrl,ansicall0(Out,Set,Call)).
ansicall0(_,[],Call):-!,Call.
ansicall0(Out,Ctrl,Call):-if_color_debug(ansicall1(Out,Ctrl,Call),keep_line_pos(Out, Call)).

ansicall1(Out,Ctrl,Call):-
   must(sgr_code_on_off(Ctrl, OnCode, OffCode)),!,
     keep_line_pos(Out, (format(Out, '\e[~wm', [OnCode]))),
	call_cleanup(Call,
           keep_line_pos(Out, (format(Out, '\e[~wm', [OffCode])))).
/*
ansicall(S,Set,Call):-
     call_cleanup((
         stream_property(S, tty(true)), current_prolog_flag(color_term, true), !,
	(is_list(Ctrl) ->  maplist(sgr_code_on_off, Ctrl, Codes, OffCodes), 
          atomic_list_concat(Codes, (';'), OnCode) atomic_list_concat(OffCodes, (';'), OffCode) ;   sgr_code_on_off(Ctrl, OnCode, OffCode)),
        keep_line_pos(S, (format(S,'\e[~wm', [OnCode])))),
	call_cleanup(Call,keep_line_pos(S, (format(S, '\e[~wm', [OffCode]))))).


*/




keep_line_pos(S, G) :-
       (stream_property(S, position(Pos)) -> 
	(stream_position_data(line_position, Pos, LPos),
        call_cleanup(G, set_stream(S, line_position(LPos)))) ; G).


:-dynamic(term_color0/2).


%term_color0(retract,magenta).
%term_color0(retractall,magenta).
term_color0(assertz,hfg(green)).
term_color0(assertz_new,hfg(green)).
term_color0(asserta_new,hfg(green)).
term_color0(db_op,hfg(blue)).

mesg_color(T,C):-var(T),!,nop(dumpST),!,C=[blink(slow),fg(red),hbg(black)],!.
mesg_color(T,C):-is_sgr_on_code(T),!,C=T.
mesg_color(T,C):-cyclic_term(T),!,C=reset.
mesg_color(T,C):- string(T),!,must(f_word(T,F)),!,functor_color(F,C).
mesg_color([_,_,_T|_],C):-atom(T),mesg_color(T,C).
mesg_color([T|_],C):-atom(T),mesg_color(T,C).
mesg_color(T,C):-(atomic(T);is_list(T)),catchvv(text_to_string(T,S),_,fail),!,mesg_color(S,C).
mesg_color(T,C):-not(compound(T)),term_to_atom(T,A),!,mesg_color(A,C).
mesg_color(succeed(T),C):-nonvar(T),mesg_color(T,C).
mesg_color((T),C):- \+ \+ ((predicate_property(T,meta_predicate(_)))),arg(_,T,E),compound(E),!,mesg_color(E,C).
mesg_color(=(T,_),C):-nonvar(T),mesg_color(T,C).
mesg_color(debug(T),C):-nonvar(T),mesg_color(T,C).
mesg_color(_:T,C):-nonvar(T),!,mesg_color(T,C).
mesg_color(T,C):-functor_safe(T,F,_),member(F,[color,ansi]),compound(T),arg(1,T,C),nonvar(C).
mesg_color(T,C):-functor_safe(T,F,_),member(F,[succeed,must,call_with_attvars]),compound(T),arg(1,T,E),nonvar(E),!,mesg_color(E,C).
mesg_color(T,C):-functor_safe(T,F,_),member(F,[fmt0,msg]),compound(T),arg(2,T,E),nonvar(E),!,mesg_color(E,C).
mesg_color(T,C):-predef_functor_color(F,C),mesg_arg1(T,F).
mesg_color(T,C):-nonvar(T),defined_message_color(F,C),matches_term(F,T),!.
mesg_color(T,C):-functor_h0(T,F,_),!,functor_color(F,C),!.

f_word(T,A):-concat_atom(List,' ',T),member(A,List),atom_length(A,L),L>0,!.
f_word(T,A):-concat_atom(List,'_',T),member(A,List),atom_length(A,L),L>0,!.
f_word(T,A):- string_to_atom(T,P),!,sub_atom(P,0,10,_,A),A\==P.
f_word(T,A):- string_to_atom(T,A),!.

mesg_arg1(T,_TT):-var(T),!,fail.
mesg_arg1(_:T,C):-nonvar(T),!,mesg_arg1(T,C).
mesg_arg1(T,TT):-not(compound(T)),!,T=TT.
mesg_arg1(T,F):-functor_h0(T,F,_).
mesg_arg1(T,C):-compound(T),arg(1,T,F),!,nonvar(F),mesg_arg1(F,C).


:- swi_export(defined_message_color/2).
:-dynamic(defined_message_color/2).

defined_message_color(todo,[fg(red),bg(black),underline]).
%defined_message_color(error,[fg(red),hbg(black),bold]).
defined_message_color(warn,[fg(black),hbg(red),bold]).
defined_message_color(A,B):-term_color0(A,B).


predef_functor_color(F,C):- defined_message_color(F,C),!.
predef_functor_color(F,C):- defined_message_color(F/_,C),!.
predef_functor_color(F,C):- term_color0(F,C),!.

functor_color(F,C):- predef_functor_color(F,C),!.
functor_color(F,C):- next_color(C),assertz(term_color0(F,C)),!.


:-dynamic(last_used_color/1).

last_used_color(pink).

last_used_fg_color(LFG):-last_used_color(LU),fg_color(LU,LFG),!.
last_used_fg_color(default).

good_next_color(C):-var(C),!,trace_or_throw(var_good_next_color(C)),!.
good_next_color(C):- last_used_fg_color(LFG),fg_color(C,FG),FG\=LFG,!.
good_next_color(C):- not(unliked_ctrl(C)).

unliked_ctrl(fg(blue)).
unliked_ctrl(fg(black)).
unliked_ctrl(fg(red)).
unliked_ctrl(bg(white)).
unliked_ctrl(hbg(white)).
unliked_ctrl(X):-is_list(X),member(E,X),nonvar(E),unliked_ctrl(E).

fg_color(LU,FG):-member(fg(FG),LU),FG\=white,!.
fg_color(LU,FG):-member(hfg(FG),LU),FG\=white,!.
fg_color(_,default).

:- swi_export(random_color/1).
random_color([reset,M,FG,BG,font(Font)]):-Font is random(8),
  findall(Cr,ansi_term:ansi_color(Cr, _),L),
  random_member(E,L),
  random_member(FG,[hfg(E),fg(E)]),not(unliked_ctrl(FG)),
  contrasting_color(FG,BG), not(unliked_ctrl(BG)),
  random_member(M,[bold,faint,reset,bold,faint,reset,bold,faint,reset]),!. % underline,negative


:- swi_export(tst_color/0).
tst_color:- make, ignore((( between(1,20,_),random_member(Call,[colormsg(C,cm(C)),dmsg(color(C,dm(C))),ansifmt(C,C)]),next_color(C),Call,fail))).
:- swi_export(tst_color/1).
tst_color(C):- make,colormsg(C,C).

:- swi_export(next_color/1).
next_color(C):- between(1,10,_), random_color(C), good_next_color(C),!.
next_color([underline|C]):- random_color(C),!.

:- swi_export(contrasting_color/2).
contrasting_color(white,black).
contrasting_color(A,default):-atom(A),A \= black.
contrasting_color(fg(C),bg(CC)):-!,contrasting_color(C,CC),!.
contrasting_color(hfg(C),bg(CC)):-!,contrasting_color(C,CC),!.
contrasting_color(black,white).
contrasting_color(default,default).
contrasting_color(_,default).

:-thread_local(ansi_prop/2).

sgr_on_code(Ctrl,OnCode):-sgr_on_code0(Ctrl,OnCode),!.
sgr_on_code(Foo,7):- notrace((format_to_error('~NMISSING: ~q~n',[sgr_on_code(Foo,7)]))),!. % ,dtrace(sgr_on_code(Foo,7)))).

is_sgr_on_code(Ctrl):-sgr_on_code0(Ctrl,_),!.

sgr_on_code0(Ctrl,OnCode):- ansi_term:sgr_code(Ctrl,OnCode).
sgr_on_code0(blink, 6).
sgr_on_code0(-Ctrl,OffCode):-  nonvar(Ctrl), sgr_off_code(Ctrl,OffCode).

sgr_off_code(Ctrl,OnCode):-ansi_term:off_code(Ctrl,OnCode),!.
sgr_off_code(- Ctrl,OnCode):- nonvar(Ctrl), sgr_on_code(Ctrl,OnCode),!.
sgr_off_code(fg(_), CurFG):- (ansi_prop(fg,CurFG)->true;CurFG=39),!.
sgr_off_code(bg(_), CurBG):- (ansi_prop(ng,CurBG)->true;CurBG=49),!.
sgr_off_code(bold, 21).
sgr_off_code(italic_and_franktur, 23).
sgr_off_code(franktur, 23).
sgr_off_code(italic, 23).
sgr_off_code(underline, 24).
sgr_off_code(blink, 25).
sgr_off_code(blink(_), 25).
sgr_off_code(negative, 27).
sgr_off_code(conceal, 28).
sgr_off_code(crossed_out, 29).
sgr_off_code(framed, 54).
sgr_off_code(overlined, 55).
sgr_off_code(_,0).


sgr_code_on_off(Ctrl,OnCode,OffCode):-sgr_on_code(Ctrl,OnCode),sgr_off_code(Ctrl,OffCode),!.
sgr_code_on_off(Ctrl,OnCode,OffCode):-sgr_on_code(Ctrl,OnCode),sgr_off_code(Ctrl,OffCode),!.


% ansicall(Ctrl,Msg):- msg_to_string(Msg,S),fresh_line,catchvv(ansifmt(Ctrl,'~w~n',[S]),_,catchvv(ansifmt(fg(Ctrl),'~w',[S]),_,'format'('~q (~w)~n',[ansicall(Ctrl,Msg),S]))),fresh_line.
/*
dmsg(Color,Term):- current_prolog_flag(tty_control, true),!,  tell(user),fresh_line,to_petty_color(Color,Type),
   call_cleanup(((sformat(Str,Term,[],[]),dmsg(Type,if_tty([Str-[]])))),told).
*/

msg_to_string(Var,Str):-var(Var),!,sformat(Str,'~q',[Var]),!.
msg_to_string(portray(Msg),Str):- with_output_to(string(Str),portray_clause_w_vars(user_output,Msg,[],[])),!.
msg_to_string(pp(Msg),Str):- sformat(Str,Msg,[],[]),!.
msg_to_string(fmt(F,A),Str):-sformat(Str,F,A),!.
msg_to_string(format(F,A),Str):-sformat(Str,F,A),!.
msg_to_string(Msg,Str):-atomic(Msg),!,sformat(Str,'~w',[Msg]).
msg_to_string(m2s(Msg),Str):-message_to_string(Msg,Str),!.
msg_to_string(Msg,Str):-sformat(Str,Msg,[],[]),!.

