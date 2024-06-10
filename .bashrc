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

alias lrc="$EDITOR $THIS"

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

function session () {
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

# Generic Colorizer
GRC="$(which grc)"
if [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
    alias colourify="$GRC -es --colour=auto"
    alias blkid='colourify blkid'
    alias configure='colourify ./configure'
    alias df='colourify df'
    alias diff='colourify diff'
    alias docker='colourify docker'
    alias docker-machine='colourify docker-machine'
    alias du='colourify du'
    alias env='colourify env'
    alias free='colourify free'
    alias fdisk='colourify fdisk'
    alias findmnt='colourify findmnt'
    alias make='colourify make'
    alias gcc='colourify gcc'
    alias g++='colourify g++'
    alias id='colourify id'
    alias ip='colourify ip'
    alias iptables='colourify iptables'
    alias as='colourify as'
    alias gas='colourify gas'
    alias ld='colourify ld'
    #alias ls='colourify ls'
    alias lsof='colourify lsof'
    alias lsblk='colourify lsblk'
    alias lspci='colourify lspci'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify traceroute'
    alias traceroute6='colourify traceroute6'
    alias head='colourify head'
    alias tail='colourify tail'
    alias dig='colourify dig'
    alias mount='colourify mount'
    alias ps='colourify ps'
    alias mtr='colourify mtr'
    alias semanage='colourify semanage'
    alias getsebool='colourify getsebool'
    alias ifconfig='colourify ifconfig'
fi

# --- Moved to profile ---
# Use i3lock with custom config
# xautolock -time 4 -locker "/home/larshb/bin/lock"
# --- Moved to profile ---

# Zoxide cd (with fzf)
# TODO: Install script
eval "$(zoxide init bash --cmd cd)"
