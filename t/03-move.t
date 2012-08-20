#!perl -T

use strict;
use warnings;

use Test::More;

use File::Slurp;
use App::Cmd::Tester;

use Text::Todo::Simple;

test_app( 'Text::Todo::Simple' => [qw(move --todo t/todo.txt 3 1)]);
is(read_file('t/todo.txt'), "Yet another task\nSomething else\nSomething less\n", "task move");

done_testing;
