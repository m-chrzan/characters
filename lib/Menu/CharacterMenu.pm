use strict;
use warnings;

use Object::Character;
use PGInterface::Get;

package Menu::CharacterMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn', 'Menu::MenuWithQuit';

has character_id => (isa => 'Str', is => 'ro', required => 1);
has character => (isa => 'Object::Character', is => 'ro');

sub _view_builder() {
    return 'views/character.tt';
}

sub BUILD {
    my $self = shift;
    my $id = $self->character_id;
    my $character = PGInterface::Get->get_character($self->db_handle, $id);

    $self->{character} = $character;
}

__PACKAGE__->meta->make_immutable;

1;
