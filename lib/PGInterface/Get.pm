use strict;
use warnings;

use DBI;

use Object::Character;

package PGInterface::Get;
use Moose;
use namespace::autoclean;

extends 'PGInterface::PGInterface';

sub get_characters() {
    my ($self, $dbh) = @_;

    my $sth = $dbh->prepare(
        'SELECT id, name, race FROM Character'
    );
    $sth->execute();

    my @characters;
    my $row;

    while ($row = $sth->fetchrow_hashref) {
        push @characters, Object::Character->new($row);
    }

    return \@characters;
}

__PACKAGE__->meta->make_immutable;

1;
