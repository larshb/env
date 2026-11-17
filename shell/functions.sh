# Shell functions (bash and zsh compatible)

# Prepend a directory to PATH if it exists and is not already present
pathadd () {
  [ -d "$1" ] || return 0
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

# Write <file>.md5 next to a file
md5 () {
  if [ -z "$1" ]; then echo "Usage: md5 <file>" >&2; return 1; fi
  echo "Writing MD5 sum to $1.md5"
  md5sum -- "$1" > "$1.md5"
}

# Retry a command up to N times: retry 3 curl -f https://...
retry () {
  local attempts=$1 i
  shift
  for i in $(seq 1 "$attempts"); do
    "$@" && return 0
    echo "Attempt $i/$attempts failed: $*" >&2
  done
  return 1
}

# cd into a directory up to 10 levels down by name: dive src
dive () {
  [ -n "$ZSH_VERSION" ] && setopt localoptions nullglob
  local _name=$1 _prefix="" _i
  for _i in 1 2 3 4 5 6 7 8 9 10; do
    # Glob only the */ prefix; the name itself stays literal
    eval "set -- ${_prefix}\"\$_name\""
    if [ -d "$1" ]; then cd -- "$1"; return; fi
    _prefix="*/$_prefix"
  done
  echo "$_name not found" >&2
  return 1
}
alias dv=dive

# Attach to tmux session <name>, creating it if needed
session () {
  if [ $# -lt 1 ]; then
    echo "Resume or create tmux session" >&2
    echo "Usage: session <name>" >&2
    return 1
  fi
  tmux new-session -A -s "$*"
}

# Ask y/N; returns 0 on yes. Works in bash and zsh.
_env_confirm () {
  local reply
  printf '%s [y/N] ' "$1"
  read -r reply
  case $reply in [yY]|[yY][eE][sS]) return 0 ;; *) return 1 ;; esac
}

# Show diff of tracked files, then commit all and push
gup () {
  git diff
  git status --short --untracked-files=no
  _env_confirm "Upload these changes?" || { echo "Cancelled"; return 1; }
  local msg
  printf 'Commit message: '
  read -r msg
  git commit -a -m "$msg" && git push
}

# Pull this repo and re-run the installer
env-update () {
  # Not the `src` alias: aliases.sh loads after this file, and aliases are
  # resolved when a function is defined
  (cd "$ENV_HOME" && git pull && ./install "$@") && . ~/".${ENV_SHELL}rc"
}

# Commit and push local changes to this repo
env-save () {
  (
    cd "$ENV_HOME" || exit 1
    git --no-pager diff
    _env_confirm "Commit and push environment changes?" || exit 1
    git commit -a -m "Update environment" && git pull --rebase && git push
  )
}
alias update-environment=env-update backup_environment=env-save

# Print all fg/bg/attribute combinations
colors-demo () {
  local bg fg attr
  for bg in 40 41 42 43 44 45 46 47 49; do
    for fg in 30 31 32 33 34 35 36 37 39 90 91 92 93 94 95 96 97; do
      for attr in 0 1 2 4 5 7; do
        printf '\033[%s;%s;%sm %s;%s;%s \033[0m' "$attr" "$bg" "$fg" "$attr" "$bg" "$fg"
      done
      echo
    done
  done
}
