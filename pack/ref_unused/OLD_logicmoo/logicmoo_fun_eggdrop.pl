:-include('logicmoo_utils_header.pl').
% ===================================================================
% Conenctors
% ===================================================================
eggdropConnect(In,Out,BotNick,Port):-eggdropConnect(In,Out,'127.0.0.1',Port,BotNick,logicmoo).

:-use_module(library(socket)).
eggdropConnect:- eggdropConnect(In,Out,'swipl',11444).

eggdropConnect(InStream,OutStream,Host,Port,Agent,Pass):-
       tcp_socket(SocketId),
       tcp_connect(SocketId,Host:Port),
       tcp_open_socket(SocketId, InStream, OutStream),
       mformat(OutStream,'~w\n',[Agent]),flush_output(OutStream),
       mformat(OutStream,'~w\n',[Pass]),flush_output(OutStream),
       retractall(stdio(Agent,_,_)),
       asserta((stdio(Agent,InStream,OutStream))),!.
		
consultation_thread(BotNick,Port):- 
      eggdropConnect(In,Out,BotNick,Port),
      to_egg('.echo off\n'),
      to_egg('.console ~w ""\n',[BotNick]),
      to_egg('eot.\n',[]),
      repeat,
      catch(read_term(In,CMD,[variable_names(Vars)]),_,fail),      
      catch(CMD,E,to_user_error(E)),
      fail.

get2react([L|IST1]):- convert_to_strings(IST1,IST2), CALL =.. [L|IST2],channel_say("#logicmoo",CALL),catch(CALL,E,to_user_error(E)).

:-dynamic(default_channel/1).
:-dynamic(default_user/1).

convert_to_strings([],[]):-!.
convert_to_strings([IS|T1],[I|ST2]):-convert_to_string(IS,I),!,convert_to_strings(T1,ST2).

term_to_string(I,IS):- catch(string_to_atom(IS,I),_,(term_to_atom(I,A),string_to_atom(IS,A))),!.

convert_to_string(I,ISO):-
                term_to_string(I,IS),!,
		string_to_list(IS,LIST),!,
		list_replace(LIST,92,[92,92],LISTM),
		list_replace(LISTM,34,[92,34],LISTO),
		string_to_atom(ISO,LISTO),!.

list_replace(List,Char,Replace,NewList):-
	append(Left,[Char|Right],List),
	append(Left,Replace,NewLeft),
	list_replace(Right,Char,Replace,NewRight),
	append(NewLeft,NewRight,NewList),!.
list_replace(List,_Char,_Replace,List):-!.

pubm(Agent, HOSTAMSK,TYPE,Channel,MESSAGE):- from_irc(Channel,Agent,say(MESSAGE)).
part(USER, HOSTAMSK,TYPE,DEST,MESSAGE):- !.
join(USER, HOSTAMSK,TYPE,DEST):- !.
rejoin(USER, HOSTAMSK,TYPE,DEST):- !.
mode("", "irc.freenode.net", "*", "#swhack", "+v", "dahut").
split("CrashChaos", "n=crash@s079.wh-sproll.uni-ulm.de", "*", "#prolog").
topc("*", "*", "*", "#logicmoo", "").

%same_str(X,Y):-term_to_string(X,XS),term_to_string(Y,YS),toLowercase(XS,XL),toLowercase(YS,YL),!,XL=YL.

to_user_error(CMD):-format(user_error,'~q~n',[CMD]),flush_output(user_error).

from(X,Y,_,Z):-from_irc(X,Y,Z),!.
from(X,Y,Z):-from_irc(X,Y,Z),!.


channel_say(console,Data):-!,write(Data),nl.

channel_say([35|Dest],Data):-!,
	once(stdio(Agent,InStream,OutStream)),
	once(channel_say(OutStream,[35|Dest],Data)),
       % mformat(OutStream,'eot.\n',[Dest,Data]),
	flush_output(OutStream),
	flush_output(user_error),!.
channel_say('#'(Dest),Data):-atom(Dest),!,atom_codes(Dest,Codes),channel_say([35|Codes],Data).
channel_say(Dest,Data):-atom(Dest),!,atom_codes(Dest,Codes),channel_say(Codes,Data).
channel_say(Dest,Data):-!,
	once(stdio(Agent,InStream,OutStream)),
	ignore(catch(format(OutStream,'.msg ~s ~w\n',[Dest,Data]),_,fail)),
	mformat(OutStream,'eot.\n',[Dest,Data]),
	flush_output(OutStream),
	flush_output(user_error),!.	
  
