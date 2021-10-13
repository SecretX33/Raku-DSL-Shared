=begin comment
#==============================================================================
#
#   Common Structures R-base actions in Raku (Perl 6)
#   Copyright (C) 2020  Anton Antonov
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Written by Anton Antonov,
#   antononcube @ gmai l . c om,
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku (Perl6) see https://raku.org/ .
#
#==============================================================================
=end comment

# The "General" section should be the same across all programming languages.
# (And natural languages too.)

use v6;
use DSL::Shared::Roles::CommonStructures;
use DSL::Shared::Actions::CommonStructures;

unit module DSL::Shared::Actions::R::CommonStructures;

class DSL::Shared::Actions::R::CommonStructures
		is DSL::Shared::Actions::CommonStructures {

	# Number list
    method number-value-list($/) { make 'c(' ~ $<number-value>>>.made.join(', ') ~ ')'; }

    # Programming languages ranges
    method r-range-spec($/) { make 'seq' ~ $<number-value-list>.made.substr(1); }
    method wl-range-spec($/) { make 'seq' ~ $<number-value-list>.made.substr(1); }
    method r-numeric-list-spec($/) { make $<number-value-list>.made; }
    method wl-numeric-list-spec($/) { make $<number-value-list>.made; }

    # Range spec
    method range-spec($/) {
		if $<range-spec-step> {
			make 'seq(' ~ $<range-spec-from>.made ~ ', ' ~ $<range-spec-to>.made ~ ', ' ~ $<range-spec-step>.made ~ ')';
		} else {
			make 'seq(' ~ $<range-spec-from>.made ~ ', ' ~ $<range-spec-to>.made ~ ')';
		}
	}

    method range-spec-from($/) { make $<number-value>.made; }
    method range-spec-to($/) { make $<number-value>.made; }
    method range-spec-step($/) { make $<number-value>.made; }

    # Regex
    method regex-pattern-spec($/) { make '"' ~ $<regex-pattern>.made ~ '"'; }

    # Over-writing the trivial
	# Trivial
	method trivial-parameter($/) { make $/.values[0].made; }
	method trivial-parameter-none($/) { make 'NA'; }
	method trivial-parameter-empty($/) { make 'c()'; }
	method trivial-parameter-automatic($/) { make 'NULL'; }
	method trivial-parameter-false($/) { make 'FALSE'; }
	method trivial-parameter-true($/) { make 'TRUE'; }
}
