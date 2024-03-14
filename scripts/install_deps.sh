#!/bin/bash
if [ ! -e "${HOME}/.oh-my-zsh" ]; then
	echo "installing oh-my-zsh..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
echo "   oh-my-zsh installed."

if [ ! -e "${HOME}/.tmux-themepack" ]; then
	echo "installing tmux-themepack..."
	git clone https://github.com/jimeh/tmux-themepack.git "${HOME}/.tmux-themepack"
fi
echo "   tmux-themepack installed."

if [ ! -e "${HOME}/src/neovim" ]; then
	echo "installing neovim..."
	mkdir -p "${HOME}/src"
	git clone https://github.com/neovim/neovim.git "${HOME}/src/neovim"
fi
echo "   neovim cloned to ${HOME}/src/neovim."


if [ ! -e "${HOME}/.config/nvim/autoload/plug.vim" ]; then
	echo "installing plug.vim..."
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
echo "   plug.vim installed"
