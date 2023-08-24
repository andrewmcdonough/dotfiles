" ==============================================================================
" # Pluginss

" I've moved from vundle to vim-plug
"
" See repo for installation instuctions
"
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" Plug 'gmarik/vundle'                  " Package manager
Plug 'tpope/vim-fugitive'             " Lots of nice git features
Plug 'tpope/vim-sensible'             " A sensible set of vim defaults
Plug 'kana/vim-textobj-user'          " Create your own text objects
Plug 'tmhedberg/matchit'              " Extended block matching
Plug 'mileszs/ack.vim'                " For searching for files
Plug 'airblade/vim-gitgutter'         " Shows git diff in the gutter (left hand side)
Plug 'tpope/vim-dispatch'             " Run commands in tmux
Plug 'vim-scripts/tComment'           " For easy line commenting
Plug 'eiginn/netrw'                   " File browsing
Plug 'tpope/vim-surround'             " Manipulate surrounding parentheses, brackets, quotes, etc
Plug 'tpope/vim-abolish'              " For case insensitive text substitution
Plug 'nelstrom/vim-textobj-rubyblock' " For working with Ruby blocks
Plug 'dense-analysis/ale'             " Syntax Checking
Plug 'vim-airline/vim-airline'        " A better status line
Plug 'vim-airline/vim-airline-themes' " A better status line
Plug 'tpope/vim-vinegar'              " Better netrw
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'               " Fuzzy finder
Plug 'liuchengxu/vim-which-key'       " Show available keybindings
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'mattn/emmet-vim'                " Templating
Plug 'mpyatishev/vim-sqlformat'
Plug 'hashivim/vim-terraform'
Plug 'pearofducks/ansible-vim'
"Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Color Schemes
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'altercation/vim-colors-solarized'

" Syntax highlighting and utilities
Plug 'tpope/vim-cucumber'       " Cucumber
Plug 'tpope/vim-rails'          " Rails
Plug 'thoughtbot/vim-rspec'     " Rspec
Plug 'mxw/vim-jsx'              " JSX
Plug 'posva/vim-vue'            " Vue
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Go
Plug 'pangloss/vim-javascript'  " Javascript

call plug#end()

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
"set cm=blowfish2    " Use th blowfish cypher for encypting files
set list            " "show whitespace
"set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [L:\ %l/%L\ (%p%%)]\ C:%c " A nicer status bar
"

" ==============================================================================
" # Templates

if has("autocmd")
  augroup templates
    autocmd BufNewFile *.html 0r ~/.vim/templates/skeleton.html
  augroup END
endif

" ==============================================================================
" # Colours/UI

try
  colorscheme Tomorrow-Night-Bright
catch /^Vim\%((\a\+)\)\=:E185/
  " Clean exit if colour scheme doesn't exist (e.g. pre-Vundling"
endtry

if has("gui_running")
  set guioptions=aiA " Disable toolbar, menu bar, scroll bars
endif

" ==============================================================================
" # Plug configuration

let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'vue': ['eslint', 'prettier'],
      \ 'ruby': ['rubocop', 'ruby'],
      \ 'sass': ['sass_lint'],
      \ 'scss': ['sass_lint'],
      \}
let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': [
  \       'eslint',
  \       'prettier',
  \   ],
  \   'vue': [
  \       'eslint',
  \       'prettier',
  \   ],
  \   'ruby': [
  \       'rubocop',
  \   ],
  \   'go': ['golint'],
  \}

" Map ALEFix command
map <Leader>f :ALEFix<ENTER>

let g:ale_fix_on_save = 0

" ## syntastic.vim -  for checking syntax on save
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
"
" let g:syntastic_ruby_exec = '~/.rubies/ruby-2.3.1/bin/ruby'
" let g:syntastic_ruby_checkers = [ 'mri' ] ", 'rubocop', 'rubylint' ]
let g:syntastic_javascript_checkers = ['eslint']

" ## ack Use the silver searcher (ag) for searching
let g:ackprg = 'ag --nogroup --nocolor --column'

" ## vim-rspec
let g:rspec_command = '!bundle exec rspec {spec}'

" tmux-dispatch
let g:tmux_sessionname=0
let g:tmux_windowname="vim"
let g:tmux_panenumber=1

autocmd BufWritePre *.rb,*.yml :%s/\s\+$//e " Strip trailing space from Ruby files on save

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

nnoremap <leader>exp :Explore<CR>
command! Ex Explore

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

" # Autofix
nnoremap <leader>f :ALEFix<CR>