channel_say(Channel,DataI):-
	convert_to_string(DataI,Data),
	once(stdio(Agent,InStream,OutStream)),
	channel_say(OutStream,Channel,Data).

channel_say(OutStream,Channel,Data):-atom(Data),!,
	concat_atom(List,'\n',Data),
	channel_say_list(OutStream,Channel,List).

channel_say(OutStream,Channel,Data):-
	channel_say_list(OutStream,Channel,[Data]).

channel_say_list(OutStream,Channel,[]).
channel_say_list(OutStream,Channel,[N|L]):-
	%ignore(catch(format(OutStream,'\n.msg ~s ~w\n',[Channel,N]),_,fail)),
	ignore(catch(format(OutStream,'\n.tcl putserv "PRIVMSG ~s :~w" ;  return "noerror ."\n',[Channel,N]),_,fail)),	
	flush_output(OutStream),
	channel_say_list(OutStream,Channel,L),!.

to_egg(X):-to_egg('~w',[X]),!.
to_egg(X,Y):-once(stdio(Agent,InStream,OutStream)),once((sformat(S,X,Y),mformat(OutStream,'~s\n',[S]),!,flush_output(OutStream))).

 

% to_egg('.raw').
eot:-!.	

getRegistered(Channel,Agent,kifbot):-chattingWith(Channel,Agent).
getRegistered("#ai",_,execute):-ignore(fail).
getRegistered("#pigface",_,execute):-ignore(fail).
getRegistered("#logicmoo",_,execute):-ignore(fail).
getRegistered("#kif",_,execute):-ignore(fail).
getRegistered("#rdfig",_,execute):-ignore(fail).
getRegistered("#prolog",_,execute):-ignore(fail).

:-dynamic(isRegisteredChk/3).

from_irc("logicmoo",Y,Z):-!.
from_irc(Y,"logicmoo",Z):-!.		       
from_irc([_], _, _):-!.
from_irc(Channel,Agent,Method):-
	set_default_channel(Channel),
	set_default_user(Agent),
        dmsg('~q',[from_irc(Channel,Agent,Method)]),
	ircEvent(Channel,Agent,Method).

my_name_used(Codes):-term_to_string(Codes,IS),
      atom_codes(IS,CODES),toLowercase(CODES,LCodes),
	append(_,[106,_,108, 108|_],LCodes).

% i hadnt see your quote at first when i posted the wikipedia quote.  i had only seen the part about being up to the compiler to pick the best method if it had to chose between a const and non-const method 
%setInHtml(TrueFalse):-
say(X) :- default_channel(C),channel_say(C,X).

ircEvent(Channel,Agent,say(W)):-same_str(W,"goodbye"),!,retractall(chattingWith(Channel,Agent)).
ircEvent(Channel,Agent,say(W)):-(same_str(W,"jllykifsh");same_str(W,"jllykifsh?")),!,
		retractall(chattingWith(Channel,Agent)),!,
		asserta(chattingWith(Channel,Agent)),!,
		say([hi,Agent,'I will answer you in',Channel,'until you say "goodbye"']).
ircEvent(Channel,Agent,say(Codes)):-!,
	 once((my_name_used(Codes);isRegisteredChk(Channel,Agent,kifbot))),
	 getWordTokens(Codes,Input),!,
	 unsetMooOption(Agent,client=_),setMooOption(Agent,client=consultation),!, 
	 idGen(Serial),idGen(Refno),get_time(Time),
	 sendEvent(Channel,Agent,english(phrase(Input,Codes),packet(Channel,Serial,Agent,Refno,Time))).
ircEvent(Channel,Agent,Method):-sendEvent(Channel,Agent,Method).

set_default_channel(Channel):-retractall(default_channel(_Channel)),asserta(default_channel(Channel)).
set_default_user(Channel):-retractall(default_user(_Channel)),asserta(default_user(Channel)).
ctcp("nsh", "n=nsh@wikipedia/nsh", "*", "#swhack", "ACTION", "sees start of topic").

%from(Channel,Agent,Method):-once(catch(once(nani_event_from(Channel,Agent,Method)),_,true)),fail.
%from(Channel,Agent,say(String)):- catch(learn_response(Channel,Agent,String),_,fail),fail.



setMooOption([]):-!.
setMooOption([H|T]):-!,
      setMooOption(H),!,
      setMooOption(T),!.
setMooOption(Var=_):-var(Var),!.
setMooOption(_=Var):-var(Var),!.
setMooOption((N=V)):-nonvar(N),!,setMooOption_thread(N,V),!.
setMooOption(N):-atomic(N),!,setMooOption_thread(N,true).
	
