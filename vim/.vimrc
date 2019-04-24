"-------------------------------------------------------------------------------
"
" Vim/GVim/NeoVim configuration file
"
" (c) Ashwin Nanjappa 2009-2019
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

" -----------------------------------------------------------------------------
" General Settings
" -----------------------------------------------------------------------------

set number                     " Display line number column
set relativenumber             " Show current line number and relative linenum for rest
set showcmd                    " Display commands as they are typed
set autoindent                 " Turn on auto indenting
set ttyfast                    " Draw screen quickly
set showmatch                  " Jump to open when closing bracket is typed
set incsearch                  " Do incremental searching
set hlsearch                   " Highlight search matches
set encoding=utf-8             " Handle Unicode files
set autoread                   " Automatically reload file if its changed
set nowrap                     " Turn off word wrap
set foldmethod=indent          " Do code folding using indentation
set visualbell                 " Flash display instead of beeping
set tags=tags;/                " Look for tags in current directory and upward search up to root
set laststatus=2               " Always show status line
set cmdheight=1                " Height of command line
set history=1000               " Number of old commands to remember
set ruler                      " Always show cursor position
set title                      " Vim sets window title
set nomodeline                 " Ignore Vim settings embedded in source files
set mouse=a                    " Enable mouse in terminal Vim
set backup                     " Enable backup of edited files
set virtualedit+=block         " In visual block mode, allow moving beyond text into empty whitespace
set pastetoggle=<F2>           " Use F2 key to toggle paste mode
set nrformats-=octal           " Disable inc/dec of octal numbers
set ttimeout                   " Enable timeout for commands
set ttimeoutlen=100            " Do not wait too long for command completion
set display+=lastline          " Display as much as possible of last line in window
set formatoptions+=j           " Join commented lines intelligently
set hidden                     " Allow opening new buffer when current buffer is unsaved
set lazyredraw                 " Increases line scrolling speed
set linebreak                  " When line is wrapped, break at word boundary
set mousemodel=popup           " Right-button of mouse works like in Windows, not X
set winaltkeys=no              " Do not use Alt for menus in Windows GVim
set printoptions+=number:y     " Add line numbers when printing file
set cryptmethod=blowfish       " Use strongest available crypt method
set backspace=indent,eol,start " Backspace over anything in insert mode
set smarttab                   " Indent new lines smartly based on tabwidth, smarter than default
set report=0                   " Always report num of lines changed by commands like %s substitution
set tildeop                    " Use ~ as operator. Ex: ~w will change case for all chars from cursor to end of word
set path=.,**                  " Add all children of cur dir for file open searching

" These two settings together achieve the following:
" Press <tab> to autocomplete to the longest matching option.
" And display rest of matching options in statusline.
" Plus allow you to cycle through those statusline options using <tab>
set wildmenu
set wildmode=longest:full,full

" Shell to use in Vim
" Fish use needs v7.4 patch 276
if v:version == 704 && has('patch276')
    set shell=/usr/bin/fish
else
    set shell=/bin/bash
endif

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

    " GVim is light background by default, so we change it
    set background=dark
endif

" Undo
set undofile         " Undo history persists across Vim sessions
set undolevels=1000  " Number of changes to undo
set undoreload=10000 " Number of lines of undo changes to save

" Scrolling
set scrolloff=0     " Top-bottom offset during scrolling
set sidescroll=1    " Smooth side scrolling
set sidescrolloff=5 " Left-right offset during side-scrolling

" Characters for whitespace
set listchars+=tab:↦\
set listchars+=eol:↵
set listchars+=extends:»    " Line extends to right
set listchars+=precedes:«   " Line extends to left
set listchars+=trail:-      " Trailing whitespace

" Characters for filling
set fillchars+=vert:╽  " Vertical split
set fillchars+=diff:⣿  " Empty line in vimdiff

" Character for word wrap
set showbreak=↪

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
set shiftround    " When using < or >, shift to nearest indent column

" Spellcheck
set spelllang=en    " Language as International English
set spellsuggest=5  " Max number of suggestions

" Syntax highlighting
syntax on          " Turn on syntax highlighting
filetype on        " Detect filetype
filetype plugin on " Load plugin for filetype
filetype indent on " Enable indenting for filetype

" Case insensitive filename completion
if exists("&wildignorecase")
    set wildignorecase
endif

