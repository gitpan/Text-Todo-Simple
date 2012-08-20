#!perl -T

use strict;
use warnings;

use Test::More;

use File::Slurp;
use App::Cmd::Tester;

use Text::Todo::Simple;

test_app('Text::Todo::Simple' => [qw(remove --todo t/todo.txt 1)]);
is(read_file('t/todo.txt'), "Something less\n", "task remove");

test_app('Text::Todo::Simple' => [qw(remove --todo t/todo.txt 1)]);
is(read_file('t/todo.txt'), "", "task remove 2");

done_testing;

unlink('t/todo.txt');
unlink('t/done.txt');