setMooOption(Name,Value):-setMooOption_thread(Name,Value).
setMooOption_thread(Name,Value):-
	((getThread(Process),
	retractall('$MooOption'(Process,Name,_)),
	asserta('$MooOption'(Process,Name,Value)),!)).

:-dynamic('$MooOption'/3).

unsetMooOption(Name,Value):-unsetMooOption(Name=Value).
unsetMooOption(Name=Value):-nonvar(Name),
	unsetMooOption_thread(Name,Value).
unsetMooOption(Name):-nonvar(Name),
	unsetMooOption_thread(Name,_).
unsetMooOption(Name):-(retractall('$MooOption'(_Process,Name,_Value))).


unsetMooOption_thread(Name):-
	unsetMooOption_thread(Name,_Value).

unsetMooOption_thread(Name,Value):-
	getThread(Process),
	retractall('$MooOption'(Process,Name,Value)).
	
getMooOption_nearest_thread(Name,Value):-
	getMooOption_thread(Name,Value),!.
getMooOption_nearest_thread(Name,Value):-
	'$MooOption'(_,Name,Value),!.
getMooOption_nearest_thread(_Name,_Value):-!.



isMooOption(Name=Value):-!,isMooOption(Name,Value).
isMooOption(Name):-!,isMooOption(Name,true).

isMooOption(Name,Value):-getMooOption_thread(Name,Value).

getMooOption_thread(Name,Value):-
	((getThread(Process),
	'$MooOption'(Process,Name,Value))),!.


getMooOption(Name=Value):-nonvar(Name),!,ensureMooOption(Name,_,Value).
getMooOption(Name=Default,Value):-nonvar(Name),!,ensureMooOption(Name,Default,Value).
getMooOption(Name,Value):-nonvar(Name),!,ensureMooOption(Name,_,Value).


ensureMooOption(Name=Default,Value):-
	ensureMooOption(Name,Default,Value),!.
	
ensureMooOption(Name,_Default,Value):-
	getMooOption_thread(Name,Value),!.

ensureMooOption(Name,Default,Default):-
	setMooOption_thread(Name,Default),!.

ensureMooOption(Name,_Default,Value):-nonvar(Name),!,   
	setMooOption_thread(Name,Value),!.

ensureMooOption(_Name,Default,Default).



setMooOptionDefaults:-
             (unsetMooOption(_)),
             setMooOption(opt_callback='sendNote'),
             setMooOption(cb_consultation='off'),
             setMooOption(opt_debug='off'),
             setMooOption(cb_error='off'),
             setMooOption(cb_result_each='off'),

% User Agent Defaults for Blank Variables
             setMooOption(opt_cxt_request='GlobalContext'),
             setMooOption(opt_ctx_assert='GlobalContext'),
             setMooOption(opt_tracking_number='generate'),
             setMooOption(opt_agent='ua_parse'),
             setMooOption(opt_precompiled='off'),
             getMooOption(opt_theory,Context),setMooOption(opt_theory=Context),
             setMooOption(opt_notation='kif'),
             setMooOption(opt_timeout=2),
             setMooOption(opt_readonly='off'),
             setMooOption(opt_debug='off'),
             setMooOption(opt_compiler='Byrd'),
             setMooOption(opt_language = 'pnx_nf'),

%Request Limits
             setMooOption(opt_answers_min=1),
             setMooOption(opt_answers_max=999), %TODO Default
             setMooOption(opt_backchains_max=5),
             setMooOption(opt_deductions_max=100),
             setMooOption(opt_backchains_max_neg=5),
             setMooOption(opt_deductions_max_neg=20),
             setMooOption(opt_forwardchains_max=1000),
             setMooOption(opt_max_breath=1000), %TODO Default

%Request Contexts
             setMooOption(opt_explore_related_contexts='off'),
             setMooOption(opt_save_justifications='off'),
             setMooOption(opt_deductions_assert='on'),
             setMooOption(opt_truth_maintence='on'),
             setMooOption(opt_forward_assertions='on'),
             setMooOption(opt_deduce_domains='on'),
             setMooOption(opt_notice_not_say=off),


%Request Pobibility
             setMooOption(opt_certainty_max=1),
             setMooOption(opt_certainty_min=1),
             setMooOption(opt_certainty=1),
             setMooOption(opt_resource_commit='on').





getThread(Id):-
	thread_self(Id).

go1:-servantProcessCreate(killable,'Consultation Mode Test (KIFBOT!) OPN Server',consultation_thread(swipl,11444),Id,[]).

go2:-consultation_thread(swipl,11444).

mformat(A,B,C):-format(A,B,C).