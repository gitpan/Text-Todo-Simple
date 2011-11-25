package Text::Todo::Simple;
{
  $Text::Todo::Simple::VERSION = '0.17';
}

use App::Cmd::Setup -app;

use strict;
use warnings;

=head1 NAME

Text::Todo::Simple - Help people finish those damn tasks

=head1 VERSION

version 0.17

=head1 SYNOPSIS

Text::Todo::Simple is a simple and basic todo list manager, without all
the additional features that make people spend more time on organizing
their tasks instead of completing them.

=head1 DESCRIPTION

Text::Todo::Simple tries to be as effective as possible doing the unique
thing it does without any surplus.

This simplicity is not to distract the users from what really matters:
emptying the todo list. The time that one wastes in tagging, prioritizing
and organizing tasks, can be spent more effectively B<completing> the tasks.

=cut

sub global_opt_spec {
	my ($default_todo, $default_done);

	if ($^O eq 'MSWin32') {
		$default_todo = $ENV{USERPROFILE}."\\todo.txt";
		$default_done = $ENV{USERPROFILE}."\\done.txt";
	} else {
		$default_todo = $ENV{HOME}."/.todo";
		$default_done = $ENV{HOME}."/.done";
	}

	my $todo_file		= $ENV{TODO_FILE}    ? $ENV{TODO_FILE}    : $default_todo;
	my $done_file		= $ENV{DONE_FILE}    ? $ENV{DONE_FILE}    : $default_done;
	my $default_action	= $ENV{TODO_DEFAULT} ? $ENV{TODO_DEFAULT} : 'help';

	return (
		[ "todo=s", "set the login email",    { default => $todo_file } ],
		[ "done=s", "set the login password", { default => $done_file } ],
	);
}

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 SEE ALSO

L<Text::Todo>

=head1 LICENSE AND COPYRIGHT

Copyright 2011 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Text::Todo::Simple
