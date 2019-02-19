" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
endif

" ================ General Config ====================

set relativenumber              "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader="\\"

" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vim/vundles.vim
" Use Vundle plugin to manage all other plugins
if filereadable(expand("~/.vim/vundles.vim"))
  source ~/.vim/vundles.vim
endif
au BufNewFile,BufRead *.vundle set filetype=vim

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

" set foldmethod=indent   "fold based on indent
set foldmethod=syntax   "fold based on syntax
set foldnestmax=5       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Custom Settings ========================
so ~/.yadr/vim/settings.vim

" ================ Rich's Settings ========================
set wrap
set tw=100
" Draw a line at 101 columns
set colorcolumn=101
highlight ColorColumn ctermbg=235 guibg=#2c2d27

colo solarized
set background=dark
hi Normal guibg=NONE ctermbg=NONE

" ================ Tags ========================

let g:tagbar_ctags_bin='/usr/local/bin/ctags'

let g:tagbar_type_vimwiki = {
      \   'ctagstype':'vimwiki'
      \ , 'kinds':['h:header']
      \ , 'sro':'&&&'
      \ , 'kind2scope':{'h':'header'}
      \ , 'sort':0
      \ , 'ctagsbin':'~/tools/vimwiki-utils/utils/vwtags.py'
      \ , 'ctagsargs': 'default'
      \ }

" indent guides custom colors
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=16
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=232

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
hi Visual term=reverse cterm=reverse guibg=Grey
" let g:yadr_disable_solarized_enhancements = 1 " enable this if issues with colors
set shell=/usr/local/bin/zsh\ -l

" scalafmt settings
function! StartNailgunScalaFmt()
  execute(':silent! !scalafmt_ng 2>/dev/null 1>/dev/null &')
  execute(':redraw!')
endfunction
call StartNailgunScalaFmt()

let g:formatdef_scalafmt = "'ng scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']

let g:autoformat_verbosemode = 0 " for error messages
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

noremap <silent><localleader>f :Autoformat<CR>:SortScalaImports<CR>

au BufWritePost *.scala :Autoformat

" syntastic settings
let g:syntastic_mode_map = { 'mode': 'passive' }

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm.app"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

if exists('$TMUX')
  let &t_SI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=1\x7\<esc>\\"
  let &t_EI = "\<esc>Ptmux;\<esc>\<esc>]50;CursorShape=0\x7\<esc>\\"
else
  let &t_SI = "\<esc>]50;CursorShape=1\x7"
  let &t_EI = "\<esc>]50;CursorShape=0\x7"
endif

let g:vimwiki_list = [{'path':'$HOME/itv-wiki','path_html':'$HOME/itv-wiki_html'}, {'path':'$HOME/vimwiki/vimwiki','path_html':'$HOME/vimwiki/vimwiki_html'}]

let g:tagbar_type_vimwiki = {
      \   'ctagstype':'vimwiki'
      \ , 'kinds':['h:header']
      \ , 'sro':'&&&'
      \ , 'kind2scope':{'h':'header'}
      \ , 'sort':0
      \ , 'ctagsbin': 'python3'
      \ , 'ctagsargsbin':'~/.vim/vwtags.py default'
      \ }

set clipboard=unnamed

set mouse=a
set autochdir

let g:gist_post_private = 1

au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown


" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Initialize plugin system
call plug#end()



