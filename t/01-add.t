#!perl -T

use Text::Todo::Simple;

use strict;
use warnings;

use Test::More;
use Test::File::Contents;

my $todo = Text::Todo::Simple -> new(
	todo_file => 't/todo.txt',
	done_file => 't/done.txt'
);

$todo -> add("Something");
file_contents_is('t/todo.txt', "Something\n", "Test task add");

$todo -> add("Something more");
file_contents_is('t/todo.txt', "Something\nSomething more\n", "Test task add 2");

done_testing(2);
