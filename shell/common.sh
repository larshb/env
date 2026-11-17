# Shared shell setup for bash and zsh. Sourced by init.bash / init.zsh,
# which set ENV_HOME before sourcing this file. Must not print anything
# (powerlevel10k instant prompt complains about console output).

ENV_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/env"

# --- Defaults (override in $ENV_CONFIG_DIR/config.sh) -------------------------
ENV_EDITOR=""               # Empty: keep $EDITOR, else first of nvim/vim/vi
ENV_LS_THEME="molokai"      # vivid theme for LS_COLORS; empty to leave alone
ENV_LS_EXTRA="ow=43;30"     # Appended to LS_COLORS (other-writable dirs)
ENV_CAT_IS_BAT=1            # alias cat to bat/batcat when available
ENV_GIT_ALIASES=1           # Load shell/git.sh
ENV_PATH_PREPEND="$HOME/.local/bin"  # Space-separated dirs to put first in PATH

[ -r "$ENV_CONFIG_DIR/config.sh" ] && . "$ENV_CONFIG_DIR/config.sh"

# --- Environment --------------------------------------------------------------
. "$ENV_HOME/shell/functions.sh"

for _dir in $(echo "$ENV_PATH_PREPEND"); do  # echo: word-split in zsh too
  pathadd "$_dir"
done
unset _dir

if [ -n "$ENV_EDITOR" ]; then
  export EDITOR="$ENV_EDITOR"
elif [ -z "$EDITOR" ]; then
  for _ed in nvim vim vi; do
    if command -v "$_ed" >/dev/null 2>&1; then export EDITOR="$_ed"; break; fi
  done
  unset _ed
fi

if [ -n "$ENV_LS_THEME" ] && command -v vivid >/dev/null 2>&1; then
  # Leave LS_COLORS alone if vivid fails (e.g. unknown theme)
  if _ls=$(vivid generate "$ENV_LS_THEME" 2>/dev/null) && [ -n "$_ls" ]; then
    export LS_COLORS="$_ls${ENV_LS_EXTRA:+:$ENV_LS_EXTRA}"
  fi
  unset _ls
fi

. "$ENV_HOME/shell/aliases.sh"
[ "$ENV_GIT_ALIASES" = 1 ] && . "$ENV_HOME/shell/git.sh"

# Machine-specific additions that should load after everything else
[ -r "$ENV_CONFIG_DIR/local.sh" ] && . "$ENV_CONFIG_DIR/local.sh"
true
