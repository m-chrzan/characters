use strict;
use warnings;

use Object::Character;
use PGInterface::Delete;

package Menu::DeleteCharacterMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn';

sub show() {
    print "Enter character id: ";
}

sub next_state() {
    my ($self, $id) = @_;

    if ($id !~ /^\d+$/) {
        return $self->error_state;
    }

    PGInterface::Delete->delete_character($self->db_handle, $id);

    return $self->return_to;
}

__PACKAGE__->meta->make_immutable;

1;
