#!/bin/bash
#
# accept user passwords and pass them to another command that requires superuser privilege

function superuser_do() {
	echo_message header "Starting 'superuser_do' function"
	# check if current user is root
    if [ $(sudo -n uptime 2>&1 | grep 'a password is required' | wc -l) != 0 ]; then
        sudo $@
    else
        echo_message info "Admin privileges not required at this time."
		# pass the command to sudo
		sudo $@
    fi
}