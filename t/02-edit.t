#!perl -T

use strict;
use warnings;

use Test::More;

use File::Slurp;
use App::Cmd::Tester;

use Text::Todo::Simple;

test_app('Text::Todo::Simple' => [qw(edit --todo t/todo.txt 1 Something else)]);
is(read_file('t/todo.txt'), "Something else\nSomething more\nYet another task\n", "task edit");

test_app('Text::Todo::Simple' => [qw(edit --todo t/todo.txt 2 s/more/less/)]);
is(read_file('t/todo.txt'), "Something else\nSomething less\nYet another task\n", "task edit regex");

done_testing;
