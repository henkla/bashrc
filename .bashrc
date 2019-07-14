#!/usr/bin/env bash
# ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗
# ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝
# ██████╔╝███████║███████╗███████║██████╔╝██║
# ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║
# ██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗
# ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝

declare -a dependencies=("exports" "settings" "aliases" "functions" "prompts")
declare -a workdir="$HOME/.bash"
function import_dependencies() {

  if [ -z "$1" ]; then

    echo "Exception: argument is empty."
    return 1

  else

    local dep=("$@")
    for d in "${dep[@]}"; do
      if [ "$workdir/$d" ]; then
        . "$workdir/$d"
      else
        echo "Exception: dependency ($workdir/$d) not found."
        return 1
      fi
    done

  fi

  return 0
}

import_dependencies "${dependencies[@]}"

#if [[ -z "$TMUX" ]]; then
#    tmux has-session &> /dev/null
#    if [ $? -eq 1 ]; then
#      exec tmux new
#      exit
#    else
#      exec tmux attach
#      exit
#    fi
#fi
# SUDO - shout at bash to su commands
# Distributed under GNU GPLv2, @jthistle on github

shopt -s expand_aliases

IFS_=${IFS}
IFS=":" read -ra PATHS <<< "$PATH"

for i in "${PATHS[@]}"; do
	for j in $( ls "$i" ); do
		if [ ${j^^} != $j ] && [ $j != "sudo" ]; then
			alias ${j^^}="sudo $j"
		fi		
	done
done

alias SUDO='sudo $(history -p !!)'

IFS=${IFS_}

# end SUDO

