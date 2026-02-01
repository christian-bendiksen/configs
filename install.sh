#!/bin/bash

QUICKSHELL_DIR="$HOME/.config/quickshell"
FONT_DIR="$HOME/.local/share/fonts"
THEME_DIR="$HOME/.themes"

mkdir -p "$QUICKSHELL_DIR" "$FONT_DIR" "$THEME_DIR"

echo "Starting user configuration setup..."

if [ ! -d "$QUICKSHELL_DIR/noctalia-shell" ]; then
    echo "Cloning Noctalia-shell..."
    git clone https://github.com/Noctalia/noctalia-shell.git "$QUICKSHELL_DIR/noctalia-shell"
else
    echo "Noctalia-shell already exists. Pulling latest changes..."
    cd "$QUICKSHELL_DIR/noctalia-shell" && git pull
fi

if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    echo "Downloading JetBrains Mono Nerd Font..."
    TEMP_FONT_DIR=$(mktemp -d)
    curl -fLo "$TEMP_FONT_DIR/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip "$TEMP_FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR"
    fc-cache -fv
    rm -rf "$TEMP_FONT_DIR"
else
    echo "JetBrains Mono Nerd Font already installed."
fi

if [ ! -d "$THEME_DIR/adw-gtk3" ]; then
    echo "Downloading adw-gtk3 theme..."
    THEME_URL=$(curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | grep "browser_download_url.*tar.xz" | cut -d '"' -f 4)
    curl -L "$THEME_URL" | tar -xJ -C "$THEME_DIR"
else
    echo "adw-gtk3 theme already exists."
fi

echo "Setup complete!"
