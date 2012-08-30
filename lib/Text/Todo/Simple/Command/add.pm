package Text::Todo::Simple::Command::add;
{
  $Text::Todo::Simple::Command::add::VERSION = '0.21';
}

use strict;
use warnings;

use Text::Todo::Simple -command;

=head1 NAME

Text::Todo::Simple::Command::add - Add a task to the list

=head1 VERSION

version 0.21

=head1 SYNOPSIS

    $ t add TASK ...

This will add the task C<TASK> to the todo list.

=cut

sub abstract { 'add a task to the list' }

sub usage_desc {
	return '%c add %o task ...';
}

sub command_names { qw/add --add -a/ }

sub execute {
	my ($self, $opt, $args) = @_;

	my $task = join ' ', @$args;
	my $todo = $self -> app -> global_options -> {'todo'};

	$self -> _append($todo, $task);

	my $id = scalar @{ $self -> _read($todo) };
	print "Added task '$id'\n";
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

1; # End of Text::Todo::Simple::Command::add
