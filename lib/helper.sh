# Print formatted info message to stdout
info() {
    printf "\r  [ \033[00;34m..\033[0m ] %s\n" "$1"
}

success() {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] %s\n" "$1"
}

fail() {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
    exit 1
}

# Function to create a symbolic link with overwrite handling
link_file() {
    local source="$1"
    local destination="$2"

    # Check if the source file exists
    if [ ! -e "$source" ]; then
        fail "Source file $source does not exist"
    fi

    # Check if the destination directory exists
    local dest_dir
    dest_dir=$(dirname "$destination")
    if [ ! -d "$dest_dir" ]; then
        fail "Destination directory $dest_dir does not exist"
    fi

    # If the destination exists and is not a symbolic link, remove it
    if [ -e "$destination" ] && [ ! -L "$destination" ]; then
        rm -f "$destination"
        if [ $? -ne 0 ]; then
            fail "Failed to remove existing file $destination"
        fi
    fi

    # Create the symbolic link
    if ln -sf "$source" "$destination"; then
        success "Linked $source to $destination"
    else
        fail "Failed to link $source to $destination"
    fi
}

