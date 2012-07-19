package Text::Todo::Simple::Command::move;
{
  $Text::Todo::Simple::Command::move::VERSION = '0.19';
}

use strict;
use warnings;

use Text::Todo::Simple -command;

=head1 NAME

Text::Todo::Simple::Command::move - Move a task to a new position

=head1 VERSION

version 0.19

=head1 SYNOPSIS

    $ t move ID NEW

This will move the task C<ID> to the position C<NEW>, shifting the other tasks.

=cut

sub abstract { 'move a task to a new position' }

sub usage_desc {
	return '%c list %o [ str ]';
}

sub command_names { qw/move mv --move -m/ }

sub execute {
	my ($self, $opt, $args) = @_;

	my $id  = shift @$args;
	my $new = shift @$args;

	my $todo  = $self -> app -> global_options -> {'todo'};
	my $tasks = $self -> _read($todo);

	$self -> usage_error("Err: Invalid task ID '$id'.\n")
		if ($id > scalar @$tasks) or ($id < 0) or !$id;

	$self -> usage_error("Err: Invalid destination ID '$id'.\n")
		if ($new > scalar @$tasks) or ($new < 0) or !$new;

	my $task  = @$tasks[$id - 1];

	splice @$tasks, $id - 1, 1;
	splice @$tasks, $new - 1, 0, $task;

	$self -> _write($todo, $tasks);
	print "Moved task '$id' to '$new'\n";
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

1; # End of Text::Todo::Simple::Command::move
