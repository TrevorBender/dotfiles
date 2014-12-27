# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.

#Colors
txtrst="\033[0m"        # Text reset (no color)
txtblu="\033[1;37m"     # Blue
txtcyn="\033[0;36m"     # Cyan

set -o vi

export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.cabal/bin"

#if [ "\$(type -t __git_ps1)" ]; then
#  PS1="${txtcyn}\$(__git_ps1 '(%s) ')$PS1"
#fi

export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] (\!) <\w> \n\$\[\033[00m\] "

alias pd=pushd
alias td=popd
alias v=vim
alias vi=vim
alias gv=gvim
alias ff=ffind
alias tmux="tmux -2"
alias t='tmux'
alias tl="tmux list-s"
alias ta="tmux a -t"
alias ts="tmux new-s -s"
alias sl='screen -ls'
alias sa='screen -r'
alias ss='screen -S'
function tss()
{
    title "$*" && ss "$*"
}

# git
#source ~/.git-completion.bash
#if [ "\$(type -t __git_ps1)" ]; then
    #PS1="${txtcyn}\$(__git_ps1 '(%s) ')$PS1"
#fi
alias g='git'
#complete -o default -o nospace -F _git g
function gitroot() { cd $(git root) ; }
