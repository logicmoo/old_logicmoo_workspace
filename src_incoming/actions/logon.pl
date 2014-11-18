/** <module>
% logon.pl
%
% This file defines how the agents gain their presence and leave the sim
% Comments below document the basic idea.
%
% Dec 13, 2035
% Douglas Miles
*/
% :- module(user). 
:- module(login, []).

:- include(logicmoo(vworld/moo_header)).

:- register_module_type(command).
:- multifile thlocal:wants_logout/1.

t_f(t,f).
t_f(true,false).
t_f(on,off).
t_f(1,0).
t_f(show,hide).
t_f(yes,no).
t_f(y,n).

to_on_off(FLAG,ON,OFF,ON_OFF):- t_f(_,FLAG) -> ON_OFF=OFF; ON_OFF=ON.


% rename
moo:action_info(rename(string),"Rename your player").
moo:agent_call_command(Agent,rename(Other)):- padd(Agent,named(Other)).

% become
moo:verb_alias(become,login).

% logon
moo:verb_alias(logon,login).

% login
moo:action_info(login(optional(agent,random(agent))),"(Re)Login and assume the role of an agent").
moo:agent_call_command(Agent,login(Other)):- show_call(become_player(Agent,Other)).

% logout
moo:action_info(logout(optional(agent,self)),"logs out of game (quits)").
moo:agent_call_command(_Agent,logout(Other)):-get_agent_session(Other,O),assert(thlocal:wants_logout(O)).

% quit
moo:verb_alias(quit,logout).

% logoff
moo:verb_alias(logoff,logout).

% dmsg/show/hide
moo:action_info(dmsg(optional(boolean,show)),"set the dmsg flag to on/off").
moo:agent_call_command(_Agent,dmsg(show)):- listing(tlbugger:dmsg_hidden(_)),current_prolog_flag(opt_debug,ON_OFF),fmt(current_prolog_flag(opt_debug,ON_OFF)).
moo:agent_call_command(_Agent,dmsg(FLAG)):- to_on_off(FLAG,on,off,ON_OFF),!,set_bugger_flag(opt_debug,ON_OFF),fmt(current_prolog_flag(opt_debug,ON_OFF)).
moo:action_info(show(optional(prolog,show)),"show messages of type").
moo:agent_call_command(_Agent,show(A)):-bugger:dmsg_show(A).
moo:action_info(hide(optional(prolog,show)),"hide messages of type").
moo:agent_call_command(_Agent,hide(A)):-bugger:dmsg_hide(A).

% debug
moo:verb_alias(debug,dmsg).

:- include(logicmoo(vworld/moo_footer)).


