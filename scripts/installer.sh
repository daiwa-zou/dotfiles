#!/usr/bin/env bash
#
# Run all dotfiles installers.

set -e

cd "$(dirname $0)"/..

echo "› brew bundle"
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  echo "Installing packages for macOS..."
  brew bundle --file=homebrew/Brewfile-macos
elif [[ "$OSTYPE" == "linux"* ]]; then
  # Linux
  echo "Installing packages for Linux..."
  brew bundle --file=homebrew/Brewfile-linux
else
  echo "Unsupported OS: $OSTYPE"
  exit 1
fi

# find the installers and run them iteratively, exlcude scripts directory
find . -name 'install.sh' -not -path './scripts/*' | while read -r installer; do
  sh -c "$installer"
done
