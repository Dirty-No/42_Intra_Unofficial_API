#!/bin/bash -e

# SCRIPT TO SEARCH A LOGIN ON 42's INTRA
# ARG #1 = login

LINK="https://profile.intra.42.fr/searches/search?query=$1"
curl $LINK \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   \
    --cookie cookies.txt\
    --compressed 2> /dev/null | sed -n '/Users/,$p' | sed '/General/,$d' |  sed 's/<[^<>]*>//g' | sed 's/Users//g' | sed -r '/^\s*$/d'
