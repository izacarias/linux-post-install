#!/bin/bash

# Check dpkg for package installation status
function check_package_installed() {
	# query dnf for install status and return a value
	dnf list installed | grep $@ &> /dev/null; echo $?
}

# Check for Flatpak repository
# ${1} = remote, ${2} = https://remote.example.com/, ${3} = return_function
function check_flatpak_repo {
	# echo_message header "Starting 'check_flatpak_repo' function"
	# If repo not is added
	if [ $(flatpak remotes | grep ${1} &> /dev/null; echo $?) = 1 ]; then
		# draw window
		if (whiptail \
			--title "Add ${1} Repository" \
			--yesno "This function requires '${1^}' repository but it is not present on your system. \n\nWould you like to add it to continue? " 10 64) then
			# Add repository
			echo_message info "Adding flatpak repository..."
			flatpak remote-add --if-not-exists ${1} ${2}
			echo_message success "Repository added."
			whiptail --title "Finished" --msgbox "The ${1^} repository has been added." 8 56
		else
			# Cancelled
			echo_message info "Addition of ${1^} repository cancelled."
			${3}
		fi
	else
		echo_message info "${1^} repository already added."
	fi
}

# Check which distribution the user is running
function check_os {
	echo_message header "Starting 'check_os' function"
	echo_message title "Checking which OS you are using..."
	# Variables
	OS_NAME="Linux"
	# Check if Linux
	echo_message info "Current OS is: "$(uname)
	if [[ $(uname) != "$OS_NAME" ]]; then
		echo_message error "You don't appear to be using $OS_NAME! Aborting. :("
		exit 99
	else
		echo_message success "You are using '$OS_NAME'. :D"
	fi
}

# Check which distribution the user is running
function check_distribution {
	# if Fedora
	if $(cat /etc/system-release | grep -qE 'Fedora'); then
		echo 'Current distribution is: '$(cat /etc/system-release)
		echo_message success "You are using Fedora. :D"
		echo "Proceeding."
	# if not Fedora else
	else
		echo_message warning "You are using a distribution that may not be compatible with this script set."
		echo_message warning "Proceeding may break your system."
		echo_message question "Are you sure you want to continue? (Y)es, (N)o : " && read REPLY
		case $REPLY in
		# Positive action
		[Yy]* )
			echo_message warning "You have been warned."
			;;
		# Negative action
		[Nn]* )
			echo_message info "Exiting..."
			exit 99
			;;
		# Error
		* )
			echo_message error 'Sorry, try again.' && check_distribution
			;;
		esac
	fi
}

# Check for and install if missing the required packages for this script set.
function check_dependencies {
	echo_message header "Starting 'check_dependencies' function"
	echo_message title "Checking if necessary dependencies are installed..."
	# Variables
	LIST=$(dirname "$0")'/data/dependencies.list'
	# Check dependencies
	for PACKAGE in $(cat $LIST); do 
		# If package is not installed
		if [ $(check_package_installed $PACKAGE) != 0 ]; then
			echo_message info "This script requires '$PACKAGE' and it is not present on your system."
			echo_message question 'Would you like to install it to continue? (Y)es, (N)o : ' && read REPLY
			case $REPLY in
			# Positive action
			[Yy]* ) 
				echo_message warning "Requires root privileges"
				sudo dnf install -y $PACKAGE
				echo_message success "Package '$PACKAGE' installed."
				;;
			# Negative action
			[Nn]* )
				echo_message info "Exiting..."
				exit 99
				;;
			# Error
			* )
				echo_message error 'Sorry, try again.' && check_dependencies
				;;
			esac
		else
			echo_message info "Dependency '$PACKAGE' is installed."
		fi
	done
	echo_message success "All dependencies are installed. :)"
}

# Check if current user is in the sudo group
function check_privileges {
	echo_message header "Starting 'check_privileges' function"
	echo_message title "Checking administrative privileges of current user..."
	# Check if user is root
	if [[ $EUID != 0 ]]; then
		if ! $(groups $USER | grep -q 'wheel';); then
			echo_message error "This user account doesn't have admin privileges."
			echo_message info "Admin privileges are required to be able use these scripts.."
			echo_message info "Exiting..."
			sleep 5 && exit 99
		else
			# Current user can use 'sudo'
			echo_message success "Current user has sudo privileges. :)"
		fi
	else
		# if dependency whiptail is installed
		if command -v whiptail 2>&1 >/dev/null; then
			# draw window
			if (whiptail --title "Root User" --yesno "You are logged in as the root user. This is not recommended.\n\nAre you sure you want to proceed?" 12 56) then
				echo_message warning "You are logged in as the root user. This is not recommended. :/"
			else
				echo_message info "Exiting..."
				exit 99
			fi
		else
			# text-based warning
			echo_message warning "You are logged in as the root user. This is not recommended. :/"
			read -p "Are you sure you want to proceed? [y/N] " REPLY
			REPLY=${REPLY:-n}
			case $REPLY in
			[Yy]* )
				echo_message info "Proceeding..."
				;;
			[Nn]* )
				echo_message info "Exiting..."
				exit 99
				;;
			* )
				echo_message error 'Sorry, try again.' && check_privileges
				;;
			esac
		fi
	fi
}

# Run system checks
function system_checks {
	# Check OS
	check_os
	# Check distribution
	check_distribution
	# Check sudo
	check_privileges
	# Check dependencies
	check_dependencies
}