# General aliases (bash and zsh compatible)

# GNU ls only uses LS_COLORS with --color. Ubuntu's default ~/.bashrc sets
# this alias, but zsh has no equivalent default.
alias ls='ls --color=auto'
alias lc='ls -la --color=always | less -R'
alias lg='git log --all --graph --decorate --oneline --color'
alias path='echo "$PATH" | tr ":" "\n"'
alias cd..='cd ..'
alias quick='make -j'
alias tmux-take='tmux attach -d -t'

# Reload shell config / edit this repo
alias src=". ~/.${ENV_SHELL}rc"
alias lrc='"$EDITOR" "$ENV_HOME"'

# Ubuntu ships bat as "batcat"
if [ "$ENV_CAT_IS_BAT" = 1 ]; then
  if command -v bat >/dev/null 2>&1; then
    alias cat=bat
  elif command -v batcat >/dev/null 2>&1; then
    alias cat=batcat bat=batcat
  fi
fi
