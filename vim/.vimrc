"-------------------------------------------------------------------------------
"
" Vim/GVim/NeoVim configuration file
"
" Maintained by Ashwin Nanjappa since 2009
"
" Note: .gvimrc is not needed.
"
" On Windows:
" 1. Put this vimfiles directory in $USERPROFILE
" 2. Put _vimrc file in %HOMEDRIVE%%HOMEPATH% with the line:
"    source $USERPROFILE/vimfiles/vimrc
"
" On Linux:
" $ ln -s ~/.vim/vimrc .vimrc
"
"-------------------------------------------------------------------------------

" Open ViM in non-Vi-compatible mode. Needed for all the ViM goodness!
" Note: This changes other settings, so MUST be at the top.

set nocompatible

"-------------------------------------------------------------------------------

" General Settings

set number                 " Display line numbers
set relativenumber         " Hybrid line number display
set showcmd                " Display commands as they are typed
set autoindent             " Turn on auto indenting
set ttyfast                " Draw screen quickly
set wildmenu               " Show matches in command auto-completion
set showmatch              " Jump to open when closing bracket is typed
set incsearch              " Do incremental searching
set ignorecase             " Ignore case in search patterns
set smartcase              " Case-sensitive search only on uppercase character
set hlsearch               " Highlight search matches
set encoding=utf-8         " Handle Unicode files
set autoread               " Automatically reload file if its changed
set nowrap                 " Turn off word wrap
set foldmethod=indent      " Do code folding using indentation
set visualbell             " Flash display instead of beeping
set tags=tags;/            " Look for tags in current directory and upward search up to root
set laststatus=2           " Always show status line
set cmdheight=1            " Height of command line
set history=1000           " Number of old commands to remember
set ruler                  " Always show cursor position
set title                  " Vim sets window title
set nomodeline             " Ignore Vim settings embedded in source files
set mouse=a                " Enable mouse in terminal Vim
set backup                 " Enable backup of edited files
set gdefault               " Substitute in entire line by default
set virtualedit=block      " Allow virtual editing in Visual mode
set pastetoggle=<F2>       " Use F2 key to toggle paste mode
set nrformats-=octal       " Disable inc/dec of octal numbers
set ttimeout               " Enable timeout for commands
set ttimeoutlen=100        " Do not wait too long for command completion
set display+=lastline      " Display as much as possible of last line in window
set formatoptions+=j       " Join commented lines intelligently
set hidden                 " Allow opening new buffer when current one is unsaved
set lazyredraw             " Increases line scrolling speed
set linebreak              " When line is wrapped, break at word boundary
set mousemodel=popup       " Right-button of mouse works like in Windows, not X
set winaltkeys=no          " Do not use Alt for menus in Windows GVim
set printoptions+=number:y " Add line numbers when printing file

"-------------------------------------------------------------------------------

" GVim settings

if has("gui_running")
    " Window size
    set lines=999 columns=150

    " In GUI mode
    set guioptions-=a
    set guioptions-=A
    set guioptions-=aA

    " GVim font
    set guifont=Ubuntu\ Mono\ 10
endif

"-------------------------------------------------------------------------------

" Disable autocopy of selected text to X clipboard in terminal mode
set clipboard-=autoselect

" Case insensitive filename completion
if exists("&wildignorecase")
    set wildignorecase
endif

" Undo
set undofile         " Undo history persists across Vim sessions
set undolevels=1000  " Number of changes to undo
set undoreload=10000 " Number of lines of undo changes to save

" Scrolling
set scrolloff=2     " Top-bottom offset during scrolling
set sidescroll=1    " Smooth side scrolling
set sidescrolloff=5 " Left-right offset during side-scrolling

" Characters for whitespace
set listchars+=tab:↦\
set listchars+=eol:↵
set listchars+=extends:»    " Line extends to right
set listchars+=precedes:«   " Line extends to left

" Characters for filling
set fillchars+=vert:╽  " Vertical split
set fillchars+=diff:⣿  " Empty line in vimdiff

" Directories

" On Linux
if has("unix")
    set backupdir=~/.vim/tmp/backup//      " Directory for backup files
    set directory=~/.vim/tmp/swap//        " Directory for swap files
    set undodir=~/.vim/tmp/undo//          " Directory for undo files
" On Windows
else
    set runtimepath+=$USERPROFILE/vimfiles " Directory for Vim plugins
    set viminfo+=n$LOCALAPPDATA/_viminfo   " Directory for viminfo
    set backupdir=$TEMP                    " Directory for backup files
    set directory=$TEMP                    " Directory for swap files
    set undodir=$TEMP                      " Directory for undo files
endif

" Tab (4 spaces)
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab     " Insert spaces for tab

