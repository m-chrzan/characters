use strict;
use warnings;
use Template;

package Menu::Menu;
use Moose;
use namespace::autoclean;

has connections => ( isa => 'HashRef[Menu::Menu]', is => 'ro');
has link_names => (isa => 'HashRef[Str]', is => 'ro');
has view => (isa => 'Str', is => 'ro', builder => '_view_builder');
has db_handle => (isa => 'DBI::db', is => 'ro');

sub _view_builder() {
    return 'views/base.tt'
}

sub _show_tt() {
    my $self = shift;
    my $tt = Template->new();
    $tt->process($self->view, {menu => $self});
}

sub show() {
    my $self = shift;
    $self->_show_tt;
}

sub formatted_link() {
    my ($self, $key) = @_;

    my $link = $self->link_names->{$key};
    my $first_letter = substr($link, 0, 1);

    if ($first_letter eq $key) {
        $link =~ s/^(.)/[$1]/;
    } else {
        $link = "[$key] $link";
    }

    return $link;
}

sub next_state() {
    my $self = shift;
    return $self;
}

__PACKAGE__->meta->make_immutable;

1;
