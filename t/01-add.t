#!perl -T

use Text::Todo::Simple;

use strict;
use warnings;

use Test::More;
use App::Cmd::Tester;
use Test::File::Contents;

test_app( 'Text::Todo::Simple' => [ qw(add --todo t/todo.txt Something) ]);
file_contents_is('t/todo.txt', "Something\n", "Test task add");

test_app( 'Text::Todo::Simple' => [ qw(add --todo t/todo.txt Something more) ]);
file_contents_is('t/todo.txt', "Something\nSomething more\n", "Test task add 2");

test_app( 'Text::Todo::Simple' => [ qw(add --todo t/todo.txt Yet another task) ]);
file_contents_is('t/todo.txt', "Something\nSomething more\nYet another task\n", "Test task add 3");

done_testing(3);
