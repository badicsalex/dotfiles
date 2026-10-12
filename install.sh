#!/usr/bin/env bash
set -euxo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sfn $SCRIPT_DIR/zsh/aliases ~/.aliases
ln -sfn $SCRIPT_DIR/zsh/zshrc ~/.zshrc
ln -sfn $SCRIPT_DIR/zsh/alex.zsh-theme ~/.oh-my-zsh/themes/alex.zsh-theme

mkdir -p ~/.config
ln -sfnT $SCRIPT_DIR/nvim ~/.config/nvim
