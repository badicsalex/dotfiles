#!/usr/bin/env bash
set -euxo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sfn $SCRIPT_DIR/aliases ~/.aliases
ln -sfn $SCRIPT_DIR/zshrc ~/.zshrc

mkdir -p ~/.config/nvim/lua
mkdir -p ~/.config/nvim/colors
mkdir -p ~/.config/nvim/syntax

ln -sfn $SCRIPT_DIR/nvim/init.vim  ~/.config/nvim/init.vim
ln -sfn $SCRIPT_DIR/nvim/config.lua  ~/.config/nvim/lua/config.lua
ln -sfn $SCRIPT_DIR/nvim/monokai_ad.vim ~/.config/nvim/colors/monokai_ad.vim
ln -sfn $SCRIPT_DIR/nvim/tatsu.vim ~/.config/nvim/syntax/tatsu.vim
