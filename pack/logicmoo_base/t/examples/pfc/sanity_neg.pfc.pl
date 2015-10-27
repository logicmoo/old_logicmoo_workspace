/** <module>
%
%  PFC is a language extension for prolog.. there is so much that can be done in this language extension to Prolog
%
% Dec 13, 2035
% Douglas Miles
*/

:- use_module(library(logicmoo/logicmoo_user)).


% :-mpred_trace.

neg(fooBar).

fooBar.

\+ fooBar.

:- mpred_test(\+fooBar).

fooBar.

:- mpred_test(fooBar).

%:- rtrace.
neg(fooBar).

:- mpred_test(\+fooBar).
%:- nortrace.

:- mpred_no_spy_all.

