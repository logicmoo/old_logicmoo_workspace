
:- use_module(library(logicmoo/logicmoo_user)).

% this example works in a serial Pfc, but has problems in a parallel one.

p, ~a ==> b.
q, ~b ==> a.
==> p.
==> q.


% this causes problems in any Pfc, unless s is already true.
r, ~s ==> t.
t ==> s.
==> r.