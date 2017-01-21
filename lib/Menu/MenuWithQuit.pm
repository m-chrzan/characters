use strict;
use warnings;

use Menu::QuitMenu;

package Menu::MenuWithQuit;
use Moose;
use namespace::autoclean;

extends 'Menu::BaseMenu';

sub BUILD {
    my $self = shift;
    $self->{connections}{q} = Menu::QuitMenu->new;
    $self->{link_names}{q} = 'quit';
}

__PACKAGE__->meta->make_immutable;

1;
