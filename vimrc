" ==============================================================================
" # Plugins

" I've been using vundle for vim plugin management for the last few years.
"
" Install by running
"
" `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'                  " Package manager
Plugin 'tpope/vim-fugitive'             " Lots of nice git features
Plugin 'tpope/vim-sensible'             " A sensible set of vim defaults
Plugin 'kana/vim-textobj-user'          " Create your own text objects
Plugin 'tmhedberg/matchit'              " Extended block matching
Plugin 'mileszs/ack.vim'                " For searching for files
Plugin 'scrooloose/syntastic'           " Check syntax on save
Plugin 'airblade/vim-gitgutter'         " Shows git diff in the gutter (left hand side)
Plugin 'ctrlp.vim'                      " Fuzzy file finder by pressing Ctrl-P
Plugin 'tpope/vim-dispatch'             " Run commands in tmux
Plugin 'tComment'                       " For easy line commenting
Plugin 'eiginn/netrw'                   " File browsing
Plugin 'tpope/vim-surround'             " Manipulate surrounding parentheses, brackets, quotes, etc
Plugin 'tpope/vim-abolish'              " For case insensitive text substitution
Plugin 'nelstrom/vim-textobj-rubyblock' " For working with Ruby blocks
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'} " Tomorrow colour scheme

" Syntax highlighting and utilities
Plugin 'tpope/vim-cucumber'       " Cucumber
Plugin 'tpope/vim-rails'          " Rails
Plugin 'thoughtbot/vim-rspec'     " Rspec
Plugin 'mxw/vim-jsx'              " JSX 
Plugin 'posva/vim-vue'            " Vue
Plugin 'fatih/vim-go'             " Go
Plugin 'pangloss/vim-javascript'  " Javascript

call vundle#end()

" ==============================================================================
" # General configuration

" My preference is for spaces over tabs, with a 2 character indent
" Consistency is the most important thing, and I always try to
" follow the style guide of any project I work on, or the idioms of a language
set tabstop=2       " Set tab character to 2 characters
set expandtab       " Expand the tab key to create two spaces
set shiftwidth=2    " Indent width for autoindent
filetype plugin indent on
autocmd FileType php setlocal tabstop=4 shiftwidth=4 " Zend's style guide recommends four space indentation

syntax on           " Syntax highlighting
set nocompatible    " Use the newer features of vim
set encoding=utf-8  " Default to UTF-8 encoding
set visualbell      " Turn off beeping
set noswapfile      " Because I find those .swp files annoying
set showmatch       " Show matching brackets
set number          " Show line numbers on the left
set colorcolumn=120 " set vertical marker at col 120, as a soft maximum line length
set tags=.tags      " Put ctags file in .tags
set backupdir=~/tmp " Don't annoy me with swap files in working directory
set directory=~/tmp 
set background=dark " I prefer dark colour schemes, even during the day
set cm=blowfish2    " Use th blowfish cypher for encypting files
set list            " "show whitespace
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [L:\ %l/%L\ (%p%%)]\ C:%c " A nicer status bar
colorscheme Tomorrow-Night-Bright

if has("gui_running")
  set guioptions=aiA " Disable toolbar, menu bar, scroll bars
endif

" ==============================================================================

" # Plugin configuraation

" ## syntastic.vim -  for checking syntax on save
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_ruby_exec = '~/.rubies/ruby-2.3.1/bin/ruby'
let g:syntastic_ruby_checkers = [ 'mri' ] ", 'rubocop', 'rubylint' ]
let g:syntastic_javascript_checkers = ['eslint']

" ## ack Use the silver searcher (ag) for searching
let g:ackprg = 'ag --nogroup --nocolor --column'

" ## vim-rspec
let g:rspec_command = '!bundle exec rspec {spec}'

" tmux-dispatch
let g:tmux_sessionname=0
let g:tmux_windowname="vim"
let g:tmux_panenumber=1

autocmd BufWritePre *.rb :%s/\s\+$//e " Strip trailing space from Ruby files on save

" ==============================================================================
" # Mappings

" ## Moving around buffers and tabs
nnoremap <C-n> :bprev<CR> " Previous buffer
nnoremap <C-m> :bnext<CR> " Next buffer
nnoremap { :tabprev<CR>   " Previous tab
nnoremap } :tabnext<CR>   " Next tab

" ## Resizing panes
nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Inspired by Sam Phippen's sugggestion to use a prefix tree, I've been
" moving to three character mappings in an attempt to avoid mapping clashes.
" https://samphippen.com/how-i-organise-my-vim-hotkeys/

nnoremap <leader>vcr :source $MYVIMRC<CR>
nnoremap <leader>vce :e $MYVIMRC<CR>

" ## Ruby and Ruby on Rails

" ### Navigation
nnoremap <leader>rns :e features/step_definitions<CR>
nnoremap <leader>rnf :e features<CR>
nnoremap <leader>rna :e app<CR>
nnoremap <leader>rnv :e views<CR>
nnoremap <leader>rnc :e controllers<CR>

" ### Running tests
nnoremap <leader>t :call RunCurrentSpecFile()<CR>
nnoremap <leader>rtt :call RunCurrentSpecFile()<CR>
nnoremap <leader>rtn :call RunNearestSpec()<CR>
nnoremap <leader>rtl :call RunLastSpec()<CR>
nnoremap <leader>rta :call RunAllSpecs()<CR>

nnoremap <leader>sp :set spell spelllang=en_gb<CR>

" ## Git

" Run a git blame on highlighted lines in visual mode
vmap gl :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p<CR>

" Open the file on github in the browser
map <leader>gho :call OpenFileInGitHub()<CR> 

" ## Generating templates

" ### Front matter (for Gatsby)
nnoremap <leader>gfm ggi---<CR>title: <CR>date: ' <ESC>"=strftime("%FT%TZ")<CR>Pa'<CR>---<CR><ESC>kkk$a

" ==============================================================================
" # Correct typos I make regularly

iab identifer identifier

" ==============================================================================
" # Functions

function! OpenFileInGitHub()
  " Opens the current file in the current branch on GitHub
  exec "!launchy https://`git remote get-url origin | sed 's/:/\\//g' | sed 's/git@//' | sed 's/.git$//g' `/tree/`git describe --contains --all HEAD`/%"
endfunction
