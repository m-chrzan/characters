use strict;
use warnings;

use DBI;

package PGInterface::PGInterface;

use Moose;
use namespace::autoclean;

has db_handle => (isa => 'Item', is => 'ro', required => 1);


__PACKAGE__->meta->make_immutable;

1;

