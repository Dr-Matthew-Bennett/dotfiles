"{{{- wish list --------------------------------------------------------------

" For vim-tmux-focus-events not to throw error on switching external windows:
" Error detected while processing function <SNR>39_do_autocmd[3]..FocusGained
" Autocommands for "*"..function tmux_focus_events#focus_gained:
"
" Update: this plugin is now obsolete and no longer needed as both neovim and
" vim (since version 8.2.2345) have native support for this functionality.

" automatic folding for markdown sections

"}}}---------------------------------------------------------------------------

"==== SETUP VUNDLE PLUGIN MANAGER =============================================
"{{{- required ----------------------------------------------------------------
if &compatible
    set nocompatible " don't try to be compatible with Vi
endif
filetype plugin indent on " use default plugins
"}}}---------------------------------------------------------------------------
"{{{- paths -------------------------------------------------------------------
set runtimepath+=~/.vim/bundle/Vundle.vim
set runtimepath+=~/.fzf
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"}}}
"{{{ - plugins I use ----------------------------------------------------------
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins I would put in a new vimrc
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/ReplaceWithRegister'

" other plugins that do more exotic things
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'jpalardy/vim-slime'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'markonm/traces.vim'
Plugin 'Matt-A-Bennett/vim-indent-object'
Plugin 'simnalamburt/vim-mundo'
Plugin 'SirVer/ultisnips'

Plugin 'tmux-plugins/vim-tmux-focus-events'
" Update: this plugin is now obsolete and no longer needed as both neovim and
" vim (since version 8.2.2345) have native support for this functionality.

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-scripts/MatlabFilesEdition'
Plugin 'wellle/targets.vim'
Plugin 'ycm-core/YouCompleteMe'
"}}}
"{{{- plugins I'm trying out---------------------------------------------------
"}}}
"{{{ - plugins I may want to try one day --------------------------------------
" Plugin 'airblade/vim-gitgutter'
" Plugin 'dense-analysis/ale'
" Plugin 'tommcdo/vim-lion'
" Plugin 'tommcdo/vim-exchange'
" Plugin 'tpope/vim-eunuch'
" Plugin 'tpope/vim-obsession'
" Plugin 'wellle/tmux-complete.vim'
"}}}
"{{{ - call vundle and load things from runtime paths --------------------------
" All of your Plugins must be added before the following line
call vundle#end() " required
" I want to override one of the defaults here, so load it now then overwrite
runtime! plugin/sensible.vim
" use % sign to jump between if, else, end
runtime! macros/matchit.vim
" be able to read man pages with :Man <program name>
runtime! ftplugin/man.vim
"}}}---------------------------------------------------------------------------
"==============================================================================

"==== PLUGIN CONFIGURATIONS AND REMAPS ========================================
"{{{- remap leader key --------------------------------------------------------
"make the space bar my leader key (must be before I make <LEADER> mappings)
noremap <SPACE> <NOP>
sunmap <SPACE>
let mapleader=" "
"}}}---------------------------------------------------------------------------
"{{{- ALE ---------------------------------------------------------------------
" needs a linter and a fixer installed on the system to work. I'm using:
" pip3 install flake8
" pip3 install black

" " use black
" let g:ale_fixers = ['black']

" " other symbols: https://coolsymbol.com/
" let g:ale_sign_error = '☠ '
" let g:ale_sign_warning = '⚠ '
"}}}---------------------------------------------------------------------------
"{{{- fzf.vim -----------------------------------------------------------------
    " search for and open file under the fzf default directory
    nnoremap <LEADER>f :Files<CR>
    " search through and jump to buffer
    nnoremap <LEADER>b :Buffers<CR>
    " search for and jump to line in any open buffer
    nnoremap <LEADER>l :Lines<CR>
    " insert mode line completion
    imap ;l <Plug>(fzf-complete-line)

    " when I search for a file, show results in a window at the bottom
    let g:fzf_layout = { 'down': '~40%' }

    " Change CTRL-X to CTRL-V to open file from fzf in vertical split
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-h': 'split',
      \ 'ctrl-v': 'vsplit' }
