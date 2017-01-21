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

sub get_character() {
    my ($self, $dbh, $id) = @_;

    my $sth = $dbh->prepare(
        'SELECT id, name, race FROM Character WHERE id = ?'
    );

    $sth->execute($id);

    return Object::Character->new($sth->fetchrow_hashref);
}

sub get_character_details() {
    my ($self, $dbh, $id) = @_;

    my $sth = $dbh->prepare(
        'SELECT name, value, description FROM character_info(?)'
    );

    $sth->execute($id);

    my @details;
    my $row;

    while ($row = $sth->fetchrow_hashref) {
        if (!$row->{value}) {
            $row->{value} = $row->{description};
            $row->{type} = 'ability';
        } else {
            $row->{type} = 'attribute';
        }

        $row->{owner_id} = $id;

        push @details, Object::Detail->new($row);
    }

    return \@details;
}

__PACKAGE__->meta->make_immutable;

1;
