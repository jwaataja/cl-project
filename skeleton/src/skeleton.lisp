(defpackage <% @var name %>
  (:use :cl<% @if executable %>
        :<% @var name %><% @endif %>))
(in-package :<% @var name %>)

<% @if executable %>(defun exit-with-backtrace (c)
  "Print the backtrace and exit. Don't land in the
   debugger."
  (uiop:print-condition-backtrace c :count 15)
  (uiop:quit 1))

(defun main (argv)
  "Entry point for standalone executable."
  (declare (ignorable argv))
  (handler-bind
      ((error #'exit-with-backtrace))
    ;; blah blah blah.
    (uiop:quit 0)))
<% @else %>;; blah blah blah.
<% @endif %>
