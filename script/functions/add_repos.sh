#!/bin/bash


function add_rpmfusion() {
	echo_message info "Adding rpmfusion repositories..."
    # Check if valid RPM Fusion repository
	if [[ "${1}" = "free" ]] || [[ "${1}" = "nonfree" ]] ; then
        if [ -e /etc/yum.repos.d/rpmfusion-${1}.repo ]; then
			echo_message info "RPM Fusion (${1^}) repository already added."
        else 
            echo_message info "Downloading RPM Fusion (${1}) repository package..."
            superuser_do "dnf install -y https://download1.rpmfusion.org/${1}/fedora/rpmfusion-${1}-release-$(rpm -E %fedora).noarch.rpm"
            if [[ $? -eq 0 ]]; then
                echo_message done "RPM Fusion repository was added"
                superuser_do dnf group update core
            else
                echo_message fail "Error adding RPM Fusion repository"
            fi
        fi
    else
        echo_message fail "Invalid RPMFusion repository"
    fi
}


# add COPR repositories
# $1 - the COPR repository name
function add_copr() {
    FULLNAME=$1
    REPO=$(echo $FULLNAME | cut -d "/" -f 2)
	echo_message info "Adding COPR repository (${1})..."
    # Check if valid RPM Fusion repository
    if find /etc/yum.repos.d/ -name "*$REPO*" -printf 1 -quit | grep -q 1 ; then
        echo_message info "COPR repository (${1}) already exsits."
    else
        superuser_do "dnf copr enable -y ${1}"
        if [[ $? -eq 0 ]]; then
            echo_message done "COPR repository was added"
        else
            echo_message fail "Error adding RPM Fusion repository"
        fi
    fi
}
