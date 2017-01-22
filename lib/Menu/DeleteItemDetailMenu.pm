use strict;
use warnings;

use Object::Detail;
use PGInterface::Delete;

package Menu::DeleteItemDetailMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn';

has details => (isa => 'ArrayRef[Object::Detail]', is => 'ro');

sub _error_builder() {
    my $self = shift;

    return Menu::ErrorMenu->new(
        return_to => $self,
        message => "Id has to be a number!"
    );
}

sub show() {
    print "Enter detail id: ";
}

sub next_state() {
    my ($self, $id) = @_;

    if ($id !~ /^\d+$/) {
        return $self->error_state;
    }

    my $detail = $self->details->[$id];

    PGInterface::Delete->delete_item_detail($self->db_handle, $detail);

    return $self->return_to;
}

__PACKAGE__->meta->make_immutable;

1;
