#!perl -T

use strict;
use warnings;

use Test::More;

use File::Slurp;
use App::Cmd::Tester;

use Text::Todo::Simple;

test_app( 'Text::Todo::Simple' => [qw(do --todo t/todo.txt --done t/done.txt 1)]);
is(read_file('t/todo.txt'), "Something else\nSomething less\n", "task do");
is(read_file('t/done.txt'), "Yet another task\n", "task do");

done_testing;
