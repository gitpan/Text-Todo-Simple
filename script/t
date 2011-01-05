#!/usr/bin/perl

use Text::Todo::Simple;
use Getopt::Long;

use warnings;
use strict;

=head1 NAME

t.pl - Command-line frontend to Text::Todo::Simple

=head1 SYNOPSIS

 t.pl [OPTIONS] [ACTION] [ARGS]

 Actions:

   add, a 	TEXT
   do 		ID
   remove, rm 	ID
   list, ls 	[STRING]
   move, mv 	ID NEW
   edit, ed 	ID TEXT

 Options:
   --todo, -t   FILE
   --done, -d   FILE

=cut

my ($default_todo, $default_done);

if ($^O eq 'MSWin32') {
	$default_todo = $ENV{USERPROFILE}."\\todo.txt";
	$default_done = $ENV{USERPROFILE}."\\done.txt";
} else {
	$default_todo = $ENV{HOME}."/.todo";
	$default_done = $ENV{HOME}."/.done";
}

my $todo_file 	   = $ENV{TODO_FILE}    ? $ENV{TODO_FILE}    : $default_todo;
my $done_file 	   = $ENV{DONE_FILE}    ? $ENV{DONE_FILE}    : $default_done;
my $default_action = $ENV{TODO_DEFAULT} ? $ENV{TODO_DEFAULT} : 'help';

GetOptions ("todo=s" => \$todo_file,
	    "done=s" => \$done_file);

my $todo = Text::Todo::Simple -> new(todo_file => $todo_file,
				     done_file => $done_file);

my %actions = (
	add      => \&add,
	do       => \&do,
	remove	 => \&remove,
	list	 => \&list,
	move	 => \&move,
	edit	 => \&edit,
	help	 => \&help
);

my %aliases = (
	a    => 'add',
	rm   => 'remove',
	ls   => 'list',
	mv   => 'move',
	ed   => 'edit'
);

my $action = $ARGV[0];

if ($action && $aliases{$action}) {
	$action = $aliases{$action};
	shift @ARGV;
} elsif (!$action || !$actions{$action}) {
	$action = $default_action;
} elsif ($actions{$action}) {
	shift @ARGV;
}

$actions{$action} -> (@ARGV);

sub add {
	my $task = join ' ', @_;

	my $i = $todo -> add($task);

	print "Added task $i\n";
}

sub do {
	$todo -> do(@_);

	print "Done task ".shift()."\n";
}

sub remove {
	$todo -> remove(@_);

	print "Removed task ".shift()."\n";
}

sub list { $todo -> list(@_); }

sub move {
	$todo -> move(@_);

	print "Moved task ".$_[0]." to ".$_[1]."\n";
}

sub edit {
	my $id  = shift;
	
	my $task = join ' ', @_;

	chomp $task;
	
	$todo -> edit($id, $task);

	print "Replaced task $id\n";
}

sub help {
	my $usage = <<END;
Usage: t.pl [ACTION] [ARGS]

 Actions:
  add, a 	TEXT
  remove, rm 	ID
  list, ls 	[STRING]
  move, mv 	ID NEW
  edit, ed 	ID TEXT

See 'perldoc t.pl' for more information.
END

	print $usage;
}

=head1 ACTION

=over 4

=item B<add>, B<a> TEXT

add a task to the list

=item B<do> ID

mark a task as done, and move it to done file

=item B<remove>, B<rm> ID

remove a task from the list

=item B<list>, B<ls> [STRING]

list tasks containing STRING (can be empty)

=item B<move>, B<mv> ID NEW

move a task from ID to NEW

=item B<edit>, B<ed> ID TEXT

replace the task ID with TEXT

=back

=head1 ACTION

=over 4

=item B<--todo>, B<-t> FILE

set todo file (takes precedence on configuration)

=item B<--done>, B<-d> FILE

set todo file (takes precedence on configuration)

=back

=head1 CONFIGURATION

The following environment variables will affect t.pl behaviour:

=over

=item B<TODO_FILE>

Specifies the path of the todo file. Default ~/.todo

=item B<DONE_FILE>

Specifies the path of the done file. Default ~/.done

=item B<TODO_DEFAULT>

Set the default action, this will be used when no action is specified.
Default 'help'

=back

=head1 AUTHOR

Alessandro Ghedini, C<< <alexbio at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-text-todo-simple at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Text-Todo-Simple>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Text::Todo::Simple
    perldoc t.pl

You can also look for information at:

=over 4

=item * GitHub page

L<http://github.com/AlexBio/Text-Todo-Simple>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Text-Todo-Simple>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Text-Todo-Simple>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Text-Todo-Simple>

=item * Search CPAN

L<http://search.cpan.org/dist/Text-Todo-Simple/>

=back

=head1 SEE ALSO

L<Text::Todo::Simple>

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
