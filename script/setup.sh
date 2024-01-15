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

# The installer accepts two parameters
# - laptop
# - desktop
function main() {
    clear
    import_functions
    echo_message info "Starting the script"
    # TODO: Add SSH keys to SSH Agent
    

    # TODO: Coloring the shell prompt

    # TODO: Gnome Extensions
    # Gnome Shortcuts (GSettings)
    gsettings_config "gsettings"
    # TODO: Configure Bash
    # TODO: Install fonts
    # TODO: Configure DNF
    # TODO: Enable RPM Fusion Repositories
    # install_package_list "packages"
    
    # Install OpenJDK
    # Install Maven
    # Install GO
    # Install Gurobi


    echo_message info "Finished"
}
main