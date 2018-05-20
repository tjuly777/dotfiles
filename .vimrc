" 行番号を表示
set number

" 現在の行をハイライト
set cursorline

" ファイル上書き前のバックアップを無効化
set nobackup
set nowritebackup

" スワップファイルの作成を無効化
set noswapfile

" 矩形選択時、文字がなくても右へ進む
set virtualedit=block

" 挿入モード時、BackSpaceで削除可能
set backspace=indent,eol,start

" 全角文字専用設定
set ambiwidth=double

" wildmenuオプション(vimバーからファイル選択が可能に)
set wildmenu

" 長い行を「@」と省略せずに表示
set display=lastline

"===================================================
" 検索関連
"===================================================
" 検索時、大文字小文字の区別をしない
set ignorecase

" 小文字検索で大文字と小文字を無視
set smartcase

" ファイル末尾まで検索したら、先頭へ折り返し
set wrapscan

" 入力と同時に検索開始
set incsearch

" 検索結果のハイライト表示、Esc2回押しでハイライト解除
set hlsearch
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>


"===================================================
" 表示関連
"===================================================
" エラーメッセージ時にビープを無効に
set noerrorbells

" Windowsでのパス区切り文字を/に
set shellslash

" 対応する括弧を強調
set showmatch

" 対応する括弧・ブレースを表示
set showmatch matchtime=1

" インデント方法変更
set cinoptions+=:0

" メッセージ表示欄を2行へ
set cmdheight=2

" ステータス行を常時表示
set laststatus=2

" 入力中コマンドを右下に表示
set showcmd

" 省略せずに表示
set display=lastline

" タブ文字をCTRL-Iで表示、行末に$で表示
set list

" 行末スペースを可視化
set listchars=tab:^\ ,trail:~

" コメントの色を水色に
hi Comment ctermfg=3

" 入力モード時、tabキーで半角スペースを挿入
set expandtab

" インデント幅
set shiftwidth=2

" tabキーの文字幅
set softtabstop=2

" タブ文字の表示幅
set tabstop=2

" 補完メニューの高さ
set pumheight=15

" ツールバー非表示
set guioptions-=T

" ヤンク時にクリップボードへ
set guioptions+=a
set clipboard=unnamed,autoselect

" メニューバー非表示
set guioptions-=m

" 右スクロールバー非表示
set guioptions+=R

" 改行時、次の行のインデントを調整
set smartindent

" タイトル表示
set title

" 全ての数字を10進数として扱う
set nrformats=

" 行をまたいだ移動
set whichwrap=b,s,h,l,<,>,[,],~

" バッファスクロール
set mouse=a

" auto reload .vimrc
augroup source-vimrc
autocmd!
autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
autocmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
augroup END

" auto comment off
augroup auto_comment_off
autocmd!
autocmd BufEnter * setlocal formatoptions-=r
autocmd BufEnter * setlocal formatoptions-=o
augroup END

" HTML/XML閉じタグ自動補完
augroup MyXML
autocmd!
autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" 編集箇所のカーソルを記憶
if has("autocmd")
augroup redhat
" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=78
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif
augroup END
endif


"===================================================
" キーマッピング
"===================================================
" 【Y】行末までのヤンク
nnoremap Y y$

" 【+/-】数字のインクリメント、デクリメント
nnoremap + <C-a>
nnoremap - <C-x>

" 【H/J/K/L】行頭・行末へ移動
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $

" 【==】バッファ全体をインデント整理
noremap == gg=G''

" 【S-Enter/C-S-Enter】上下に空行を挿入
"imap <S-CR> <End><CR>
"imap <C-S-CR> <Up><End><CR>
"nnoremap <S-CR> mzo<ESC>`z
"nnoremap <C-S-CR> mzo<ESC>`z

" 【C-Up】【C-Down】行を移動
nnoremap <C-Up> "zdd<Up>"zP
nnoremap <C-Down> "zdd"zp

" 複数行を移動
vnoremap <C-Up> "zx<Up>"zP`[V`]
vnoremap <C-Down> "zx"zp`[V`]

" x/sでレジスタへ保存しないように
nnoremap x "_x
nnoremap s "_s


"===================================================
" プラグイン関連
"===================================================

" deinが入ってない場合に自動でダウンロード
let s:dein_dir = $HOME . '/.vim/bundle'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " Load and cached toml
  " all plugins listed in toml
  call dein#load_toml(s:dein_dir . '/rc/dein.toml', {'lazy': 0})
  call dein#load_toml(s:dein_dir . '/rc/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup
if dein#check_install()
  call dein#install()
endif

" シンタックスハイライト
syntax on

" カラースキーム設定
set background=dark 
colorscheme dracula
set t_Co=256

