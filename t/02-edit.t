#!perl -T

use Text::Todo::Simple;

use strict;
use warnings;

use Test::More;
use App::Cmd::Tester;
use Test::File::Contents;

test_app( 'Text::Todo::Simple' => [ qw(edit --todo t/todo.txt 1 Something else) ]);
file_contents_is('t/todo.txt', "Something else\nSomething more\nYet another task\n", "Test task edit");

test_app( 'Text::Todo::Simple' => [ qw(edit --todo t/todo.txt 2 s/more/less/) ]);
file_contents_is('t/todo.txt', "Something else\nSomething less\nYet another task\n", "Test task edit regex");

done_testing(2);
