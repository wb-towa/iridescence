#!/usr/env/bin perl

# Author: William B
# Email: toadwarrior@gmail.com
# Date: 2016-May-29
# Copyright (c) 2016-2020 All Rights Reserved https://github.com/wb-towa/iridescence/
#
# A port of a python library I wrote awhile ago but for Perl
# Python repo at https://bitbucket.org/wb-towa/blade
#
# GPL v3 licence
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# TODO:
#
# - Add more functionality
# - hex to rgb and rgb to hex shouldnt't be undescored functions
# - acept 3 letter hex codes
#

package Iridescence;

use 5.18.2;
use strict;
use warnings;

#
# Interal Functions
#
sub _stripHash {
    # remove the hash from the hex color if found
    my $html_color = shift;

    if ($html_color =~ /^#/) {
        return substr $html_color, 1;
    } else {
        return $html_color;
    }
 }


sub _boundsCheck {
    # Ensure the number stays within the 0 to 255
    my $num = shift;

    if ($num > 255) {
        return 255;
    } elsif ($num < 0) {
        return 0;
    } else {
        return $num;
    }
}

sub _hexToRgb {
    # Convert the hex string to list of RBG integers
    my $hex_str = shift;
    my ($r, $g, $b) = _stripHash($hex_str) =~ m/(\w{2})(\w{2})(\w{2})/;

    my @rgb = ();
    $rgb[0] = CORE::hex($r);
    $rgb[1] = CORE::hex($g);
    $rgb[2] = CORE::hex($b);

    return @rgb;
}

sub _rgbToHex {
    # convert ints representing r,g,b into a hex color string
    # no hash included
    my($r, $g, $b) = @_;
    return sprintf("%02lx%02lx%02lx", $r, $g, $b);
}

#
# Public Functions
#
sub blend {
    # Blend colour 1 and colour 2 by a given percentage represented as 0.0 to 1.0
    # Params:
    # colour1 in html hex format (string)
    # colour2 in html hex format (string)
    # percentage (float)
    my $tone = 0;
    my ($color1, $color2, $pct) = @_;
    my @rgb1 = _hexToRgb($color1);
    my @rgb2 = _hexToRgb($color2);

    my $r = _boundsCheck(sprintf("%.0f", ($rgb2[0] - $rgb1[0]) * $pct) + $rgb1[0]);
    my $g = _boundsCheck(sprintf("%.0f", ($rgb2[1] - $rgb1[1]) * $pct) + $rgb1[1]);
    my $b = _boundsCheck(sprintf("%.0f", ($rgb2[2] - $rgb1[2]) * $pct) + $rgb1[2]);

    return _rgbToHex($r, $g, $b);
}

sub lighten {
    # Lighten the color by a given percentage represented as 0.0 to 1.0
    # Params:
    # colour in html hex format (string)
    # percentage (float)
    my $tone = 255;
    my ($color, $pct) = @_;
    my @rgb = _hexToRgb($color);

    my $r = _boundsCheck(sprintf("%.0f", ($tone - $rgb[0]) * $pct) + $rgb[0]);
    my $g = _boundsCheck(sprintf("%.0f", ($tone - $rgb[1]) * $pct) + $rgb[1]);
    my $b = _boundsCheck(sprintf("%.0f", ($tone - $rgb[2]) * $pct) + $rgb[2]);

    return _rgbToHex($r, $g, $b);
}

sub darken {
    # Darken the color by a given percentage represented as 0.0 to 1.0
    # Params:
    # colour in html hex format (string)
    # percentage (float)
    my $tone = 0;
    my ($color, $pct) = @_;
    my @rgb = _hexToRgb($color);

    my $r = _boundsCheck(sprintf("%.0f", ($tone - $rgb[0]) * $pct) + $rgb[0]);
    my $g = _boundsCheck(sprintf("%.0f", ($tone - $rgb[1]) * $pct) + $rgb[1]);
    my $b = _boundsCheck(sprintf("%.0f", ($tone - $rgb[2]) * $pct) + $rgb[2]);

    return _rgbToHex($r, $g, $b);
}

1;

