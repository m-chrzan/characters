use strict;
use warnings;

package Menu::MenuWithReturn;
use Moose;
use namespace::autoclean;

extends 'Menu::BaseMenu';

has return_to => (isa => 'Menu::Menu', is => 'ro', required => 1);

sub BUILD {
    my $self = shift;
    $self->{connections}{r} = $self->return_to;
    $self->{link_names}{r} = 'return';
}

__PACKAGE__->meta->make_immutable;

1;
