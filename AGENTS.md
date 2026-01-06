# Repository Guidelines

## Project Structure & Module Organization
- `tmux.conf` is the primary configuration file for all keybindings, statusline settings, and options.
- `plugins/` contains TPM-managed plugin checkouts; treat these as vendored code and avoid manual edits.
- `.git/` holds repository metadata only.

## Build, Test, and Development Commands
- Reload config in a running session: `tmux source-file ~/.config/tmux/tmux.conf` (or use the bound `prefix + r`).
- Install plugins via TPM: press `prefix + I` inside tmux.
- Update plugins via TPM: press `prefix + U` inside tmux.
- If a full restart is required: `tmux kill-server` (terminates all sessions; use with care).

## Coding Style & Naming Conventions
- Keep one setting per line and use `set -g` for global options, `setw -g` for window options.
- Place brief comments above each logical block (e.g., “# Statusline”, “# Pane resizing”).
- Prefer consistent ordering: terminal setup → keybindings → UI/statusline → plugins.

## Testing Guidelines
- No automated tests are defined for this repository.
- Validate changes by reloading tmux and checking: statusbar placement, keybindings, and plugin behavior.

## Commit & Pull Request Guidelines
- Follow Conventional Commit style as seen in history (e.g., `chore: update statusline`).
- PRs should describe intent, summarize changes, and include before/after notes for UI-facing tweaks.

## Security & Configuration Tips
- Do not store secrets or tokens in `tmux.conf`; use environment variables where needed.
- Keep the plugin list minimal to reduce startup time and maintenance overhead.
