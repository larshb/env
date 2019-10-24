#!/bin/bash

THIS=$BASH_SOURCE
HERE=$(dirname $THIS)

. $HERE/.formatting

# Aliases

alias lg="git log --all --graph --decorate --color --graph --oneline"
alias st="git status -uno ."
alias cat="bat"
alias src=". ~/.bashrc"
#alias lrc="open ~/.bashrc"
alias make="colormake"
alias path='echo $PATH | tr ":" "\n"'

# TMUX
# if [ -z "$TMUX" ]
# then
#     tmux attach -t default || tmux new -s default
# fi

# PATH
pathadd () {
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)"
    then
        export PATH="$1:$PATH"
    fi
}

backup_environment () {
    cd $HERE
    clear
    git diff | cat
    read -p "Update environment? [y/N]: " -n 1 -r
    echo # new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        git commit . -m "Auto-update environemnt"
        git pull
        git push
    fi
    cd -
}
