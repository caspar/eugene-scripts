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
# No need to touch anything beyond this point.
function enableProxy {
    networksetup  -setsocksfirewallproxy ${INTERFACE} localhost ${PORT}
    networksetup  -setsocksfirewallproxystate ${INTERFACE} on
    ${SSH_CMD}
}
function disableProxy {
    ps -ax | grep "${SSH_CMD}" | grep -v grep | awk '{print $INFO}'| xargs kill
    networksetup  -setsocksfirewallproxystate ${INTERFACE} off
}
function showStatus {
    ps -ax | grep "${SSH_CMD}" | grep -v grep > /dev/null
    if [ $? -eq 0 ]; then
        echo "An SSH Tunnel is ON."
    else
        echo "An SSH Tunnel is OFF."
    fi
    networksetup -getsocksfirewallproxy ${INTERFACE} | grep Enabled | grep Yes > /dev/null
    if [ $? -eq 0 ]; then
        echo "Proxy IS configured for ${INTERFACE}."
    else
        echo "Proxy IS NOT configured for ${INTERFACE}."
    fi
}
case "$INFO" in
    on) echo "Enabling Proxy"
        enableProxy
        ;;
    off)    echo "Disabling Proxy"
        disableProxy
        ;;
    status) echo status
        showStatus
        ;;
    *) echo Options: on to enable proxy, off to disable, status to see status.
esac