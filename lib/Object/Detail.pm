use strict;
use warnings;

package Object::Detail;
use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

extends 'Object::Object';

has name => (isa => 'Str', is => 'ro');
has value => (isa => 'Str', is => 'ro');
has type => (isa => enum ([qw/attribute ability/]), is => 'ro');
has owner_id => (isa => 'Int', is => 'ro');

__PACKAGE__->meta->make_immutable;

1;


