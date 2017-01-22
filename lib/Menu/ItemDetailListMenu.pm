use strict;
use warnings;

use Menu::AddItemDetailMenu;
use Menu::DeleteItemDetailMenu;
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

sub _pre_show {
    my $self = shift;

    $self->{item} = PGInterface::Get->get_item($self->db_handle, $self->item_id);

    $self->{details} = PGInterface::Get->get_item_details(
        $self->db_handle,
        $self->item->id
    );

    $self->{connections}{d} = Menu::DeleteItemDetailMenu->new(
        db_handle => $self->db_handle,
        details => $self->details,
        return_to => $self
    );
    $self->{link_names}{d} = 'delete detail';

    $self->{connections}{a} = Menu::AddItemDetailMenu->new(
        db_handle => $self->db_handle,
        item => $self->item,
        return_to => $self
    );
    $self->{link_names}{a} = 'add detail';
}

__PACKAGE__->meta->make_immutable;

1;