"}}}---------------------------------------------------------------------------
"{{{- mundo -------------------------------------------------------------------
" to see and choose a previous state from the undo tree
nnoremap <F5> :MundoToggle<CR>
"}}}---------------------------------------------------------------------------
"{{{- targets.vim -------------------------------------------------------------
" Only consider targets fully visible on screen:
" let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa'

" Same as above, but prioritise pairs fully on line coming before the cursor
" (ll) more than stuff fully off the line (bb and aa)
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb al ll bb aa'

" Controls the keys used in maps for seeking next and last text objects.
let g:targets_nl = ['n', 'N']
"}}}---------------------------------------------------------------------------
"{{{- traces.vim --------------------------------------------------------------
" fyi: there is extensive help documentation that's not on the github page
" immediately highlight numerical ranges once you put the comma :N,N
let g:traces_num_range_preview = 1
" window used to show off-screen matches (just 5 since I only want the gist).
let g:traces_preview_window = "below 5new"
" if value is 1, view position will not be changed when highlighting ranges or
" patterns outside initial view position. I like this since I see it all in the
" preview window setting above
let g:traces_preserve_view_state = 1
"}}}---------------------------------------------------------------------------
"{{{- ultisnips ---------------------------------------------------------------
" Ultisnips trigger configuration.
" Do not use <TAB> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<C-l>"
let g:UltiSnipsJumpBackwardTrigger="<C-h>"
let g:UltiSnipsEditSplit="vertical"
" where ultisnips looks for snippets
" (I think you can add multiple items in the list)
let g:UltiSnipsSnippetDirectories=["/home/mattb/.vim/ultisnips"]
"}}}---------------------------------------------------------------------------
"{{{- vim-indent-object -------------------------------------------------------
" make repeatable
nnoremap <Plug>innerindent ii ii :call repeat#set("\<Plug>innerindent")<CR>
nnoremap <Plug>aroundindent ai ai :call repeat#set("\<Plug>aroundindent")<CR>
"}}}---------------------------------------------------------------------------
"{{{- vim-slime ---------------------------------------------------------------
" vim-slime lets me send text objects and visual selections from vim to a tmux
" pane of my choice.  You can set the target manually using Ctrl-c + v.
" ":i.j"    means the ith window, jth pane

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
" I want to be able to override the defaults, so load it now
let g:slime_default_config =
            \ {"socket_name": "default", "target_pane": "{top-left}"}
" and not to ask me about it even on the first time I use it
let g:slime_dont_ask_default = 1

" To use vim like mappings instead of emacs keybindings use the following:
" Send {visual} text.
xmap <LEADER>s <Plug>SlimeRegionSend
" Send {motion}.
nmap <LEADER>s <Plug>SlimeMotionSend
" Send {count} line(s)
nmap <LEADER>ss <Plug>SlimeLineSend
" }}}--------------------------------------------------------------------------
"{{{- vim-tmux-navigator ------------------------------------------------------
" disable tmux navigator when zooming the vim pane
let g:tmux_navigator_disable_when_zoomed = 1
" }}}--------------------------------------------------------------------------
"{{{- YouCompleteMe -----------------------------------------------------------
" YouCompleteMe has a few filetypes that it doesn't work on by default.
" I removed markdown and text from this list and they seem to work just fine.
let g:ycm_filetype_blacklist = {
            \ 'tagbar': 1,
            \ 'notes': 1,
            \ 'netrw': 1,
            \ 'unite': 1,
            \ 'vimwiki': 1,
            \ 'pandoc': 1,
            \ 'infolog': 1,
            \ 'leaderf': 1,
            \ 'mail': 1
            \}
"}}}---------------------------------------------------------------------------
"==============================================================================

