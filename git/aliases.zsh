#!/bin/sh

# Pull from the remote repository and prune deleted branches
alias gl='git pull --prune'

# Log with a pretty graph format
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

# Push the current branch to origin
alias gp='git push origin HEAD'

# Show git diff with color and without `+` and `-` signs, use less for pagination
alias gd='git diff --color | sed "s/^\([^-+ ]*\)[-+ ]/\\1/" | less -r'

# Standard commit command
alias gc='git commit'

# Commit all changes
alias gca='git commit -a'

# Checkout a branch
alias gco='git checkout'

# Custom alias to copy the branch name (ensure you have a `git copy-branch-name` function or script)
alias gcb='git copy-branch-name'

# List all branches
alias gb='git branch'

# Show status in short format with branch name
alias gs='git status -sb'

# Add all changes and commit with a message
alias gac='git add -A && git commit -m'

# Custom command to edit new files (ensure you have a `git-edit-new` function or script)
alias ge='git-edit-new'
