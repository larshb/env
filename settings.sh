# All settings and their defaults, in one place. Sourced by the shell
# (shell/common.sh, bash and zsh) and by ./install.
#
# Override any of them in $XDG_CONFIG_HOME/env/config.sh (default
# ~/.config/env/config.sh), which is sourced at the end of this file.
# Values already set in the environment also take precedence.

ENV_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/env"

# --- Shell --------------------------------------------------------------------
ENV_EDITOR="${ENV_EDITOR-}"                 # Empty: keep $EDITOR, else first of nvim/vim/vi
ENV_LS_THEME="${ENV_LS_THEME-molokai}"      # vivid theme for LS_COLORS; empty leaves it alone
ENV_LS_EXTRA="${ENV_LS_EXTRA-ow=43;30}"     # Appended to LS_COLORS (other-writable dirs)
ENV_CAT_IS_BAT="${ENV_CAT_IS_BAT-1}"        # alias cat to bat/batcat when available
ENV_GIT_ALIASES="${ENV_GIT_ALIASES-1}"      # gdi, gst, glo, gpr, ... (shell/git.sh)
ENV_PATH_PREPEND="${ENV_PATH_PREPEND-$HOME/.local/bin}"  # Space-separated dirs put first in PATH
ENV_FZF="${ENV_FZF-1}"                      # fzf key bindings (Ctrl+R, Ctrl+T, Alt+C)
ENV_ZOXIDE="${ENV_ZOXIDE-1}"                # zoxide: z / zi

# --- ./install ----------------------------------------------------------------
ENV_APT_EXTRA="${ENV_APT_EXTRA-}"           # Extra apt packages, space-separated
ENV_NPM_EXTRA="${ENV_NPM_EXTRA-}"           # Extra global npm packages, space-separated
ENV_NODE_VERSION="${ENV_NODE_VERSION-node}" # Passed to `nvm install` (e.g. node, --lts, 22)
ENV_P10K_DIR="${ENV_P10K_DIR-$HOME/powerlevel10k}"  # Where powerlevel10k is cloned
ENV_PICKER="${ENV_PICKER-auto}"             # App picker: auto (whiptail if available), whiptail, text

if [ -r "$ENV_CONFIG_DIR/config.sh" ]; then
  . "$ENV_CONFIG_DIR/config.sh"
fi
