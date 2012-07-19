package Text::Todo::Simple::Command;
{
  $Text::Todo::Simple::Command::VERSION = '0.19';
}

use strict;
use warnings;

use App::Cmd::Setup -command;

=head1 NAME

Text::Todo::Simple::Command - Base class for Text::Todo::Simple commands

=head1 VERSION

version 0.19

=head1 METHODS

=head2 _read( $file )

Read file to array reference

=cut

sub _read {
	my ($self, $file_name) = @_;

	open my $file, '<', $file_name
		or $self -> usage_error("Err: cannot open '$file_name': $!.\n");

	my @data = map {chomp $_; $_ } <$file>;
	close $file;

	return \@data;
}

=head2 _append( $file_name, $data )

Append string to file

=cut

sub _append {
	my ($self, $file_name, $data) = @_;

	chomp $data;

	open my $file, '>>', $file_name
		or $self -> usage_error("Err: cannot open '$file_name': $!.\n");

	print $file $data, "\n";
	close $file;
}

=head2 _write( $file, $data )

Write array (by reference) to file

=cut

sub _write {
	my ($self, $file_name, $data) = @_;

	my $string = join "\n", @$data ;

	open my $file, '>', $file_name
		or $self -> usage_error("Err: cannot open '$file_name': $!.\n");

	print $file $string, $string ne "" ? "\n" : "";
	close $file;
}

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 SEE ALSO

L<Text::Todo>

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Text::Todo::Simple::Command
