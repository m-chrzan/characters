use strict;
use warnings;

use Object::Character;
use Object::Item;
use PGInterface::Get;

package Menu::ItemListMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithQuit', 'Menu::MenuWithReturn';

has character => (isa => 'Object::Character', is => 'ro');
has items => (isa => 'ArrayRef[Object::Item]', is => 'ro');

sub _view_builder() {
    return 'views/items.tt'
}

sub show() {
    my $self = shift;
    $self->{items} = PGInterface::Get->get_items($self->db_handle,
                                                 $self->character->id);
    $self->_show_tt;
}

__PACKAGE__->meta->make_immutable;

1;
