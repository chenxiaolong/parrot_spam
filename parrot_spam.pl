use strict;
use warnings;
use v5.18;

my @parrots = grep { length $_ > 0 } @ARGV;
unless (@parrots) {
    print STDERR "Nothing to repeat\n";
    exit 1;
}

my $avail = 4000;

SPAM: while (1) {
    foreach my $p (@parrots) {
        $avail -= length $p;
        last SPAM if $avail < 0;
        print $p;
    }
}

print "\n" if -t STDIN;
