#!/fbin/bash

# Define the target directory for your dotfiles
DOTFILES_DIR=~/dotfiles

# Ensure the dotfiles directory exists
mkdir -p "$DOTFILES_DIR"

# Declare an associative array to map files/folders to their categories
declare -A DOTFILES=(
    [~/.bashrc]="bash"
    [~/.bash_aliases]="bash"
    [~/.bash_logout]="bash"
    [~/.zshrc]="zsh"
    [~/.zshenv]="zsh"
    [~/.tmux.conf]="tmux"
    [~/.gitconfig]="git"
    [~/.gitignore_global]="git"
    [~/.vimrc]="vim"
    [~/.config/nvim]="nvim"
    [~/.config/Code/User]="vscode"
    [~/.config/htop]="htop"
    [~/.config/lazygit]="lazygit"
    [~/.config/flameshot]="flameshot"
    [~/.config/gcloud]="gcloud"
    [~/.config/guake]="guake"
    [~/.config/JetBrains]="jetbrains"
    [~/.config/gh]="github"
)

# Move files to the appropriate subdirectories
for FILE in "${!DOTFILES[@]}"; do
    CATEGORY="${DOTFILES[$FILE]}"
    TARGET_DIR="$DOTFILES_DIR/$CATEGORY"

    # Create the category directory if it doesn't exist
    mkdir -p "$TARGET_DIR"

    # Move the file or folder if it exists
    if [ -e "$FILE" ]; then
        echo "Moving $FILE to $TARGET_DIR/"
        mv "$FILE" "$TARGET_DIR/"
    else
        echo "Skipping $FILE: not found"
    fi
done

# Use stow to symlink the dotfiles
echo "Stowing files..."
cd "$DOTFILES_DIR" || exit
for CATEGORY in "${DOTFILES[@]}"; do
    if [ -d "$CATEGORY" ]; then
        echo "Stowing $CATEGORY..."
        stow -v -t ~ "$CATEGORY"
    fi
done

echo "Dotfiles organized and stowed successfully!"