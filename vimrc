" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim from Jae :D
"

" Appearance
set number         " show line numbers
set laststatus=2   " always show status line

" Show a few lines of context at the top or bottom
" - vim's default is 5, but Jae likes 1
set scrolloff=1

" Buffer switching using Cmd-Left/Right or Alt-Left/Right
:nnoremap <D-Right> :bnext<CR>
:nnoremap <M-Right> :bnext<CR>
:nnoremap <D-Left> :bprevious<CR>
:nnoremap <M-Left> :bprevious<CR>
" and don't let MacVim remap them
if has("gui_macvim")
    let macvim_skip_cmd_opt_movement = 1
endif

" Tab settings
set tabstop=8      " do NOT change this; see help page -- run :h 'tabstop'
set shiftwidth=4   " when coding, auto-indent by 4 spaces, a la K&R
set expandtab      " always replace tab with spaces,
autocmd FileType make setlocal noexpandtab         " except for Makefile

" Text file settings
" - automatically indent lines according to previous lines
" - replace tab with 8 spaces
" - when I hit tab key, move 2 spaces instead of 8
" - wrap text if I go longer than 80 columns
" - check spelling
autocmd FileType text setlocal autoindent expandtab softtabstop=2 textwidth=80 spell spelllang=en_us

" Don't do spell-checking on Vim help files
autocmd FileType help setlocal nospell

" Create ~/.vimbackup (if not there already) to store backup, undo, swap files
silent! !mkdir -p ~/.vimbackup

" Prepend ~/.vimbackup to backupdir & undodir, so that Vim will look for
" that directory before littering the current dir with backup and undo files
set backupdir^=~/.vimbackup
set undodir^=~/.vimbackup

" Also use ~/.vimbackup for swap files. The trailing // tells Vim to
" incorporate full path into swap file names
set dir^=~/.vimbackup//

" Ignore case when searching
" - override this setting by tacking on \c or \C to your search term to make
"   your search always case-insensitive or case-sensitive, respectively.
set ignorecase

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

"
" End of Jae's Vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
