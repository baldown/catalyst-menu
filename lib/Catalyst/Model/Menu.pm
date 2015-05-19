package Catalyst::Model::Menu;

use 5.006;
use strict;
use warnings FATAL => 'all';

use Catalyst::Model::Menu::Link;
use Template;

=head1 NAME

Catalyst::Model::Menu - The great new Catalyst::Model::Menu!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Catalyst::Model::Menu;

    my $foo = Catalyst::Model::Menu->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=cut

sub new {
    my ($class, %options) = @_;
    my $self = {
        title => $options{title},
        links => [],
        class => $options{class},
        list_class => $options{list_class},
        selected_item_class => $options{selected_item_class} || 'active',
        selected_class => $options{selected_class} || 'selected',
        only_inner => $options{only_inner} || 0,
    };
    $self = bless $self, $class;
    $self->add_link(@$_) foreach @{$options{links}};
    return $self;
}

sub add_link {
    my ($self, @opts) = @_;
    my %params = scalar(@opts) == 2 ? 
        (title => $opts[1],
        url => $opts[0]) : (@opts);
    my $linkobj = Catalyst::Model::Menu::Link->new(%params);
    push($self->{links}, $linkobj);
}

sub links {
    my ($self) = @_;
    return wantarray ? @{$self->{links}} : $self->{links};
}

sub build_menu {
    my ($self, $request) = @_;
    my $tt = Template->new();
    my $inner = qq(
            [% FOREACH link IN menu.links %]
              <li role="presentation" [% link.selected(request) ? 'class="' _ menu.selected_item_class _ '" ' : '' %]">
                <a role="menuitem" [% link.selected(request) ? 'class="' _ menu.selected_class _ '" ' : '' %] 
                href="[% link.url %]">[% link.title %]</a>
              </li>
            [% END %]
    );
    my $text = $self->{only_inner} ? $inner : qq(
        <div class="[% menu.class %]">
            <span class="menu_title">[% menu.title %]</span>
            <ul role="menu" class="[% menu.list_class %]">
            $inner
            </ul>
        </div>
    );
    my $output;
    $tt->process(\$text,
    {
        request => $request,
        menu => $self,
    },
    \$output);
    return $output;
}

=head1 AUTHOR

Josh Ballard, C<< <josh at oofle.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-catalyst-model-menu at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Model-Menu>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Catalyst::Model::Menu


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Catalyst-Model-Menu>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Catalyst-Model-Menu>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Catalyst-Model-Menu>

=item * Search CPAN

L<http://search.cpan.org/dist/Catalyst-Model-Menu/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2013 Josh Ballard.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Catalyst::Model::Menu
