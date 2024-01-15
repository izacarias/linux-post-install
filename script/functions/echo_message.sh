#!/bin/bash

# Print messages
function echo_message(){
    local color=$1;
	local message=$2;
	if ! [[ $color =~ '^[0-9]$' ]] ; then
		case $(echo -e $color | tr '[:upper:]' '[:lower:]') in
			info) color=4 ;;
            done) color=2 ;;
            warn) color=3 ;;
            fail) color=1 ;;
			# white
			*) color=7 ;;
		esac
	fi
	tput bold;
	tput setaf $color;
	echo '-- '$message;
	tput sgr0;
}
