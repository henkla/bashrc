# git specifics
###############
alias gstatus='git status'
alias gadd='git add'
alias gcommit='git commit -m'
alias gpush='git push'
alias gpull='git pull'
alias gcheckout='git checkout'
alias gbranch='git branch'

# some more ls aliases
######################
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CFl'
alias lsal='ls -al'
alias li='echo ""; ls -al'
alias lh='ls -lh'
alias grep='grep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
###############################################################
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# shell specifics
########################
alias r='source ~/.bashrc; command xfce4-panel -r'
alias c='clear'
alias qq='exit'

# aliases for navigating
########################
alias cd..='cd ..'
alias ..='cd ..'
alias 1='cd / ; clear; ls'
alias 2='cd ~ ; clear; ls'
alias 3='cd ~/Hämtningar ; clear; ls'
alias 4='cd ~/Skrivbord; clear; ls'
alias 5='cd ~/Molntjänster/Dropbox/Studier/Aktuella\ kurser; clear; ls'
alias 6='cd ~/Dokument/Projekt/; clear; ls'

# editing 
#########
alias edit='vim'

# SSH / remote desktops
#######################
alias rpi='ssh hela@helaweb.se' # don't bother - password logins turned off and key required

# custom aliases
################
alias svd='clear; echo "# TOP 15 HEADLINES FROM SVD.SE :"; echo "================================="; wget --output-document - --quiet svd.se | grep "h2 class=\"Teaser-heading" | cut -d ">" -f2 | cut -d "<" -f1 | head -n30 | sort -u | uniq' 
alias update='sudo apt update && sudo apt upgrade -y'
alias desk="wmctrl -k on"
alias ff="new pcmanfm $DIR"
alias ss="scrot -d 3 -c"
