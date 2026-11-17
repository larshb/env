# Output helpers for ./install (bash)

if [ -t 1 ]; then
  _c() { printf '\033[%sm' "$1"; }
else
  _c() { :; }
fi

section() { printf '\n%s%s%s\n' "$(_c '1;4;32')" "$*" "$(_c 0)"; }
info()    { printf '%s%s%s\n' "$(_c 34)" "$*" "$(_c 0)"; }
warn()    { printf '%s%s%s\n' "$(_c 33)" "$*" "$(_c 0)" >&2; }
die()     { printf '%s%s%s\n' "$(_c 31)" "$*" "$(_c 0)" >&2; exit 1; }
