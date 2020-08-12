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

installed_pkgs=$(pacman -Qettq)
desired_pkgs=$(sort ~/.local/share/desired_pkgs)

pkgs_to_install=$(comm -13 <(echo $installed_pkgs | tr ' ' '\n') <(echo $desired_pkgs | tr ' ' '\n'))
pkgs_to_delete=$(comm -23 <(echo $installed_pkgs | tr ' ' '\n') <(echo $desired_pkgs | tr ' ' '\n'))

if ! [ -z "$pkgs_to_install" ]; then
	echo "Need to install following packages:"
    echo "$pkgs_to_install"
	prompt "Proceed?"
	[ $prompt_result == "y" ] && sudo pacman --noconfirm -S $pkgs_to_install || echo "Skipping package install..."	
fi

if ! [ -z "$pkgs_to_delete" ]; then
	echo "Need to delete following packages:"
	echo "$pkgs_to_delete"
	prompt "Proceed?"
	[ $prompt_result == "y" ] && sudo pacman --noconfirm -Rscn $pkgs_to_delete || echo "Skipping package removal..."
fi

