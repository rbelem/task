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

my $output_csv = Text::CSV->new({ binary => 1, auto_diag => 1 });
open my $output_fh, ">:encoding(UTF-8)", $output_filename;
$output_csv->say($output_fh, [@headers]);

my $third_col_sum = 0;
my $fourth_col_negative = 0;
my $fourth_col_positive = 0;
foreach my $row (@{$input_csv_aoh}) {
  $output_csv->say($output_fh, [@{$row}{@headers}]);

  $third_col_sum += $row->{$headers[3]};

  if ($row->{$headers[4]} > 0) {
    $fourth_col_positive++;
  } elsif ($row->{$headers[4]} < 0) {
    $fourth_col_negative++;
  }
}

close($output_fh);

print "Third column sum result: $third_col_sum\n";

my $input_csv_size = scalar @{$input_csv_aoh};
my $percentage_positive = $fourth_col_positive / $input_csv_size * 100;
my $percentage_negative = $fourth_col_negative / $input_csv_size * 100;
print "Negative: $fourth_col_negative - $percentage_negative, ";
print "Positive: $fourth_col_positive - $percentage_positive\n";
