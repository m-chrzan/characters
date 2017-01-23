use strict;
use warnings;

use DBI;

use Object::Character;
use Object::Item;

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

    my $sth = $dbh->prepare(q/
        SELECT id, name, race, is_dnd_character(id) as is_dnd
        FROM Character
        WHERE id = ?
    /);

    $sth->execute($id);

    my $character = Object::Character->new($sth->fetchrow_hashref);

    if ($character->is_dnd) {
        my $sth = $dbh->prepare(q/
            SELECT name, value, modifier(character_id, name) as modifier
            FROM ChAttribute
            WHERE character_id = ? AND name SIMILAR TO
            'strength|dexterity|constitution|intelligence|wisdom|charisma|level'
        /);
        $sth->execute($id);

        my $row;
        my %statistics;
        my %modifiers;
        while ($row = $sth->fetchrow_hashref) {
            $statistics{$row->{name}} = $row->{value};
            $modifiers{$row->{name}} = $row->{modifier};
        }

        $character->statistics(\%statistics);
        $character->modifiers(\%modifiers);

        $sth = $dbh->prepare(q/
            SELECT value as level, proficiency_bonus(character_id) as prof_bonus
            FROM ChAttribute
            WHERE character_id = ? AND name = 'level'
        /);
        $sth->execute($id);

        $row = $sth->fetchrow_hashref;

        $character->level($row->{level});
        $character->prof_bonus($row->{prof_bonus});
    }

    return $character;
}

sub get_items() {
    my ($self, $dbh, $character_id) = @_;

    my $sth = $dbh->prepare('SELECT id, name FROM Item WHERE character_id = ?');
    my $rows_read = $sth->execute($character_id);

    my @items;
    my $row;

    while ($row = $sth->fetchrow_hashref) {
        push @items, Object::Item->new($row);
    }

    return \@items;
}

sub get_item() {
    my ($self, $dbh, $id) = @_;

    my $sth = $dbh->prepare(
        'SELECT I.id as id, I.name as name, C.name as owner_name ' .
        'FROM Item I JOIN Character C ON I.character_id = C.id ' .
        'WHERE I.id = ?'
    );

    $sth->execute($id);

    return Object::Item->new($sth->fetchrow_hashref);
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
        if (not defined $row->{value}) {
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

sub get_item_details() {
    my ($self, $dbh, $id) = @_;

    my $sth = $dbh->prepare(
        'SELECT name, value, description FROM item_info(?)'
    );

    $sth->execute($id);

    my @details;
    my $row;

    while ($row = $sth->fetchrow_hashref) {
        if (not defined $row->{value}) {
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
