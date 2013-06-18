#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 2;

BEGIN {
    use_ok( 'Catalyst::Model::Menu' ) || print "Bail out!\n";
    use_ok( 'Catalyst::Model::Menu::Link' ) || print "Bail out!\n";
}

diag( "Testing Catalyst::Model::Menu $Catalyst::Model::Menu::VERSION, Perl $], $^X" );
