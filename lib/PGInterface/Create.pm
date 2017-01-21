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

sub create_item() {
    my ($self, $dbh, $name, $character_id) = @_;

    $dbh->{AutoCommit} = 0;

    my $sth = $dbh->prepare("SELECT MAX(id) FROM Item");
    $sth->execute;

    my $result = $sth->fetchrow_arrayref;
    my $max_id = $result->[0];
    $max_id++;

    $sth = $dbh->prepare(
        'INSERT INTO Item (id, name, character_id) VALUES (?, ?, ?)'
    );

    $sth->execute($max_id, $name, $character_id);

    $dbh->commit;

    $dbh->{AutoCommit} = 1;

    return $max_id;
}

sub create_character_detail() {
    my ($self, $dbh, $detail) = @_;

    my ($table, $column);

    if ($detail->type eq 'attribute') {
        $table = 'ChAttribute';
        $column = 'value';
    } else {
        $table = 'ChAbility';
        $column = 'description';
    }

    my $sth = $dbh->prepare(
        "INSERT INTO $table (name, $column, character_id) VALUES (?, ?, ?)"
    );

    $sth->execute($detail->name, $detail->value, $detail->owner_id);
}

__PACKAGE__->meta->make_immutable;

1;
