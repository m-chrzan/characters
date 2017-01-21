use strict;
use warnings;

package Menu::QuitMenu;
use Moose;
use namespace::autoclean;

extends 'Menu::Menu';

sub show() {
    print "Bye!";
}

sub next_state() {
    return undef;
}

__PACKAGE__->meta->make_immutable;

1;
