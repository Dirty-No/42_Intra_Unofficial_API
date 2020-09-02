#!/bin/bash -e

# SCRIPT TO SEARCH A SOMEONE'S BLACKHOLE (42cursus only) ON 42's INTRA
# ARG #1 = login

#   THIS SCRIPT REQUIRES A FILE NAMED COOKIES.TXT THAT CONTAINS THE COOKIES REQUIRED FOR YOU TO LOG ON THE INTRA
#
#   YOU NEED TO LOG IN with sign_in.sh TO GET IT
#
#   THIS SCRIPT WILL USE YOUR SESSION AND SENDS DIRECTLY THE REQUESTS FROM YOUR COMPUTER TO THE INTRA'S SERVERS
#                                   !!! USE AT YOUR OWN RISK !!!

LINK="https://profile.intra.42.fr/users/$1/goals?cursus=42cursus"
curl $LINK \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   \
    --cookie cookies.txt \
    --compressed 2> /dev/null
