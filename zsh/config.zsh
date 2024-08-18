# Determine the operating system
is_macos() {
  [[ "$(uname)" == "Darwin" ]]
}

is_linux() {
  [[ "$(uname)" == "Linux" ]]
}

# Set colors for `ls` based on the OS
if is_macos; then
  # macOS configuration
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  export CLICOLOR=true
elif is_linux; then
  # Linux configuration
  export LS_COLORS="di=1;34:fi=0;37:ln=1;36:pi=40;33:so=1;35:bd=40;33:cd=40;33:or=1;31:mi=1;31:ex=1;32:"
fi

# Load custom functions and completion scripts
fpath=($ZSH/functions $fpath)
autoload -U $ZSH/functions/*(:t)

# Customize terminal history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Zsh options
setopt NO_BG_NICE               # Don't adjust priority of background jobs
setopt NO_HUP                   # Don't send SIGHUP to background jobs on exit
setopt NO_LIST_BEEP             # Disable beep on list completions
setopt LOCAL_OPTIONS            # Allow functions to have local options
setopt LOCAL_TRAPS              # Allow functions to have local traps
setopt HIST_VERIFY              # Verify history substitutions before execution
setopt SHARE_HISTORY            # Share history between Zsh sessions
setopt EXTENDED_HISTORY         # Record timestamps in history
setopt PROMPT_SUBST             # Evaluate prompt string dynamically
setopt CORRECT                  # Automatically correct minor spelling errors
setopt COMPLETE_IN_WORD         # Allow completion within a word
setopt IGNORE_EOF               # Ignore EOF (Ctrl-D) and continue reading input
setopt APPEND_HISTORY           # Append new history entries to HISTFILE
setopt INC_APPEND_HISTORY       # Incrementally append history and share across sessions
setopt HIST_IGNORE_ALL_DUPS     # Ignore duplicate history entries
setopt HIST_REDUCE_BLANKS       # Remove extra blanks from history entries
setopt COMPLETE_ALIAS           # Expand aliases after completion

# Key bindings
bindkey '^[^[[D' backward-word     # Ctrl-Left Arrow to move backward by word
bindkey '^[^[[C' forward-word      # Ctrl-Right Arrow to move forward by word
bindkey '^[[5D' beginning-of-line  # Ctrl-Left Arrow to move to the beginning of the line
bindkey '^[[5C' end-of-line        # Ctrl-Right Arrow to move to the end of the line
bindkey '^[[3~' delete-char        # Delete key to delete the character under the cursor
bindkey '^?' backward-delete-char # Backspace key to delete the character before the cursor
