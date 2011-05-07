#!perl -T

use Text::Todo::Simple;

use strict;
use warnings;

use Test::More;
use App::Cmd::Tester;
use Test::File::Contents;

test_app( 'Text::Todo::Simple' => [ qw(do --todo t/todo.txt --done t/done.txt 1) ]);
file_contents_is('t/todo.txt', "Something else\nSomething less\n", "Test task do");
file_contents_is('t/done.txt', "Yet another task\n", "Test task do");

done_testing(2);