"==== FUNCTIONS ===============================================================
"{{{- toggle between light and dark colorscheme --------------------------------
function! SetColorScheme()
    " check if tmux colorsheme is light or dark, and pick for vim accordingly
    if system('tmux show-environment THEME')[0:9] == 'THEME=dark'
        colorscheme zenburn
        :let $BAT_THEME = ''
    else
        colorscheme seoul256-light
        :let $BAT_THEME = 'Monokai Extended Light'
    endif
endfunction

function! ToggleLightDarkColorscheme()
    if system('tmux show-environment THEME')[0:9] == 'THEME=dark'
        :silent :!tmux set-environment THEME 'light'
        :silent :!tmux source-file ~/.tmux_light.conf
    else
        :silent :!tmux set-environment THEME 'dark'
        :silent :!tmux source-file ~/.tmux_dark.conf
    endif
    :call SetColorScheme()
endfunction
"}}}---------------------------------------------------------------------------
"{{{- open/close YCM doc pages ------------------------------------------------
function! YCM_Toggle_Docs()
    let doc_file = bufname('/tmp/*\d\+')
    if !bufexists(doc_file)
        YcmCompleter GetDoc
    else
        execute 'bwipeout ' doc_file
    endif
endfunction
"}}}---------------------------------------------------------------------------
"{{{- handle w3m_scratch file and toggle split to use it ----------------------
function! WriteW3MToScratch()
    " only if the file matches this highly specific reg exp will we do anything
    "(e.g. a file that looks like: .w3m/w3mtmp{some numbers}-{number})
    if match(@%, "\.w3m/w3mtmp\\d\\+-\\d") != -1
        :silent! wq! /tmp/w3m_scratch
    endif
endfunction

function! ToggleW3M()
    if bufexists("/tmp/w3m_scratch")
        :bwipe! /tmp/w3m_scratch
    else
        :silent! split /tmp/w3m_scratch
    endif
endfunction
"}}}---------------------------------------------------------------------------
"{{{- Ag: Start ag in the specified directory e.g. :Ag ~/foo ------------------
function! s:ag_in(bang, ...)
    if !isdirectory(a:1)
        throw 'not a valid directory: ' .. a:1
    endif
    " Press `?' to enable preview window.
    call fzf#vim#ag(join(a:000[1:], ' '),
                \ fzf#vim#with_preview({'dir': a:1}, 'right:50%', '?'), a:bang)
endfunction

" Ag call a modified version of Ag where first arg is directory to search
command! -bang -nargs=+ -complete=dir Ag call s:ag_in(<bang>0, <f-args>)
"}}}---------------------------------------------------------------------------
"{{{- make a 4-way split and resize the windows how I like --------------------
" THIS CAN BE REMOVED ONCE I MASTER THE :MKSESSION TYPE COMMANDS
function! WorkSplit()
    let l:currentWindow=winnr()
    silent! execute "normal! :vsplit\<CR> :buffer 2\<CR>"
    silent! execute "normal! :split\<CR> :resize -20\<CR> :b scratch2\<CR>"
    silent! execute l:currentWindow . "wincmd w"
    silent! execute "normal! :split\<CR> :resize -20\<CR> :b scratch1\<CR>"
endfunction
"}}}---------------------------------------------------------------------------
"{{{- restore cursor position -------------------------------------------------
" run a command, but put the cursor back when it's done
function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
"}}}---------------------------------------------------------------------------
"{{{- matlab functions for easy interrogation of variables --------------------
function! MatlabImagesc(type)
    :call MatlabPrepCode()
    silent :execute "normal! o figure, imagesc(V__), axis image"
    :call MatlabExecuteCode()
endfunction

function! MatlabPlot(type)
    :call MatlabPrepCode()
    silent :execute "normal! o figure, plot(V__), axis image"
    :call MatlabExecuteCode()
endfunction

function! MatlabHist(type)
    :call MatlabPrepCode()
    silent :execute "normal! o figure, hist(V__,100), axis image"
    :call MatlabExecuteCode()
endfunction

