use strict;
use warnings;

use PGInterface::Create;

package Menu::AddItemDetailMenuName;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn';

has name => (isa => 'Str', is => 'ro', required => 1);
has item => (isa => 'Object::Item', is => 'ro');

sub show() {
    my $self = shift;
    print "Enter value: ";
}

sub next_state() {
    my ($self, $value) = @_;

    if (not $value) {
        return $self->error_state;
    }

    my $type;

    if ($value =~ /^\d+/) {
        $type = 'attribute';
    } else {
        $type = 'ability';
    }

    my $detail = Object::Detail->new(
        name => $self->name,
        value => $value,
        type => $type,
        owner_id => $self->item->id
    );

    PGInterface::Create->create_item_detail(
        $self->db_handle,
        $detail
    );

    return $self->return_to;
}

__PACKAGE__->meta->make_immutable;

1;
