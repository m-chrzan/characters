use strict;
use warnings;

package Object::Character;
use Moose;
use namespace::autoclean;

extends 'Object::Object';

has id => (isa => 'Int', is => 'rw');
has name => (isa => 'Str', is => 'rw');
has race => (isa => 'Str', is => 'rw');
has is_dnd => (isa => 'Bool', is => 'ro');

has level => (isa => 'Int', is => 'rw');
has prof_bonus => (isa => 'Int', is => 'rw');
has statistics => (isa => 'HashRef[Int]', is => 'rw');
has modifiers => (isa => 'HashRef[Int]', is => 'rw');

__PACKAGE__->meta->make_immutable;

1;

