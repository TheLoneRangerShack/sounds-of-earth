mkdir data
cd data

mkdir -p sounds/vowels
mkdir -p sounds/consonants

mkdir Non_Pulmonic_Raw
mkdir Co_Articulated_Consonants

##Vowels
wget https://en.wikipedia.org/wiki/IPA_vowel_chart_with_audio
cd sounds/vowels
cat ../../IPA_vowel_chart_with_audio | perl -ln -e 'print $1 if m#(upload.wikimedia.org/[^"]+ogg[^"]*)#' | xargs -I % wget --no-use-server-timestamp %

##Consonants
cd -
wget https://en.wikipedia.org/wiki/IPA_pulmonic_consonant_chart_with_audio
cd sounds/consonants
cat ../../IPA_pulmonic_consonant_chart_with_audio | perl -ln -e 'print  if m#(upload.wikimedia.org/[^]+ogg[^]*)#' | xargs -I % wget --no-use-server-timestamp %

wget https://en.wikipedia.org/wiki/International_Phonetic_Alphabet_chart

## Edit to keep non-pulmonic consonants table only for convenience.
cd -
cd Non_Pulmonic_Raw
cat ../Non_Pulmonic_Table | perl -ln -e 'print "en.wikipedia.org$1" if m#class="IPA"><a href="(/wiki/[^"]+)#' | xargs -I % wget --no-use-server-timestamp %
cd -
cd sounds/consonants
ls -tr ../../Non_Pulmonic_Raw/ | xargs -I % bash -c "cat ../../Non_Pulmonic_Raw/% | perl -ln -e 'print \$1 if m#(upload.wikimedia.org/[^\"]+ogg[^\"]*)#' | xargs -I {} wget --no-use-server-timestamp {}"

## Edit alphabet chart page and keep only co-articulated consonants for convenience
cd -
cd Co_Articulated_Raw
cat ../Co_Articulated_Consonants | perl -ln -e 'print "en.wikipedia.org$1" if m#class="IPA"><a href="(/wiki/[^"]+)#' | xargs -I % wget --no-use-server-timestamp %
cd -
cd sounds/consonants
ls -tr ../../Co_Articulated_Raw/ | xargs -I % bash -c "cat ../../Co_Articulated_Raw/% | perl -ln -e 'print \$1 if m#(upload.wikimedia.org/[^\"]+ogg[^\"]*)#' | xargs -I {} wget --no-use-server-timestamp {}"
