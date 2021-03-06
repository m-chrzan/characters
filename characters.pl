#!/usr/bin/env perl
use strict;
use warnings;

use Getopt::Std;
use DBI;

use lib 'lib';
use Menu::CharacterListMenu;

our ($opt_d, $opt_h, $opt_r, $opt_u, $opt_p);
$opt_d = 'bd';
$opt_h = 'labdb';
$opt_r = 5432;

getopts('d:h:r:u:p:');
# d => dbname
# h => host
# r => port
# u => username
# p => password

my $dbh = DBI->connect("dbi:Pg:dbname=$opt_d;host=$opt_h;port=$opt_r",
                        $opt_u, $opt_p,
                        {AutoCommit => 1});

my $menu = Menu::CharacterListMenu->new(db_handle => $dbh);


while ($menu) {
    $menu->show();
    my $next_command = readline;
    chomp $next_command;
    $menu = $menu->next_state($next_command);
}
