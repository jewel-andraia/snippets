#!/bin/bash
# .bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm


# Get the aliases and functions
if [ -f ./.bashrc ]; then
        . ./.bashrc
fi
if [ -f ./.aliases ]; then
        . ./.aliases
fi


# Functions

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

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


# User specific environment and startup programs

if [ -f ~/apps/hub/etc/hub.bash_completion.sh ]; then
    source ~/apps/hub/etc/hub.bash_completion.sh ]
fi

export PS1="🌜\t⌚\\[$(tput bold)\]\[\033[38;5;3m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[32m\]\$(parse_git_branch)\[\033[00m\] 🌛 "
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export PATH=$PATH:$HOME/bin:.

export EDITOR=vim

export GREP_OPTIONS='--binary-files=without-match  --directories=skip --exclude-dir="minified" --exclude-dir="blog" --exclude-dir=="html/application/classes/controller/maps" -R'

# State of the world

git status 2>/dev/null

