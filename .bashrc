#!/bin/bash

THIS=$BASH_SOURCE
HERE=$(dirname $THIS)

. $HERE/.formatting

. $HERE/.aliases

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

md5 () {
    ifile=$1
    ofile=$ifile.md5
    if [ "$ifile" == "" ]; then echo "Usage ${FUNCNAME[0]} <file>"; return 1; fi
    echo "Writing MD5-sum to $ofile"
    md5sum $ifile > $ofile
}

retry () {
    let attempts=$1
    shift
    call="$@"
    echo "Call: $call"
    for i in $(seq 1 $attempts); do
        $call
        if $?; then
            echo Success!
            return 0
        else
            echo "Failed attempt $i"
        fi
    done
    return 1
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

pathadd ~/.local/bin

export LS_COLORS="$(vivid generate molokai)"  # sharkdp/vivid
export LS_COLORS+=':ow=43;30'

