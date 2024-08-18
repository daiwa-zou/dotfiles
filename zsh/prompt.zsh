autoload -U colors && colors

# Determine the path to the git executable
if (( $+commands[git] )); then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

# Function to get the current branch name
git_branch() {
  $git symbolic-ref --short HEAD 2>/dev/null
}

# Function to determine if there are uncommitted changes and if the branch is clean
git_dirty() {
  if $git status -s &>/dev/null; then
    if [[ -n $($git status --porcelain) ]]; then
      echo "on %{$fg_bold[red]%}$(git_branch)%{$reset_color%}"
    else
      echo "on %{$fg_bold[green]%}$(git_branch)%{$reset_color%}"
    fi
  else
    echo ""
  fi
}

# Function to check if there are commits to push
need_push() {
  if $git rev-parse --is-inside-work-tree &>/dev/null; then
    local number
    number=$($git cherry -v origin/$(git_branch) 2>/dev/null | wc -l | awk '{print $1}')
    
    if (( number > 0 )); then
      echo " with %{$fg_bold[magenta]%}$number unpushed%{$reset_color%}"
    else
      echo " "
    fi
  fi
}

# Function to format the current directory name
directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

# Function to display battery status (macOS only)
battery_status() {
  if [[ "$(uname)" == "Darwin" && $(sysctl -n hw.model) == *"Book"* ]]; then
    $ZSH/bin/battery-status
  fi
}

# Set the prompt string
export PROMPT=$'\n$(battery_status)in $(directory_name) $(git_dirty)$(need_push)\n› '

# Set the right prompt (RPROMPT) to display additional information
set_prompt() {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

# Update the terminal title and set the prompt before each command
precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
