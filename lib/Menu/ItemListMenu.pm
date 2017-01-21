use strict;
use warnings;

use Menu::AddItemMenu;
use Menu::ItemDetailListMenu;
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

sub BUILD {
    my $self = shift;

    $self->{connections}{a} = Menu::AddItemMenu->new(
        db_handle => $self->db_handle,
        character => $self->character,
        return_to => $self
    );
    $self->{link_names}{a} = 'add item';
}

sub show() {
    my $self = shift;
    $self->{items} = PGInterface::Get->get_items($self->db_handle,
                                                 $self->character->id);
    $self->_show_tt;
}

sub next_state() {
    my ($self, $command) = @_;

    if ($command =~ /^\d+$/) {
        return Menu::ItemDetailListMenu->new(
            db_handle => $self->db_handle,
            return_to => $self,
            item_id => $command
        );
    } else {
        return $self->_standard_next_state($command);
    }
}


__PACKAGE__->meta->make_immutable;

1;
