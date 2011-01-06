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

$todo -> remove(1);
file_contents_is('t/todo.txt', "", "Test task edit");

done_testing(1);

unlink('t/todo.txt');
unlink('t/done.txt');
