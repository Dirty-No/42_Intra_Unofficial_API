#!/bin/bash -e

#   SCRIPT TO PRINT ALL 42'S INTRA LOGINS
#
#   WARNING : WILL MAKE 26*26*26 REQUEST TO THE INTRA
#           !!! USE AT YOUR OWN RISK !!!

#   THIS SCRIPT REQUIRES A FILE NAMED COOKIES.TXT THAT CONTAINS THE COOKIES REQUIRED FOR YOU TO LOG ON THE INTRA
#
#   ONE WAY TO GET THIS FILE IS USING THIS CHROME EXTENSION :
#   https://chrome.google.com/webstore/detail/cookiestxt/njabckikapfpffapmjgojcnbfjonfjfg?hl=fr
#
#   THIS SCRIPT WILL USE YOUR SESSION AND SENDS DIRECTLY THE REQUESTS FROM YOUR COMPUTER TO THE INTRA'S SERVERS
#                                   !!! USE AT YOUR OWN RISK !!!

FILE=$(cat cookies.txt)

COOKIE_GA=$(echo "$FILE" | grep "^.42.fr" | grep -o "_ga.*" | grep -o "GA.*" | tr -d "\n \t\r")
COOKIE_GID=$(echo "$FILE" | grep "^.42.fr" | grep -o "_gid.*" | grep -o "GA.*" | tr -d "\n \t\r")
COOKIE_USER_ID=$(echo "$FILE" | grep "^intra.42.fr" | grep -o "user.id.*" | sed 's/user.id//g' | tr -d "\n \t\r")
COOKIE_SESSION=$(echo "$FILE" | grep "^.intra.42.fr" | grep -o "_intra_42_session_production.*" | sed 's/_intra_42_session_production//g' | tr -d "\n \t\r")

for X in {a..z}
do
#   if script crashes before end you can know which X it was testing last
#   and you can get the rest of the list without starting again from scratch by modifying the script
    echo "$X" >> state
    for Y in {a..z}
    do
        for Z in {a..z}
        do
            LINK="https://profile.intra.42.fr/searches/search?query=$X$Y$Z"
            #REQUEST
            echo "$(curl $LINK \
                -H 'Cache-Control: max-age=0'   -H 'DNT: 1'   -H 'Upgrade-Insecure-Requests: 1'   \
                -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36'   \
                -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   \
                -H 'Sec-Fetch-Site: same-origin'   -H 'Sec-Fetch-Mode: navigate'   -H 'Sec-Fetch-User: ?1'   \
                -H 'Sec-Fetch-Dest: document'   -H 'Referer: https://profile.intra.42.fr/'   \
                -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7'   \
                -H "Cookie: _ga=$COOKIE_GA; _intra_42_session_production=$COOKIE_SESSION; user.id=$COOKIE_USER_ID; locale=en; _gid=$COOKIE_GID"   \
                -H 'If-None-Match: W/"f6849efa7dddf5949c5f1e8c8083d6ff"'   --compressed 2>> log)" \
            | sed -n '/Users/,$p' | sed '/General/,$d' |  sed 's/<[^<>]*>//g' | sed 's/Users//g' | sed -r '/^\s*$/d' &
        done
    done
done

# TO SORT YOUR LIST FILE AND REMOVE DUPLICATES : echo "$(sort list_file)" | uniq > list_file
