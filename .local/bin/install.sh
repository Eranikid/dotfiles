#!/bin/bash

function prompt() {    
    prompt_text=$1
    echo -n "$prompt_text [y/n] "
    while true; do
        read -n 1 -r -s yn    
        case $yn in
            [Yy]* ) prompt_result='y'; break;;
            [Nn]* ) prompt_result='n'; break;;        
        esac
    done
    echo
}

function get_enabled_systemd_services {
    systemctl list-unit-files | tr -s [:blank:] | cut -d' ' -f1,2 | grep 'enabled$' | cut -d' ' -f1
}

installed_pkgs=$(yay -Qettq)
desired_pkgs=$(sort ~/.local/share/desired_pkgs)

pkgs_to_install=$(comm -13 <(echo $installed_pkgs | tr ' ' '\n') <(echo $desired_pkgs | tr ' ' '\n'))
pkgs_to_delete=$(comm -23 <(echo $installed_pkgs | tr ' ' '\n') <(echo $desired_pkgs | tr ' ' '\n'))

if ! [ -z "$pkgs_to_install" ]; then
	echo "Need to install following packages:"
	echo "$pkgs_to_install"
	prompt "Proceed?"
	[ $prompt_result == "y" ] && yay --noconfirm -S $pkgs_to_install || echo "Skipping package install..."	
fi

if ! [ -z "$pkgs_to_delete" ]; then
	echo "Need to delete following packages:"
	echo "$pkgs_to_delete"
	prompt "Proceed?"
	[ $prompt_result == "y" ] && yay --noconfirm -Rscn $pkgs_to_delete || echo "Skipping package removal..."
fi

enabled_svcs=$(get_enabled_systemd_services | sort)
desired_svcs=$(sort ~/.local/share/desired_svcs)

svcs_to_enable=$(comm -13 <(echo $enabled_svcs | tr ' ' '\n') <(echo $desired_svcs | tr ' ' '\n'))
svcs_to_disable=$(comm -23 <(echo $enabled_svcs | tr ' ' '\n') <(echo $desired_svcs | tr ' ' '\n'))

if ! [ -z $svcs_to_enable ]; then
	echo "Need to enable following systemd units:"
	echo $svcs_to_enable
	prompt "Proceed?"
	if [ $prompt_result == "y" ]; then
		for svc in $svcs_to_enable; do
			sudo systemctl enable $svc
		done
	else
		echo "Skipping enabling services..."
	fi
fi

if ! [ -z $svcs_to_disable ]; then
	echo "Need to disable following systemd units:"
	echo $svcs_to_disable
	prompt "Proceed?"
	if [ $prompt_result == "y" ]; then
		for svc in $svcs_to_disable; do
			sudo systemctl disable $svc
		done
	else
		echo "Skipping disabling services..."
	fi
fi
