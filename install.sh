#!/usr/bin/env bash
set -euxo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sfn $SCRIPT_DIR/zsh/aliases ~/.aliases
ln -sfn $SCRIPT_DIR/zsh/zshrc ~/.zshrc
ln -sfn $SCRIPT_DIR/zsh/alex.zsh-theme ~/.oh-my-zsh/themes/alex.zsh-theme

rm -rf ~/.config/nvim/lua
mkdir -p ~/.config/nvim/colors
mkdir -p ~/.config/nvim/syntax
mkdir -p ~/.config/nvim/after/syntax

ln -sfn $SCRIPT_DIR/nvim/init.lua  ~/.config/nvim/init.lua
ln -sfn $SCRIPT_DIR/nvim/lua  ~/.config/nvim/lua
ln -sfn $SCRIPT_DIR/nvim/monokai_ad.vim ~/.config/nvim/colors/monokai_ad.vim
ln -sfn $SCRIPT_DIR/nvim/syntax/tatsu.vim ~/.config/nvim/syntax/tatsu.vim
ln -sfn $SCRIPT_DIR/nvim/syntax/c_after.vim ~/.config/nvim/after/syntax/c.vim
