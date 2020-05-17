#!/usr/bin/env perl

use 5.18.2;
use strict;
use warnings;

use Iridescence;

use Test::Simple tests => 7;


my $black = '000000';
my $white = 'ffffff';



ok(Iridescence::lighten($black, 1.0) eq $white, "black lightened 100pct");

ok(Iridescence::darken($white, 1.0) eq $black, "white darkened 100pct");

ok(Iridescence::_stripHash("#".$black)  eq $black, "remove hash");

ok(Iridescence::_boundsCheck(500) == 255, "upper bounds check");

ok(Iridescence::_boundsCheck(-500) == 0, "lower bounds check");

ok(Iridescence::_boundsCheck(125) == 125, "within bounds check");

ok(Iridescence::_rgbToHex(0, 0, 0) eq $black, "rgb to hex");

