# Dotfiles repo

This is a chezmoi source directory. Files here (e.g. `dot_zshrc`, `private_dot_claude/`) are sources that chezmoi renders into `$HOME`. Editing a file here does **not** update the live config until `chezmoi apply` is run.

## After any change to a tracked file

Run `chezmoi apply` to propagate the change to `$HOME`. Do this as the final step of the task — before reporting it complete.

## Git workflow

Commit and push directly to `main`. Don't create branches or pull requests unless Andrew explicitly asks — this overrides the global instruction to branch per task.
