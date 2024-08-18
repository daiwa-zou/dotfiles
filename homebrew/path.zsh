# Check if the system is macOS or Linux
if [ "$(uname)" = "Darwin" ]; then
    # macOS
    export PATH="/opt/homebrew/bin:$PATH"
elif [ "$(uname)" = "Linux" ]; then
    # Linux
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
