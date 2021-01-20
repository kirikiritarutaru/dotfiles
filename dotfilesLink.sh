 #!/bin/sh
 sudo add-apt-repository ppa:regolith-linux/release
 sudo apt install regolith-desktop-standard -y
 mkdir -p ~/.config/regolith/i3
 sudo apt install -y vim neovim
 ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
 ln -sf ~/dotfiles/.vimrc ~/.vimrc
 ln -sf ~/dotfiles/.zshrc ~/.zshrc
 ln -sf ~/dotfiles/.Xresources ~/.Xresources
 mkdir -p ~/.vim/rc
 sudo ln -sf ~/dotfiles/rc/dein.toml ~/.vim/rc/dein.toml
 sudo ln -sf ~/dotfiles/rc/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
 mkdir -p ~/.config/nvim/
 ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
 ln -sf ~/dotfiles/nvim/dein.toml ~/.config/nvim/dein.toml
 ln -sf ~/dotfiles/nvim/dein_lazy.toml ~/.config/nvim/dein_lazy.toml
 ln -sf ~/dotfiles/regolith/i3/config ~/.config/regolith/i3/config
