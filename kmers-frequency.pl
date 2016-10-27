#!/usr/local/bin/perl
# Mike McQuade
# kmers-frequency.pl
# Takes in a DNA string and an integer for the k-mers to generate,
# then outputs the frequency array of it.

use strict;
use warnings;

# Initialize variables
my (@kmers,@frequency,$genome,$k);
my @alphabet = ('A','C','G','T');
my $currentPower = my $currentChar = 0;

# Open the file to read
open(my $fh,"<ba1k.txt") or die $!;
$genome = <$fh>;
$k = <$fh>;

# Generate every possible k-mer
for (my $i = $k-1; $i >= 0; $i--) {
	$currentPower = scalar(@alphabet) ** $i;
	for (my $j = 0; $j < scalar(@alphabet)**$k; $j++) {
		if ($i == $k-1) {push(@kmers,$alphabet[$currentChar]);}
		else {$kmers[$j] .= $alphabet[$currentChar];}

		$currentPower--;

		if ($currentPower == 0){
			$currentChar = ($currentChar+1) % scalar(@alphabet);
			$currentPower = scalar(@alphabet) ** $i;
		}
	}
}

# Check how many times in the genome each pattern occurs
foreach my $pattern (@kmers) {
	my $total = 0;
	for (my $i = 0; $i <= (length($genome)-$k); $i++){
		if (substr($genome,$i,$k) eq $pattern) {$total++;}
	}
	push(@frequency,$total);
}

# Close the file
close($fh) || die "Couldn't close file properly";

# Print out the frequency array of the genome
print "@frequency\n";