use strict;
use warnings;

use DBI;

use Object::Character;

package PGInterface::Delete;
use Moose;
use namespace::autoclean;

extends 'PGInterface::PGInterface';

sub delete_character() {
    my ($self, $dbh, $id) = @_;

    my $sth = $dbh->prepare("DELETE FROM Character WHERE id = ?");
    $sth->execute($id);
}

__PACKAGE__->meta->make_immutable;

1;
