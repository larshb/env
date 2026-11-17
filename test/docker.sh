#!/usr/bin/env bash
# Try ./install on a fresh Ubuntu in a Docker container you can keep using.
#
#   test/docker.sh                  # create + install on first run, then open zsh
#   test/docker.sh 24.04 --yes      # other release; extra args go to ./install
#   test/docker.sh --select         # re-run ./install (any args) in the container
#   test/docker.sh --fresh          # throw the container away and start over
#   test/docker.sh --rm             # delete the container
#
# The repo is mounted read-only at ~/env, so edits here show up inside
# (run `src` or open a new shell). Nothing outside the container is touched.
set -euo pipefail
cd "$(dirname "$0")/.."

version=26.04
fresh=0
remove=0
args=()
for a in "$@"; do
  case $a in
    [0-9]*.[0-9]*) version=$a ;;
    --fresh) fresh=1 ;;
    --rm) remove=1 ;;
    *) args+=("$a") ;;
  esac
done
name="env-test-$version"
exists() { docker container inspect "$name" >/dev/null 2>&1; }

if [ "$fresh" = 1 ] || [ "$remove" = 1 ]; then
  exists && docker rm -f "$name" >/dev/null && echo "Removed $name"
  [ "$remove" = 1 ] && exit 0
fi

if ! exists; then
  echo "Creating $name"
  docker build -q -t "env-test:$version" --build-arg VERSION="$version" -f test/Dockerfile test >/dev/null
  docker run -d --init --name "$name" --hostname "$name" \
    -v "$PWD:/home/tester/env:ro" "env-test:$version" sleep infinity >/dev/null
fi
docker start "$name" >/dev/null   # in case it was stopped (e.g. after a reboot)

tty=(-i); [ -t 0 ] && tty=(-it)
# Install on first use, or whenever ./install arguments are given
if [ ${#args[@]} -gt 0 ] || ! docker exec "$name" test -e /home/tester/.env-installed; then
  docker exec "${tty[@]}" "$name" bash -c './install "$@" && touch ~/.env-installed' _ "${args[@]}"
fi

if [ -t 0 ]; then
  docker exec -it "$name" zsh -l
else
  echo "Installed. Open a shell with: test/docker.sh"
fi
