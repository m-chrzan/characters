use strict;
use warnings;

package Menu::ErrorMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::Menu';

has message => (isa => 'Str', is => 'ro', default => 'Unknown command!');
has return_to => (isa => 'Menu::Menu', is => 'ro', required => 1);

sub show() {
    my $self = shift;
    print $self->message;
}

sub next_state() {
    my $self = shift;
    return $self->return_to;
}

__PACKAGE__->meta->make_immutable;

1;
