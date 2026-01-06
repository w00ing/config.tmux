# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

- **Reload config**: `tmux source-file ~/.config/tmux/tmux.conf` or `prefix + r` inside tmux
- **Install plugins**: `prefix + I` inside tmux (TPM)
- **Update plugins**: `prefix + U` inside tmux (TPM)
- **Kill server**: `tmux kill-server` (terminates all sessions)

## Project Structure

- `tmux.conf` - Primary configuration file for keybindings, statusline, and options
- `plugins/` - TPM-managed plugin checkouts (vendored; do not edit manually)

## Configuration Style

- One setting per line; use `set -g` for global options, `setw -g` for window options
- Organize in order: terminal setup → keybindings → UI/statusline → plugins
- Brief comments above each logical block

## Key Bindings (prefix is C-a)

- `|` split horizontal, `-` split vertical
- `h/j/k/l` resize panes, `m` maximize pane
- `v` begin selection in copy mode, `y` copy to clipboard

## Installed Plugins

- tpm, tmux-sensible, vim-tmux-navigator, tmux-resurrect, tmux-continuum, tmux-which-key

## Commit Style

Follow Conventional Commits (e.g., `chore: update statusline`).
