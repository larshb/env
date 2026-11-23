# My environment

Personal shell, tmux and vim configuration for Ubuntu, for both bash and zsh.

## Setup

    ./install            # everything
    ./install --dry-run  # show what would change
    ./install links zsh  # only some components
    ./install --select   # choose which apps to install
    ./install --help

Components: `config`, `links`, `packages`, `zsh`, `node`. Every step
is idempotent, so it is safe to re-run. `links` adds one `source` line to
each of `~/.bashrc`, `~/.zshrc`, `~/.tmux.conf`, `~/.vimrc` and nvim's
`init.vim`, and updates lines left over from older layouts of this repo.

### Apps

The apps live in [`packages/apps.txt`](packages/apps.txt) (apt, plus yazi via
cargo). On first run `./install` shows a checklist and saves your choice to
`~/.config/env/apps`; later runs reuse it without asking. Use `--select` to
change it, or `--yes` to never prompt. Packages your Ubuntu release doesn't
have are skipped with a warning.

### Trying it out

    test/docker.sh             # Ubuntu 26.04 container: install once, then zsh
    test/docker.sh --select    # re-run ./install (any args) inside it
    test/docker.sh 24.04 --yes # another release
    test/docker.sh --fresh     # start over / --rm to delete it

The container is kept between runs, so later runs open a shell straight
away. The repo is mounted read-only at `~/env`, so edits show up inside
(`src` reloads). Nothing outside the container is touched.

## Configuration

Machine-specific settings live outside the repo, in `$XDG_CONFIG_HOME/env/`
(default `~/.config/env/`):

| File              | Purpose                                                    |
| ----------------- | ---------------------------------------------------------- |
| `config.sh`       | Settings for the shell and `./install`. All settings and defaults: [`settings.sh`](settings.sh) |
| `local.sh`        | Any extra shell setup; sourced last in bash and zsh        |
| `tmux.local.conf` | tmux overrides                                             |
| `vimrc.local`     | vim/nvim overrides                                         |

## Layout

    install              setup script
    settings.sh          all settings and their defaults
    config.example.sh    template for ~/.config/env/config.sh
    shell/               init.bash, init.zsh -> common.sh, aliases, functions,
                         git, tools (fzf, zoxide, fd, eza)
    tmux/tmux.conf
    vim/vimrc            shared by vim and nvim
    packages/            apps.txt, npm.txt
    lib/                 helpers for ./install
    test/                Docker test for ./install

## Cheat sheet

| Command               | Does                                                |
| --------------------- | --------------------------------------------------- |
| `session <name>`      | Attach to tmux session, creating it if needed       |
| (tmux) Ctrl+a `\|` / `-` | Split side by side / top and bottom             |
| (tmux) Alt+arrow      | Move to the pane in that direction                  |
| `dive <dir>` / `dv`   | `cd` into a directory up to 10 levels down          |
| `retry <n> <cmd...>`  | Run a command up to n times until it succeeds       |
| `gup`                 | Show diff, commit all tracked changes, push         |
| `env-update`          | Pull this repo and re-run `./install`               |
| `env-save`            | Commit and push changes to this repo                |
| `lrc` / `src`         | Edit this repo / reload shell config                |
| `cd <part>` / `cdi`   | Jump to a frequent directory (zoxide; `z`/`zi` with `ENV_ZOXIDE_CMD=z`) |
| Ctrl+R / Ctrl+T / Alt+C | fzf history search / insert file / cd             |
| `ll` / `la` / `lt`    | eza long listing / with hidden / tree               |
| `gdi gst gfe glo gpr gcm gsp` | git diff/status/fetch/log/pull --rebase/commit/stash -p |
| `:TrimWhitespace`     | (vim) strip trailing whitespace                     |
