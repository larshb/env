# Zsh entry point. Add to ~/.zshrc:  source /path/to/env/shell/init.zsh
[[ -o interactive ]] || return 0

ENV_HOME="${${(%):-%x}:A:h:h}"
ENV_SHELL=zsh
source "$ENV_HOME/shell/common.sh"
