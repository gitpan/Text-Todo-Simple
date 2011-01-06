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

$todo -> do(1);
file_contents_is('t/todo.txt', "Something less\n", "Test task do");
file_contents_is('t/done.txt', "Something else\n", "Test task do");

done_testing(2);
