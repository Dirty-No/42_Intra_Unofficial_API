
# An curl client for 42's intra

This client uses your cookies to make the requests to the intranet, so use at your own risk, you're the only person responsible for what you do with it.

This client is not limited by any ratelimit of the intra's API as it simply scrapes it's way in.

This client is based on curl.



To make any of the scripts work you need to have a file named "cookies.txt", containing the cookies needed to log on the intra, next to the scripts.

You can sign in using your login and password using sign_in.sh to get the cookies.
# What the scripts do:

### sign_in.sh :
Allow you to sign in and get your cookies required to be logged on the intra.

### search_login.sh :
Will search the login passed as argument on the intra and print the results.

Works in the same way it would do if you manually searched the login with the intra's search bar.

### get_grade.sh :
Print the grade a student has on a project and if he failed or passed it.

Takes the student's login as the first argument.

Takes the project name as the second argument.

 eg: `./get_grade.sh smaccary "Exam Rank 02"`  will print "success\n100"

 ### get_blackhole.sh:
Print the remaining number of blackhole days and the date of the blackhole as a JSON.

Is simply a web request to "https://profile.intra.42.fr/users/$LOGIN/goals?cursus=42cursus"

Takes the student's login as the first argument.

### get_close_list:
Hurray! A whole of shame.

Prints all the students's logins whom have recently been closed for a community service.


### get_list.sh :
Prints every logins found on 42's intra.

This script is very heavy and willl probably crash as it makes 26 * 26 * 26 requests to the server.

You should think twice about using this.

It will probably crash before the end.

Use this at your own risk.

