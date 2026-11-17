# Bash entry point. Add to ~/.bashrc:  . /path/to/env/shell/init.bash
[ -n "$BASH_VERSION" ] || return 0
case $- in *i*) ;; *) return 0 ;; esac  # Interactive shells only

ENV_HOME="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
ENV_SHELL=bash
. "$ENV_HOME/shell/common.sh"
