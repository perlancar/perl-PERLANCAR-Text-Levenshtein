package PERLANCAR::Text::Levenshtein;

# DATE
# VERSION

#use 5.010001;
#use strict;
#use warnings;

#require Exporter;
#our @ISA = qw(Exporter);
#our @EXPORT_OK = qw(editdist);

# BEGIN BLOCK: routine
sub __min(@) {
    my $m = $_[0];
    for (@_) {
        $m = $_ if $_ < $m;
    }
    $m;
}

# straight copy of Wikipedia's "Levenshtein Distance"
sub editdist {
    my @a = split //, shift;
    my @b = split //, shift;

    # There is an extra row and column in the matrix. This is the distance from
    # the empty string to a substring of the target.
    my @d;
    $d[$_][0] = $_ for 0 .. @a;
    $d[0][$_] = $_ for 0 .. @b;

    for my $i (1 .. @a) {
        for my $j (1 .. @b) {
            $d[$i][$j] = (
                $a[$i-1] eq $b[$j-1]
                    ? $d[$i-1][$j-1]
                    : 1 + __min(
                        $d[$i-1][$j],
                        $d[$i][$j-1],
                        $d[$i-1][$j-1]
                    )
                );
        }
    }

    $d[@a][@b];
}
# END BLOCK

1;
# ABSTRACT: Calculate Levenshtein edit distance

=head1 DESCRIPTION

This module contains the routine C<editdist> copied from L<App::perlbrew>, which
is copied from Wikipedia article "Levenshtein Distance".


=head1 FUNCTIONS

=head2 editdist($str1, $str2) => int

Not exported.
