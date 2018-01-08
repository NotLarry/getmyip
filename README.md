## Synopsis

getmyip.sh - an attempt to get my IP when my upstream provider changes it and give it back to me when I am offsight.

## Motivation

I don't pay for a dedicated IP and when it changes I forget to update it elsewhere.  I usually end up having to shell into some box I know I accessed from home just to parse the auth files and find my new IP.
This script gets my public IP from the local router, gets the last public IP from the config file, compares them and, if they do not match, updates the config file and slacks me the new IP.
## Installation

Installation involves moving the gitmyip.sh to /sbin the config directory to /etc/ and make the bash script executable.
As to the getmyip.conf the last_public_ip will be set by the script.  A channel, username, and hook provided by slack will need to be set.
I also place a cronjob */5 * * * * /sbin/checkmyip.sh to run every 5 minutes and check the IP.

## License

Lets not restrict the use of this at this time
