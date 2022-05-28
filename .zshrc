#------------settings
bindkey -v
bindkey '^ ' autosuggest-accept

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

fpath+=~/.zfunc
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

# キー待ち時間を短縮
KEYTIMEOUT=1

#------------alias
alias ez='nvim ~/.zshrc'
alias sz='source ~/.zshrc'
alias l='ls -CF'
alias ls='ls --color=auto -CF'
alias lt='ls -tlr'
alias ll='ls -alF'
alias la='ls -A'
alias sad='sudo apt update'
alias sag='sudo apt upgrade -y'
alias sai='sudo apt install'
alias sar='sudo apt autoremove -y'
alias aptupd='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y'
alias allupdate='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && pyenv update && nvim -N -u ~/.config/nvim/init.vim -c "try | call dein#update() | finally | qall! | endtry" -V1 -es && zplug update && ~/.tmux/plugins/tpm/bin/update_plugins all'
alias partupdate='nvim -N -u ~/.config/nvim/init.vim -c "try | call dein#update() | finally | qall! | endtry" -V1 -es && zplug update && ~/.tmux/plugins/tpm/bin/update_plugins all'
alias pi='pip install'
alias piu='pip install -U'
alias g='git'
alias gaa='git add --all'
alias gcm='git commit -m'
alias gac='git add --all && git commit -m'
alias gp='git push origin HEAD'
alias pip-upgrade-all="pip list -o | tail -n +3 | awk '{ print \$1 }' | xargs pip install -U"
alias et='nvim ~/.tmux.conf'
alias nv='nvim'
alias envim='nvim ~/.config/nvim/init.vim'
alias unlock='sudo rm /var/lib/apt/lists/lock & sudo rm /var/lib/dpkg/lock'
alias rc='ranger-cd'
alias rmrf='rm -rf'
alias ide='tmux split-window -h -d -p 66 && tmux split-window -v -d'
alias rmi='rm -i'
alias mvi='mv -i'
alias cpi='cp -i'
alias gg='git graph'

# ウィンドウのプロパティ値の取得コマンド
alias xp='xprop | grep "WM_WINDOW_ROLE\|WM_CLASS" && echo "WM_CLASS(STRING) = \"NAME\", \"CLASS\""'

#------------ranger
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}
bindkey -s '^o' 'ranger-cd^M'

#------------fzf
function select-history() {
 BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
 CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

#------------export
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export ENHANCD_HOOK_AFTER_CD="tree -C -L 1"
export PYENV_ROOT=$HOME/.pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi
eval "$(pyenv virtualenv-init -)"
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export EDITOR=vim
export LD_LIBRARY_PATH=/usr/local/cuda/lib64
export TERM='screen-256color'
export PYENV_PATH=$HOME/.pyenv

set termguicolors

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
zplug 'yonchu/zsh-python-prompt'

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose > /dev/null
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ ! -f ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]] && zcompile ~/.zshrc
