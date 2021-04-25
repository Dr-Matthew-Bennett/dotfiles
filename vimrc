"{{{- wish list ---------------------------------------------------------------

" For targets.vim not to go crazy anytime I source my vimrc

" automatic folding for markdown sections

" for <Leader>\ to use :b# only when the # exists, otherwise use :bn

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
Plugin 'Matt-A-Bennett/vim-indent-object'
Plugin 'SirVer/ultisnips'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'jpalardy/vim-slime'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'markonm/traces.vim'
Plugin 'simnalamburt/vim-mundo'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/MatlabFilesEdition'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'ycm-core/YouCompleteMe'
"}}}
"{{{- plugins I'm trying out---------------------------------------------------
" lots more text objects! looks very good and well made
" Plugin 'dense-analysis/ale'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'vim-scripts/Tabmerge' 
Plugin 'wellle/targets.vim'
"}}}
"{{{ - plugins I may want to try one day --------------------------------------
" Plugin 'airblade/vim-gitgutter'
" Plugin 'scrooloose/nerdtree'
" Plugin 'tommcdo/vim-lion'
" Plugin 'tpope/vim-eunuch'

" This one only works for NeoVim... but it allows to have neo(vim) run in the
" areas of a browser where you'd enter text (so maybe sending an email etc.)
" The Primeagen explains: https://www.youtube.com/watch?v=ID_kNcj9cMo
" Plugin 'glacambre/firenvim'
"}}}
"{{{ - call vundle and override things -----------------------------------------
" All of your Plugins must be added before the following line
call vundle#end() " required
" I want to override one of the defaults here, so load it now then overwrite
runtime! plugin/sensible.vim
"}}}---------------------------------------------------------------------------
"==============================================================================

"==== PLUGIN CONFIGURATIONS AND REMAPS ========================================
"{{{- remap leader key --------------------------------------------------------
"make the space bar my leader key (must be before I make <Leader> mappings)
noremap <Space> <Nop>
sunmap <Space>
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
    " insert mode line completion
    imap ;l <Plug>(fzf-complete-line)
    " search for and open file under the fzf default directory
    nnoremap <Leader>f :Files<cr>
    " search for and jump to line in any open buffer
    nnoremap <Leader>l :Lines<cr>
    " search through and jump to buffer
    nnoremap <Leader>b :Buffers<cr>

    " when I search for a file, show results in a window at the bottom
    let g:fzf_layout = { 'down': '~40%' }

    " Change CTRL-X to CTRL-V to open file from fzf in vertical split
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-h': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Ag call a modified version of Ag where first arg is directory to search
    command! -bang -nargs=+ -complete=dir Ag call s:ag_in(<bang>0, <f-args>)
"}}}---------------------------------------------------------------------------
"{{{- mundo -------------------------------------------------------------------
" to see and choose a previous state from the undo tree
nnoremap <F5> :MundoToggle<cr>
"}}}---------------------------------------------------------------------------
"{{{- targets.vim -------------------------------------------------------------
" Only consider targets fully visible on screen:
" let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa'

" Same as above, but prioritise pairs fully on line coming before the cursor
" (ll) more than stuff fully off the line (bb and aa)
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb al ll bb aa'

