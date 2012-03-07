" ----------------------------------------------------------------------------
"          FILE: .vimrc
"   DESCRIPTION: Vim configuration file
"        AUTHOR: Sorin Ionescu <sorin.ionescu@gmail.com>
"       VERSION: 1.3.11
" ----------------------------------------------------------------------------

" Version Check ---------------------------------------------------------- {{{

if v:version < 703
    echo '.vimrc requires Vim 7.3 or greater'
    finish
endif

" }}}
" Bundles ---------------------------------------------------------------- {{{

" Turn off vi compatibility.
set nocompatible

" Turning filetype off is necessary to load ftdetect files.
filetype off

" Install Vundle for bundles to work:
"     git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" General ---------------------------------------------------------------- {{{

" Manages Vim bundles.
Bundle 'gmarik/vundle'

" A better status bar.
Bundle 'Lokaltog/vim-powerline'

" Identifies file indentation.
Bundle 'Raimondi/YAIFA'

" Aligns text.
Bundle 'godlygeek/tabular'

" Tree undo.
Bundle 'sjl/gundo.vim'

" Use the repeat command (.) with plugins.
Bundle 'tpope/vim-repeat'

" Provides pairs of bracket mappings for buffer, file navigation and editing.
Bundle 'tpope/vim-unimpaired'

" Renames the file in the current buffer.
Bundle 'vim-scripts/Rename2'

" Kills a  buffer without closing the split.
Bundle 'vim-scripts/bufkill.vim'

" Emacs-style scratch buffer.
Bundle 'vim-scripts/scratch'

" Escape ANSI codes.
Bundle 'vim-scripts/AnsiEsc.vim'

" Resizes the current buffer to accommodate its content.
Bundle 'roman/golden-ratio'

" Show marks in a gutter.
Bundle 'garbas/vim-showmarks'

" Easily navigate to a letter.
Bundle 'Lokaltog/vim-easymotion'

" History of yanks, changes, and deletes.
Bundle 'vim-scripts/YankRing.vim'

" }}}
" Color Scheme ----------------------------------------------------------- {{{

" A usable color scheme.
Bundle 'altercation/vim-colors-solarized'

" }}}
" Syntax ----------------------------------------------------------------- {{{

Bundle 'tpope/vim-markdown'
" Bundle 'timcharper/textile.vim'
" Bundle 'andrewschleifer/nu-vim'

" }}}
" File Navigation -------------------------------------------------------- {{{

" Buffer and file navigation.
Bundle 'kien/ctrlp.vim'

" Tag manager.
" Bundle 'kien/tabman.vim'

" }}}
" Programming ------------------------------------------------------------ {{{

" A better paste.
Bundle 'sickill/vim-pasta'

" A better grep.
Bundle 'mileszs/ack.vim'

" Searches a file for todo, fixme.
Bundle 'vim-scripts/TaskList.vim'

" Browse tags of source code files.
Bundle 'majutsushi/tagbar'

" Syntax checking through external checkers.
Bundle 'scrooloose/syntastic'

" Comment and uncomment code.
Bundle 'tomtom/tcomment_vim'

" Insert-completion via the tab key.
Bundle 'ervandew/supertab'

" Colors parenthesis.
Bundle 'kien/rainbow_parentheses.vim'

" Surround selection with quotes, parenthesis, etc.
Bundle 'tpope/vim-surround'

" Automatically closes quotes, parenthesis, brackets, etc.
Bundle 'Raimondi/delimitMate'

" Automatically closes functions, blocks, etc.
Bundle 'tpope/vim-endwise'

" Allows for writing user-defined text objects.
Bundle 'kana/vim-textobj-user'

" Indentation-based text objects.
Bundle 'michaeljsmith/vim-indent-object'

" Displays indent levels.
Bundle 'nathanaelkane/vim-indent-guides'

" Configures % to match more than just single characters.
Bundle 'vim-scripts/matchit.zip'

" TextMate-like snippets.
" Bundle 'msanders/snipmate.vim'

" Snippets for snipMate.
" Bundle 'scrooloose/snipmate-snippets'

" }}}
" Version Control -------------------------------------------------------- {{{

" Git syntax highlighting.
Bundle 'tpope/vim-git'

" Git integration.
Bundle 'tpope/vim-fugitive'

" Git commit browser.
Bundle 'int3/vim-extradite'

" Gist paste.
Bundle 'mattn/gist-vim'

" Merge conflict resolution.
Bundle 'sjl/threesome.vim'

" }}}
" Web Development -------------------------------------------------------- {{{

" Expands condensed HTML.
Bundle 'mattn/zencoding-vim'

" Translates markdown into HTML for previewing.
Bundle 'nelstrom/vim-markdown-preview'

" HTML langauge.
Bundle 'othree/html5.vim'

" Validate HTML files.
Bundle 'sorin-ionescu/vim-htmlvalidator'

" CSS language.
Bundle 'https://github.com/ChrisYip/Better-CSS-Syntax-for-Vim.git'

" LESS (dynamic CSS) language.
" Bundle 'groenewege/vim-less'

" JavaScript language.
Bundle 'pangloss/vim-javascript'

" Compiler for JavaScript Lint.
" Bundle 'vim-scripts/compilerjsl.vim'

" jQuery JavaScript framework.
" Bundle 'vim-scripts/jQuery'

" CoffeeScript language.
" Bundle 'kchmck/vim-coffee-script'

" }}}
" Ruby/Rails ------------------------------------------------------------- {{{

" Ruby langauge.
Bundle 'vim-ruby/vim-ruby'

" Ruby refactoring tool (dependency: matchit).
" Bundle 'ecomba/vim-ruby-refactoring'

" Text object for selecting ruby blocks (dependency: matchit).
Bundle 'nelstrom/vim-textobj-rubyblock'

" Quickly converts Ruby blocks between {} and begin/end.
Bundle 'sorin-ionescu/vim-ruby-block-conv'

" Debug Ruby scripts and applications.
" Bundle 'astashov/vim-ruby-debugger'

" Runs bundler commands.
" Bundle 'tpope/vim-bundler'

" Runs rake commands.
" Bundle 'tpope/vim-rake'

" Ruby on Rails application development.
" Bundle 'tpope/vim-rails'

" Haml, Sass, and SCSS template langauges.
" Bundle 'tpope/vim-haml'

" Liquid template langauge.
" Bundle 'tpope/vim-liquid'

" Runs Ruby tests, RSpec, shoulda, cucumber.
" Bundle 'janx/vim-rubytest'

" Runs RSpec tests (dependency: hpricot gem).
" Bundle 'skwp/vim-rspec'

" A macro behavior-driven development testing framework.
" Bundle 'tpope/vim-cucumber'

" A micro behavior-driven development testing framework.
" Bundle 'tsaleh/vim-shoulda'

" }}}
" Python ----------------------------------------------------------------- {{{

" Almost everything needed for Python programming.
" Bundle 'klen/python-mode'

" }}}
" Org-Mode --------------------------------------------------------------- {{{

" Emacs Org-Mode for Vim.
" Bundle 'jceb/vim-orgmode'

" }}}

" }}}
" General Settings ------------------------------------------------------- {{{

" SECURE: Do not parse mode comments in files.
set modelines=0

" Large undo levels.
set undolevels=1000

" Size of command history.
set history=50

" Always use unicode.
set encoding=utf8

" Share the clipboard.
" set clipboard+=unnamed

" Fix backspace.
set backspace=indent,eol,start

" Keep a backup file.
set backup

" Store backup files in one place.
set backupdir^=$HOME/.vim/backup//

" Store swap files in one place.
set dir^=$HOME/.vim/swap//

" Store undo files in one place.
set undodir^=$HOME/.vim/undo//

" Store view files in one place.
set viewdir^=$HOME/.vim/view//

" Save undo tree.
set undofile

" Allow undoing a reload from disk.
set undoreload=1000

" Auto read externally modified files.
set autoread

" Auto write before certain commands.
set autowrite

" Set spell check language.
set spelllang=en_au

" Save battery by letting OS flush to disk.
set nofsync

" Set the default shell.
" set shell=bash

" Leaders ---------------------------------------------------------------- {{{

" Comma is easier to access than backslash.
let mapleader = ','

" Semicolon is second-easier to type than backslash.
let maplocalleader = ';'

" }}}

" }}}
" Presentation ----------------------------------------------------------- {{{

" Never let a window be less than 1px.
set winminheight=1

" Show short messages, no intro.
set shortmess=aIoO

" Show the current mode.
set showmode

" Show last command.
set showcmd

" Scroll n lines before vertical edge.
set scrolloff=3

" Scroll n lines before horizontal edge.
set sidescroll=3

" Page on extended output.
set more

" Ring bell on error messages.
set errorbells

" Show visual cue on error messages.
set visualbell

" Don't keep windows at equal size.
set noequalalways

" Split window appears below the current one.
set splitbelow

" Split window appears right the current one.
set splitright

" Line break at the characters in breakat.
set linebreak

" Show ↪ at the beginning of wrapped lines.
let &showbreak=nr2char(8618).' '

" Fast scrolling when on a decent connection.
set ttyfast

" Do not draw while executing macros.
set lazyredraw

" Set keys move cursor to next/previous line.
set ww+=<,>,[,]

" Show the cursor position.
set ruler

" Show how far a line is from current line.
" set relativenumber

" Allow hidden buffers.
set hidden

" Show matching parenthesis.
set showmatch

" Match for 3 tenths of a second.
set matchtime=3

" Pairs to match.
set matchpairs+=<:>

" Highlight the current line.
set cursorline

" Print syntax highlighting.
set printoptions+=syntax:y

" Print line numbers.
set printoptions+=number:y

" Enable error jumping.
set cf

" Enable syntax highlighting.
syntax on

" Detect file type.
filetype on

" Enable file indenting.
filetype indent on

" Load syntax files for better indenting.
filetype plugin indent on

" Color Scheme ----------------------------------------------------------- {{{

" Set the color scheme.
try
    if match($ITERM_PROFILE, 'Dark') != -1
        set background=dark
    elseif match($ITERM_PROFILE, 'Light') != -1
        set background=light
    else
        set background=dark
    endif
    colorscheme solarized
catch /E185:/
    colorscheme default
endtry

" }}}
" User Interface --------------------------------------------------------- {{{

if has('gui_running')
    " Use a good font.
    set guifont=Monaco\ for\ Powerline:h12

    " Enable menu bar.
    set guioptions+=m

    " Disable the tool bar.
    set guioptions-=T

    " Disable left scrollbar.
    set guioptions-=l

    " Disable left scrollbar if split is present.
    set guioptions-=L

    " Disable right scrollbar.
    set guioptions-=r

    " Disable right scrollbar if split is present.
    set guioptions-=R

    " Do not auto copy selection to clipboard.
    set guioptions-=a

    if has('gui_macvim')
        " Transparent background.
        set transparency=5

        " Real full screen.
        set fuopt+=maxvert,maxhorz

        " Shift+Arrows selection.
        let macvim_hig_shift_movement = 1

        " Command+Shift+Left.
        macm Window.Select\ Previous\ Tab key=<D-S-Left>

        " Command+Shift+Right.
        macm Window.Select\ Next\ Tab key=<D-S-Right>
    endif
endif

if has('mouse')
    " Enable mouse everywhere.
    set mouse=a

    " Show a pop-up for right-click.
    set mousemodel=popup_setpos

    " Hide mouse while typing.
    set mousehide
endif

" }}}
" Window Title ----------------------------------------------------------- {{{
if has('title') && (has('gui_running') || &title)
    " Set the title.
    set titlestring=

    " File name.
    set titlestring+=%f\ "

    " Flags.
    set titlestring+=%h%m%r%w

    " Program name.
    set titlestring+=\ -\ %{v:progname}

    " Working directory.
    set titlestring+=\ -\ %{substitute(getcwd(),\ $HOME,\ '~',\ '')}
endif

" }}}
" Terminal Settings ------------------------------------------------------ {{{

if &term =~ 'xterm'
    if &termencoding == ''
        set termencoding=utf-8
    endif

    if has('title')
        " Restore the title of the shell upon exit.
        let &titleold = 'Terminal'

        " Set the title.
        set title
    endif

    if has('mouse')
        " Terminal type for mouse recognition.
        set ttymouse=xterm2
    endif

    " Restore screen on exit.
    set restorescreen

    " Terminal in 'termcap' mode.
    set t_ti=7[r[?47h

    " Terminal out of 'termcap mode.
    set t_te=[?47l8
endif

" }}}
" Status Line ------------------------------------------------------------ {{{

" Always show status.
set laststatus=2

" Disable status line fill chars.
set fillchars+=stl:\ ,stlnc:\ " Space.

" }}}

" }}}
" Search and Replace ----------------------------------------------------- {{{

" Show partial matches as search is entered.
set incsearch

" Highlight search patterns.
set hlsearch

" Enable case insensitive search.
set ignorecase

" Disable case insensitivity if mixed case.
set smartcase

" Wrap to top of buffer when searching.
set wrapscan

" Make search and replace global by default.
set gdefault

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" Keep search matches in the middle of the window.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Keep jumps in the middle of the window.
nnoremap g, g,zz
nnoremap g; g;zz

" Open a QuickFix window for the last search.
nnoremap <silent> <Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Ack last search.
nnoremap <silent> <Leader>? :execute "Ack! '" .
    \ substitute(
        \ substitute(
            \ substitute(
                \ @/, "\\\\<", "\\\\b", ""),
            \ "\\\\>", "\\\\b", ""),
        \ "\\\\v", "", "") .
    \ "'"<CR>

" }}}
" Whitespace ------------------------------------------------------------- {{{

" Do not select the end of line.
set selection=old

" Expand tabs into spaces.
set expandtab

" Set tab to equal 4 spaces.
set tabstop=4

" Set soft tabs equal to 4 spaces.
set softtabstop=4

" Set auto indent spacing.
set shiftwidth=4

" Shift to the next round tab stop.
set shiftround

" Insert spaces in front of lines.
set smarttab

" Copy indent from the current line.
set autoindent

" Wrap text.
set wrap

" Maximum line width before wrapping.
set textwidth=85

" Describes how auto formatting is to be done.
set formatoptions=qrn1

" Allow virtual editing in visual block mode.
set virtualedit+=block

" Invisible Characters ----------------------------------------------------{{{

" Do not show invisible characters.
set nolist

" List of characters to show instead of whitespace.
set listchars=tab:▸\ ,eol:¬,trail:-,extends:❯,precedes:❮

" Highlight VCS conflict markers.
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" }}}
" Folding ---------------------------------------------------------------- {{{

" Enable folding.
set foldenable

" Syntax dictates folding.
set foldmethod=syntax

" Use a one level fold.
set foldlevel=0

" Do not nest more than 2 folds.
set foldnestmax=2

" Focus the current fold.
nnoremap <Leader>z zMzvzz

" Make zO recursively open the top level fold regardless of cursor placement.
nnoremap zO zCzO

" Credit: Steve Losh
function! SJLFoldText()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " Expand tabs into spaces.
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . ' ...' .
        \ repeat(" ",fillcharcount) .
        \ foldedlinecount . ' ...' . ' '
endfunction
set foldtext=SJLFoldText()

" }}}
" File Name Auto Completion ---------------------------------------------- {{{

" Show a list entries.
set wildmenu

" Enable completion on tab.
set wildchar=<Tab>

" Insert mode completion.
set completeopt=longest,menu,preview

" Wildcard expansion completion.
set wildmode=list:longest,list:full

" Keyword completion for when Ctrl-P and Ctrl-N are pressed.
set complete=.,t

" Completion Ignored Files ----------------------------------------------- {{{

" VCS directories.
set wildignore+=.hg,.git,.svn

" LaTeX intermediate files.
set wildignore+=*.aux,*.out,*.toc

" Binary images.
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

" Lua byte code.
set wildignore+=*.luac

" Compiled object files.
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest

" Python byte code.
set wildignore+=*.pyc

" Compiled spelling lists.
set wildignore+=*.spl

" Backup, auto save, swap, and view files.
set wildignore+=*~,#*#,*.sw?,*=

" Mac OS X.
set wildignore+=*.DS_Store

" }}}

" }}}
" Auto Commands ---------------------------------------------------------- {{{

" Auto save on lost focus. DISABLED: Closes help file when focus is lost.
" au FocusLost * silent bufdo if !empty(bufname('%')) && !&ro | update | endif
" au FocusLost * :wa

" Remember folds."
set viewoptions=folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Switch the CWD to the current buffer.
" au BufEnter * lcd %:p:h

" Resize splits when the window is resized.
au VimResized * exe "normal! \<c-w>="

" Strip trailing whitespace.
au BufWritePre,FileWritePre,FileAppendPre,FilterWritePre *
    \ call StripTrailingWhitespace()

" }}}
" File Settings ---------------------------------------------------------- {{{

" BASH ------------------------------------------------------------------- {{{

aug ft_bash
    au!
    au BufNewFile,BufRead bash-fc-* setlocal filetype=sh
    setlocal tabstop=2 softtabstop=2 shiftwidth=2
aug end

" }}}
" CSS -------------------------------------------------------------------- {{{

aug ft_css
    au!
    au BufNewFile,BufRead *.less setlocal filetype=less

    " Use cc to change lines without borking the indentation.
    au BufNewFile,BufRead *.css,*.less nnoremap <buffer> cc ddko

    " Use <Leader>S to sort properties.
    au BufNewFile,BufRead *.css,*.less
        \ nnoremap <buffer> <LocalLeader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<CR> insert a pair of brackets in such a way that the cursor is
    " correctly positioned inside of them and the following code doesn't get
    " unfolded.
    au BufNewFile,BufRead *.css,*.less
        \ inoremap <buffer> {<CR> {}<left><CR>.<CR><esc>kA<bs><tab>
aug end

" }}}
" Git -------------------------------------------------------------------- {{{

aug ft_git
    au!
    au FileType git* setlocal noexpandtab tabstop=4 shiftwidth=4

" Fugitive --------------------------------------------------------------- {{{

    " Jump to the last known position when reopening a file.
    au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif

    " Map '..' to go up a directory in fugitive tree/blob buffers.
    au User fugitive
    \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
    \   nnoremap <buffer> .. :edit %:h<CR> |
    \ endif

    " Auto-clean fugitive buffers.
    au BufReadPost fugitive://* set bufhidden=delete

    " }}}

aug end

" }}}
" HTML ------------------------------------------------------------------- {{{

aug ft_html
    au!
    au FileType html compiler html
    inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<CR>a
aug end

" }}}
" Mail-------------------------------------------------------------------- {{{

aug ft_mail
    au!
    au Filetype mail setlocal spell
aug end

" }}}
" Markdown --------------------------------------------------------------- {{{

aug ft_markdown
    au!
    au BufNewFile,BufRead *.m*down setlocal filetype=markdown
aug end

" }}}
" Mercurial -------------------------------------------------------------- {{{

aug ft_mercurial
    au!
    au BufNewFile,BufRead .hgrc,hgrc,Mercurial.ini setlocal filetype=dosini
aug end

" }}}
" Python ----------------------------------------------------------------- {{{

aug ft_python
    au!
    au FileType python
        \ noremap <buffer> <LocalLeader>rr :RopeRename<CR>
        \ vnoremap <buffer> <LocalLeader>rm :RopeExtractMethod<CR>
        \ noremap <buffer> <LocalLeader>ri :RopeOrganizeImports<CR>
        \ setlocal
            \ omnifunc=pythoncomplete#Complete
            \ tabstop=4
            \ softtabstop=4
            \ shiftwidth=4
            \ textwidth=79
            \ colorcolumn=80

        " Pydoc
        au FileType python noremap <buffer> <
        au FileType python noremap <buffer> <LocalLeader>ds :call ShowPyDoc('<C-R><C-W>', 1)<CR>
aug end

" }}}
" Python (Django) -------------------------------------------------------- {{{

aug ft_django
    au!
    au BufNewFile,BufRead dashboard.py normal! zR
    au BufNewFile,BufRead settings.py setlocal foldmethod=marker
    au BufNewFile,BufRead urls.py
        \ setlocal nowrap
        \ normal! zR
    au BufNewFile,BufRead admin.py,urls.py,models.py,views.py,settings.py,forms.py
        \ setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py
        \ setlocal filetype=python.django foldmethod=marker
aug end

" }}}
" Text ------------------------------------------------------------------- {{{

aug ft_text
    au!
    " Enable soft-wrapping for text files
    au FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist
aug end

" }}}
" Vagrant ---------------------------------------------------------------- {{{

aug ft_vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set filetype=ruby
aug end

" }}}
" Vim -------------------------------------------------------------------- {{{

aug ft_vim
    au!
    au FileType vim,help setlocal textwidth=78
    au FileType vim setlocal foldmethod=marker colorcolumn=79
aug end

" }}}
" Zsh -------------------------------------------------------------------- {{{

aug ft_zsh
    au!
    au BufNewFile,BufRead zshecl*,prompt_*_setup setlocal filetype=zsh
    setlocal tabstop=2 softtabstop=2 shiftwidth=2
aug end

" }}}

" }}}
" Plugin Settings -------------------------------------------------------- {{{

" Ack -------------------------------------------------------------------- {{{

map <Leader>a :Ack!

" }}}
" Auto Complete Pop ------------------------------------------------------ {{{

" Set length of characters before keyword completion.
let g:AutoComplPop_BehaviorKeywordLength = 4

" }}}
" Command-T -------------------------------------------------------------- {{{

" Set the maximum height of the match window.
let g:CommandTMaxHeight = 10

" }}}
" CtrlP ------------------------------------------------------------------ {{{

" Go up the file system until '.git', or similar, is found.
let g:ctrlp_working_path_mode = 2

" Set the maximum height of the match window.
let g:ctrlp_max_height = 10

" Do not remember the last input.
let g:ctrlp_persistent_input = 0

" Do not override Ctrl + P.
let g:ctrlp_map = '<Leader>t'

" Enable help tag, exuberant ctags, quickfix, and directory search.
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir']

" Map buffer search.
nnoremap <Leader>b :CtrlPBuffer<CR>

" Map most recently used file search.
nnoremap <Leader>m :CtrlPBuffer<CR>

" }}}
" Gist ------------------------------------------------------------------- {{{

let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" }}}
" Golden Ratio ----------------------------------------------------------- {{{

nnoremap <Leader>G <Plug>(golden_ratio_resize)
let g:golden_ratio_autocommand = 0

"}}}
" Gundo ------------------------------------------------------------------ {{{

nnoremap <Leader>U :GundoToggle<CR>
let g:gundo_preview_bottom = 1

" }}}
" HTML5 ------------------------------------------------------------------ {{{

let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0

" }}}
" Indent Guides ---------------------------------------------------------- {{{

" Auto calculate guide colors.
let g:indent_guides_auto_colors = 1

" Use skinny guides.
let g:indent_guides_guide_size = 1

" Indent from level 2.
let g:indent_guides_start_level = 2

" }}}
" Markdown Preview  ------------------------------------------------------ {{{

" Map Leader + P to preview.
nmap <Leader>P :Mm<CR>

" }}}
" Org-Mode --------------------------------------------------------------- {{{

let g:org_todo_keywords = ['TODO', '|', 'DONE']
let g:org_plugins = [
    \ 'ShowHide', '|', 'Navigator',
    \ 'EditStructure', '|', 'Todo', 'Date', 'Misc'
\ ]

" }}}
" Preview ---------------------------------------------------------------- {{{

let g:PreviewBrowsers='open'

" }}}
" Powerline -------------------------------------------------------------- {{{

" Use fancy UTF-9 symbols (requires a patched font, see documentation).
let g:Powerline_symbols = 'fancy'

" }}}
" Python by Dmitry Vasiliev ---------------------------------------------- {{{

let python_highlight_all = 1
let python_print_as_function = 1
let python_slow_sync = 1

" }}}
" Rainbow Parenthesis ---------------------------------------------------- {{{

nmap <Leader>rp :RainbowParenthesesToggle<CR>

" }}}
" Ropevim ---------------------------------------------------------------- {{{

let ropevim_enable_shortcuts = 0
let ropevim_guess_project = 1
let ropevim_global_prefix = '<C-c>p'

" }}}
" Showmarks -------------------------------------------------------------- {{{

" Do not enable showmarks at startup.
let g:showmarks_enable = 0

" Do not include the various brace marks (), {}, etc.
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY"

" }}}
" Solarized -------------------------------------------------------------- {{{

if exists('g:colors_name') && g:colors_name == 'solarized'
    " Text is unreadable with background transparency.
    if has('gui_macvim')
        set transparency=0
    endif

    " Highlighted text is unreadable in Terminal.app because it
    " does not support setting of the cursor foreground color.
    if !has('gui_running') && $TERM_PROGRAM == 'Apple_Terminal'
        if &background == 'dark'
            hi Visual term=reverse cterm=reverse ctermfg=10 ctermbg=7
        endif
    endif
endif

" }}}
" Surround --------------------------------------------------------------- {{{

let g:surround_40 = "(\r)"
let g:surround_91 = "[\r]"
let g:surround_60 = "<\r>"

" }}}
" Syntastic -------------------------------------------------------------- {{{

" Mark syntax errors with :signs.
let g:syntastic_enable_signs = 1

" Do not auto jump to the error when saving a file.
let g:syntastic_auto_jump = 0

" Do not auto show the error list.
let g:syntastic_auto_loc_list = 0

" Show warnings.
let g:syntastic_quiet_warnings = 0

" Do not validate the following file types.
let g:syntastic_disabled_filetypes = ['html', 'python']

" Set the display format.
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

" }}}
" Tagbar ----------------------------------------------------------------- {{{

let g:tagbar_sort = 1            " Sort by name.
let g:tagbar_compact = 0         " Use compact layout.
let g:tagbar_expand = 1          " Expand window in GUI mode.

map <Leader>i <Plug>TagbarToggle

" Define custom Zsh support (requires definition in ~/.ctags).
let g:tagbar_type_zsh = {
    \ 'ctagstype': 'zsh',
    \ 'kinds': [
        \ 'f:functions:1'
    \ ],
    \ 'fold': 0
\ }

" }}}
" TaskList --------------------------------------------------------------- {{{

map <Leader>T <Plug>TaskList

" }}}
" Tcomment --------------------------------------------------------------- {{{

" Map 'gcp' comment the current paragraph (block).
if exists('loaded_tcomment')
    nmap <silent> gcp <c-_>p
endif

" }}}
" Threesome -------------------------------------------------------------- {{{

let g:threesome_initial_mode = "grid"

let g:threesome_initial_layout_grid = 1
let g:threesome_initial_layout_loupe = 0
let g:threesome_initial_layout_compare = 0
let g:threesome_initial_layout_path = 0

let g:threesome_initial_diff_grid = 1
let g:threesome_initial_diff_loupe = 0
let g:threesome_initial_diff_compare = 0
let g:threesome_initial_diff_path = 0

let g:threesome_initial_scrollbind_grid = 0
let g:threesome_initial_scrollbind_loupe = 0
let g:threesome_initial_scrollbind_compare = 0
let g:threesome_initial_scrollbind_path = 0

let g:threesome_wrap = "nowrap"

" }}}
" Yankring --------------------------------------------------------------- {{{

" Hide the history file.
let g:yankring_history_file = '.yankring-history'

" }}}

" }}}
" Key Remapping ---------------------------------------------------------- {{{

" Tab Navigation --------------------------------------------------------- {{{

" Easily create a new tab.
map <Leader>tt :tabnew<CR>

" Easily close a tab.
map <Leader>tc :tabclose<CR>

" Easily move a tab.
noremap <Leader>tm :tabmove<CR>

" Easily go to next tab.
noremap <Leader>tn :tabnext<CR>

" Easily go to previous tab.
noremap <Leader>tp :tabprevious<CR>

" }}}
" Window Navigation ------------------------------------------------------ {{{

" Navigate to left window.
nnoremap <C-h> <C-w>h

" Navigate to down window.
nnoremap <C-j> <C-w>j

" Navigate to top window.
nnoremap <C-k> <C-w>k

" Navigate to right window.
nnoremap <C-l> <C-w>l

" Horizontal split then move to bottom window.
nnoremap <Leader>- <C-w>s

" Vertical split then move to right window.
nnoremap <Leader>\| <C-w>v<C-w>l

" }}}
" Text Alignment --------------------------------------------------------- {{{

nnoremap <Leader>Al :left<CR>
nnoremap <Leader>Ac :center<CR>
nnoremap <Leader>Ar :right<CR>
vnoremap <Leader>Al :left<CR>
vnoremap <Leader>Ac :center<CR>
vnoremap <Leader>Ar :right<CR>

" }}}
" Miscellaneous Mappings ------------------------------------------------- {{{

" Disable search match highlight.
nnoremap <Leader><space> :noh<CR>

" Duplicate a selection.
vnoremap D y'>p

" Tab to indent in visual mode.
vnoremap <Tab> >gv

" Shift+Tab to unindent in visual mode.
vnoremap <S-Tab> <gv

" Re hard wrap paragraph.
nnoremap <Leader>q gqip

" Reselect pasted text.
nnoremap <Leader>v V`]

" Display-wise up/down movement instead of linewise.
noremap j gj
noremap k gk

" Faster ESC.
inoremap jk <ESC>
inoremap kj <ESC>

" Format Paragraph.
nnoremap <Leader>q gwap

" Formatting, TextMate-style.
nnoremap Q gqip

" Change Case.
nnoremap <C-u> gUiw
inoremap <C-u> <ESC>gUiwea

" Write with sudo.
cnoremap w!! w !sudo tee % >/dev/null

" Toggle spell checking.
nnoremap <silent><Leader>s :set spell!<CR>

" Shift+P replace selection without overwriting default register in vmode.
vnoremap P p :call setreg('"', getreg('0'))<CR>

" Strip trailing whitespace.
nnoremap <Leader>W call StripTrailingWhiteSpace()

" Quick return.
inoremap <C-CR> <ESC>A<CR>
inoremap <S-C-CR> <ESC>A:<CR>

" Fix linewise visual selection of various text objects.
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Faster substitute.
nnoremap <Leader>S :%s//<left>

" Easier linewise reselection.
nnoremap <Leader>v V`]

" Toggle paste.
set pastetoggle=<F8>

" Replaste.
nnoremap <D-p> "_ddPV`]

" Diff.
nnoremap <silent><Leader>do :diffoff!<CR>
nnoremap <silent><Leader>dg :diffget<CR>:diffupdate<CR>
nnoremap <silent><Leader>dp :diffput<CR>:diffupdate<CR>
nnoremap <silent><Leader>du :diffupdate<CR>

" Better completion.
set completeopt=longest,menuone,preview
" inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-p> pumvisible() ?
    \ '<C-n>'  : '<C-n><C-r>=pumvisible() ?
        \ "\<lt>up>" : ""<CR>'
inoremap <expr> <C-n> pumvisible() ?
    \ '<C-n>'  : '<C-n><C-r>=pumvisible() ?
    \ "\<lt>Down>" : ""<CR>'

" }}}

" }}}
" Text Objects (Credit: Steve Losh) -------------------------------------- {{{

" Shortcut for [] -------------------------------------------------------- {{{

onoremap id i[
onoremap ad a[
vnoremap id i[
vnoremap ad a[

" }}}
" Next/Last () ----------------------------------------------------------- {{{

vnoremap <silent> inb :<C-U>normal! f(vib<CR>
onoremap <silent> inb :<C-U>normal! f(vib<CR>
vnoremap <silent> anb :<C-U>normal! f(vab<CR>
onoremap <silent> anb :<C-U>normal! f(vab<CR>
vnoremap <silent> in( :<C-U>normal! f(vi(<CR>
onoremap <silent> in( :<C-U>normal! f(vi(<CR>
vnoremap <silent> an( :<C-U>normal! f(va(<CR>
onoremap <silent> an( :<C-U>normal! f(va(<CR>

vnoremap <silent> ilb :<C-U>normal! F)vib<CR>
onoremap <silent> ilb :<C-U>normal! F)vib<CR>
vnoremap <silent> alb :<C-U>normal! F)vab<CR>
onoremap <silent> alb :<C-U>normal! F)vab<CR>
vnoremap <silent> il( :<C-U>normal! F)vi(<CR>
onoremap <silent> il( :<C-U>normal! F)vi(<CR>
vnoremap <silent> al( :<C-U>normal! F)va(<CR>
onoremap <silent> al( :<C-U>normal! F)va(<CR>

" }}}
" Next/Last {} ----------------------------------------------------------- {{{

vnoremap <silent> inB :<C-U>normal! f{viB<CR>
onoremap <silent> inB :<C-U>normal! f{viB<CR>
vnoremap <silent> anB :<C-U>normal! f{vaB<CR>
onoremap <silent> anB :<C-U>normal! f{vaB<CR>
vnoremap <silent> in{ :<C-U>normal! f{vi{<CR>
onoremap <silent> in{ :<C-U>normal! f{vi{<CR>
vnoremap <silent> an{ :<C-U>normal! f{va{<CR>
onoremap <silent> an{ :<C-U>normal! f{va{<CR>

vnoremap <silent> ilB :<C-U>normal! F}viB<CR>
onoremap <silent> ilB :<C-U>normal! F}viB<CR>
vnoremap <silent> alB :<C-U>normal! F}vaB<CR>
onoremap <silent> alB :<C-U>normal! F}vaB<CR>
vnoremap <silent> il{ :<C-U>normal! F}vi{<CR>
onoremap <silent> il{ :<C-U>normal! F}vi{<CR>
vnoremap <silent> al{ :<C-U>normal! F}va{<CR>
onoremap <silent> al{ :<C-U>normal! F}va{<CR>

" }}}
" Next/Last [] ----------------------------------------------------------- {{{

vnoremap <silent> ind :<C-U>normal! f[vi[<CR>
onoremap <silent> ind :<C-U>normal! f[vi[<CR>
vnoremap <silent> and :<C-U>normal! f[va[<CR>
onoremap <silent> and :<C-U>normal! f[va[<CR>
vnoremap <silent> in[ :<C-U>normal! f[vi[<CR>
onoremap <silent> in[ :<C-U>normal! f[vi[<CR>
vnoremap <silent> an[ :<C-U>normal! f[va[<CR>
onoremap <silent> an[ :<C-U>normal! f[va[<CR>

vnoremap <silent> ild :<C-U>normal! F]vi[<CR>
onoremap <silent> ild :<C-U>normal! F]vi[<CR>
vnoremap <silent> ald :<C-U>normal! F]va[<CR>
onoremap <silent> ald :<C-U>normal! F]va[<CR>
vnoremap <silent> il[ :<C-U>normal! F]vi[<CR>
onoremap <silent> il[ :<C-U>normal! F]vi[<CR>
vnoremap <silent> al[ :<C-U>normal! F]va[<CR>
onoremap <silent> al[ :<C-U>normal! F]va[<CR>

" }}}
" Next/Last <> ----------------------------------------------------------- {{{

vnoremap <silent> in< :<C-U>normal! f<vi<<CR>
onoremap <silent> in< :<C-U>normal! f<vi<<CR>
vnoremap <silent> an< :<C-U>normal! f<va<<CR>
onoremap <silent> an< :<C-U>normal! f<va<<CR>

vnoremap <silent> il< :<C-U>normal! f>vi<<CR>
onoremap <silent> il< :<C-U>normal! f>vi<<CR>
vnoremap <silent> al< :<C-U>normal! f>va<<CR>
onoremap <silent> al< :<C-U>normal! f>va<<CR>

" }}}
" Next '' ---------------------------------------------------------------- {{{

vnoremap <silent> in' :<C-U>normal! f'vi'<CR>
onoremap <silent> in' :<C-U>normal! f'vi'<CR>
vnoremap <silent> an' :<C-U>normal! f'va'<CR>
onoremap <silent> an' :<C-U>normal! f'va'<CR>

vnoremap <silent> il' :<C-U>normal! F'vi'<CR>
onoremap <silent> il' :<C-U>normal! F'vi'<CR>
vnoremap <silent> al' :<C-U>normal! F'va'<CR>
onoremap <silent> al' :<C-U>normal! F'va'<CR>

" }}}
" Next "" ---------------------------------------------------------------- {{{

vnoremap <silent> in" :<C-U>normal! f"vi"<CR>
onoremap <silent> in" :<C-U>normal! f"vi"<CR>
vnoremap <silent> an" :<C-U>normal! f"va"<CR>
onoremap <silent> an" :<C-U>normal! f"va"<CR>

vnoremap <silent> il" :<C-U>normal! F"vi"<CR>
onoremap <silent> il" :<C-U>normal! F"vi"<CR>
vnoremap <silent> al" :<C-U>normal! F"va"<CR>
onoremap <silent> al" :<C-U>normal! F"va"<CR>

" }}}

" }}}
" Abbreviations ---------------------------------------------------------- {{{

cabbr cdf cd %:p:h<CR>
cabbr lcdf lcd %:p:h<CR>

" }}}
" Functions -------------------------------------------------------------- {{{

" Open URL --------------------------------------------------------------- {{{

command! -bar -nargs=1 OpenURL :!open <args>
function! OpenURL()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    echo s:uri
    if s:uri != ""
        exec "!open \"" . s:uri . "\""
    else
        echo "No URI found in line"
    endif
endfunction
map <Leader>w :call OpenURL()<CR>

" }}}
" Error Toggle ----------------------------------------------------------- {{{

command! ErrorsToggle call ErrorsToggle()
function! ErrorsToggle()
    if exists("w:is_error_window")
        unlet w:is_error_window
        exec "q"
    else
        exec "Errors"
        lopen
        let w:is_error_window = 1
    endif
endfunction

command! -bang -nargs=? QFixToggle call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction

nmap <silent> <F3> :ErrorsToggle<CR>
nmap <silent> <F4> :QFixToggle<CR>

" }}}
" Strip Trailing Whitespace ---------------------------------------------- {{{

function! StripTrailingWhitespace()
    if !&binary && &modifiable && &filetype != 'diff'
        let l:winview = winsaveview()
        %s/\s\+$//e
        let @/=''
        call winrestview(l:winview)
    endif
endfunction

" }}}
" Toggle Background ------------------------------------------------------ {{{

function! BackgroundToggle()
    let &background = ( &background == "dark"? "light" : "dark" )
    if exists("g:colors_name")
        exe "colorscheme " . g:colors_name
    endif
endfunction
command! BackgroundToggle :call BackgroundToggle()
silent! nnoremap <F2> :BackgroundToggle<CR>
silent! inoremap <F2> :BackgroundToggle<CR>
silent! vnoremap <F2> :BackgroundToggle<CR>

" }}}

" }}}

