use strict;
use warnings;

package Menu::AddItemMenu;

use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn';

has character => (isa => 'Object::Character', is => 'ro');

sub show() {
    print "Enter item name: ";
}

sub next_state() {
    my ($self, $name) = @_;

    if ($name eq '') {
        return $self->error_state;
    }

    my $id = PGInterface::Create->create_item(
        $self->db_handle,
        $name,
        $self->character->id
   );

    return Menu::ItemDetailListMenu->new(
        return_to => $self->return_to,
        db_handle => $self->db_handle,
        item_id => $id
    );
}

__PACKAGE__->meta->make_immutable;

1;
