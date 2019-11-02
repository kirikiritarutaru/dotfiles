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
set number
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
set wildmode=list:longest

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
set nohlsearch

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

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" sudoを忘れた場合に強制的に書き込み
cnoremap w!! w !sudo tee > /dev/null %<CR> :e!<CR>

" 削除するときにレジスタに入れない
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X

" Yで行末までヤンク
nnoremap Y y$
"ヤンクレジスタからの貼付け
nnoremap <Leader>p "0p

" 押しにくいキーをremap
noremap <Leader>h  ^
noremap <Leader>l  $
nnoremap <Leader>/  *
noremap ; :
noremap : ;
vnoremap ; :
vnoremap : ;

" タブページを使いやすいようにリマップ
nnoremap <silent> <C-H> :tabprevious<CR>
nnoremap <silent> <C-L> :tabnext<CR>
nnoremap <Leader>n :tabnew<Space>

" バッファを使いやすいようにリマップ
nnoremap <silent> <Leader>J :bnext<CR>
nnoremap <silent> <Leader>K :bprev<CR>

" <F4> でコード実行
function! Exe()
  echo "Exe"
  let filename = expand('%:t')
  if stridx(filename, ".py") != -1
    !python %
  elseif stridx(filename, ".jl") != -1
    !julia %
  elseif stridx(filename, ".cpp") != -1
    !./build_run.sh
  else
    echo "unknown filetype"+filename
  endif
endfunction
command! Exe :call Exe()

nnoremap <F4> :Exe<CR>

"-------dein.vim
if !&compatible
  set nocompatible
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

let s:dein_dir = expand('~/.cache/dein')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir = expand('~/.vim/rc')
  let s:toml = g:rc_dir.'/dein.toml'
  let s:lazy_toml = g:rc_dir. '/dein_lazy.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy':1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable
autocmd FileType python setlocal equalprg=autopep8\ - " python code format

if dein#check_install()
  call dein#install()
endif
