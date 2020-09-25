#!/bin/bash

# SCRIPT TO GET ALL LAST COMMUNITY SERVICES (42paris only)

#   THIS SCRIPT REQUIRES A FILE NAMED COOKIES.TXT THAT CONTAINS THE COOKIES REQUIRED FOR YOU TO LOG ON THE INTRA
#
#   YOU NEED TO SIGN IN WITH sign_in.sh TO GET YOUR COOKIES
#
#   THIS SCRIPT WILL USE YOUR SESSION AND SENDS DIRECTLY THE REQUESTS FROM YOUR COMPUTER TO THE INTRA'S SERVERS
#                                   !!! USE AT YOUR OWN RISK !!!

declare -a StringArray=("assembly" "order" "federation" "alliance")

for coalition in "${StringArray[@]}"; do
    printf "\n%s %10s %s\n\n" "###############" "$coalition" "###############"
    for page in {1..2}; do
        LINK="https://profile.intra.42.fr/blocs/16/coalitions/42cursus-paris-the-$coalition/scores?page=$page&search=close"
        PAGE=$(
            curl -s $LINK \
            -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   \
            --cookie cookies.txt \
            --compressed)
        LOGINS=$(echo "$PAGE" | grep href=\"/users/ | sed 's/<[^<>]*>//g')
        DATES=$(echo "$PAGE" | grep -B6 href=\"/users/ | grep -Eo title=\'.*\' | sed 's/title=//g' | tr "'" '|' )
        paste <(echo "$DATES") <(echo "$LOGINS")
    done
done
