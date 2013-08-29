#!/bin/bash
# Proxy configuration tool
# Settings
SSH_OPTIONS="-C2qTnND"      # SSH settings.
PORT=8080                   # Localhost port - to be honest this doesn't matter, as we will seamlessly tell Networks/System Preferences this information.
SSH_PORT=22                 # Port that you will be connecting to on the server.
SSH_USER="elee"             # Username to access said server.
SSH_HOST="orca.elee.me"     # The server you will be connecting to.
INTERFACE="Wi-Fi"           # Interface that is reconfigured: run `networksetup -listallnetworkservices` to figure this out.
# Initiation of SSH command to be used (Implementation of Mosh to be done soon).
SSH_CMD="ssh ${SSH_OPTIONS} ${PORT} -p ${SSH_PORT} ${SSH_USER}@${SSH_HOST}"
