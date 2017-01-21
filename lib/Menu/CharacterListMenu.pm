use strict;
use warnings;

use Menu::CharacterMenu;
use Menu::AddCharacterMenu;
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

sub BUILD {
    my $self = shift;

    $self->{connections}{a} = Menu::AddCharacterMenu->new(
        db_handle => $self->db_handle,
        return_to => $self
    );
    $self->{link_names}{a} = 'add character';
}

sub show() {
    my $self = shift;
    $self->{characters} = PGInterface::Get->get_characters($self->db_handle);
    $self->_show_tt;
}

sub next_state() {
    my ($self, $command) = @_;

    if ($command =~ /^\d+$/) {
        return Menu::CharacterMenu->new(
            db_handle => $self->db_handle,
            return_to => $self,
            character_id => $command
        );
    } else {
        return $self->_standard_next_state($command);
    }
}

__PACKAGE__->meta->make_immutable;

1;
