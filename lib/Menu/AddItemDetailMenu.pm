use strict;
use warnings;

use Menu::AddItemDetailMenuName;

package Menu::AddItemDetailMenu;

use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn';

has item => (isa => 'Object::Item', is => 'ro');

sub show() {
    print "Enter detail name: ";
}

sub next_state() {
    my ($self, $name) = @_;

    if (not $name) {
        return $self->error_state;
    }

    return Menu::AddItemDetailMenuName->new(
        return_to => $self->return_to,
        db_handle => $self->db_handle,
        item => $self->item,
        name => $name,
    );
}

__PACKAGE__->meta->make_immutable;

1;
