#!/bin/sh

printf "Login: "
read LOGIN

stty -echo
printf "Password: "
read PASSWORD
stty echo
printf "\n"

echo "" > cookies.txt

TOKEN=$(curl -s -c cookies.txt -b cookies.txt 'https://signin.intra.42.fr/users/sign_in' --compressed)
TOKEN=$(echo "$TOKEN" | sed '/<meta name="csrf-token" content="/!d;s//&\n/;s/.*\n//;:a;/"/bb;$!{n;ba};:b;s//\n&/;P;D')
TOKEN=$(echo "$TOKEN" | sed 's/+/%2B/g' | sed 's/\//%2F/g' | sed 's/=/%3D/g')

curl -s -c cookies.txt -b cookies.txt 'https://signin.intra.42.fr/users/sign_in' \
--data-raw "utf8=%E2%9C%93&authenticity_token=$TOKEN&user%5Blogin%5D=$LOGIN&user%5Bpassword%5D=$PASSWORD&commit=Sign+in" \
--compressed > /dev/null

CHECK="$(curl -s -b cookies.txt https://profile.intra.42.fr/)"
CHECK=$(echo "$CHECK" | grep "Intra Profile Home")

if [ -z  "$CHECK" ];
	then printf "\e[31mLOGIN : [FAILED]"
	else printf "\e[32mLOGIN : [SUCCESS]"
fi

printf "\e[0m\n"