#!/usr/bin/env perl

use strict;
use warnings;
use File::Basename;
use Text::CSV;

my $length = scalar @ARGV;
die("Usage: interview-task-2.pl -i <input.csv> -o <output.csv>\n") unless ($length == 4 && $ARGV[0] eq "-i" && $ARGV[2] eq "-o");

my $input_filename = $ARGV[1];
my $output_filename = $ARGV[3];

die("Can't locale the input file '$input_filename'\n") unless -e $input_filename;
die("Can't read the input file '$input_filename'\n") unless -r $input_filename;
die("The output file '$output_filename' already exists\n") unless !-e $output_filename;
my $output_dir = dirname($output_filename);
die("Can't write to the '$output_dir'\n") unless -w $output_dir;

my @headers = qw(id product salesperson A B C D location departments E);

my $input_csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
my $input_csv_aoh = $input_csv->csv(in => $input_filename, headers => [@headers]);
