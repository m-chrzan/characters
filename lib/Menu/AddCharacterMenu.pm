use strict;
use warnings;

package Menu::AddCharacterMenu;

use Moose;
use namespace::autoclean;
use Menu::AddCharacterMenuName;

extends 'Menu::MenuWithReturn';

sub _error_builder() {
    my $self = shift;

    return Menu::ErrorMenu->new(
        return_to => $self,
        message => "Name can't be NULL!"
    );
}

sub show() {
    print "Enter character's name: ";
}

sub next_state() {
    my ($self, $name) = @_;

    if ($name eq '') {
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
