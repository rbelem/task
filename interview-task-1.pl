#!/usr/bin/env perl

use strict;
use warnings;

my $length = scalar @ARGV;
die("Usage: interview-task-2.pl -i <input.csv> -o <output.csv>\n") unless ($length == 4 && $ARGV[0] eq "-i" && $ARGV[2] eq "-o");
