" Zach's modified .vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup			" keep a backup file
endif
set history=1000		" keep 100 lines of command line history
set undolevels=1000     " remember 1000 undos
set ruler				" show the cursor position all the time
set showcmd				" display incomplete commands
set showmode			" show the current mode
set incsearch			" do incremental searching

" change the mapleader from \ to ,
let mapleader=","

set hidden " hide buffers instead of closing them
noremap <leader>b :LustyJuggler<CR>

" better window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" two bangs for sudo priv
cmap w!! w !sudo tee % >/dev/null

" Don't use Ex mode, use Q for formatting
map Q gq

" Escape is so far away!
inoremap jj <Esc>
inoremap jk <Esc>
" So don't use it. Good luck!
inoremap <Esc> <nop>

" Vim medium mode!! Again, good luck!
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
	set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" Also use a custom colorscheme
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
	colorscheme solarized
    set background=dark
	if has("gui_gtk2")
		set guifont=Inconsolata\ 11
	elseif has("gui_win32")
		set guifont=Consolas:h9:cANSI
	endif
	
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically dfooooooo language-dependent indenting.
	filetype plugin indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		autocmd FileType text setlocal textwidth=78

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
					\ if line("'\"") > 1 && line("'\"") <= line("$") |
					\   exe "normal! g`\"" |
					\ endif

	augroup END
else
	set autoindent				" always set autoindenting on
endif " has("autocmd")

set list						" show tabs, newlines
set listchars=tab:>-,trail:-	" display the tabs in a pretty way

set number						" show line numbers
set cursorline					" highlight cursor line

"set rtp+=~/.vim/bundle/powerline/bindings/vim
set laststatus=2                " always show statusline
"let g:Powerline_theme = 'solarized256'
let g:Powerline_colorscheme = 'solarized256'

autocmd InsertEnter * hi Normal guibg=black
autocmd InsertLeave * hi Normal guibg=#002b36

set scrolloff=5					" always try to show 5 lines at the top and the bottom

set expandtab					" use spaces
set softtabstop=4				" use spaces
set tabstop=4					" shorten tabs
set shiftwidth=4				" shorten shift

set showmatch                   " show matching parens

set ignorecase                  " ignore case for searches
set smartcase                   " ignore case when patterns are all lower

set visualbell                  " no beeping

set title                       " change the term title

set wildignore=*.pyc

" Testing no backups or swap files
set nobackup
set noswapfile


" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
		command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
								\ | wincmd p | diffthis
endif

set pastetoggle=<F2>

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

call pathogen#infect()
