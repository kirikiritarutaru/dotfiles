#!/bin/sh
mkdir -p ~/.tmux
sudo apt update
sudo apt upgrade -y
sudo apt install -y gcc make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev vim neovim zsh tree fcitx-mozc tmux git ranger
chsh -s $(which zsh)
source ~/.zshrc
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
mkdir -p ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
mkdir -p ~/.vim/rc
sudo ln -sf ~/dotfiles/rc/dein.toml ~/.vim/rc/dein.toml
sudo ln -sf ~/dotfiles/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
mkdir -p ~/.config/nvim/
ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/nvim/dein.toml ~/.config/nvim/dein.toml
ln -sf ~/dotfiles/nvim/dein_lazy.toml ~/.config/nvim/dein_lazy.toml
source ~/.zshrc
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
git clone git://github.com/yyuu/pyenv-update.git ~/.pyenv/plugins/pyenv-update
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
