use strict;
use warnings;

package Menu::AddCharacterMenu;

use Moose;
use namespace::autoclean;
use Menu::AddCharacterMenuName;

extends 'Menu::MenuWithReturn';

sub show() {
    print "Enter character's name: ";
}

sub next_state() {
    my ($self, $name) = @_;

    if (not $name) {
        return $self->error_state;
    }

    return Menu::AddCharacterMenuName->new(
        db_handle => $self->db_handle,
        return_to => $self->return_to,
        name => $name
    );
}

__PACKAGE__->meta->make_immutable;

1;
