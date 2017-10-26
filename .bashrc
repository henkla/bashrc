# For:		  See:
# aliases	  .bash_aliases
# functions	.bash_functions
# prompt	  .bash_prompt


if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

# very much needed
export GTK2_RC_FILES=$HOME/.gtkrc-2.0

# make sure all shell integration goes
# through tmux interface
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux -2
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Load alias file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Load functions file
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

# Load custom prompt file
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make sure we have colors on dir's
export LS_OPTIONS='--color=auto'
#eval "`dircolors`"
#eval 'dircolors .dircolors.256dark'

#alias ls='ls $LS_OPTIONS'

# Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# set options for less
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
# or the short version
# export LESS='-F -i -J -M -R -W -x4 -X -z-4'

# Clear screen and activate custom prompt
clear 
__setprompt
_getstatus

# Apparently, this is used by the VIM package that I'm using
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin:/home/hela/.vimpkg/bin
