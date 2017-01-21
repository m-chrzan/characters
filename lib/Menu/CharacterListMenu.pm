use strict;
use warnings;

use Object::Character;
use PGInterface::Get;

package Menu::CharacterListMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithQuit';

has characters => (isa => 'ArrayRef[Object::Character]', is => 'ro');

sub _view_builder() {
    return 'views/characters.tt'
}

sub show() {
    my $self = shift;
    $self->{characters} = PGInterface::Get->get_characters($self->db_handle);
    $self->_show_tt;
}

__PACKAGE__->meta->make_immutable;

1;