function! MatlabSummarise(type)
    :call MatlabPrepCode()
    silent :execute "normal! o whos V__"
    silent :execute "normal! o V__(1:min(size(V__, 1), 5), 1:min(size(V__, 2), 5))"
    silent :execute "normal! o [min(V__(:)), max(V__(:)), length(unique(V__(:)))]"
    :call MatlabExecuteCode()
endfunction

" helper functions
function! MatlabPrepCode()
    " mark the current cursor position
    silent :execute "normal! mx"
    " visually select and yank between opfunc marks
    silent :execute "normal! `[v`]\"my"
    " drop down to a new line, ready for composition
    " silent :execute "normal! o \<ESC>"
    " reassign variable for use in code
    silent :execute "normal! o V__ = \<ESC>\"mpA;"
    :call MatlabExecuteCode()
endfunction

function! MatlabExecuteCode()
    " create a space after
    silent :execute "normal! o \<ESC>"
    " move back line below mark, and visually select to end of paragraph
    silent :execute "normal! `xj0v}"
    " send it to the tmux window
    silent :execute "normal\<Plug>SlimeRegionSend"
    " move cursor back to original position
    silent :execute "normal! \"_dd`xu"
endfunction
"}}}---------------------------------------------------------------------------
"{{{- search the help docs with ag and fzf ------------------------------------
function! Help_AG()
    let orig_file = expand(@%)
    let v1 = v:version[0]
    let v2 = v:version[2]
    " search in the help docs with ag-silver-search and fzf and open file
    execute "normal! :Ag /usr/share/vim/vim".v1.v2."/doc/\<CR>"
    " if we opened a help doc
    if orig_file != expand(@%)
        set nomodifiable
        " for some reason not all the tags work unless I open the real help
        " so get whichever help was found and opened through Ag
        let help_doc=expand("%:t")
        " open and close that help doc - now the tags will work
        execute "normal! :tab :help " help_doc "\<CR>:q\<CR>"
    endif
endfunction

" get some help
command! H :call Help_AG()
"}}}---------------------------------------------------------------------------
"{{{- 'delete', 'change', 'yank' between any two characters -------------------
" YOU'RE NEVER GOING TO USE THESE...
function! DeleteInside(char)
    execute "normal! T".a:char
    execute "normal! dt".a:char
endfunction
function! DeleteAround(char)
    execute "normal! F".a:char
    execute "normal! df".a:char
endfunction

function! ChangeInside(char)
    :call DeleteInside(a:char)
    :startinsert
endfunction
function! ChangeAround(char)
    :call DeleteAround(a:char)
    :startinsert
endfunction

function! YankInside(char)
    :call DeleteInside(a:char)
    normal! u
endfunction
function! YankAround(char)
    :call DeleteAround(a:char)
    normal! u
endfunction
"}}}---------------------------------------------------------------------------
"{{{- calulate remaining jumps ------------------------------------------------
if v:version > 801
    function! RemainingJumps()
      let [l:jumplist, l:pos] = getjumplist()
      return max([0, len(l:jumplist) - l:pos - 1])
    endfunction
endif
"}}}---------------------------------------------------------------------------
"==============================================================================

