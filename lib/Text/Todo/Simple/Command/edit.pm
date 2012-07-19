package Text::Todo::Simple::Command::edit;
{
  $Text::Todo::Simple::Command::edit::VERSION = '0.19';
}

use strict;
use warnings;

use Text::Todo::Simple -command;

=head1 NAME

Text::Todo::Simple::Command::edit - Edit a task

=head1 VERSION

version 0.19

=head1 SYNOPSIS

    $ t edit ID TASK

This will replace the task ID with TASK. If TEXT begins with 's/' it will be
treated as a regex (see L<EXAMPLES>).

=cut

sub abstract { 'edit a task' }

sub usage_desc {
	return '%c edit %o id task ...';
}

sub command_names { qw/edit ed --edit -e/ }

sub execute {
	my ($self, $opt, $args) = @_;

	my $id    = shift @$args;
	my $task  = join ' ', @$args;
	my $todo  = $self -> app -> global_options -> {'todo'};
	my $tasks = $self -> _read($todo);

	$self -> usage_error("Err: Invalid task ID '$id'.\n")
		if ($id > scalar @$tasks) or ($id < 0) or !$id;

	if ($task =~ m/^s\//) {
		eval '@$tasks[$id-1] =~ '.$task;
	} else {
		@$tasks[$id-1] = $task;
	}

	$self -> _write($todo, $tasks);
	print "Modified task '$id'\n";
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

1; # End of Text::Todo::Simple::Command::edit