" # Pry
nnoremap <leader>pry orequire "pry"; binding.pry<ESC>^
nnoremap <leader>prr orequire "pry"; binding.pry_remote<ESC>^
nnoremap <leader>log oRails.logger.debug("*** ")<ESC>hi

" # fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-M-p> :Rg<CR>
nnoremap <C-M-t> ihello<CR>

" ## fzf templating - WIP - not currently working

function! ApplyTemplate(templates)
  " exec ":'<,'>!ruby -e \"require 'erb'; input = ARGF.read;  puts ERB.new(File.open('" + a:templates[0] + "').read, nil, '-').result(binding)"
  " function! ApplyTemplate(template_name)
  " normal e template_name
  " system("!ruby -e \"require 'erb'; input = ARGF.read;  puts ERB.new(File.open('/Users/amcdonough/templates/class.erb').read, nil, '-').result(binding)\"")
  " let myvar = system("ls")
  " echom template_name
  echom "Testing"
endfunction

function! GetTemplate()
  exec "yy"
  let ApplyFn = function("ApplyTemplate")
  return fzf#run({
  \ 'source': 'ls ~/templates/*.erb',
  \ 'sink*':    ApplyFn,
  \ 'options': '+m --prompt="Templates> "',
  \ 'left': '20%'
  \})
endfunction

nnoremap <leader>z :source ~/.vimrc<CR>

"noremap <leader>t :call fzf#run({'source': 'ls ~/templates/*.erb', 'sink': 'e'})<CR>
"noremap <leader>t :call GetTemplate()<CR>
noremap <leader>t exec "ruby -e \"require 'erb'; input = ARGF.read;  puts ERB.new(File.open('$HOME/templates/class.erb').read, nil, '-').result(binding)\""

" Run a git blame on highlighted lines in visual mode
vmap gl :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p<CR>

" Open the file on github in the browser
map <leader>gho :call OpenFileInGitHub()<CR>

" ## Generating templates

" ### Front matter (for Gatsby)
nnoremap <leader>gfm ggi---<CR>title: <CR>date: ' <ESC>"=strftime("%FT%TZ")<CR>Pa'<CR>---<CR><ESC>kkk$a


nnoremap <leader>tp :<C-U>! ruby ~/code/vim-ruby-macros/bin/filter.rb<CR>

" Toggling paste mode

set pastetoggle=<leader>pas

" Map OSX clipboards - cut, copy paste
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>
map <C-v> :read !pbpaste<CR>

" ==============================================================================
" # Correct typos I make regularly, and useful shortcuts

iab identifer identifier
iab langauge language
iab langage language
iab baord board
iab § #

" ==============================================================================
" # Functions

function! OpenFileInGitHub()
  " Opens the current file in the current branch on GitHub
  exec "!launchy https://`git remote get-url origin | sed 's/:/\\//g' | sed 's/git@//' | sed 's/.git$//g' `/tree/`git describe --contains --all HEAD`/%"
endfunction

" ==============================================================================
" # Status bar configuration
" https://github.com/vim-airline/vim-airline

" section  meaning (example)
" A  displays the mode + additional flags like crypt/spell/paste (INSERT)
" B  VCS information - branch, hunk summary (master)
" C  filename + read-only flag (~/.vim/vimrc RO)
" X  filetype (vim)
" Y  file encoding[fileformat] (utf-8[unix])
" Z  current position in the file
" [...]  additional sections (warning/errors/statistics) from external plugins (e.g. YCM, syntastic, ...)

let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 50,
      \ 'b': 160,
      \ 'x': 70,
      \ 'y': 60,
      \ 'z': 60,
      \ 'warning': 80,
      \ 'error': 80,
      \ }

let g:airline#extensions#default#layout = [
      \ [ 'a', 'c', 'b' ],
      \ [ 'x', 'y', 'z', 'error', 'warning' ]
      \ ]

" ==============================================================================
" # netrw configuration
"
" Much of this borrowed from @shapeshed: https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0        " No banner
"let g:netrw_browse_split = 4  " Open new files in a horizontal split
let g:netrw_winsize = 10      " Set width as 25
" let g:netrw_liststyle = 3   " Tree
let g:netrw_liststyle = 4
let g:netrw_altv = 1

set nocompatible
if has("autocmd")
  filetype plugin indent on
endif

" Autocompletion
let g:coc_disable_startup_warning = 1
" exe 'source' "~/dotfiles/coc.vim.config"


" ==============================================================================
" # vim-terraform configuration
"
let g:terraform_align=1


" Common spelling mistakes
ab language language
