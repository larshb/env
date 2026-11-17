# Integration for optional CLI tools; each part is skipped if the tool is
# missing. Sourced by common.sh (bash and zsh) with ENV_SHELL set.

_have() { command -v "$1" >/dev/null 2>&1; }

# fd: Ubuntu names the binary fdfind
if ! _have fd && _have fdfind; then
  alias fd=fdfind
fi

# fzf: Ctrl+R history, Ctrl+T files, Alt+C cd. Uses fd for file lists.
# Key bindings need a terminal (zsh warns "can't change option: zle" otherwise)
if [ "$ENV_FZF" = 1 ] && [ -t 0 ] && _have fzf; then
  for _fd in fd fdfind; do
    if _have "$_fd"; then
      export FZF_DEFAULT_COMMAND="$_fd --type f --hidden --exclude .git"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND="$_fd --type d --hidden --exclude .git"
      break
    fi
  done
  unset _fd
  eval "$(fzf --"$ENV_SHELL" 2>/dev/null)"
fi

# zoxide: z <part of dir name>, zi to pick interactively
if [ "$ENV_ZOXIDE" = 1 ] && _have zoxide; then
  eval "$(zoxide init "$ENV_SHELL")"
fi

# imv: Ubuntu only ships imv-wayland / imv-x11
if ! _have imv && _have imv-wayland; then
  imv () {
    if [ -n "$WAYLAND_DISPLAY" ]; then imv-wayland "$@"; else imv-x11 "$@"; fi
  }
fi

# eza: extra listings; plain ls is left alone
if _have eza; then
  alias ll='eza -l --git --group-directories-first'
  alias la='eza -la --git --group-directories-first'
  alias lt='eza --tree --level=2'
fi

unset -f _have
