use strict;
use warnings;

use Object::Character;
use Object::Detail;
use PGInterface::Get;

package Menu::CharacterDetailListMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithQuit', 'Menu::MenuWithReturn';

has character => (isa => 'Object::Character', is => 'ro');
has details => (isa => 'ArrayRef[Object::Detail]', is => 'ro');

sub _view_builder() {
    return 'views/character_details.tt'
}

sub BUILD {
    my $self = shift;

    $self->{details} = PGInterface::Get->get_character_details(
        $self->db_handle,
        $self->character->id
    );
}

sub show() {
    my $self = shift;
    $self->{details} = PGInterface::Get->get_character_details(
        $self->db_handle,
        $self->character->id
    );
    $self->_show_tt;
}

__PACKAGE__->meta->make_immutable;

1;
