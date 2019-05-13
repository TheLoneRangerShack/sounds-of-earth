use Data::Dumper;

# Generate a consonant, vowel pair for pairing up with notes
sub main {
	my @consonants = `ls -tr data/sounds/consonants`;
	chomp @consonants;
	my @vowels = `ls -tr data/sounds/vowels`;
	chomp @vowels;
	my @notes = `cat line.partial.transcription`;
	chomp @notes;

	my $consonant_flag = 0;
	my $vowel_flag = 0;

	foreach my $note (@notes) {
		print "$note\t". ($consonants[$consonant_flag % scalar(@consonants)]). "\t". ($vowels[$vowel_flag % scalar(@vowels)]). "\n";
		$consonant_flag++;
		$vowel_flag++;
	}
}
main;

