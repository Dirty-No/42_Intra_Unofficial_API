
# An unofficial API for 42's intra

This "API" uses your cookies to make the requests to the intranet, so use at your own risk, you're the only person responsible for what you do with it.
This "API" is not limited by any ratelimit of the real API
This "API" uses curl.



To make any of the scripts work you need to place a file named "cookies.txt", containing the cookies needed to log on the intra, next to the scripts.
One way to get this file is using this [chrome extension](https://chrome.google.com/webstore/detail/cookiestxt/njabckikapfpffapmjgojcnbfjonfjfg?hl=fr) 

# What the scripts do:

### parse_cookies.sh :
Parses the cookie file passes as argument and prints you your credential, allowing you to check if they are correctly parsed.

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

Is simply a web request to "https://profile.intra.42.fr/users/LOGIN/goals?cursus=42cursus"

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

