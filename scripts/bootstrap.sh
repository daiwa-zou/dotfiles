set -e

# change directory into parent directory of this script
# set script parent directory as DOTFILES_ROOT
cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# print formatted info message to stdout
info() {
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

success() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
	echo ''
	exit
}

# link file
link_file() {
	ln -s "$1" "$2"
	success "linked $1 to $2"
}

# find all files with .lnk extension and link them to user home directory
install_dotfiles() {
	info 'installing dotfiles'

	for source in $(find "$DOTFILES_ROOT" -maxdepth 2 -name '*.lnk'); do
		destination="$HOME/.$(basename "${source%.*}")"
		link_file "$source" "$destionation"
	done
}
