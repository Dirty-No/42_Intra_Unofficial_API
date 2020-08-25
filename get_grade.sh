#!/bin/bash -e

#   ARG 1 = LOGIN
#   ARG 2 = "PROJECT"

#   eg: ./get_grade.sh smaccary "Exam Rank 02"
#       will print "success\n100"

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

# WE CAN'T GET THE PROJECT PAGE DIRECTLY WITH THE LOGIN AS THEY ARE LISTED BY TEAM ID
# SO WE HAVE TO SCRAP THE PROJECT URL FROM THE USER PAGE AND THEN MAKE THE REQUEST

INTRA_PAGE=$(curl "https://profile.intra.42.fr/users/$1" \
  -H 'Cache-Control: max-age=0' \
  -H 'DNT: 1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://projects.intra.42.fr/projects/exam-rank-02' \
  -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H "Cookie: _ga=$COOKIE_GA; _intra_42_session_production=$COOKIE_SESSION; user.id=$COOKIE_USER_ID; locale=en; _gid=$COOKIE_GID"   \
  -H 'If-None-Match: W/"6c68d52de37e30e80b4b827f6f3917a5"' \
  --compressed 2> /dev/null)

PROJECT="$2</a>"

PROJECT_LINK=$(echo "$INTRA_PAGE" | grep "$PROJECT" | grep -o '".*"' | tr -d '"')

PROJECT_PAGE=$(curl "$PROJECT_LINK" \
  -H 'Cache-Control: max-age=0' \
  -H 'DNT: 1' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: same-site' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://projects.intra.42.fr/projects/exam-rank-02' \
  -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H "Cookie: _ga=$COOKIE_GA; _intra_42_session_production=$COOKIE_SESSION; user.id=$COOKIE_USER_ID; locale=en; _gid=$COOKIE_GID"   \
  -H 'If-None-Match: W/"6c68d52de37e30e80b4b827f6f3917a5"' \
  --compressed 2> /dev/null)

echo "$PROJECT_PAGE" | sed -n '/data-status/,$p' | sed '/project-summary-item/,$d' | sed 's/<[^<>]*>//g' | sed -r '/^\s*$/d'
