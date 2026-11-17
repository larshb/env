# Machine-specific settings for the env repo.
# ./install copies this to ~/.config/env/config.sh; edit that copy.
# Sourced by bash, zsh and ./install.
#
# Every available setting and its default is listed in settings.sh in the
# repo. Uncomment or add the ones you want to change, for example:

# ENV_EDITOR=vim
# ENV_LS_THEME=one-dark
# ENV_CAT_IS_BAT=0
# ENV_APT_EXTRA="htop gimp"

# Other files in ~/.config/env/ picked up automatically if present:
#   apps              app selection, written by ./install --select
#   local.sh          extra shell setup, sourced last (bash and zsh)
#   tmux.local.conf   tmux overrides, e.g. set -g status-style bg=colour25
#   vimrc.local       vim overrides, e.g. let g:env_trim_on_save = 1
