use strict;
use warnings;

use Menu::AddCharacterDetailMenuName;

package Menu::AddCharacterDetailMenu;

use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn';

has character => (isa => 'Object::Character', is => 'ro');

sub _error_builder() {
    my $self = shift;

    return Menu::ErrorMenu->new(
        return_to => $self,
        message => "Detail name can't be NULL!"
    );
}

sub show() {
    print "Enter detail name: ";
}

sub next_state() {
    my ($self, $name) = @_;

    if ($name eq '') {
        return $self->error_state;
    }

    return Menu::AddCharacterDetailMenuName->new(
        return_to => $self->return_to,
        db_handle => $self->db_handle,
        character => $self->character,
        name => $name,
    );
}

__PACKAGE__->meta->make_immutable;

1;
