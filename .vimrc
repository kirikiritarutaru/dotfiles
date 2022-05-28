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

"---------digraphs
" 全角文字に飛びたい→f + <C-k> + 飛びたい文字
" 半角記号に飛びたい→f / t / F / T + 飛びたい文字
" 全角記号に飛びたい→f / t / F / T + j + 飛びたい文字の半角版
noremap fj f<C-k>j
noremap Fj F<C-k>j
noremap tj t<C-k>j
noremap Tj T<C-k>j

" 半角jだけはfjjで飛ぶ
digraphs jj 106  " j

" カッコ
digraphs j( 65288  " （
digraphs j) 65289  " ）
digraphs j[ 12300  " 「
digraphs j] 12301  " 」
digraphs j{ 12302  " 『
digraphs j} 12303  " 』
digraphs j< 12304  " 【
digraphs j> 12305  " 】

" 句読点
digraphs j, 12289  " 、
digraphs j. 12290  " 。
digraphs j! 65281  " ！
digraphs j? 65311  " ？
digraphs j: 65306  " ：

" 数字
digraphs j0 65296  " ０
digraphs j1 65297  " １
digraphs j2 65298  " ２
digraphs j3 65299  " ３
digraphs j4 65300  " ４
digraphs j5 65301  " ５
digraphs j6 65302  " ６
digraphs j7 65303  " ７
digraphs j8 65304  " ８
digraphs j9 65305  " ９

" その他の記号
digraphs j~ 12316  " 〜
digraphs j/ 12539  " ・
digraphs js 12288  " 　 ←全角空白

"---------マッピング
" ESC連打でハイライト解除
nnoremap <silent><Esc><Esc> :noh<CR>

" ESC時に日本語入力解除
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction
set ttimeoutlen=150
"Leave Insert mode
autocmd InsertLeave * call Fcitx2en()

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
" 連続で同じテキストを貼り付けできるように設定
vnoremap <silent> <Leader>p "0p

" 押しにくいキーをremap
noremap <silent> <Leader>h  ^
noremap <silent> <Leader>l  $
noremap <silent> <Leader>/  *
noremap ; :
noremap : ;
vnoremap ; :
vnoremap : ;

" カレント行と列を強調表示（トグル）
noremap <silent> <Leader>c :set cursorcolumn! <Bar>set cursorline!<CR>

" タブページを使いやすいようにリマップ
nnoremap <silent> <Leader>J :tabprevious<CR>
nnoremap <silent> <Leader>K :tabnext<CR>
nnoremap <Leader>n :tabnew<Space>

" バッファを使いやすいようにリマップ
nnoremap <silent> <C-h> :bprev<CR>
nnoremap <silent> <C-l> :bnext<CR>

" 直前の置換を繰り返す「&」コマンドの修正
nnoremap & :&&<CR>
xnoremap & :&&<CR>

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

" 数字のインクリメントとデクリメントを分かりやすく
nnoremap + <C-a>
nnoremap - <C-x>

" カーソル下の単語の大文字小文字をトグル
nnoremap <Space>u mzg~iw`z<Cmd>delmarks z<CR>
nnoremap <Space>U mzlbg~l`z<Cmd>delmarks z<CR>

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

"-------背景色設定
" カレント行と列の強調表示の色を設定
highlight CursorColumn ctermbg=235
highlight CursorLine ctermbg=235

filetype plugin indent on
syntax enable
autocmd FileType python setlocal equalprg=autopep8\ - " python code format

if dein#check_install()
  call dein#install()
endif
