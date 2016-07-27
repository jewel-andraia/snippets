# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

if [ -f ~/apps/hub/etc/hub.bash_completion.sh ]; then
    source ~/apps/hub/etc/hub.bash_completion.sh ]
fi

PATH=$PATH:$HOME/bin

export PATH

GREP_OPTIONS='--binary-files=without-match  --directories=skip --exclude-dir="minified" --exclude-dir="blog" --exclude-dir=="html/application/classes/controller/maps" -R'
export GREP_OPTIONS

# Functions

findgrep () {
        # find | grep
	if [ $# -eq 0 ]; then
		echo "findgrep: No arguments entered."; return 1
	else
		# "{.[a-zA-Z],}*" instead of "." makes the output cleaner
		find {.[a-zA-Z],}* -type f | xargs grep -n $* /dev/null \
				2> /dev/null
	fi
}


# State of the world

git status

if [[ -z "$STY" ]]; then
    screen -ls
fi
