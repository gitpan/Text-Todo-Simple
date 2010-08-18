package Text::Todo::Simple;

use Carp;

use warnings;
use strict;

=head1 NAME

Text::Todo::Simple - Todo list manager that helps in finishing tasks, not organizing them

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Text::Todo::Simple is a simple and basic todo list manager, without all
the additional features that make people spending more time on organizing
tasks instead of completing them.

    use Text::Todo::Simple;

    my $todo = Text::Todo::Simple->new(todo_file => $todo_file,
				       done_file => $done_file);

    $todo->add('Something to do');
    $todo->list('Something');
    $todo->edit(1, 'Something to do and more');
    $todo->add('Something else to do');
    $todo->move(2, 1);
    $todo->remove(2);
    $todo->do(1);

=head1 DESCRIPTION

Text::Todo::Simple tries to be as effective as possible doing the unique
thing it does without any surplus.

This simplicity is aimed to not distract the users from what really
matters: emptying the todo list. The time that one wastes in tagging,
prioritizing and organizing tasks, can be spent more effectively B<completing>
the tasks.

Text::Todo::Simple was inspired by stevelosh' L<t|<a href="http://stevelosh.com/projects/t/"></a>> project.

=head1 METHODS

=head2 new

Create a todo object

=cut

sub new {
	my ($class, %args) = @_;
 
	my $self = bless({%args}, $class);

	return $self;
}

=head2 add( $task )

Add $task to the todo list

=cut

sub add {
	my ($self, $task) = @_;

	_append($self -> {'todo_file'}, $task);
}

=head2 do( $id )

Move $id task to done file

=cut

sub do {
	my ($self, $id) = @_;

	my $task = @{ _read($self -> {'todo_file'}) }[$id-1];
	_append($self -> {'done_file'}, $task);
	
	$self -> rm($id);
}

=head2 list( $grep )

List task containing $grep (optional)

=cut

sub list {
	my ($self, $grep) = @_;

	my $tasks = _read($self -> {'todo_file'});

	for (my $i = 0; $i < scalar @$tasks; $i++) {
		substr(@$tasks[$i], 0, 0, ($i+1)." ");
	}

	my $find = $grep ? $grep : "(.*?)";

	my @out = grep(/$find/, @{ $tasks });

	foreach my $item(@out) {
		print $item, "\n";
	}
}

=head2 remove( $id )

Remove $id task

=cut

sub remove {
	my ($self, $id) = @_;

	my $tasks = _read($self -> {'todo_file'});

	splice @$tasks, $id-1, 1;

	_write($self -> {'todo_file'}, $tasks);
}

=head2 edit( $id, $new )

Replace $id task with $new

=cut

sub edit {
	my ($self, $id, $new) = @_;

	my $tasks = _read($self -> {'todo_file'});

	@$tasks[$id-1] = $new;

	_write($self -> {'todo_file'}, $tasks);
}

=head2 move( $id, $new )

Move $id task to $new

=cut

sub move {
	my ($self, $id, $new) = @_;

	my $tasks = _read($self -> {'todo_file'});
	my $task  = @$tasks[$id-1];

	splice @$tasks, $id-1, 1;
	use Data::Dumper;
	
	splice @$tasks, $new-1, 0, $task;

	_write($self -> {'todo_file'}, $tasks);
}

=head1 INTERNAL METHODS

=head2 _read( $file )

Read file to array reference

=cut

sub _read {
	my $file = shift;

	open(FILE, "<$file") or croak "Cannot open $file in read mode.\n";
	my @data = <FILE>;
	close(FILE);

	foreach my $item(@data) {
		chomp $item;
	}

	return \@data;
}

=head2 _append( $file, $data )

Append string to file

=cut

sub _append {
	my ($file, $data) = @_;

	chomp $data;

	open(FILE, ">>$file") or croak "Cannot open $file in append mode.\n";
	print FILE $data, "\n";
	close(FILE);
}

=head2 _write( $file, $data )

Write array (by reference) to file

=cut

sub _write {
	my ($file, $data) = @_;

	open(FILE, ">$file") or croak "Cannot open $file in read mode.\n";

	foreach my $item(@{ $data }) {
		print FILE "$item\n";
	}

	close(FILE);
}

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

L<Text::Todo>

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Text::Todo::Simple
