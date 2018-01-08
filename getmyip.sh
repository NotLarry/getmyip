#!/bin/bash

################################################################################
#
#  getmyip.sh to reach out to the network get my current IP address.  
#
#  getmyips.sh will then take that IP and check it against the last ip and if it
#  has changed, update the IP file and send that information upstream.
#
################################################################################

# set variables to be loaded from files
# repaced by sed line below # source /etc/getmyip/getmyip.ip          # previous IP address
source /etc/getmyip/getmyip.conf        # configuration settings

# get the current IP from dd-wrt router @192.168.1.1 and place it in $public_ip
# changed this at the suggestion of wilpig @ https://github.com/wilpig
public_ip=$(dig +short myip.opendns.com @resolver1.opendns.com)

# check $public_ip against $last_public_ip.  If they are not the same put the
# $public_ip value into the ip file and send the new ip address to #r00tw4rz at
# notlarry.slack.com
if [ "$public_ip" != "$last_public_ip" ]; then 
    sed -i "s/^last_public_ip.*/last_public_ip=\"${public_ip}\"/" /etc/getmyip/getmyip.conf    

    # this would be nice if I could do it #curl $curl_cmd                                               # Slack new IP
    # but this works for now
    curl -X POST --data-urlencode "payload={\"challen\":\"$channel\", \"username\": \"$username\", \"text\": \"r00tw4rz.org has a new IP @ $public_ip.\", \"icon_emoji\": \":ghost:\"}" https://hooks.slack.com/services/$hook

fi

