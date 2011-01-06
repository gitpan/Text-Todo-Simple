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

$todo -> edit(1, "Something else");
file_contents_is('t/todo.txt', "Something else\nSomething more\n", "Test task edit");

$todo -> edit(2, "s/more/less/");
file_contents_is('t/todo.txt', "Something else\nSomething less\n", "Test task edit regex");

done_testing(2);