"==== CUSTOM CONFIGURATIONS ===================================================
"{{{- general settings --------------------------------------------------------
" keep all the annoying files in one place
set backupdir=~/linux_config_files/.vim/backup//
set directory=~/linux_config_files/.vim/swap//
set undodir=~/linux_config_files/.vim/undo//
set encoding=utf-8
set number " put line number where the cursor is
set relativenumber " number all other lines relative to current line
set hidden " when switching buffers, don't complain about unsaved changes
set undofile " remember changes from previous vim session (so I can still undo)
set splitbelow " where new vim pane splits are positioned
set splitright " where new vim pane splits are positioned
set noequalalways " don't resize windows when I close a split
set diffopt+=vertical " when using diff mode (fugitive) have a vertical split
set nostartofline " keep cursor on the same column even when no chars are there
set cc=80 "show vertical bar at 80 columns
set textwidth=79 " at 79 columns, wrap text
set linebreak " wrap long lines at char in 'breakat' (default " ^I!@*-+;:,./?")
set nowrap " don't wrap lines by default
set wildmenu " list completion options when typing in command line mode
set wildmode=list,full
" set wildmode=longest,list " behave like bash autocomplete rather than zsh
set wildignorecase " ignore case when completing file names
set expandtab " expand tabs into spaces
set tabstop=4 " a tab is the same as 4 spaces
set softtabstop=4 " when I hit <TAB> in insert mode, put 4 spaces
set shiftwidth=4 " when auto-indenting, use 4 spaces per tab
set autoindent " when creating a new line, copy indent from line above
set nojoinspaces " don't join with double spaces when line ens with ./!/?
set showmatch " show the matching part of the pair for [] {} and ()
set incsearch " show matches for patterns while they are being typed
set hlsearch | noh " highlight matches for searched (turn off when sourcing)
set smartcase " with both on, searches with no capitals are case insensitive...
set ignorecase " ...while searches with capital characters are case sensitive.
set nrformats= " don't interpret 007 as octal (<C-a/x> will make 008, not 010)
if v:version > 801
    set nrformats=unsigned " ignore any minus sign when using <C-a/x>
endif
set spell spelllang=en
set nospell " don't highlight misspellings unless I say so
set lazyredraw " don't redraw screen during macros (let them complete faster)
set foldlevelstart=1 " when opening new files, start with only top folds open
set t_Co=256 " use full colours
syntax enable " highlight special words to aid readability

" make the highlighted searched words less distracting
highlight Search term=reverse ctermfg=230 ctermbg=8 cterm=underline
" check if we're on a light or dark colorscheme in tmux, and pick accordingly
call SetColorScheme()

"}}}---------------------------------------------------------------------------
"{{{ - status line ------------------------------------------------------------
" path/file LEAVE THE TRAILING SPACES AT THE $!! 
set statusline=%<%f\ 
" current git branch
set statusline+=%{FugitiveStatusline()}
" is this file: help? modified? read only?
set statusline+=%h%m%r%=
" space (there must be a proper way to do this)
set statusline+=\ \ \ \ \ 
if v:version > 801
    " add remaining number of jumps
    set statusline+=%{'jumps:\ '.RemainingJumps()}
    " space (there must be a proper way to do this)
    set statusline+=\ \ \ \ \ 
endif
" last search term
set statusline+=\/%{@/}\/
" space (there must be a proper way to do this)
set statusline+=\ \ \ \ \ 
" line / column number
set statusline+=%-14.(%l,%c%V%)
" percent through the file (or top/bottom)
set statusline+=%P

