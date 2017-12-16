
# a stripped down search function for use inside the
# current directory. refer to "find" for more advance search
############################################################
f() {

	# Check if argument is provided
	if (( "$#" == 1 )); then

		# Target is what we are looking for
		TARGET=$1

		# Limit the print to this many lines
		LIMIT=25

		# Before print, check how many hits
		HITS=$(find . 2>/dev/null | grep -i $TARGET | wc -l)

		# If number of hits goes above limit, ask the user
		# whether or not to print the result
		if (( HITS > LIMIT )); then

			while true; do
				read -p "$HITS hits for \"$TARGET\". Print anyways? y/n: " yn
				case $yn in
					[Yy]* ) find . 2>/dev/null | grep -i $TARGET; return;;
					[Nn]* ) return;;
					* ) echo "Please answer yes or no.";;
				esac
			done

		# If number of hits are below limit, directly
		# print them to the screen
		else
			find . 2>/dev/null | grep -i $TARGET
		fi

	# No arguments were given!
	else
		echo "Usage: f [PHRASE]"; return
	fi
}


# show internal and external ip address
#######################################
function myip {

	echo "Internal IP: "; hostname -I
	echo "External IP: "; curl icanhazip.com

}


#Automatically do an ls after each cd
#####################################
cd ()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}


# Extracts any archive(s) (if unp isn't installed)
##################################################
extract () {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}


# quickly access and edit various custom bash scripts
##############################################
scr() {
  case $1 in
    -1|-b|-B) vim /home/hela/.bashrc;;
    -2|-t|-T) vim /usr/local/bin/terminal.sh;;
    -3|-a|-A) vim /home/hela/.bash_aliases;;
    -4|-f|-F) vim /home/hela/.bash_functions;;
    -5|-p|-P) vim /home/hela/.bash_prompt;;
    -6|-x|-X) vim /home/hela/.tmux.conf;;
    *)
       clear
       echo "Usage: scr -n [n = 1-6]"
       echo "-----------------------------"
       echo "-1|-b) .bashrc"
       echo "-2|-t) terminal.sh"
       echo "-3|-a) .bash_aliases"
       echo "-4|-f) .bash_functions"
       echo "-5|-p) .bash_prompt"
       echo "-6|-x) .tmux.conf";;
  esac
}


# function for overloading the native "rm" function
#rm ()
#{
#	if (( "$#" == 0 )); then
#
#		echo "Specify which file(s) to remove!"
#	else
#		gvfs-trash $1
#	fi
#}

# print some cool status
function _getstatus
{
	 # Define colors
	local BGBLACK="\033[1;30;0m"
    local LIGHTGRAY="\033[38;5;246m"
    local WHITE="\033[1;30m"
    local BLACK="\033[0;32m"
    local DARKGRAY="\033[1;30m"
    local RED="\033[31m"
    local LIGHTRED="\033[1;31m"
    local GREEN="\033[0;32m"
    local LIGHTGREEN="\033[1;32m"
    local BROWN="\033[0;33m"
    local YELLOW="\033[1;33m"
    local BLUE="\033[0;34m"
    local LIGHTBLUE="\033[1;34m"
    local MAGENTA="\033[0;35m"
    local LIGHTMAGENTA="\033[1;35m"
    local CYAN="\033[0;36m"
    local LIGHTCYAN="\033[1;36m"
    local NOCOLOR="\033[0m"
    local INVERT="\e[7m"
	local BOLD="\e[1m"

	MEM="${BGBLACK}${LIGHTGRAY} MEM ${BOLD} $(get_mem) ${NOCOLOR}"
	SSD="${BGBLACK}${LIGHTGRAY} HD1 ${BOLD} $(get_ssd) ${NOCOLOR}"
	HDD="${BGBLACK}${LIGHTGRAY} HD2 ${BOLD} $(get_hdd) ${NOCOLOR}"
	CPU="${BGBLACK}${LIGHTGRAY} CPU ${BOLD} $(get_cpu)% ${NOCOLOR}"
	JBS="${BGBLACK}${LIGHTGRAY} JBS ${BOLD} $(get_jbs) ${NOCOLOR}"
	NET="${BGBLACK}${LIGHTGRAY} NET ${BOLD} $(get_net) ${NOCOLOR}"
	UPT="${BGBLACK}${LIGHTGRAY} UPT ${BOLD} $(get_upt) ${NOCOLOR}"
	DTE="${BGBLACK}${LIGHTGRAY} DTE ${BOLD} $(get_dte) ${NOCOLOR}"
	BAT="${BGBLACK}${LIGHTGRAY} BAT ${BOLD} $(get_bat) ${NOCOLOR}"
	echo -e "$CPU$MEM$SSD$HDD$NET$UPT$BAT"
}

