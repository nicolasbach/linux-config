#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Configure Bash History
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT='%F %T - '
export HISTFILESIZE=20000
export HISTSIZE=5000
shopt -s histappend
export PROMPT_COMMAND='history -a'

# Configure Environment 
export EDITOR=vim

# Alias configuration
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
PS1='[\u@\h \W]\$ '
neofetch
