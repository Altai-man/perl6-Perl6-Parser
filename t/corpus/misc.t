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

subtest {
    { ok round-trips(Q:to[_END_]), Q{Combinations}
use v6;

multi combs(@, 0) { "" };
multi combs { combs(@^dict, $^n - 1) X~ @dict };

(.say for combs(<a b c>, $_)) for 1..4;

# vim: expandtab shiftwidth=4 ft=perl6
_END_
};
}

subtest {
    { ok round-trips(Q:to[_END_]), Q{Simple strings grammar}

grammar String::Simple::Grammar {
    rule TOP {^ <string> $}
    # Note for now, {} gets around a rakudo binding issue
    token string { <quote> {} <quotebody($<quote>)> $<quote> }
    token quote { '"' | "'" }
    token quotebody($quote, $two) { ( <escaped($quote)> | <!before $quote> . )* }
    token escaped($quote) { '\\' ( $quote | '\\' ) }
}

# The parse-tree builder ultimately returns the string itself.
class String::Simple::Actions {
    method TOP($/) { make $<string>.made }
    method string($/) { make $<quotebody>.made }
    method quotebody($/) { make [~] $0.map: {.<escaped>.made or ~$_} }
    method escaped($/) { make ~$0 }
}
_END_
 }
};

done-testing;
