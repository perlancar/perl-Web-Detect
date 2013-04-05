package Web::Detect;

use 5.010001;
use strict;
use warnings;
use Log::Any '$log';

# VERSION

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(detect_web);

sub detect_web {
    my %res;

    if (($ENV{GATEWAY_INTERFACE} // "") =~ m!^CGI/!) {
        $res{cgi} = 1;
    }
    if ($ENV{MOD_PERL}) {
        $res{mod_perl} = 1;
    }
    if ($ENV{PLACK_ENV}) {
        $res{plack} = 1;
        $res{psgi} = 1;
    }

    return undef unless %res;
    \%res;
}

1;
#ABSTRACT: Detect if program is running under some web environment

=head1 SYNOPSIS

 use Web::Detect qw(detect_web);
 say "Running under web" if detect_web();


=head1 DESCRIPTION


=head1 FUNCTIONS

=head2 detect_web() => HASHREF

Return undef if not detected running under any web environment.

Return a hash otherwise, with following keys: C<mod_perl> (bool, true if
detected running under mod_perl), C<plack> (bool, true if detected running under
Plack), C<cgi> (bool, true if detected running under CGI).


=head1 FAQ

=head2 What is the use of this module?

Usually I do it to decide whether to output HTML or plaintext. Running under
some web environment usually prefers HTML output.

=head1 TODO


=head1 SEE ALSO

=cut
