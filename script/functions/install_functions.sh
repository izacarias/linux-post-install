#!/bin/bash

# Install single package function
# ${1} = package-name

function install_package() {
	echo_message header "Starting 'install_package' function..."
	# If package is not installed
	if [ $(check_package_installed ${1}) != 0 ]; then
		echo_message info "${1} is not installed. Installing..."
		echo_message info "Installing package '${1}'..."
        superuser_do "dnf install -y ${1}"
		# Admin privileges
		if [ $? -eq 0 ]; then
			echo_message success "Installation of package '${1}' is complete."
		else
			# Cancelled or error
			echo_message fail "Installation of ${1} failed."
		fi
	else
		# Already installed
		echo_message info "Package '${1}' is already installed."
	fi
}

function install_package_list() {
    echo_message header "Starting installation of packages..."
    LIST=$(dirname "$0")'/data/'${1}'.list'
    for PACKAGE in $(cat $LIST); do
        install_package $PACKAGE
    done
}