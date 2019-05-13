use Data::Dumper;
sub main {
	my @consonants = `ls sounds`;
	#print Dumper(@consonants);
	my @sorted_consonants;
	foreach my $file (@consonants) {
		chomp $file;
		#print "$file\n";
		my @metadata = `stat sounds/$file`;
		my %file_and_ts;
		foreach my $meta (@metadata) {
			chomp $meta;
			if( $meta =~ m/File: (.*)$/ ) {
				$file_and_ts{ 'file' } = $1;
			}
			elsif( $meta =~ m/Change: (.*)$/ ) {
				$file_and_ts{ 'ts' } = $1;
			}
		}
		my $file = $file_and_ts{ 'file' };
	        my $ts_formatted = $file_and_ts{ 'ts' };

		my $ts = `date -d "$ts_formatted" +%s%N`;
		chomp $ts;

		push (@sorted_consonants,  [$ts, $file]);
	}

	print Dumper(\@sorted_consonants);
}
main();


