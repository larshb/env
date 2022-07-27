#!/bin/bash

if [ -n "$ZSH_VERSION" ]; then
   #echo "This is zsh"
   return 1
elif [ -n "$BASH_VERSION" ]; then
   : # OK
else
   echo "wtf shell is this?"
   return 1
fi

THIS=$BASH_SOURCE
HERE=$(dirname $THIS)

. $HERE/bash/formatting
. $HERE/bash/aliases
. $HERE/bash/git_aliases

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
        if $call; then
            echo Success!
            return 0
        else
            echo "Failed attempt $i"
        fi
    done
    return 1
}

dive () {
    local path=$1
    for i in {1..10}; do
        if cd $path 2> /dev/null; then
            return 0
        fi
        path="*/$path"
    done
    >&2 echo "$path not found"
    return 1
}

alias dv=dive

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
export LS_COLORS+=':ow=43;30' 2>/dev/null # Not relevant for zsh

session () {
  if [ $# -lt 1 ]; then
    echo -e "Resume or create TMUX session\n\nUsage: session <name>"
    return 1
  fi
  name="$@"
  if tmux ls | grep "$name"; then
    echo Session \"$name\" found!
    tmux a -t $name
  else
    echo No session \"$name\" found!
    tmux new -s $name
  fi
}
