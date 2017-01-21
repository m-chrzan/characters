use strict;
use warnings;

use Object::Item;
use Object::Detail;
use PGInterface::Get;

package Menu::ItemDetailListMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithQuit', 'Menu::MenuWithReturn';

has item => (isa => 'Object::Item', is => 'ro');
has item_id => (isa => 'Int', is => 'ro');
has details => (isa => 'ArrayRef[Object::Detail]', is => 'ro');

sub _view_builder() {
    return 'views/item_details.tt'
}

sub BUILD {
    my $self = shift;

    $self->{item} = PGInterface::Get->get_item($self->db_handle, $self->item_id);

    $self->{details} = PGInterface::Get->get_item_details(
        $self->db_handle,
        $self->item->id
    );
}

sub show() {
    my $self = shift;
    $self->{details} = PGInterface::Get->get_item_details(
        $self->db_handle,
        $self->item->id
    );
    $self->_show_tt;
}

__PACKAGE__->meta->make_immutable;

1;
