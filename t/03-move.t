#!perl -T

use Text::Todo::Simple;

use strict;
use warnings;

use Test::More;
use App::Cmd::Tester;
use Test::File::Contents;

test_app( 'Text::Todo::Simple' => [ qw(move --todo t/todo.txt 3 1) ]);
file_contents_is('t/todo.txt', "Yet another task\nSomething else\nSomething less\n", "Test task move");

done_testing(1);
