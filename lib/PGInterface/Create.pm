use strict;
use warnings;

use DBI;

use Object::Character;

package PGInterface::Create;

use Moose;
use namespace::autoclean;
extends 'PGInterface::PGInterface';

sub create_character() {
    my ($self, $dbh, $name, $race) = @_;

    $dbh->{AutoCommit} = 0;

    my $sth = $dbh->prepare("SELECT MAX(id) FROM Character");
    $sth->execute;

    my $result = $sth->fetchrow_arrayref;
    my $max_id = $result->[0];
    $max_id++;

    $sth = $dbh->prepare(
        "INSERT INTO Character (id, name, race) VALUES (?, ?, ?)"
    );

    $sth->execute($max_id, $name, $race);

    $dbh->commit;

    $dbh->{AutoCommit} = 1;

    return $max_id;
}

__PACKAGE__->meta->make_immutable;

1;
