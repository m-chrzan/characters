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

sub delete_character_detail() {
    my ($self, $dbh, $detail) = @_;

    my $table;

    if ($detail->type eq 'attribute') {
        $table = 'ChAttribute';
    } else {
        $table = 'ChAbility';
    }

    my $sth = $dbh->prepare(
        "DELETE FROM $table WHERE name = ? AND character_id = ?"
    );

    $sth->execute($detail->name, $detail->owner_id);
}

__PACKAGE__->meta->make_immutable;

1;