" Controls the keys used in maps for seeking next and last text objects.
let g:targets_nl = 'nN'
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
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
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
" pane of my choice.  You can set the target manually using hitting C-c and
" then v.
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
xmap <Leader>s <Plug>SlimeRegionSend
" Send {motion}.
nmap <Leader>s <Plug>SlimeMotionSend
" Send {count} line(s)
nmap <Leader>ss <Plug>SlimeLineSend
" }}}--------------------------------------------------------------------------
"{{{- vim-tmux-navigator ------------------------------------------------------
" disable tmux navigator when zooming the vim pane
let g:tmux_navigator_disable_when_zoomed = 1
" }}}--------------------------------------------------------------------------
"{{{- YouCompleteMe -----------------------------------------------------------
" YouCompleteMe has a few filetypes that it doesn't work on by default.
" I removed markdown from this list and it seems to work just fine.
let g:ycm_filetype_blacklist = {
            \ 'tagbar': 1,
            \ 'notes': 1,
            \ 'netrw': 1,
            \ 'unite': 1,
            \ 'text': 1,
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
    else
        colorscheme seoul256-light
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
"{{{- Ag: Start ag in the specified directory ---------------------------------
" e.g.
"   :Ag ~/foo
function! s:ag_in(bang, ...)
  if !isdirectory(a:1)
    throw 'not a valid directory: ' .. a:1
  endif
  " Press `?' to enable preview window.
  call fzf#vim#ag(join(a:000[1:], ' '),
              \ fzf#vim#with_preview({'dir': a:1}, 'right:50%', '?'), a:bang)
endfunction
"}}}---------------------------------------------------------------------------
"{{{- make a 4-way split and resize the windows how I like --------------------
function! WorkSplit()
    let l:currentWindow=winnr()
    execute "normal! :vsplit\<cr> :buffer 2\<cr>"
    execute "normal! :split\<cr> :resize -20\<cr> :b scratch2\<cr>"
    execute l:currentWindow . "wincmd w"
    execute "normal! :split\<cr> :resize -20\<cr> :b scratch1\<cr>"
endfunction
"}}}---------------------------------------------------------------------------
"{{{- open a new help page in a new split -------------------------------------
function! NewHelpSplit(subject)
    let current_tabpage = string(tabpagenr())
    " open a help page in a new tab
    :execute ':tab :help ' a:subject
    " merge that tab as a split in current tab (bottom, means the original tab
    " content will be on the bottom, and therefore the help will be on the top)
    :execute ':Tabmerge ' current_tabpage ' bottom'
    " move the cursor the the newest help (basically just go up like a madman)
    :execute 'wincmd k'
    :execute 'wincmd k'
    :execute 'wincmd k'
    :execute 'wincmd k'
endfunction

" make the above function easy to use like :NHelp topic
:command -nargs=1 NHelp :call NewHelpSplit("<args>")
"}}}---------------------------------------------------------------------------
"{{{- smoothly scroll the screen up and down ----------------------------------
function SmoothScroll(scroll_direction, n_scroll)
    let n_scroll = a:n_scroll
    if a:scroll_direction == 1
        let scrollaction=""
    else 
        let scrollaction=""
    endif
    exec "normal " . scrollaction
    redraw
    let counter=1
    while counter<&scroll*n_scroll
        let counter+=1
        sleep 8m " ms per line
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction
"}}}---------------------------------------------------------------------------
"{{{- restore cursor position ------------------------------------------------
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
"{{{- last search term --------------------------------------------------------
function! LastSearch()
    return @/
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
        " silent :execute "normal! o \<Esc>"
        " reassign variable for use in code
        silent :execute "normal! o V__ = \<Esc>\"mpA;"
        :call MatlabExecuteCode()
    endfunction

    function! MatlabExecuteCode()
        " create a space after
        silent :execute "normal! o \<Esc>"
        " move back line below mark, and visually select to end of paragraph
        silent :execute "normal! `xj0v}"
        " send it to the tmux window
        silent :execute "normal\<Plug>SlimeRegionSend"
        " move cursor back to original position
        silent :execute "normal! \"_dd`xu"
    endfunction
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
set scrolloff=8 " show 8 lines between cursor and top/bottom of page
set cc=80 "show vertical bar at 80 columns
set textwidth=79 " at 79 columns, wrap text
set linebreak " wrap long lines at char in 'breakat' (default " ^I!@*-+;:,./?")
set nowrap " don't wrap lines by default
set wildmenu " list completion options when typing in command line mode
set wildmode=list:full
" set wildmode=longest,list " behave like bash autocomplete rather than zsh
set wildignorecase " ignore case when completing file names
set expandtab " expand tabs into spaces
set tabstop=4 " a tab is the same as 4 spaces
set softtabstop=4 " when I hit <tab> in insert mode, put 4 spaces
set shiftwidth=4 " when auto-indenting, use 4 spaces per tab
set autoindent " when creating a new line, copy indent from line above
set nojoinspaces " don't join with double spaces when line ending with ./!/?
set showmatch " show the matching part of the pair for [] {} and ()
set incsearch " show matches for patterns while they are being typed
set hlsearch | noh " highlight matches for searched (turn off when sourcing)
set smartcase " with both on, searches with no capitals are case insensitive...
set ignorecase " ...while searches with capital characters are case sensitive.
set nrformats= " don't interpret 007 as octal (<C-a> will make 008, not 010)
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
" path/file
set statusline=%<%f\
" current git branch
set statusline+=%{FugitiveStatusline()}
" is this file: help? modified? read only?
set statusline+=%h%m%r%=
" line / column number
set statusline+=%-14.(%l,%c%V%)
" last search term
set statusline+=\/%{LastSearch()}\/
" space (there must be a proper way to do this)
set statusline+=\ \ \ \ \ 
" percent through the file (or top/bottom)
set statusline+=%P
"}}}---------------------------------------------------------------------------
"{{{- general remaps ----------------------------------------------------------
augroup general
    autocmd!
    "{{{- colorscheme switches ------------------------------------------------
    " If the syntax highlighting goes weird, F12 to redo it
    nnoremap <F12> :syntax sync fromstart<cr>
    nnoremap <Leader>o :call ToggleLightDarkColorscheme()<cr>
    autocmd FocusGained * :call SetColorScheme()
    " anytime we read in a buffer, if it came from w3m then write to scratch
    autocmd BufReadPost * :call WriteW3MToScratch()
    "}}}-----------------------------------------------------------------------
    "{{{- movements and text objects ------------------------------------------
    " let g modify insert/append to work on visual lines, in the same way as it
    " modifies motions like 0 and $
    nnoremap gI g0i
    nnoremap gA g$i

    " smoothly scroll the screen for some scrolling operations
    nnoremap <C-U> :call SmoothScroll(1,1)<cr>
    nnoremap <C-D> :call SmoothScroll(2,1)<cr>
    nnoremap <C-B> :call SmoothScroll(1,2)<cr>
    nnoremap <C-F> :call SmoothScroll(2,2)<cr>

    " store relative line number jumps in the jumplist.
    nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
    nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

    " inner/around line text objects
    " visual mode
    xnoremap <silent> il <Esc>^vg_
    xnoremap <silent> al <Esc>0v$
    " operator pending mode
    onoremap <silent> il :<C-U>normal! ^vg_<CR>
    onoremap <silent> al :<C-U>normal! 0v$<CR>

    " paste at end of line, with an automatic space
    nnoremap <Leader><Leader>p o<C-r>"<Esc>kJ
    " paste at start of line, with an automatic space
    nnoremap <Leader><Leader>P O<C-r>"<Esc>J

    " Mappings for warnings from Worp/Ale in the style of unimpaired-next
    nmap <silent> [W <Plug>(ale_first)
    nmap <silent> [w <Plug>(ale_previous)
    nmap <silent> ]w <Plug>(ale_next)
    nmap <silent> ]W <Plug>(ale_last)
    "}}}-----------------------------------------------------------------------
    "{{{- splits --------------------------------------------------------------
    " generate new vertical split with \ (which has | on it)
    " and switch to next buffer (if there's more than one buffer)
    nnoremap <Leader>\ :vsplit<cr>:bnext<cr>
    " generate new horizontal split with - and switch to next buffer (if
    " there's more than one buffer)
    nnoremap <Leader>- :split<cr>:bnext<cr>

    " open current split in own tab (like zoom in tmux) and keep cursor " pos
    nnoremap <Leader>z mx:tabedit %<cr>g`x

    " close current buffer, keep window and switch to last used buffer
    nnoremap <Leader>x :b# \| bd #<cr>

    " split vim into 4 windows, load first and second files on buffers 1 and 2.
    " make the bottom windows short and load scratch*.m
    nnoremap <silent><Leader>4 :call WorkSplit()<cr>

    " resize windows (and make it repeatable with dot command)
    " widen the split
    nmap <Leader>H <Plug>WidenSplit
    nnoremap <silent><Plug>WidenSplit :exe "vertical resize +5"<cr>
                \ :call repeat#set("\<Plug>WidenSplit")<CR>
    " thin the split
    nmap <silent><Leader>h <Plug>ThinSplit
    nnoremap <Plug>ThinSplit :exe "vertical resize -5"<cr>
                \ :call repeat#set("\<Plug>ThinSplit")<CR>
    " heighten the split
    nmap <silent><Leader>J <Plug>HeightenSplit
    nnoremap <Plug>HeightenSplit :exe "resize +3"<cr>
                \ :call repeat#set("\<Plug>HeightenSplit")<CR>
    " shorten the split
    nmap <silent><Leader>j <Plug>ShortenSplit
    nnoremap <Plug>ShortenSplit :exe "resize -3"<cr>
                \ :call repeat#set("\<Plug>ShortenSplit")<CR>

    " open/close horizontal split containing w3m_scratch
    nnoremap <leader>w :call ToggleW3M()<cr>

    "}}}-----------------------------------------------------------------------
    "{{{- searching and substitution ------------------------------------------
    " toggle highlighted searches
    nnoremap <silent><expr> <Leader>/
                \ (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

    " substitute word under the cursor
    nnoremap <Leader>* :%s/\<<C-r><C-w>\>/
    "}}}-----------------------------------------------------------------------
    "{{{- common files to edit/source -----------------------------------------
    " edit/source common file in split window
    nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
    nnoremap <Leader>sv :source $MYVIMRC<cr>

    nnoremap <Leader>eb :vsplit
                \ /home/mattb/linux_config_files/base_bashrc<cr>
    nnoremap <Leader>ea :vsplit
                \ /home/mattb/linux_config_files/aliases_multihost/base_aliases<cr>
    nnoremap <Leader>ef :vsplit
                \ /home/mattb/linux_config_files/functions_multihost/base_functions<cr>
    nnoremap <Leader>et :vsplit
                \ /home/mattb/linux_config_files/tmux.conf<cr>
    "}}}-----------------------------------------------------------------------
    "{{{- copy and paste with clipboard ---------------------------------------
    " paste from system CTRL-C clipboard
    nnoremap <Leader>p "+p
    " paste from system highlighted clipboard
    nnoremap <Leader>P "*p
    " copy contents of unnamed register to system CTRL-C clipboard
    nnoremap <silent><Leader>y :call Preserve("normal! Gp\"+dGu")<cr>
                \ :echo 'copied to CTRL-C clipboard'<cr>
    " copy contents of unnamed register to system highlighted clipboard
    nnoremap <silent><Leader>Y :call Preserve("normal! Gp\"*dGu")<cr>
                \ :echo 'copied to highlight clipboard'<cr>
    "}}}-----------------------------------------------------------------------
    "{{{- abbreviations -------------------------------------------------------
    " emails
    iabbrev @g bennettmatt4@gmail.com
    iabbrev @u matthew.bennett@uclouvain.be
    " common mispellings
    iabbrev keybaord keyboard
    iabbrev laod load
    iabbrev hte the
    "}}}-----------------------------------------------------------------------
    "{{{- spelling ------------------------------------------------------------
    " instantly go with first spelling suggestion
    nnoremap <Leader>sp a<C-X>s<Esc>
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

    " search vim help for word under the cursor
    " (not working right - overwriting matlab version)
    " autocmd FileType vim nmap <Leader>d "hyiw :help <c-r>h<cr>

augroup END
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
    autocmd FileType python nmap <Leader>q mxyiwO<Esc>pIprint(<Esc>A)<Esc>
                \<Plug>SlimeLineSend<Esc>ddg`xu

    " open/close the full python docs on thing under the cursor
    nnoremap <Leader>cd :call YCM_Toggle_Docs()<cr>

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
    autocmd FileType matlab nmap <Leader>cq viw<Plug>SlimeRegionSend

    " print documentation of matlab function
    autocmd FileType matlab nmap <Leader>cd mxyiwO<Esc>pIhelp <Esc>
                \<Plug>SlimeLineSend<Esc>ddg`xu

    " ask whos a variable under the cursor
    autocmd FileType matlab nmap <Leader>cw mxyiwO<Esc>pIwhos <Esc>
                \<Plug>SlimeLineSend<Esc>ddg`xu

    " imagesc <motion>
	autocmd FileType matlab noremap <silent> <Leader>ci
                \ :set opfunc=MatlabImagesc<CR>g@
    " plot <motion>
	autocmd FileType matlab noremap <silent> <Leader>cp
                \ :set opfunc=MatlabPlot<CR>g@
    " histogram <motion>
	autocmd FileType matlab noremap <silent> <Leader>ch
                \ :set opfunc=MatlabHist<CR>g@
    " summary info of <motion>
	autocmd FileType matlab noremap <silent> <Leader>cs
                \ :set opfunc=MatlabSummarise<CR>g@
    "}}}-----------------------------------------------------------------------
    "{{{ - function documentation ---------------------------------------------
    " clean documentation after func snip (remove lines with unused arguments)
    autocmd FileType matlab nnoremap <Leader>dc
                \ :g/% arg :/norm dap <cr>
                \ :g/optional_/d <cr> :%s/arg, //g <cr>G

    " add any optional variables to the help docs LEAVE THE SPACE AT THE $!! 
    autocmd FileType matlab nnoremap <Leader>dh 
                \/set default values for optional variables<cr>j0wy}zR
                \/'\\n'],<cr>pms
                \v}k$:norm f=d$<cr>
                \}yy'sPjwv}k$
                \:norm ^i['\n<cr>
                \'sv}k$: norm $i'],...<cr>
                \'skdd=}}2ddG
    "}}}-----------------------------------------------------------------------
augroup END
"}}}
augroup markdown "{{{
    autocmd!
    autocmd FileType markdown setlocal spell
    " inside headed title:
    autocmd FileType markdown onoremap iht :<c-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rwvg_"<cr>
    " around headed title:
    autocmd FileType markdown onoremap aht :<c-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rvg_"<cr>
    " inside headed body:
    autocmd FileType markdown onoremap ihb :<c-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rjv/^#\\+ \\w\\+.*$\rk"<cr>
    " around headed body:
    autocmd FileType markdown onoremap ahb :<c-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rv/^#\\+ \\w\\+.*$\rk"<cr>
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
    " nnoremap <Leader>g :^ms/\\k$me`sgq`en:noh
"}}}
augroup tmux "{{{
    autocmd!
    autocmd FileType tmux setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType tmux setlocal foldlevel=0
    autocmd FileType tmux setlocal foldlevelstart=0
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

