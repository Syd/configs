"####################################################################
"#
"# Vim Startup File
"#
"set verbose=9
"set t_kb=
"set t_kD=
set nobackup
set backspace=start,indent,eol
set viminfo=\"20,%,'5,/10,:20,h,n~/.viminfo
set history=50
set laststatus=2
set showmode
set showcmd
set showmatch
"set matchtime=3 
set vb t_vb=
set noerrorbells
set virtualedit=block
set title
set shell=sh
set complete=.,w,b,t
set formatoptions=cqn1
set switchbuf=

"####################################################################
"#
"# The Status Line
"#
"####################################################################
set statusline=%f%=%1*[%Y%R%M]%*

"####################################################################
"#
"# Abbreviations
"#
"####################################################################
abbreviate ctor constructor
abbreviate Ctor Constructor
abbreviate dtor destructor
abbreviate Dtor Destructor
abbreviate #i #include
abbreviate #d #define

"####################################################################
"#
"# FileType Support
"#
"####################################################################
filetype on
filetype plugin on
filetype indent on

"####################################################################
"#
"# Programming Stuff
"#
"####################################################################
set path+=include
set path+=lib
set tags=./.tags,.tags,./.ruby_tags,.ruby_tags
set tagstack
set tabstop=8
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set textwidth=78
set nowrap    
set autoindent
set number
set foldcolumn=1
set foldmethod=indent
set foldlevel=1
set nofoldenable

"#################################################################### 
"# 
"# Mappings and Commands 
"# 
"####################################################################

"# Cheat Sheet
"#
"#  F1 - Toggle search highlighting
"#  F2 - Pick a buffer
"#  F3 - Use Gay Indent Rules
"#  F4 - Run the 'make' program
"#  F5 - Toggle paste mode
"#  F6 - Wrap current paragraph at 76 columns
"#  F7 - Next QuickFix Line
"#  F8 - Replay buffer A
"#  F9 - Grow current window
"# F10 - Shrink current window
"# F11 - Maximize current window
"# F12 - Change to next window

nmap <F1> :nohls<cr>
map <silent> <unique> <F2> :MRU<CR>
nmap <F3> :call UseGayIndent()<cr>
imap <F3> <c-o><F3>
nmap <F4> :make<cr>
imap <F4> <c-o><F4>
nmap <F5> :call TogglePasteMode()<cr>
imap <F5> <c-o><F5>
vmap <F6> :call WrapAt76()<cr>
"imap <F6> <c-o><F6>
nmap <F7> :cn<cr>
imap <F7> <c-o><F7>
nmap <F8> @a
imap <F8> <c-o>@a
nmap <F9> <c-w>+
imap <F9> <Esc><F9>
nmap <F10> <c-w>-
imap <F10> <Esc><F10>
nmap <F11> <c-w>_
imap <F11> <Esc><F11>
nmap <F12> <c-w>w
imap <F12> <Esc><F12>

"# ^N, ^A, ^E
nmap <c-n> :n<cr>
imap <c-a> <c-o>^
imap <c-e> <c-o>$

"# don't use the up/down arrow keys
imap  k
imap <c-j> <c-o>j

"# use vim's super : mode
nmap <Space> q:

"# shortcut for save
nmap W :w

"# jump to the last buffer
nmap <c-x> :e #

"# Insert a comment bar
nmap <c-y> O80i#==j
imap <c-y> <c-o><c-y>A

command Q  :qa
command W  :w
command Wq :wq

"####################################################################
"#
"# Auto Commands
"#
"####################################################################
" Cursor lines!
"set cursorline
"set cursorcolumn
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn

