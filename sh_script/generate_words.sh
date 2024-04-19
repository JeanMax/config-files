#!/bin/bash

# DICT=/usr/share/hunspell/fr_FR.dic
DICT=~/sh_script/french.dic

MIN_WORD_LEN=4
MAX_WORD_LEN=8

N_WORDS=2


clean_dict() {
    cut -d/ -f1 $DICT \
        | grep -E "^.{$MIN_WORD_LEN,$MAX_WORD_LEN}$"
}

pick_random_line() {
    shuf -n $N_WORDS | xargs
}

while true; do
    words=$(clean_dict | pick_random_line)
    words=( $words )

    password=$(tr -d ' ' <<< "${words[@]^} \$ 974")  # capitalize / rm spaces

    (( $(wc -c <<< $password) > 13 )) && break
done
echo $password
