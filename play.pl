#!/usr/bin/perl

#
# usage: start music playing in rhythmbox first, then run this script
#
# type ctrl-c to kill it
#

use strict;
use warnings;

while (1) {
  sleep 5 + int rand rand 100; # mean is approx 30 seconds

  # check we're not at the beginning or end of a track
  my ($elapsed, $total) = map secs($_), split " ", `rhythmbox-client --print-playing-format "%te %td"`;
  if ($elapsed > 10 && $total-$elapsed > 10) {
    system "rhythmbox-client --pause";
    warn "paused\n";
    sleep 5 + int rand 10;
    system "rhythmbox-client --play";
    warn "playing\n";
  } else {
    warn "not stopping near start or end\n";
  }
}


sub secs {
  my ($min, $secs) = split /:/, shift;
  return $min*60+$secs;
}
