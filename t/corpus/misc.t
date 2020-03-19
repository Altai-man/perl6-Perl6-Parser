use Test;
use Perl6::Parser;
use lib 't/lib/';
use Utils;

my $*CONSISTENCY-CHECK = True;
my $*FALL-THROUGH      = True;

subtest {
	{ ok round-trips( Q:to[_END_] ), Q{Problem 1};
use JSON::Tiny;

grammar IPv4 {
    token TOP { <seg> ** 4 % '.' }
    token seg { \d+ { 0 <= $/ <= 255 } }
}

# Find all IPv4 data sources and show them.
my @data = from-json(slurp 'input.json');
for @data.map(*<from>) -> $from {
    if IPv4.parse($from) {
        say "Address: $from";
    }
}
_END_
    };
}

done-testing;
