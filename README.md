# My environment

Personal shell, tmux and vim configuration for Ubuntu, for both bash and zsh.

## Setup

    ./install            # everything
    ./install --dry-run  # show what would change
    ./install links tmux # only some components
    ./install --help

Components: `config`, `links`, `packages`, `tmux`, `zsh`, `node`. Every step
is idempotent, so it is safe to re-run. `links` adds one `source` line to
each of `~/.bashrc`, `~/.zshrc`, `~/.tmux.conf`, `~/.vimrc` and nvim's
`init.vim`, and updates lines left over from older layouts of this repo.

After the first run, install tmux plugins with <kbd>Ctrl</kbd>+<kbd>A</kbd>,
<kbd>I</kbd> (update with <kbd>Ctrl</kbd>+<kbd>A</kbd>, <kbd>U</kbd>).

## Configuration

Machine-specific settings live outside the repo, in `~/.config/env/`
(`$XDG_CONFIG_HOME/env/` for the shell and vim files):

| File              | Purpose                                                    |
| ----------------- | ---------------------------------------------------------- |
| `config.sh`       | Settings for the shell and `./install`. See [`config.example.sh`](config.example.sh) |
| `local.sh`        | Any extra shell setup; sourced last in bash and zsh        |
| `tmux.local.conf` | tmux overrides: theme colours, extra plugins, shell        |
| `vimrc.local`     | vim/nvim overrides                                         |

Example `tmux.local.conf`:

    set -g @env-accent colour25          # status bar + pane borders
    set -g @env-accent-active colour39   # active pane border
    set -g @plugin 'tmux-plugins/tmux-yank'

## Layout

    install              setup script
    config.example.sh    documented settings
    shell/               init.bash, init.zsh -> common.sh, aliases, functions, git
    tmux/tmux.conf
    vim/vimrc            shared by vim and nvim
    packages/            apt.txt, npm.txt
    lib/                 helpers for ./install

## Cheat sheet

| Command               | Does                                                |
| --------------------- | --------------------------------------------------- |
| `session <name>`      | Attach to tmux session, creating it if needed       |
| `dive <dir>` / `dv`   | `cd` into a directory up to 10 levels down          |
| `retry <n> <cmd...>`  | Run a command up to n times until it succeeds       |
| `gup`                 | Show diff, commit all tracked changes, push         |
| `env-update`          | Pull this repo and re-run `./install`               |
| `env-save`            | Commit and push changes to this repo                |
| `lrc` / `src`         | Edit this repo / reload shell config                |
| `gdi gst gfe glo gpr gcm gsp` | git diff/status/fetch/log/pull --rebase/commit/stash -p |
| `:TrimWhitespace`     | (vim) strip trailing whitespace                     |