" Files to ignore on autocomplete
set wildignore=*.bin
set wildignore+=*.dat
set wildignore+=*.datA
set wildignore+=*.datB
set wildignore+=*.del
set wildignore+=*.jpg
set wildignore+=*.mat
set wildignore+=*.o
set wildignore+=*.orig
set wildignore+=*.out
set wildignore+=*.pdf
set wildignore+=*.png
set wildignore+=*.pyc
set wildignore+=*.so
set wildignore+=*.swp
set wildignore+=*.tree
set wildignore+=*/build/*
set wildignore+=tags

" -------------------------------------------------------------------------------
" Autocommands: These are executed when Vim starts
" -------------------------------------------------------------------------------

" Associate files with filetypes
"
" The correct filetype might be required by plugins to apply their features
" on the file.
augroup SetFileTypesForExtensions
    autocmd!
    autocmd BufRead,BufNewFile *.cu         set filetype=cpp
    autocmd BufRead,BufNewFile *.fbs        set filetype=idl        " FlatBuffers schema file is in IDL format
    autocmd BufRead,BufNewFile *.gp         set filetype=gnuplot
    autocmd BufRead,BufNewFile *.prototxt   set filetype=javascript
    autocmd BufRead,BufNewFile *.srt        set filetype=srt
    autocmd BufRead,BufNewFile *.vrapperrc  set filetype=vim
    autocmd BufRead,BufNewFile Dockerfile*  set filetype=dockerfile " Filetype required by dockerfile plugin
    autocmd BufRead,BufNewFile Jenkinsfile* set filetype=groovy
    autocmd BufRead,BufNewFile strace.log   set filetype=strace
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

" Jump to last position on reopening file
" From: http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Note: Common solutions on web, jump to last line, but don't remember column
augroup OnFileOpenJumpToLastPos
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
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
    autocmd Filetype cpp    setlocal commentstring=//\ %s
    autocmd Filetype cmake  setlocal commentstring=#\ %s
    autocmd Filetype matlab setlocal commentstring=%\%s
augroup END

" Set make based on filetype
augroup SetMakeForFiletype
    autocmd!
    autocmd Filetype cpp setlocal makeprg=make\ -j\ 4\ -C\ ..\/build
augroup END

" -----------------------------------------------------------------------------
" Functions
" -----------------------------------------------------------------------------

""" Function to remove trailing whitespace

fun! TrimWhitespace()

    " Save current cursor position
    let l:save_cursor = getpos('.')

    " Remove whitespace
    %s/\s\+$//e

    " Jump back to saved cursor position
    call setpos('.', l:save_cursor)
endfun

" Ex command to call above function
command! TrimWhitespace call TrimWhitespace()

" Autoformat JSON in buffer
command! FormatJSON %!python3 -m json.tool

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" From: http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

" -----------------------------------------------------------------------------
" Key remappings
" -----------------------------------------------------------------------------

" Disable arrow keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

" Move up-down screen lines, not file lines
" Useful when moving up and down wrapped lines
nnoremap j gj
nnoremap k gk

" Make mistakenly hitting F1 useful
nnoremap <F1> <nop>
inoremap <F1> <Esc>

" Use Atl-hjkl to switch between windows
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Use <C-L> to clear the highlighting of :set hlsearch
" Tip from Tim Pope
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Disable entering ex mode
map Q <nop>

" On search, highlight but do not jump ahead
" * jumps to next match, `` jumps back
nnoremap * *``

" Make Y (yank) behave like D and C
" That is, only yank from current char to EOL, not yank the entire line
nnoremap Y y$

" Jump <CTRL-]> by default jumps to first tag that matches among multiple tags
" We map this to g<CTRL-]> which instead shows list of multiple tags
nnoremap <C-]> g<C-]>

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

" Vim-Plug plugin manager
" Note: Use *only* single quotes

" Disable shallow cloning for Vim-Plug
" Cause --depth 1 fails on HTTPS repos
" This means :PlugUpdate is slower, but does not fail
let g:plug_shallow=0

call plug#begin('~/.vim/plugins_by_vimplug')
Plug 'FooSoft/vim-argwrap'                                        " Wrap and unwrap arguments using :ArgWrap
Plug 'ap/vim-buftabline'                                          " Show buffers as tabs.
Plug 'cespare/vim-toml'                                           " Syntax highlighting for TOML file format.
Plug 'dag/vim-fish'                                               " Syntax highlighting for Fish script files.
Plug 'dahu/Asif'                                                  " Required by vim-asciidoc plugin.
Plug 'dahu/vim-asciidoc'                                          " To compile ASCIIDoc files by typing :make
Plug 'dahu/vimple'                                                " Required by vim-asciidoc plugin.
Plug 'editorconfig/editorconfig-vim'                              " To apply .editorconfig settings in Vim.
Plug 'gcavallanti/vim-noscrollbar'                                " Horizontal scrollbar in statusline.
Plug 'haya14busa/incsearch.vim'                                   " Highlight ALL matches WHILE typing incsearch.
Plug 'honza/dockerfile.vim'                                       " Syntax highlighting for Dockerfile.
Plug 'itchyny/lightline.vim'                                      " Lightweight powerline/airline clone.
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Simple FZF support in Vim. Provides :FZF command.
Plug 'junegunn/fzf.vim'                                           " FZF plugin for Vim. Provides many commands.
Plug 'junegunn/vim-easy-align'                                    " Align code using :EasyAlign
Plug 'kshenoy/vim-signature'                                      " Display bookmarks visually in left-side gutter.
Plug 'majutsushi/tagbar'                                          " Class explorer using :TagBar
Plug 'mhinz/vim-signify'                                          " Show Git changed lines with marks in left-side gutter
Plug 'mileszs/ack.vim'                                            " ACK plugin, we use it for :Ag (cause ag.vim is not maintained)
Plug 'nfvs/vim-perforce'                                          " Perforce cmds on current file from inside Vim.
Plug 'scrooloose/syntastic'                                       " Syntax checking of code files (C++, Py)
Plug 'sickill/vim-monokai'                                        " Monokai colorscheme for Vim.
Plug 'simplyzhao/cscope_maps.vim'                                 " Jump to cscope tags in C/C++/CUDA files.
Plug 'thiagoalessio/rainbow_levels.vim'                           " Set fg color based on indent level.
Plug 'tpope/vim-commentary'                                       " Toggle commenting using gc.
Plug 'tpope/vim-fugitive'                                         " Show version control info in statusline.
Plug 'tpope/vim-unimpaired'                                       " Switch buffers using ]b [b
Plug 'tyru/capture.vim'                                           " Show Ex cmd output in buffer
Plug 'unblevable/quick-scope'                                     " Help to jump on f command.
Plug 'vim-latex/vim-latex'                                        " Compile LaTeX files.
Plug 'vim-scripts/AdvancedSorters'                                " Sort words in visual range with :SortWORDs
Plug 'vim-scripts/VisIncr'                                        " Dr. Chip's Vim script for increment-decrement.
Plug 'vim-scripts/groovy.vim'                                     " Syntax highligting for Groovy lang. This is used by JenkinsFile.
Plug 'vim-scripts/hgrev'                                          " Show Mercurial repo info in statusline.
call plug#end()

""" Ack.vim

" Use Ag for search
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

""" AsciiDoc

" Vim-AsciiDoc plugin sets to asciidoc by default, we change it to asciidoctor
autocmd FileType asciidoc compiler asciidoctor

" Set themes dir for asciidoctor compiler. Else plugin throws warning
let g:asciidoctor_themes_dir='~/.rbenv/versions/2.1.5/lib/ruby/gems/2.1.0/gems/asciidoctor-1.5.2/data/stylesheets'

" To stop startup error in nvim
let vimple_init_vn = 0

""" FZF

" Ctrl-P searches through MRU files
" Choosing this cause of muscle memory from CtrlP plugin
nmap <C-p> :History<cr>

" Ctrl-F searches filesystem
" Choosing this cause of muscle memory from CtrlP plugin
nmap <C-f> :Files<cr>

""" IncSearch

" Replace default mappings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)

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

""" Lightline

" Replace some of the components of Lightline statusline
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'FilenameForLightline',
      \   'percent': 'NoScrollbarForLightline'
      \ }
      \ }

" Instead of % show NoScrollbar horizontal scrollbar
function! NoScrollbarForLightline()
    return noscrollbar#statusline(20,'-','▓',['▐'],['▌'])
endfunction

" Show full path of filename
function! FilenameForLightline()
    return expand('%')
endfunction

""" NetRW

" List files like ls -l
" Tree listing was good, but would show entire old tree even when moving up
" dirs, so it was unusable.
let g:netrw_liststyle=1

" Hide banner shown at top by default
let g:netrw_banner=0

""" Colorscheme

if has("gui_running")
    colorscheme default
else
    colorscheme monokai
endif

""" QuickScope

" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""" Signify

" Instead of trying commands of all VCS, only try for these
let g:signify_vcs_list = [ 'git', 'hg' ]

" Show this symbol for lines that are deleted
let g:signify_sign_delete = "-"

""" Syntastic

" Syntastic check slows down saving files with :w
" So, below I disable all automatic syntax checks
" I manually check with :SyntasticCheck

" Turn off actively checking on buffer save or open
let g:syntastic_mode_map = {"mode": "passive", "active_filetypes": [], "passive_filetypes": []}

" Disable syntax check on :wq
let g:syntastic_check_on_wq = 0

" Disable check on buffer open and save
let g:syntastic_check_on_open = 0

" Error and warning symbols to show in left-side gutter
let g:syntastic_error_symbol   = "✗"
let g:syntastic_warning_symbol = "⚠"

" C++ compiler options to use for syntax check
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"

""" Tagbar

" Keyboard shortcut \tb to open Tagbar
nnoremap <Leader>tb :TagbarToggle<CR>

" Remove help and whitespace lines in Tagbar window
let g:tagbar_compact = 1

" Show tags in order they are in file
let g:tagbar_sort = 0

" Tagbar width
let g:tagbar_width = 50

" Open up folded nested tags to show chosen tag
let g:tagbar_autoshowtag = 1

" -----------------------------------------------------------------------------
" External tools
" -----------------------------------------------------------------------------

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

" ------------------------------------------------------------------------------
