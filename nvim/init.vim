let g:python3_host_prog = $HOME . '/.pyenv/shims/python3'
let g:python_host_prog = ''

" setting
" Leaderのマッピング
let mapleader = "\<Space>"
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" ヤンクでクリップボードにコピー
set clipboard&
set clipboard^=unnamedplus
" 最後のカーソル位置を記憶
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

" 見た目系
" 行番号を表示
set relativenumber
" 現在の行を強調表示
" set cursorline
" 現在の行を強調表示（縦）
" set cursorcolumn
" highlight CursorColumn ctermbg=DarkGray
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmenu
set wildmode=full

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch

"---------マッピング
" ESC連打でハイライト解除
nnoremap <silent><Esc><Esc> :noh<CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" vim-expand-region用の設定
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" vim-gitgutter用の設定
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" 削除するときにレジスタに入れない
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" Yで行末までヤンク
nnoremap Y y$

" 押しにくいキーをremap
noremap <silent> <Leader>h  ^
noremap <silent> <Leader>l  $
noremap <silent> <Leader>/  *
noremap ; :
noremap : ;
nnoremap <F4> <CR>q:

" タブページを使いやすいようにリマップ
nnoremap <silent> <C-H> :tabprevious<CR>
nnoremap <silent> <C-L> :tabnext<CR>
nnoremap <Leader>n :tabnew<Space>

" バッファを使いやすいようにリマップ
nnoremap <silent> <Leader>k :bprev<CR>
nnoremap <silent> <Leader>j :bnext<CR>

" Leader+bで単語のブラウザ検索
nmap <Leader>b <Plug>(openbrowser-smart-search)
vmap <Leader>b <Plug>(openbrowser-smart-search)

"------- vim-showmarks settings
" 基本マップ
nnoremap [Mark] <Nop>
nmap m [Mark]

" m + s で現在位置をマーク
if !exists('g:markrement_char')
    let g:markrement_char = [
    \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
    \ ]
endif
nnoremap <silent>[Mark]s :<C-u>call <SID>AutoMarkrement()<CR>:DoShowMarks<CR>
function! s:AutoMarkrement()
    if !exists('b:markrement_pos')
        let b:markrement_pos = 0
    else
        let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    endif
    execute 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
endfunction

" m + l でマーク一覧を表示/非表示
let b:mark_exist = 0
set updatetime=1
function! s:MarkList()
  if b:mark_exist == 0
    let b:mark_exist = 1
    nnoremap <silent>[Mark]l :<C-u>1PreviewMarks<CR>
    \:<C-u>NoShowMarks<CR> :<C-u>call <SID>MarkList()<CR>
  else
    let b:mark_exist = 0
    nnoremap <silent>[Mark]l :<C-u>PreviewMarks<CR>
    \:<C-u>DoShowMarks<CR> :<C-u>call <SID>MarkList()<CR>
  endif
endfunction
nnoremap <silent>[Mark]l :<C-u>PreviewMarks<CR>
\:<C-u>DoShowMarks<CR> :<C-u>call <SID>MarkList()<CR>

" m + m + 1文字 で指定のマークへ移動
nnoremap [Mark]m '
" m + n で次のマークへ移動
nnoremap [Mark]n ]`
" m + b で前のマークへ移動
nnoremap [Mark]b [`
nnoremap [Mark]D :delmarks!<CR>

"-------LSP settings
let g:LanguageClient_serverCommands = {}
if executable('clangd')
    let g:LanguageClient_serverCommands['c'] = ['clangd']
    let g:LanguageClient_serverCommands['cpp'] = ['clangd']
endif

if executable('pyls')
    let g:LanguageClient_serverCommands['python'] = ['pyls']
endif

" augroup LanguageClient_config
"     autocmd!
"     autocmd User LanguageClientStarted setlocal signcolumn=yes
"     autocmd User LanguageClientStopped setlocal signcolumn=auto
" augroup END

augroup LCHighlight
    autocmd!
    autocmd CursorHold,CursorHoldI *.py,*.c,*.cpp call LanguageClient#textDocument_documentHighlight()
augroup END

"-------dein.vim
if !&compatible
  set nocompatible
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

let s:dein_cache_dir = '~/.cache/dein'
let s:dein_config_dir = '~/.config/nvim'

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  call dein#load_toml(s:dein_config_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:dein_config_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
autocmd FileType python setlocal equalprg=autopep8\ - " python code format

if dein#check_install()
  call dein#install()
endif
