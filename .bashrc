#!/bin/bash

THIS=$BASH_SOURCE
HERE=$(dirname $THIS)

. $HERE/.formatting

# Aliases

alias make="colormake"
alias cat="bat"
alias src=". ~/.bashrc"
alias path='echo $PATH | tr ":" "\n"'

# TMUX
if [ -z "$TMUX" ]
then
    tmux attach -t default || tmux new -s default
fi

# PATH
pathadd () {
    if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)"
    then
        export PATH="$1:$PATH"
    fi
}
