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
alias g=git
alias ff=ffind
alias r=ranger
alias lst='ls -tr | tail -1'
function title ()
{
    echo -ne "\ek$1\e\\"
}
alias t=title
function tss()
{
    title "$*" && ss "$*"
}

# git
source ~/.git-completion.sh
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \
    || complete -o default -o nospace -F _git g
source ~/.git-prompt.sh
if [ "\$(type -t __git_ps1)" ]; then
    PS1="${txtcyn}\$(__git_ps1 '(%s) ')$PS1"
fi
alias g='git'
complete -o default -o nospace -F _git g
function gitroot() { cd $(git root) ; }


function set_bash_prompt ()
{
    local lefthalf="$(whoami)@$(hostname -s) $(pwd | sed "s|$HOME|~|")$(__git_ps1 " (%s)")"
    local righthalf=$(date '+%a %b %d %T')
    local columns=$(tput cols)
    let fillsize=${columns}-${#lefthalf}-${#righthalf}+1
    if [[ $fillsize -lt 0 ]] ; then
        fill=" "
    else
        fill=$(printf ' %0.s' {1..300}) # 300 spaces
        fill=${fill:0:$fillsize}
    fi
# make sure than new lines are not indented (or whitespace will show up in prompt)
    PS1="\[\e]0;\w\a\]\n\[\e[47m\]\[\e[32m\]\u@\h\[\e[31m\]$(__git_ps1 " (%s)")\[\e[36m\] \w${fill}\
\[\e[36m\]\d \t\[\e[0m\]\n\
\$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:( \")\
\[\e[0m\]> "
}
# need tput
#PROMPT_COMMAND=set_bash_prompt
