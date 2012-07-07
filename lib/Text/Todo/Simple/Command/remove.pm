package Text::Todo::Simple::Command::remove;
{
  $Text::Todo::Simple::Command::remove::VERSION = '0.18';
}

use strict;
use warnings;

use Text::Todo::Simple -command;

=head1 NAME

Text::Todo::Simple::Command::remove - Remove a task

=head1 VERSION

version 0.18

=head1 SYNOPSIS

    $ t remove ID

This will remove the task C<ID> from the list.

=cut

sub abstract { 'remove a task' }

sub usage_desc {
	return '%c remove %o id';
}

sub command_names { qw/remove rm --remove -r/ }

sub execute {
	my ($self, $opt, $args) = @_;

	my $id    = shift @$args;
	my $todo  = $self -> app -> global_options -> {'todo'};
	my $tasks = $self -> _read($todo);

	$self -> usage_error("Err: Invalid task ID '$id'.\n")
		if ($id > scalar @$tasks) or ($id < 0) or !$id;

	splice @$tasks, $id - 1, 1;

	$self -> _write($todo, $tasks);
	print "Removed task '$id'\n";
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

1; # End of Text::Todo::Simple::Command::remove
