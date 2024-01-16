#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-


# tab width
tabs 4
clear

TITLE="Fedora Post-Install Script"

# Include functions
function import_functions {
	DIR="functions"
	# iterate through the files in the 'functions' folder
	for FUNCTION in $(dirname "$0")/$DIR/*; do
		# skip directories
		if [[ -d $FUNCTION ]]; then
			continue
		# exclude markdown readmes
		elif [[ $FUNCTION == *.md ]]; then
			continue
		elif [[ -f $FUNCTION ]]; then
			# source the function file
			. $FUNCTION
		fi
	done
}

# The installer accepts two parameters for the installation type
# - laptop
# - desktop
# $1 - installation type
function main() {
    clear
    import_functions
    if [ "$#" -eq 1 ]; then
        # General configurations
        echo_message info "Starting the script"
        # gsettings_config "gsettings"                # configuring Gnome
        # add_rpmfusion "free"
        # add_rpmfusion "nonfree"
        # add_copr "kwizart/fedy"
        # install_package_list "general"
        if [[ "$1" == laptop ]] then
            echo_message info "Executing laptop specific actions"
            # add_copr "kallepm/tuxedo-drivers"
            # add_copr "kallepm/tuxedo-touchpad-switch"
            # add_copr "kallepm/tuxedo-control-center"
            # install_package_list "laptop"

        fi
    else
        echo_message fail "Wrong number of arguments"    
    fi
    
    # TODO: Add SSH keys to SSH Agent
    # TODO: Coloring the shell prompt
    # TODO: Gnome Extensions
    # TODO: Configure Bash
    # TODO: Install fonts
    # TODO: Configure DNF
    
    # Install OpenJDK
    # Install Maven
    # Install GO
    # Install Gurobi
    echo_message info "Finished"
}

# Calls the main function
main "$@"