use strict;
use warnings;

use PGInterface::Create;

package Menu::AddCharacterMenuName;
use Moose;
use namespace::autoclean;

extends 'Menu::MenuWithReturn';

has name => (isa => 'Str', is => 'ro', required => 1);

sub _error_builder() {
    my $self = shift;

    return Menu::ErrorMenu->new(
        return_to => $self,
        message => "Race can't be NULL!"
    );
}

sub show() {
    my $self = shift;
    print "Enter " . $self->name . "'s race: ";
}

sub next_state() {
    my ($self, $race) = @_;

    if ($race eq '') {
        return $self->error_state;
    }

    my $id = PGInterface::Create->create_character(
        $self->db_handle,
        $self->name,
        $race
    );

    return Menu::CharacterMenu->new(
        return_to => $self->return_to,
        db_handle => $self->db_handle,
        character_id => $id
    );
}

__PACKAGE__->meta->make_immutable;

1;