" Spellcheck
set spelllang=en    " Language as International English
set spellsuggest=5  " Max number of suggestions

" Syntax highlighting
syntax on          " Turn on syntax highlighting
filetype on        " Detect filetype
filetype plugin on " Load plugin for filetype
filetype indent on " Enable indenting for filetype

" Files to ignore on autocomplete
set wildignore=*.bin,*/build/*,*.dat,*.datA,*.datB,*.del,*.jpg,*.mat,*.o,*.out,*.orig,*.pdf,*.png,*.pyc,*.so,*.swp,*.tree

"-------------------------------------------------------------------------------

" Autocommands

" Associate files with filetypes based on extensions
augroup SetFileTypesForExtensions
    autocmd!
    autocmd BufRead,BufNewFile *.cu        set filetype=cpp
    autocmd BufRead,BufNewFile *.gp        set filetype=gnuplot
    autocmd BufRead,BufNewFile *.srt       set filetype=srt
    autocmd BufRead,BufNewFile *.strace    set filetype=strace
    autocmd BufRead,BufNewFile *.vrapperrc set filetype=vim
augroup END

" Show cursorline only in active window
augroup CursorLineOnlyInActive
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave *                      setlocal nocursorline
augroup END

" Show guideline only in insert mode
augroup GuidelineOnlyInInsertMode
  autocmd!
  autocmd InsertEnter * setlocal colorcolumn=80
  autocmd InsertLeave * setlocal colorcolumn=0
augroup END

" Jump to last remembered position on reopening file
augroup OnFileOpenJumpToLastPos
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" Enable line wrap in TeX files
augroup EnableLineWrapForTeXFiles
    autocmd!
    autocmd FileType tex setlocal wrap
augroup END

" Keep all folds open when a file is opened
augroup OpenAllFoldsOnFileOpen
    autocmd!
    autocmd BufRead * normal zR
augroup END

" Open Quickfix window automatically after running :make
augroup OpenQuickfixWindowAfterMake
    autocmd!
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup END

" When TagBar window is open, running :make makes QuickFix window appear in it
" Fix to force QuickFix to open at bottom
augroup ForceQuickFixToOpenAtBottom
    autocmd!
    autocmd FileType qf wincmd J
augroup END

" Set comment strings based on filetype
augroup SetCommentForFiletype
    autocmd!
    autocmd Filetype cpp   setlocal commentstring=//\ %s
    autocmd Filetype cmake setlocal commentstring=#\ %s
augroup END

" Set make based on filetype
augroup SetMakeForFiletype
    autocmd!
    autocmd Filetype cpp setlocal makeprg=make\ -j\ 4\ -C\ ..\/build
augroup END

"-------------------------------------------------------------------------------

" Keys

" Use <C-L> to clear the highlighting of :set hlsearch
" Tip from Tim Pope
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Backspace over anything in insert mode
set backspace=indent,eol,start

" Disable entering ex mode
map Q <nop>

" On search, highlight but do not jump ahead
nnoremap * *``

" Move up-down screen lines, not file lines
nnoremap j gj
nnoremap k gk

" Disable arrow keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Make mistakenly hitting F1 useful
nnoremap <F1> <nop>
inoremap <F1> <Esc>

" Make Y (yank) behave like D and C
" That is, only yank from current char to EOL, not yank the entire line
nnoremap Y y$

" Use Atl-hjkl to switch between windows and terminals (in NeoVim)

if has('nvim')
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
endif
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"-------------------------------------------------------------------------------

""" Plugins

" Vim-Plug plugin manager
" Note: Use *only* single quotes

call plug#begin('~/.vim/plugins_by_vimplug')
Plug 'bling/vim-airline'            " Display beautiful statusline
Plug 'dag/vim-fish'                 " Editing Fish script files
Plug 'dahu/Asif'                    " Required by vim-asciidoc plugin
Plug 'dahu/vim-asciidoc'            " To compile ASCIIDoc files
Plug 'dahu/vimple'                  " Required by vim-asciidoc plugin
Plug 'jeetsukumaran/vim-filebeagle' " Explore directory around current file
Plug 'junegunn/vim-easy-align'      " Align lines along certain chars
Plug 'justinmk/vim-syntax-extra'    " Enhanced syntax coloring for C++
Plug 'kien/ctrlp.vim'               " Quickly open recent files
Plug 'kshenoy/vim-signature'        " Display bookmarks visually on left side
Plug 'majutsushi/tagbar'            " Display classes, methods and variables in file
Plug 'mhinz/vim-signify'            " Visually mark lines with uncommitted changes
Plug 'rking/ag.vim'                 " Search files using Ag
Plug 'scrooloose/syntastic'         " Syntax checking of file
Plug 'tejr/sahara'                  " Sahara colorscheme for Vim
Plug 'tpope/vim-commentary'         " Tim Pope's plugin to toggle commenting using gc
Plug 'tpope/vim-fugitive'           " Show version control in statusline
Plug 'tpope/vim-unimpaired'         " Easy commands to move between buffers
Plug 'unblevable/quick-scope'       " Help to jump on f command
Plug 'vim-latex/vim-latex'          " Compile LaTeX files
Plug 'vim-scripts/hgrev'            " Show Mercurial repo info in statusline
Plug 'xolox/vim-easytags'           " Run ctags automatically on file save
Plug 'xolox/vim-misc'               " Required by easytags plugin
call plug#end()

""" Airline

" Show buffers as tabs
let g:airline#extensions#tabline#enabled = 1

" Show full path in statusline
let g:airline_section_c = '%F'

" In X, we can use fancy colors and Unicode symbols
if &term =~ "xterm" || has ("gui_running")

    " Define dict before settings symbols in it
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    let g:airline_left_sep                        = '▶'
    let g:airline_right_sep                       = '◀'
    let g:airline_symbols.linenr                  = '␤ '
    let g:airline#extensions#tabline#left_sep     = '▶'
    let g:airline#extensions#tabline#left_alt_sep = '▶'
    " Show buffers as tabs
    let g:airline#extensions#tabline#enabled      = 1

" In VT, we can only use simple ASCII and 8 color themes
else

    let g:airline_theme                           = 'hybrid'
    let g:airline_left_sep                        = ' '
    let g:airline_right_sep                       = ' '
    let g:airline#extensions#tabline#left_sep     = ' '
    let g:airline#extensions#tabline#left_alt_sep = ' '

endif

""" AsciiDoc

" Vim-AsciiDoc plugin sets to asciidoc by default, we change it to asciidoctor
autocmd FileType asciidoc compiler asciidoctor

" Set themes dir for asciidoctor compiler. Else plugin throws warning
let g:asciidoctor_themes_dir='~/.rbenv/versions/2.1.5/lib/ruby/gems/2.1.0/gems/asciidoctor-1.5.2/data/stylesheets'

""" CtrlP

" Open MRU by default
let g:ctrlp_cmd = 'CtrlPMRU'

" Search from CWD upwards when finding files
" Faster than default mode which goes down to .git/.hg and finds from there
let g:ctrlp_working_path_mode = ' '

" Show hidden files in find mode
let g:ctrlp_show_hidden = 1

""" EasyTags

let g:easytags_dynamic_files = 1         " Read and update the project's tag file
let g:easytags_events = ['BufWritePost'] " Update only on file write

""" LaTeX

let g:Tex_DefaultTargetFormat    = "pdf" " Compile to PDF on \ll
let g:Tex_MultipleCompileFormats = "pdf" " Enable multi-compile for PDF (Ex: for \cite)
let g:Tex_CompileRule_pdf        = "pdflatex -interaction=nonstopmode --shell-escape $*"

" Enable words with - and _ as keywords in LaTeX
let g:tex_isk="48-57,-,_,a-z,A-Z,192-255"

" Compile with XeTeX on \lx
function SetXeTex()
    let g:Tex_CompileRule_pdf = "xelatex -interaction=nonstopmode --shell-escape $*"
endfunction
map <Leader>lx :<C-U>call SetXeTex()<CR>

" Disable folding (which this plugin does by default)
let g:Tex_FoldedSections     = ""
let g:Tex_FoldedEnvironments = ""
let g:Tex_FoldedMisc         = ""

""" Man

" Open man page for word under cursor
map <leader>k <Plug>(Man)

""" NetRW

let g:netrw_liststyle=3 " Tree style listing
let g:netrw_banner=0    " Hide banner shown at top

""" Sahara

colorscheme sahara

""" Signify

let g:signify_sign_delete = "-"

""" Syntastic

" Disable syntax check on file save
let g:syntastic_check_on_wq          = 0
let g:syntastic_error_symbol         = "✗"
let g:syntastic_warning_symbol       = "⚠"
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"

""" Tagbar

nnoremap <Leader>tb :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_sort    = 0

"-------------------------------------------------------------------------------

""" External tools

" Ranger
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RagerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    exec 'silent !ranger --choosefiles=' . shellescape(temp)
    if !filereadable(temp)
        " Nothing to read.
        redraw!
        return
    endif
    let names = readfile(temp)
    if empty(names)
        " Nothing to open.
        redraw!
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>

""" Zeal

" Query word for word under cursor on \z
nnoremap <Leader>z :!zeal --query "<cword>"&<CR><CR>

"-------------------------------------------------------------------------------
