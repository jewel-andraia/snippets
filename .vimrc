" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set smartindent  "autoindent          " always set autoindenting on
set noexpandtab
set tabstop=8
set shiftwidth=4
set nosmarttab

set showmatch

set nobackup

set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch
set number

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
" ANDY SEZ: screw the if
syntax on


" Only do this part when compiled with support for autocommands.
"if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  "filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  "autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  "autocmd BufReadPost *
    "\ if line("'\"") > 0 && line("'\"") <= line("$") |
    "\   exe "normal g`\"" |
    "\ endif

"endif " has("autocmd")

  "causes vim not to wrap sentences
  "toggles matching for () {} [] ''
"set sm!

  "toggles ignore case for searches
set ic!

nmap j gj
nmap k gk

" We're ignoring the fact that this may not always be GUI.
set mouse=a

dd;;;;-;;;;;;-;;;;;!}~/scmindent.scm
ddp ]q O;;;;;-;;;;;v}=/;;;;;-;;;;;
map [l :set lisp autoindent
map ]l :set nolisp smartindent
map W b
map ~
map ~
