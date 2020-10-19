#!/bin/sh

# Used to log on the intra

convert_utf8()
{
	echo "$1"	\
	|	sed 's/%/%25/g'		|	sed 's/\&/%26/g'	|	sed 's/!/%21/g'	\
	|	sed 's/"/%22/g'		|	sed 's/#/%23/g'		|	sed 's/\$/%24/g'	|	sed 's/(/%28/g'		\
	|	sed 's/)/%29/g'		|	sed 's/+/%2B/g'		|	sed 's/,/%2C/g'		|	sed 's/\//%2F/g'	\
	|	sed 's/:/%3A/g'		|	sed 's/;/%3B/g'		|	sed 's/</%3C/g'		|	sed 's/=/%3D/g'		\
	|	sed 's/>/%3E/g'		|	sed 's/?/%3F/g'		|	sed 's/@/%40/g'		|	sed 's/\[/%5B/g'	\
	|	sed 's/]/%5D/g'		|	sed 's/\^/%5E/g'	|	sed 's/`/%60/g'		|	sed 's/{/%7B/g'		\
	|	sed 's/|/%7C/g'		|	sed 's/}/%7D/g'		|	sed 's/ /+/g'
}

parse_token()
{
	TOKEN=$(echo "$1" |  grep csrf-token | sed 's/<meta name="csrf-token" content="//g' | sed 's/" \/>//g')
	convert_utf8 "$TOKEN"
}

check_session()
{
    #arg 1 is cookie file
    CHECK="$(curl -s -b "$1" https://profile.intra.42.fr/)"
    CHECK=$(echo "$CHECK" | grep "Intra Profile Home")
    if [ -z  "$CHECK" ];
    	then printf "\e[31mLOGIN : [FAILED]"
    	else printf "\e[32mLOGIN : [SUCCESS]"
    fi

    printf "\e[0m\n"
}

do_sign_in()
{
    DIR=$(dirname "$0")
    COOKIE_JAR="$DIR/$1"

    printf "Login: "
    read LOGIN

    stty -echo
    printf "Password: "
    read PASSWORD
    stty echo
    printf "\n"

    TOKEN=$(curl -j -s -c $COOKIE_JAR 'https://signin.intra.42.fr/users/sign_in' --compressed)
    TOKEN=$(parse_token "$TOKEN")


    PASSWORD=$(convert_utf8 "$PASSWORD")

    curl -s -c $COOKIE_JAR -b $COOKIE_JAR 'https://signin.intra.42.fr/users/sign_in' \
    --data-raw "utf8=%E2%9C%93&authenticity_token=$TOKEN&user%5Blogin%5D=$LOGIN&user%5Bpassword%5D=$PASSWORD&commit=Sign+in" \
    --compressed > /dev/null

    check_session $COOKIE_JAR
}

do_sign_in cookies.txt
