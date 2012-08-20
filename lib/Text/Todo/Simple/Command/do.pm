package Text::Todo::Simple::Command::do;
{
  $Text::Todo::Simple::Command::do::VERSION = '0.20';
}

use strict;
use warnings;

use Text::Todo::Simple -command;

=head1 NAME

Text::Todo::Simple::Command::do - Finish a task

=head1 VERSION

version 0.20

=head1 SYNOPSIS

    $ t do ID

This will remove the task C<ID> from the todo list, and append it to the done
list.

=cut

sub abstract { 'finish a task' }

sub usage_desc {
	return '%c do %o id';
}

sub command_names { qw/do --do -d/ }

sub execute {
	my ($self, $opt, $args) = @_;

	my $id    = shift @$args;
	my $todo  = $self -> app -> global_options -> {'todo'};
	my $done  = $self -> app -> global_options -> {'done'};
	my $tasks = $self -> _read($todo);
	my $task  = @$tasks[$id-1];

	splice @$tasks, $id - 1, 1;

	$self -> _append($done, $task);
	$self -> _write($todo, $tasks);
	print "Done task '$id'\n";
}

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Text::Todo::Simple::Command::do