get_bat() 
{
	echo "$(upower -d | grep percentage | head -1 | cut -d " " -f15)"
}

get_net()
{
	echo "$(awk 'END {print NR}' /proc/net/tcp)"
}

get_jbs()
{
	local stopped=$(jobs -s | wc -l | tr -d " ")
	local running=$(jobs -r | wc -l | tr -d " ")
	stopped+="S"
	running+="R"
	echo "$running/$stopped"
}

get_mem()
{
	free | grep Mem | awk '{print $3/$2 * 100.0}' | rev | cut -c3- | rev | sed 's/$/%/'
}

get_ssd()
{
	df -h | grep '/dev/sda1' | awk {'print $5'}
}

get_hdd()
{
    df -h | grep '/dev/sdb1' | awk {'print $5'}
}


get_cpu()
{
    ps aux | awk {'sum+=$3;print sum'} | tail -n 1 
}

get_upt()
{
	echo "$(uptime | sed 's/^.\+up\ \+\([^,]*\).*/\1/g')"
}

get_dte()
{
    DATE_STATUS=$(date '+%y-%m-%d') # Date
	echo -e "$DATE_STATUS"
}

#renameall()
#{
#
#	while true; do
#        	read -p "${RED}Rename ALL filenames in current directory? y/n: " yn
#                	case $yn in
#                        	[Yy]* ) for f in * ; do mv "$f" "$(stat -c %y "$f" | cut -d ' ' -f 1,2 | cut -d '.' -f1) $f" ; done; return 1;;
#                                [Nn]* ) done; return 1;;
#                                    * ) echo "Please answer yes or no.";;
#                        esac
#        done
#
#	return 1;
#
#
#	#for f in * ; do mv "$f" "$(stat -c %y "$f" | cut -d ' ' -f 1,2 | cut -d '.' -f1) $f" ; done
#	#stat -c %y "$f" | cut -d ' ' -f 1,2 | cut -d '.' -f1
#}

backup()
{
    START_DIR=$(pwd)
    DATE_NOW=$(date +"%Y-%m-%d")
    GIT_REPO=$HOME/Dokument/Projekt/bashrc
    MESSAGE='BACKUP'
    
	if (( "$#" == 1 )); then

        MESSAGE=$1
    fi

    command sudo cp $HOME/.bashrc $HOME/.bash_aliases $HOME/.bash_functions $HOME/.bash_prompt $HOME/.config/compton.conf $GIT_REPO
    command cd $GIT_REPO
    command git add .
    command git commit -m "$MESSAGE $DATE_NOW"
    command git push origin master
    command cd $START_DIR

}


#backup() {
#
#	dir=$(pwd)				  # remember the initial directory
#	now=$(date +"%Y-%m-%d")			  # store date inte var for commit message
#	usr='/home/hela'			  # the location of the user directory
#	src=$usr/.dotfiles			  # the file where the dot-files are stored
#	loc=$usr/Molntjänster/GitHub/dot-files    # the location to the local repository
#	mapfile -t files < $src			  # load filenames from source file inte array
#	command cd $usr				  # cd into home directory
#		
#	# iterate array and copy each target to repo directory
#	for i in ${files[*]} 
#	do
#	   	command find . -maxdepth 3 -name $i -not -path "*Bilder*" -not -path "*Studier*" -not -path "*Musik*" -not -path "*Skrivbord*" -not -path "*Dokument*" -not -path "*Molntjänster*" -exec cp --parents \{\} $loc \;
#	done
#
#	command pacman -Q > $loc/pacman-Q.txt	  # don't forget our list of installed packages
#	command cd $loc				  # cd into the local repository
#	command git add $loc			  # track all files in repo
#	command git commit -m "Backup: $now"	  # create a commit point
#	command git push origin master		  # push to GitHub
#	command cd $dir				  # cd back into the directory we came from
#}

# launch whatever program in a new tmux window
new() {

	if (( "$#" == 1 )); then
	
		command tmux new-window -n ${1^^} $1
		command tmux last-window

	else

		command tmux new-window -n 'BASH'
		command tmux last-window

	fi
}

# swiftly switch between pre-set screen setups
screens() 
{
	if (( "$#" == 1 )); then
		 case $1 in
			1|--laptop|-L) sh ~/.screenlayout/laptop.sh;;
			2|--dual|-D) sh ~/.screenlayout/dual.sh;;
	    		3|--triple|-T) sh ~/.screenlayout/triple.sh;;
    			*) sh ~/.screenlayout/laptop.sh;;
		 esac
	else
		sh ~/.screenlayout/laptop.sh	
	fi

	exit 0
}
