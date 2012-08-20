#!perl -T

use strict;
use warnings;

use Test::More;

use File::Slurp;
use App::Cmd::Tester;

use Text::Todo::Simple;

test_app('Text::Todo::Simple' => [qw(add --todo t/todo.txt Something)]);
is(read_file('t/todo.txt'), "Something\n", "task add");

test_app('Text::Todo::Simple' => [qw(add --todo t/todo.txt Something more)]);
is(read_file('t/todo.txt'), "Something\nSomething more\n", "task add 2");

test_app('Text::Todo::Simple' => [qw(add --todo t/todo.txt Yet another task)]);
is(read_file('t/todo.txt'), "Something\nSomething more\nYet another task\n", "task add 3");

done_testing;
