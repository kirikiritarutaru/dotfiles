#------------shledon
eval "$(sheldon source)"

#------------settings
bindkey '^ ' autosuggest-accept
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=100000
SAVEHIST=100000
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
alias l='ls -GF'
alias ls='ls --color=auto -GF'
alias lt='ls -tlr'
alias ll='ls -alF'
alias la='ls -A'

alias nv='nvim'

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

function fzf-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | fzf-tmux -p --reverse --height 40%`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-history-selection
bindkey '^H' fzf-history-selection

## tmux window switcher
function tmux-window-switcher () {
    local window="$(tmux list-windows -a -F '#S:#W' | fzf-tmux -p --height 40% --reverse | awk '{print $1}')"

    if [ -n "$window" ]; then
      session_name="${window%%:*}"
      window_name="${window#*:}"

      BUFFER="tmux switch-client -t $session_name && tmux select-window -t $window_name"
      zle accept-line
    fi
}
zle -N tmux-window-switcher
bindkey '^w' tmux-window-switcher

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
export TERM='screen-256color'
export PYENV_PATH=$HOME/.pyenv

export PATH="/usr/local/cuda/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

set termguicolors


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ ! -f ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]] && zcompile ~/.zshrc
