# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v
bindkey '^ ' autosuggest-accept

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# コマンドのスペルミスの指摘
setopt correct
# 補完候補が複数ある時に、一覧表示する
setopt auto_list
# 履歴中の重複行をすべて削除する
setopt hist_ignore_all_dups
# 直前と重複するコマンドを記録しない
setopt hist_ignore_dups
# コマンド中の余分なスペースは削除して履歴に記録する
setopt hist_reduce_blanks
# 履歴と重複するコマンドを記録しない
setopt hist_save_no_dups
# カッコの対応などを自動的に補完する
setopt auto_param_keys
# 履歴を複数端末間で共有する。
setopt share_history
# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

#------------vcs_info
# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
# zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
# zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () { vcs_info }
# RPROMPT='${vcs_info_msg_0_}'

#------------alias
alias ez='nvim ~/.zshrc'
alias sz='source ~/.zshrc'
alias l='ls -CF'
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias i3config='sudo -E nvim ~/.config/i3/config'
# alias pycharm='bash ~/src/pycharm-community-2019.1.1/bin/pycharm.sh &'
alias sad='sudo apt update'
alias sag='sudo apt upgrade -y'
alias sai='sudo apt install'
alias sar='sudo apt autoremove'
alias aptupd='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias allupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && pyenv update && nvim -N -u ~/.config/nvim/init.vim -c "try | call dein#update() | finally | qall! | endtry" -V1 -es && zplug update && ~/.tmux/plugins/tpm/bin/update_plugins all'
alias ev='nvim ~/.vimrc'
alias pi='pip install'
alias piu='pip install -U'
alias g='git'
alias gaa='git add --all'
alias gcm='git commit -m'
alias gp='git push'
alias pia='pip-review -a'
alias et='nvim ~/.tmux.conf'
alias nv='nvim'
alias envim='nvim ~/.config/nvim/init.vim'
alias unlock='sudo rm /var/lib/apt/lists/lock & sudo rm /var/lib/dpkg/lock'

# ウィンドウのプロパティ値の取得コマンド
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'

#------------export
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export ENHANCD_HOOK_AFTER_CD="tree -L 1"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export TERM=tmux-256color
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

#------------zplug
source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'mafredri/zsh-async', from:github
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "peco/peco", as:command, from:gh-r, use:"*amd64*"
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "zsh-users/zsh-syntax-highlighting"

# if ! zplug check --verbose; then
#     printf "Install? [y/N]: "
#     if read -q; then
#         echo; zplug install
#     fi
# fi

zplug load --verbose > /dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ ! -f ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]] && zcompile ~/.zshrc