"}}}---------------------------------------------------------------------------
"{{{- general remaps ----------------------------------------------------------
augroup general
    autocmd!
    "{{{- colorscheme switches ------------------------------------------------
    " If the syntax highlighting goes weird, F12 to redo it
    nnoremap <F12> :syntax sync fromstart<CR>
    nnoremap <LEADER>o :call ToggleLightDarkColorscheme()<CR>
    autocmd FocusGained * :call SetColorScheme()
    "}}}-----------------------------------------------------------------------
    "{{{- movements and text objects ------------------------------------------
    " let g modify insert/append to work on visual lines, in the same way as it
    " modifies motions like 0 and $
    nnoremap gI g0i
    nnoremap gA g$i

    " store relative line number jumps in the jumplist.
    nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
    nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

    " inner/around line text objects
    " visual mode
    xnoremap <silent> il <ESC>^vg_
    xnoremap <silent> al <ESC>0v$
    " operator pending mode
    onoremap <silent> il :<C-u>normal! ^vg_<CR>
    onoremap <silent> al :<C-u>normal! 0v$<CR>

    " inner/around file text objects (define i and a for consistency's sake)
    " visual mode
    xnoremap <silent> if <ESC>gg0vG
    xnoremap <silent> af <ESC>gg0vG
    " operator pending mode
    onoremap <silent> if :<C-u>normal! gg0vG<CR>
    onoremap <silent> af :<C-u>normal! gg0vG<CR>

    " delete between any two characters
    " YOU'RE NEVER GOING TO USE THESE...
    nnoremap <LEADER>di :call DeleteInside('')<left><left>
    nnoremap <LEADER>ci :call ChangeInside('')<left><left>
    nnoremap <LEADER>yi :call YankInside('')<left><left>
    nnoremap <LEADER>da :call DeleteAround('')<left><left>
    nnoremap <LEADER>ca :call ChangeAround('')<left><left>
    nnoremap <LEADER>ya :call YankAround('')<left><left>

    " paste at end of line, with an automatic space
    nnoremap <LEADER><LEADER>p o<C-r>"<ESC>kJ
    " paste at start of line, with an automatic space
    nnoremap <LEADER><LEADER>P O<C-r>"<ESC>J

    " Mappings for warnings from Worp/Ale in the style of unimpaired-next
    "nmap <silent> [W <Plug>(ale_first)
    "nmap <silent> [w <Plug>(ale_previous)
    "nmap <silent> ]w <Plug>(ale_next)
    "nmap <silent> ]W <Plug>(ale_last)
    "}}}-----------------------------------------------------------------------
    "{{{- splits --------------------------------------------------------------
    " generate new vertical split with \ (which has | on it)
    " and switch to next buffer (if there's more than one buffer)
    nnoremap <LEADER>\ :vsplit<CR>:bnext<CR>
    " generate new horizontal split with - and switch to next buffer (if
    " there's more than one buffer)
    nnoremap <LEADER>- :split<CR>:bnext<CR>

    " open current split in own tab (like zoom in tmux) and keep cursor " pos
    nnoremap <LEADER>z mx:tabedit %<CR>g`x

    " close current buffer, keep window and switch to last used buffer
    nnoremap <LEADER>x :b# \| bd #<CR>

    " split vim into 4 windows, load first and second files on buffers 1 and 2.
    " make the bottom windows short and load scratch*.m
    " THIS CAN BE REMOVED ONCE I MASTER THE :MKSESSION TYPE COMMANDS
    nnoremap <silent><LEADER>4 :call WorkSplit()<CR>

    " resize windows (and make it repeatable with dot command)
    " widen the split
    nmap <LEADER>H <Plug>WidenSplit
    nnoremap <silent><Plug>WidenSplit :exe "vertical resize +5"<CR>
                \ :call repeat#set("\<Plug>WidenSplit")<CR>
    " thin the split
    nmap <silent><LEADER>h <Plug>ThinSplit
    nnoremap <Plug>ThinSplit :exe "vertical resize -5"<CR>
                \ :call repeat#set("\<Plug>ThinSplit")<CR>
    " heighten the split
    nmap <silent><LEADER>J <Plug>HeightenSplit
    nnoremap <Plug>HeightenSplit :exe "resize +3"<CR>
                \ :call repeat#set("\<Plug>HeightenSplit")<CR>
    " shorten the split
    nmap <silent><LEADER>j <Plug>ShortenSplit
    nnoremap <Plug>ShortenSplit :exe "resize -3"<CR>
                \ :call repeat#set("\<Plug>ShortenSplit")<CR>

    " anytime we read in a buffer, if it came from w3m then write to scratch
    autocmd BufReadPost * :call WriteW3MToScratch()

    " open/close horizontal split containing w3m_scratch
    nnoremap <LEADER>w :call ToggleW3M()<CR>
    "}}}-----------------------------------------------------------------------
    "{{{- searching and substitution ------------------------------------------
    " toggle highlighted searches
    nnoremap <silent><expr> <LEADER>/
                \ (v:hlsearch ? ':nohls' : ':set hls')."\n"

    " substitute word under the cursor
    nnoremap <LEADER>* :%s/\<<C-r><C-w>\>/
    "}}}-----------------------------------------------------------------------
    "{{{- common files to edit/source -----------------------------------------
    " edit/source common file in split window

    nnoremap <LEADER>ev :vsplit $MYVIMRC<CR>
    nnoremap <LEADER>sv :source $MYVIMRC<CR>

    nnoremap <LEADER>eb :vsplit
                \ /home/mattb/linux_config_files/base_bashrc<CR>
    nnoremap <LEADER>ea :vsplit
                \ /home/mattb/linux_config_files/aliases_multihost/base_aliases<CR>
    nnoremap <LEADER>ef :vsplit
                \ /home/mattb/linux_config_files/functions_multihost/base_functions<CR>
    nnoremap <LEADER>et :vsplit
                \ /home/mattb/linux_config_files/tmux.conf<CR>
    "}}}-----------------------------------------------------------------------
    "{{{- copy and paste with clipboard ---------------------------------------
    " paste from system CTRL-C clipboard
    nnoremap <LEADER>p "+p
    " paste from system highlighted clipboard
    nnoremap <LEADER>P "*p
    " copy contents of unnamed register to system CTRL-C clipboard
    nnoremap <silent><LEADER>y :call Preserve("normal! Gp\"+dGu")<CR>
                \ :echo 'copied to CTRL-C clipboard'<CR>
    " copy contents of unnamed register to system highlighted clipboard
    nnoremap <silent><LEADER>Y :call Preserve("normal! Gp\"*dGu")<CR>
                \ :echo 'copied to highlight clipboard'<CR>
    "}}}-----------------------------------------------------------------------
    "{{{- spelling and abbreviations-------------------------------------------
    " instantly go with first spelling suggestion
    nnoremap <LEADER>sp a<C-x>s<ESC>
    " common mispellings
    iabbrev keybaord keyboard
    iabbrev laod load
    iabbrev hte the
    " emails
    iabbrev @g bennettmatt4@gmail.com
    iabbrev @u matthew.bennett@uclouvain.be
    "}}}-----------------------------------------------------------------------
augroup END
"}}}---------------------------------------------------------------------------
"{{{- file specific settings --------------------------------------------------
augroup vim "{{{
    autocmd!
    " start out with everything folded away
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
    autocmd FileType vim setlocal foldlevelstart=0
augroup END
"}}}
augroup vim help "{{{
    autocmd!
    autocmd FileType help setlocal number
    autocmd FileType help setlocal relativenumber
"}}}
augroup python "{{{
    autocmd!
    set completeopt-=preview "don't have preview window on python autocomplete
    " avoid conversion issues when checking into GitHub and/or sharing with other users.
    autocmd FileType python setlocal fileformat=unix
    " enable all Python syntax highlighting features
    autocmd FileType python let python_highlight_all=1
    autocmd FileType python setlocal foldmethod=indent

    " print a variable under the cursor
    autocmd FileType python nmap <LEADER>q mxyiwO<ESC>pIprint(<ESC>A)<ESC>
                \<Plug>SlimeLineSend<ESC>ddg`xu

    " open/close the full python docs on thing under the cursor
    nnoremap <LEADER>cd :call YCM_Toggle_Docs()<CR>

