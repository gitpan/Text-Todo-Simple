#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Text::Todo::Simple' ) || print "Bail out!
";
}

diag( "Testing Text::Todo::Simple $Text::Todo::Simple::VERSION, Perl $], $^X" );
