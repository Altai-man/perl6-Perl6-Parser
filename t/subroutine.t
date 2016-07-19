use v6;

use Test;
use Perl6::Tidy;

plan 2;

my $pt = Perl6::Tidy.new;

subtest {
	plan 1;

	my $parsed = $pt.tidy( Q[sub foo { }] );
	isa-ok $parsed, Q{Root};
}, Q{empty};

subtest {
	plan 2;

	subtest {
		plan 5;

		subtest {
			plan 1;

			my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( 0 ) { }
_END_
			isa-ok $parsed, Q{Root};
		}, Q{constant};

		subtest {
			plan 1;

			my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( $a ) { }
_END_
			isa-ok $parsed, Q{Root};
		}, Q{untyped};

		subtest {
			plan 4;

			subtest {
				plan 1;

				my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( Str $a ) { }
_END_
				isa-ok $parsed, Q{Root};
			}, Q{typed};

			subtest {
				plan 1;

				my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( ::T $a ) { }
_END_
				isa-ok $parsed, Q{Root};
			}, Q{type-capture};

			subtest {
				plan 1;

				my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( Str ) { }
_END_
				isa-ok $parsed, Q{Root};
			}, Q{type-only};

			subtest {
				plan 1;

				my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( Str $a where "foo" ) { }
_END_
				isa-ok $parsed, Q{Root};
			}, Q{type-constrained};
		}, Q{typed};

		subtest {
			plan 1;

			my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( $a = 0 ) { }
_END_
			isa-ok $parsed, Q{Root};
		}, Q{default};

		subtest {
			plan 1;

			my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( :$a ) { }
_END_
			isa-ok $parsed, Q{Root};
		}, Q{optional};
	}, Q{single};

	subtest {
		plan 1;

		my $parsed = $pt.tidy( Q:to[_END_] );
sub foo( $a, $b ) { }
_END_
		isa-ok $parsed, Q{Root};
	}, Q{multiple};
}, Q{scalar arguments};

# vim: ft=perl6