augroup END
"}}}
augroup matlab "{{{
    autocmd!
    " make gcc comment matlab correctly
    autocmd FileType matlab setlocal commentstring=%\ %s
    autocmd FileType matlab setlocal foldmethod=indent

    " abbreviations
    autocmd FileType matlab iabbrev <buffer> fig figure
    autocmd FileType matlab iabbrev <buffer> key keyboard
    autocmd FileType matlab iabbrev <buffer> dbq dbquit
    autocmd FileType matlab iabbrev <buffer> dbc dbcont

    "{{{ - variables/functions under the cursor -------------------------------
    " send the variable under the cursor to matlab
    autocmd FileType matlab nmap <LEADER>cq viw<Plug>SlimeRegionSend

    " print documentation of matlab function
    autocmd FileType matlab nmap <LEADER>cd mxyiwO<ESC>pIhelp <ESC>
                \<Plug>SlimeLineSend<ESC>ddg`xu

    " ask whos a variable under the cursor
    autocmd FileType matlab nmap <LEADER>cw mxyiwO<ESC>pIwhos <ESC>
                \<Plug>SlimeLineSend<ESC>ddg`xu

    " imagesc <motion>
	autocmd FileType matlab noremap <silent> <LEADER>ci
                \ :set opfunc=MatlabImagesc<CR>g@
    " plot <motion>
	autocmd FileType matlab noremap <silent> <LEADER>cp
                \ :set opfunc=MatlabPlot<CR>g@
    " histogram <motion>
	autocmd FileType matlab noremap <silent> <LEADER>ch
                \ :set opfunc=MatlabHist<CR>g@
    " summary info of <motion>
	autocmd FileType matlab noremap <silent> <LEADER>cs
                \ :set opfunc=MatlabSummarise<CR>g@
    "}}}-----------------------------------------------------------------------
    "{{{ - function documentation ---------------------------------------------
    " clean documentation after func snip (remove lines with unused arguments)
    autocmd FileType matlab nnoremap <LEADER>dc
                \ :g/% arg :/norm dap <CR>
                \ :g/optional_/d <CR> :%s/arg, //g <CR>G

    " add any optional variables to the help docs LEAVE THE SPACE AT THE $!! 
    autocmd FileType matlab nnoremap <LEADER>dh 
                \/set default values for optional variables<CR>j0wy}zR
                \/'\\n'],<CR>pms
                \v}k$:norm f=d$<CR>
                \}yy'sPjwv}k$
                \:norm ^i['\n<CR>
                \'sv}k$: norm $i'],...<CR>
                \'skdd=}}2ddG
    "}}}-----------------------------------------------------------------------
