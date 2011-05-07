#!perl -T

use Text::Todo::Simple;

use strict;
use warnings;

use Test::More;
use App::Cmd::Tester;
use Test::File::Contents;

test_app( 'Text::Todo::Simple' => [ qw(remove --todo t/todo.txt 1) ]);
file_contents_is('t/todo.txt', "Something less\n", "Test task remove");

test_app( 'Text::Todo::Simple' => [ qw(remove --todo t/todo.txt 1) ]);
file_contents_is('t/todo.txt', "", "Test task remove 2");

done_testing(2);

unlink('t/todo.txt');
unlink('t/done.txt');
