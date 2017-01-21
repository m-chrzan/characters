use strict;
use warnings;

use Menu::ErrorMenu;

package Menu::BaseMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::Menu';

has error_state => (
    isa => 'Menu::ErrorMenu',
    is => 'ro',
    builder => '_error_builder'
);

sub _error_builder() {
    my $self = shift;
    return Menu::ErrorMenu->new(return_to => $self);
}

sub _standard_next_state() {
    my ($self, $command) = @_;

    if ($self->connections->{$command}) {
        return $self->connections->{$command};
    } else {
        return $self->error_state;
    }
}

sub next_state() {
    my $self = shift;
    return $self->_standard_next_state(@_);
}

__PACKAGE__->meta->make_immutable;

1;