"####################################################################
"# text files
autocmd FileType mail,text call PlainTextSettings()
autocmd BufRead,BufNewFile *.txt call PlainTextSettings()
autocmd BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d
/^$
autocmd BufRead /* call NonSpecialFiles()

"####################################################################
"# Ruby
autocmd BufRead,BufNewFile Rakefile set filetype=ruby
autocmd BufRead,BufNewFile rakefile set filetype=ruby
autocmd BufRead,BufNewFile *.rake   set filetype=ruby
autocmd BufRead,BufNewFile .irbrc   set filetype=ruby
autocmd BufRead,BufNewFile *.rjs    set filetype=ruby
autocmd BufRead,BufNewFile *.rhtml  call ERubySettings()
autocmd FileType ruby,eruby         call RubySettings()

"####################################################################
"# JavaScript can be just like Ruby
autocmd FileType javascript         call UseRubyIndent()

"####################################################################
"# Crontabs
autocmd BufRead /tmp/crontab* call CrontabSettings()

"####################################################################
"#
"# Functions
"#
"####################################################################
function PlainTextSettings ()
    setlocal shiftwidth=8
    setlocal softtabstop=0
    setlocal wrap
    setlocal nonumber
    setlocal noautoindent
    set foldmethod=manual
    set formatoptions-=c
    set formatoptions+=ta
    set spell
endfunction

"####################################################################
function TogglePasteMode ()
    if (&paste)
    	set nopaste
    	echo "Paste Mode Off"
    else
    	set paste
    	echo "Paste Mode On"
    endif
endfunction

"####################################################################
function UseGayIndent ()
    setlocal tabstop=4
    setlocal softtabstop=0
    setlocal shiftwidth=4
    setlocal noexpandtab
    echo "Using Gay Indent Rules"
endfunction

"####################################################################
function RubySettings ()
    call UseRubyIndent()
    command! -buffer Irb call RunIRB()
endfunction

"####################################################################
function UseRubyIndent ()
    setlocal tabstop=8
    setlocal softtabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
    setlocal makeprg=ruby\ %
endfunction

"####################################################################
" Does three things:
"
"   1) Clears the screen
"   2) Runs IRB on the current buffer
"   3) Redraws the Vim screen
function RunIRB ()
    :silent !clear;irb -r %
    :redraw!
endfunction

"####################################################################
function ERubySettings ()
    imap <buffer> <CR> <C-R>=PMADE_XmlEndToken()<CR>
endfunction

"####################################################################
function WrapAt76 ()
    let tw = &textwidth
    let &l:textwidth = 76
    exec "normal! gqap"
    let &l:textwidth = tw
endfunction

"####################################################################
function NonSpecialFiles ()
    nmap <buffer> <Enter> <c-]>
endfunction

"####################################################################
function CrontabSettings ()
    setlocal nobackup
    setlocal nowritebackup
endfunction

"####################################################################
"#
"# Syntax Colors
"#
"####################################################################
if &t_Co > 2
    if &term == 'screen'
        set term=xterm-256color
    else
        let &t_Co = 16
    endif

    syntax on
    set hlsearch
    set incsearch

    hi clear Folded
    hi clear FoldColumn
    hi Folded		ctermfg=magenta
    hi FoldColumn	ctermfg=0

    hi CursorLine       ctermbg=15 cterm=none
    hi CursorColumn     ctermbg=15 cterm=none

    hi StatusLine	ctermfg=0
    hi StatusLineNC	ctermfg=darkred		ctermbg=white
    hi Search		ctermfg=white		ctermbg=darkblue
    hi IncSearch	ctermfg=darkgreen	ctermbg=black
    hi Visual		ctermbg=15              cterm=underline
    hi VertSplit	ctermfg=0
    hi LineNr		ctermfg=0
    hi ModeMsg		ctermfg=cyan
    hi NonText		ctermfg=cyan

    hi Error            ctermfg=lightred        ctermbg=lightblue cterm=reverse
    hi ErrorMsg         ctermfg=white           ctermbg=darkred
    hi SpellBad         ctermfg=lightred        ctermbg=lightblue cterm=reverse

    hi Define           ctermfg=4               cterm=bold
    hi Function         ctermfg=11
    hi Type             ctermfg=10
    hi Comment		ctermfg=0
    hi Constant		ctermfg=3
    hi PreProc		ctermfg=2
    hi Statement	ctermfg=12
    hi Identifier	ctermfg=darkgreen
    hi Cursor		ctermfg=grey
    hi Keyword          ctermfg=12
    hi Exception        ctermfg=red
    hi Delimiter        ctermfg=5
    hi Special          ctermfg=5

    hi rubyConstant     ctermfg=3
    hi rubySymbol       ctermfg=13
    hi rubyIdentifier   ctermfg=2
    hi rubyInterpolation ctermfg=11

    hi User1            ctermbg=1
    hi User2            ctermfg=10 cterm=reverse
endif

"####################################################################
"#
"# MRU Settings
"#
"####################################################################
let MRU_File          = '.vim-mru-list'
let MRU_Max_Entries   = 10
let MRU_Window_Height = 15

"####################################################################
"#
"# Project Plugin Settings
"#
"####################################################################
let g:proj_window_width = 50
let g:proj_flags = "imstcn"

"####################################################################
"#
"# Jam
"#
"####################################################################
"set makeprg=jam\ -q
"command Jam :make
"nmap <c-j> :make<cr>
