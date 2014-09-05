" 色分け
syntax on
" 文字コード自動判別
"set encoding=euc-jp
"set fileencodings=utf-8,euc-jp,iso-2022-jp,sjis
"set fileformats=unix,dos,mac
"set ambiwidth=double

" 文字コードの自動認識
set encoding=utf-8

" タブの画面上での幅
set tabstop=4
" タブをスペースに展開する
set expandtab
" 自動的にインデントする
set smartindent
" 自動インデント幅
set shiftwidth=4
" タブをスペースn個で表現
set softtabstop=4
" 検索文字のハイライト
set hlsearch
" インクリメンタルサーチ
set incsearch
" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" ステータスラインに文字コード・改行コードを表示
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" ステータスラインを常に表示
set laststatus=2
" tabとeolを表示
" set list
" マウスモード有効
set mouse=a
set ttymouse=xterm2

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLineNC guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLineNC guifg=#2E4340 guibg=#ccdc90
augroup END

" Alignを日本語環境で使用するための設定
:let g:Align_xstrlen = 3

autocmd FileType perl nmap ,s :!perl -wc -Ilib %

noremap fg :call Search_pm('vne')<ENTER>
noremap ff :call Search_pm('e')<ENTER>
noremap fd :call Search_pm('sp')<ENTER>

set nocompatible               " be iMproved
filetype off


if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
  endif
  " originalrepos on github
  " NeoBundle 'Shougo/neobundle.vim'
  " NeoBundle 'Shougo/vimproc'
  " NeoBundle 'VimClojure'
  " NeoBundle 'Shougo/vimshell'
  " NeoBundle 'Shougo/unite.vim'
  " NeoBundle 'Shougo/neocomplcache'
  " NeoBundle 'Shougo/neosnippet'
  " NeoBundle 'jpalardy/vim-slime'
  " NeoBundle 'scrooloose/syntastic'
  " NeoBundle 'andviro/flake8-vim'
  " NeoBundle 'vim-scripts/python.vim'
  ""NeoBundle 'https://bitbucket.org/kovisoft/slimv'
  
  filetype plugin indent on     " required!
  filetype indent on
  syntax on
