package Text::Todo::Simple::Command::list;
{
  $Text::Todo::Simple::Command::list::VERSION = '0.21';
}

use strict;
use warnings;

use Text::Todo::Simple -command;

=head1 NAME

Text::Todo::Simple::Command::list - List your tasks

=head1 VERSION

version 0.21

=head1 SYNOPSIS

    $ t list [ STR ]

This will list every taks on the todo list, optionally filtering them by C<STR>.

=cut

sub abstract { 'list your tasks' }

sub usage_desc {
	return '%c list %o [ str ]';
}

sub command_names { qw/list ls --list -l/ }

sub execute {
	my ($self, $opt, $args) = @_;

	my $todo  = $self -> app -> global_options -> {'todo'};
	my $tasks = $self -> _read($todo);
	my $grep  = join ' ', @$args;

	$grep  = '(.*)' unless $grep;

	for (my $i = 0; $i < scalar @$tasks; $i++) {
		$_ = $tasks -> [$i];

		my $string = ($i + 1).": $_\n";

		print $string if m/$grep/;
	}
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

1; # End of Text::Todo::Simple::Command::list
