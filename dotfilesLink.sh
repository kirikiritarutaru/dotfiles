#!/bin/sh
mkdir -p ~/.tmux
mkdir -p ~/.config/regolith/i3
sudo add-apt-repository ppa:regolith-linux/release
sudo apt install -y gcc make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev regolith-desktop-standard vim neovim zsh tree fcitx-mozc tmux git ranger
chsh -s $(which zsh)
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.vim/rc
sudo ln -sf ~/dotfiles/rc/dein.toml ~/.vim/rc/dein.toml
sudo ln -sf ~/dotfiles/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
mkdir -p ~/.config/nvim/
ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/nvim/dein.toml ~/.config/nvim/dein.toml
ln -sf ~/dotfiles/nvim/dein_lazy.toml ~/.config/nvim/dein_lazy.toml
ln -sf ~/dotfiles/regolith/i3/config ~/.config/regolith/i3/config
source ~/.zshrc
