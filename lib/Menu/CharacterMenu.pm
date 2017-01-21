use strict;
use warnings;

use Menu::CharacterDetailListMenu;
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

    $self->{connections}{d} = Menu::CharacterDetailListMenu->new(
        db_handle => $self->db_handle,
        character => $self->character,
        return_to => $self
    );
    $self->{link_names}{d} = 'details';
}

__PACKAGE__->meta->make_immutable;

1;
