use strict;
use warnings;

package Object::Character;
use Moose;
use namespace::autoclean;

extends 'Object::Object';

has id => (isa => 'Int', is => 'rw');
has name => (isa => 'Str', is => 'rw');
has race => (isa => 'Str', is => 'rw');

__PACKAGE__->meta->make_immutable;

1;

