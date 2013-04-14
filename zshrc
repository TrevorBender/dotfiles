# Path to your oh-my-zsh configuration.
ZSH=$HOME/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# Lines configured by zsh-newuser-install
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
export PATH="$HOME/bin:$PATH"
alias grails=~/sw/grails/bin/grails
export PATH="$PATH:$HOME/sw/sbt/bin"
export PATH="$PATH:$HOME/sw/play"

alias pd=pushd
alias td=popd
alias v=vi
alias gv=gvim
alias tmux="tmux -2"
alias t='tmux'
alias tl="tmux list-s"
alias ta="tmux a -t"
alias ts="tmux new-s -s"
alias sl='screen -ls'
alias sa='screen -r'
alias ss='screen -S'
alias clj='clojure-1.4'
alias last='ls -tr | tail -1'

function gitroot() { cd $(git root) ; }
alias lh='ls -lh'

if [[ $TERM = "linux" ]] ; then
    export PS1="> "
fi

export VIMCLOJURE_SERVER_JAR="$HOME/sw/vimclojure/lib/server-2.3.0.jar"

unsetopt correct_all