augroup END
"}}}
augroup markdown "{{{
    autocmd!
    autocmd FileType markdown setlocal spell
    " inside headed title:
    autocmd FileType markdown onoremap iht :<C-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rwvg_"<CR>
    " around headed title:
    autocmd FileType markdown onoremap aht :<C-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rvg_"<CR>
    " inside headed body:
    autocmd FileType markdown onoremap ihb :<C-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rjv/^#\\+ \\w\\+.*$\rk"<CR>
    " around headed body:
    autocmd FileType markdown onoremap ahb :<C-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rv/^#\\+ \\w\\+.*$\rk"<CR>
augroup END
"}}}
augroup tex "{{{
    autocmd!
    autocmd FileType tex setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType tex setlocal foldlevel=0
    autocmd FileType tex setlocal foldlevelstart=0

    " gq until a line beginning with \
    " I figured out the macro (that's everything after the :), but I've
    " forgotten how to do the remap commands
    " nnoremap <LEADER>g :^ms/\\k$me`sgq`en:noh
    " a year later, I think maybe this?
    " nnoremap <LEADER>g :^ms/\\<CR>$me`sgq`en:noh
augroup END
"}}}
augroup tmux "{{{
    autocmd!
    autocmd FileType tmux setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType tmux setlocal foldlevel=0
    autocmd FileType tmux setlocal foldlevelstart=0
augroup END
"}}}
augroup tidy_code_matlab_and_python "{{{
    autocmd!
    " remove trailing whitespace and perform auto indent when writing
    autocmd BufWritePre *.py,*.m :call Preserve("%s/\\s\\+$//e")
    autocmd BufWritePre *.m :call Preserve("normal! gg=G")
augroup END
"}}}
"}}}---------------------------------------------------------------------------
"{{{- cursor behaviour --------------------------------------------------------
augroup cursor_behaviour
    autocmd!
    " reset cursor on start:
    autocmd VimEnter * silent !echo -ne "\e[2 q"
    " cursor blinking bar on insert mode
    let &t_SI = "\e[5 q"
    " cursor steady block on command mode
    let &t_EI = "\e[2 q"
    " highlight current line when in insert mode
    autocmd InsertEnter * set cursorline
    " turn off current line highlighting when leaving insert mode
    autocmd InsertLeave * set nocursorline
augroup END
"}}}---------------------------------------------------------------------------
"==============================================================================
"
