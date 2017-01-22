use strict;
use warnings;

use Object::Character;
use PGInterface::Delete;

package Menu::DeleteItemMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn';

sub show() {
    print "Enter item id: ";
}

sub _error_builder() {
    my $self = shift;

    return Menu::ErrorMenu->new(
        return_to => $self,
        message => "Id has to be a number!"
    );
}

sub next_state() {
    my ($self, $id) = @_;

    if ($id !~ /^\d+$/) {
        return $self->error_state;
    }

    PGInterface::Delete->delete_item($self->db_handle, $id);

    return $self->return_to;
}

__PACKAGE__->meta->make_immutable;

1;
