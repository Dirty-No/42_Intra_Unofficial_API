#!/bin/bash -e

#   ARG 1 = LOGIN
#   ARG 2 = "PROJECT"

#   eg: ./get_grade.sh smaccary "Exam Rank 02"
#       will print "success\n100"

#   THIS SCRIPT REQUIRES A FILE NAMED COOKIES.TXT THAT CONTAINS THE COOKIES REQUIRED FOR YOU TO LOG ON THE INTRA
#   YOU CAN GET THIS FILE WITH sign_in.sh
#   THIS SCRIPT WILL USE YOUR SESSION AND SENDS DIRECTLY THE REQUESTS FROM YOUR COMPUTER TO THE INTRA'S SERVERS
#                                   !!! USE AT YOUR OWN RISK !!!

# WE CAN'T GET THE PROJECT PAGE DIRECTLY WITH THE LOGIN AS THEY ARE LISTED BY TEAM ID
# SO WE HAVE TO SCRAP THE PROJECT URL FROM THE USER PAGE AND THEN MAKE THE REQUEST

LINK="https://profile.intra.42.fr/users/$1"
INTRA_PAGE=$(curl $LINK \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   \
    --cookie cookies.txt \
    --compressed 2> /dev/null)

PROJECT="$2</a>"

PROJECT_LINK=$(echo "$INTRA_PAGE" | grep "$PROJECT" | grep -o '".*"' | tr -d '"')

PROJECT_PAGE=$(curl $PROJECT_LINK \
    -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   \
    --cookie cookies.txt \
    --compressed 2> /dev/null)

echo "$PROJECT_PAGE" | sed -n '/data-status/,$p' | sed '/project-summary-item/,$d' | sed 's/<[^<>]*>//g' | sed -r '/^\s*$/d'
