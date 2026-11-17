# Machine-specific settings for the env repo.
# ./install copies this to ~/.config/env/config.sh; edit that copy.
# Sourced by both bash and zsh, and by ./install. Values shown are defaults.

# --- Shell --------------------------------------------------------------------
# ENV_EDITOR=""               # Empty: keep $EDITOR, else first of nvim/vim/vi
# ENV_LS_THEME="molokai"      # vivid theme for LS_COLORS (vivid themes); "" disables
# ENV_LS_EXTRA="ow=43;30"     # Appended to LS_COLORS
# ENV_CAT_IS_BAT=1            # alias cat=bat
# ENV_GIT_ALIASES=1           # gdi, gst, glo, gpr, ...
# ENV_PATH_PREPEND="$HOME/.local/bin"   # Space-separated

# --- ./install ----------------------------------------------------------------
# ENV_APT_EXTRA=""            # Extra apt packages, space-separated
# ENV_NPM_EXTRA=""            # Extra global npm packages, space-separated
# ENV_NODE_VERSION="node"     # Passed to `nvm install` (e.g. node, --lts, 22)
# ENV_P10K_DIR="$HOME/powerlevel10k"   # Where powerlevel10k is cloned

# Other files in ~/.config/env/ picked up automatically if present:
#   local.sh          extra shell setup, sourced last (bash and zsh)
#   tmux.local.conf   tmux overrides, e.g. set -g @env-accent colour25
#   vimrc.local       vim overrides, e.g. let g:env_trim_on_save = 1
