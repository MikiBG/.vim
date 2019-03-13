" Miguel Bello Gamboa
" 04/05/2018


"-------------------------------------------------------------- 
" GENERAL
"-------------------------------------------------------------- 
" Enter current millenium
set nocompatible

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nnoremap <leader>w :w!<cr>

"-------------------------------------------------------------- 
" FINDING FILES
"-------------------------------------------------------------- 
" Search down into subfolders
set path+=**

" Tabs auto-completion
"set wildmode=longest,list,full
set wildmenu

"-------------------------------------------------------------- 
" TAG JUMPING
"-------------------------------------------------------------- 
" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" Now we can:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

"-------------------------------------------------------------- 
" VIM USER INTERFACE    
"-------------------------------------------------------------- 
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=2

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
" set noerrorbells
" set novisualbell
set vb t_vb=
" timeout length used for mapping delays
set tm=500

"-------------------------------------------------------------- 
" SEARCHING
"-------------------------------------------------------------- 
" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
noremap <space> /
noremap <c-space> ?

"-------------------------------------------------------------- 
" COLORS AND FONTS
"-------------------------------------------------------------- 
" Enable syntax highlighting
syntax enable

set termguicolors
" default colorscheme
colorscheme rupza
" to toggle between colorschemes
nnoremap <silent> <F9> :exec "color " .
    \ ((g:colors_name == "rupza") ? "subtle_solo_light" : "rupza")<CR>

hi clear SpellBad
hi SpellBad cterm=underline

" Set utf8 as standard encoding 
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"-------------------------------------------------------------- 
" FILES, BACKUPS AND UNDO
"-------------------------------------------------------------- 
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"-------------------------------------------------------------- 
" TEXT, TAB AND INDENT 
"-------------------------------------------------------------- 
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 80 characters
set linebreak
set textwidth=80

set autoindent
set smartindent
set wrap "Wrap lines

"-------------------------------------------------------------- 
" VISUAL MODE
"-------------------------------------------------------------- 
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"-------------------------------------------------------------- 
" MOVING ARROUND; TABS, WINDOWS AND BUFFERS   
"-------------------------------------------------------------- 
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>

" " Smart way to move between windows
" noremap <C-j> <C-W>j
" noremap <C-k> <C-W>k
" noremap <C-h> <C-W>h
" noremap <C-l> <C-W>l

" " Close the current buffer
" map <leader>bd :Bclose<cr>

" " Close all the buffers
" map <leader>ba :1,1000 bd!<cr>

" " Useful mappings for managing tabs
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove

" " Opens a new tab with the current buffer's path
" map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" " Switch CWD to the directory of the open buffer
" map <leader>cd :cd %:p:h<cr>:pwd<cr>

" " Specify the behavior when switching between buffers 
" try
"   set switchbuf=useopen,usetab,newtab
"   set stal=2
" catch
" endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"-------------------------------------------------------------- 
" STATUS LINE   
"-------------------------------------------------------------- 
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"-------------------------------------------------------------- 
" SPELL CHECKING
"-------------------------------------------------------------- 
" Set language American English
set spelllang=en

" File that contains exceptions
" set spellfile=$HOME/Dropbox/en.utf-8.add

" Pressing ,ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>

"-------------------------------------------------------------- 
" MISC
"-------------------------------------------------------------- 
" Toggle paste mode on and off
noremap <leader>pp :setlocal paste!<cr>

" Delete trailing white space on save, useful for Python and 
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

"-------------------------------------------------------------- 
" HELPER FUNCTIONS
"-------------------------------------------------------------- 
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

"-------------------------------------------------------------- 
" EDIT LATEX
"-------------------------------------------------------------- 
" to compile latex file
noremap <leader>ll :w <CR> :!pdflatex % <CR>

" to show latex file
noremap <leader>lv :! evince %:r.pdf & <CR>

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" to jump directly to placeholder in a template
inoremap <C-j> <Esc>/<++><CR><Esc>cf>

" Completions using placeholders
inoremap "" ""<++><Esc>F"i
inoremap $$ $$<++><Esc>F$i
inoremap () ()<++><Esc>F)i
inoremap [] []<++><Esc>F]i
inoremap {} {}<++><Esc>F}i

inoremap (( \left(\right)<++><Esc>F\i
inoremap [[ \left[\right]<++><Esc>F\i
inoremap {{ \left\{\right\}<++><Esc>F\;i

inoremap EE \begin{equation}<CR>\end{equation}<Esc>O
inoremap FF \begin{figure}[!htb]<CR>\centering<CR>\includegraphics{}<CR>\caption{<++>}<CR>\end{figure}<Esc>2kf}i

"-------------------------------------------------------------- 
" EDIT JULIA
"-------------------------------------------------------------- 
" to comment lines of code
au BufRead,BufNewFile *.jl set filetype=julia
autocmd FileType julia setlocal commentstring=#\ %s
"
"-------------------------------------------------------------- 
" PLOTTING
"-------------------------------------------------------------- 
" Shortcut to plot
autocmd FileType gnuplot noremap <leader>pl :w \| :!gnuplot %:t <CR>
autocmd FileType python noremap <leader>pl :w \| :!python %:t <CR>
" commenting in gnuplot scripts
au BufRead,BufNewFile *.plt     set filetype=gnuplot
autocmd FileType gnuplot setlocal commentstring=#\ %s
