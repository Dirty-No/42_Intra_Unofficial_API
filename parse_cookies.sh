#!/bin/bash -e

# THIS IS A TEST SCRIPT THAT ALLOWS YOU TO CHECK IF YOUR COOKIES ARE CORRECTLY PARSED

# PARSE COOKIES USED FOR WEB REQUEST HEADER  -H 'Cookie: _ga=***REMOVED***; _intra_42_session_production=***REMOVED***; user.id=***REMOVED***; locale=en; _gid=***REMOVED***'   \
# ARG 1 = cookies.txt

FILE=$(cat $1)

COOKIE_GA=$(echo "$FILE" | grep "^.42.fr" | grep -o "_ga.*" | grep -o "GA.*" | tr -d "\n \t\r")
COOKIE_GID=$(echo "$FILE" | grep "^.42.fr" | grep -o "_gid.*" | grep -o "GA.*" | tr -d "\n \t\r")
COOKIE_USER_ID=$(echo "$FILE" | grep "^intra.42.fr" | grep -o "user.id.*" | sed 's/user.id//g' | tr -d "\n \t\r")
COOKIE_SESSION=$(echo "$FILE" | grep "^.intra.42.fr" | grep -o "_intra_42_session_production.*" | sed 's/_intra_42_session_production//g' | tr -d "\n \t\r")

echo GA $COOKIE_GA
echo GID $COOKIE_GID
echo USER_ID $COOKIE_USER_ID
echo SESSION $COOKIE_SESSION