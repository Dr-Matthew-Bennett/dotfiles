"{{{- wish list ---------------------------------------------------------------

" For vim-tmux-focus-events not to throw error on switching external windows:
" Error detected while processing function <SNR>39_do_autocmd[3]..FocusGained
" Autocommands for "*"..function tmux_focus_events#focus_gained:
"
" Update: this plugin is now obsolete and no longer needed as both neovim and
" vim (since version 8.2.2345) have native support for this functionality.

" Create a funtion like Preserve() that preserves the unnamed register

" A way to set all vim buffers to target a particular tmux pane via slime
"}}}---------------------------------------------------------------------------

"==== PLUGINS, ASSOCIATED CONFIGURATIONS AND REMAPS ===========================
"{{{- load plugins (and setup vundle) -----------------------------------------
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
"}}}---------------------------------------------------------------------------
"{{{- plugins I use -----------------------------------------------------------
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins I would put in a new vimrc
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'

" other plugins that do more exotic things
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jpalardy/vim-slime'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'markonm/traces.vim'
Plugin 'Dr-Matthew-Bennett/vim-surround-funk'
Plugin 'simnalamburt/vim-mundo'
Plugin 'simeji/winresizer'
" Plugin 'SirVer/ultisnips'
Plugin 'skywind3000/vim-auto-popmenu'
Plugin 'tmux-plugins/vim-tmux-focus-events'
" Update: vim-tmux-focus-events is now obsolete and no longer needed as both
" neovim and vim (since version 8.2.2345) have native support for this
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'wellle/targets.vim'
" Plugin 'ycm-core/YouCompleteMe'

" plugins that I've forgotten what they do
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'vim-scripts/indentpython.vim'
"}}}---------------------------------------------------------------------------
"{{{- plugins I'm trying out---------------------------------------------------
Plugin 'bronson/vim-visual-star-search'
Plugin 'romainl/vim-cool'
" Plugin 'wellle/tmux-complete.vim'
Plugin 'Konfekt/complete-common-words.vim'
Plugin 'Dr-Matthew-Bennett/tmux-complete.vim'
"}}}---------------------------------------------------------------------------
"{{{- plugins I may want to try one day ---------------------------------------
" Plugin 'airblade/vim-gitgutter'
" Plugin 'dense-analysis/ale'
" Plugin 'machakann/vim-swap'
" Plugin 'tommcdo/vim-lion'
" Plugin 'tommcdo/vim-exchange'
" Plugin 'tpope/vim-eunuch'
" Plugin 'tpope/vim-obsession'
" Plugin 'tpope/vim-vinegar'
" Plugin 'junegunn/vim-easy-align'
" Plugin 'kana/vim-arpeggio'
"}}}---------------------------------------------------------------------------
"{{{- plugins I'm working on --------------------------------------------------
Plugin 'Dr-Matthew-Bennett/vim-unit-test'
" Plugin 'Dr-Matthew-Bennett/vim-visual-history'
"}}}---------------------------------------------------------------------------
"{{{- call vundle and load things from runtime paths --------------------------
" All of your Plugins must be added before the following line
call vundle#end() " required
" I want to override one of the defaults here, so load it now then overwrite
runtime! plugin/sensible.vim
" use % sign to jump between if, else, end
runtime! macros/matchit.vim
" be able to read man pages with :Man <program name>
runtime! ftplugin/man.vim
"}}}---------------------------------------------------------------------------
"}}}---------------------------------------------------------------------------
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
" insert mode line completion (include all text in other tmux panes)
imap ;l <Esc>:call AllTmuxPanesToBuffer()<CR>a<Plug>(fzf-complete-line)

augroup fzf
    " once fzf window is poplulated, remove the buffer holding the tmux stuff
    autocmd FileType fzf :call WipeBufferIfExists('.tmux')
augroup END

" when I search for a file, show results in a window at the bottom
let g:fzf_layout = { 'down': '~40%' }

" remove the config for preview window (I prefer vim's default behaviour)
let fzf1 = "--height 80% -m --layout=reverse --marker=o"
let fzf2 = ""
let fzf3 = "--bind ctrl-a:select-all,ctrl-d:deselect-all"
let fzf4 = "--bind ctrl-y:preview-up,ctrl-e:preview-down"
let $FZF_DEFAULT_OPTS = fzf1.' '.fzf2.' '.fzf3.' '.fzf4

" Change CTRL-X to CTRL-l to open file from fzf in vertical split
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-d': 'split',
            \ 'ctrl-l': 'vsplit' }
"}}}---------------------------------------------------------------------------
"{{{- mundo -------------------------------------------------------------------
" to see and choose a previous state from the undo tree
nnoremap <F5> :MundoToggle<CR>
"}}}---------------------------------------------------------------------------
"{{{- targets.vim -------------------------------------------------------------
" Default
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb al rB Al bb aa bB Aa BB AA'
" Only consider targets fully visible on screen:
" let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa'

" Same as above, but prioritise pairs fully on line coming before the cursor
" (ll) more than stuff fully off the line (bb and aa)
" let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb al ll bb aa'

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
""{{{- ultisnips --------------------------------------------------------------
"" Ultisnips trigger configuration.
"" Do not use <TAB> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger=";s"
"let g:UltiSnipsJumpForwardTrigger="<C-n>"
"let g:UltiSnipsJumpBackwardTrigger="<C-p>"
"let g:UltiSnipsEditSplit="vertical"
"" where ultisnips looks for snippets
"" (I think you can add multiple items in the list)
"let g:UltiSnipsSnippetDirectories=["/home/mattb/.vim/ultisnips"]
""}}}--------------------------------------------------------------------------
"{{{ - tmuxcomplete.vim -------------------------------------------------------
let g:tmuxcomplete_pane_index_display_duration_ms = '200'
"}}} --------------------------------------------------------------------------
"{{{- vim-indent-object -------------------------------------------------------
" make repeatable
nnoremap <Plug>innerindent ii ii :call repeat#set("\<Plug>innerindent")<CR>
nnoremap <Plug>aroundindent ai ai :call repeat#set("\<Plug>aroundindent")<CR>
"}}}---------------------------------------------------------------------------
"{{{- vim-slime ---------------------------------------------------------------
" vim-slime lets me send text objects and visual selections from vim to a tmux
" pane of my choice. 
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
" set default target where slime will send text
let g:slime_default_config =
        \ {"socket_name": "default", "target_pane": "{top-left}"}

" since I already set it above, don't ask what the default should be on startup
let g:slime_dont_ask_default = 1

" from :help s
" s is a synonym for 'cl'
" S is a synonym for 'cc'
" so map 's' to: '[s]lime [s]end to target pane'
" send {visual} text.
xmap s <Plug>SlimeRegionSend
" send {motion}.
nmap s <Plug>SlimeMotionSend
" send {count} line(s)
nmap ss <Plug>SlimeLineSend
" change slime target pane mid-session 
nnoremap <LEADER>ss :call ChangeBufferSlimeConfig(200)<CR>
" get all the visible text in a particular tmux pane and suck it in to a buffer 
nnoremap S :call tmuxcomplete#tmux_pane_to_buffer()<CR>
"}}}---------------------------------------------------------------------------
"{{{- vim-surround-funk -------------------------------------------------------
augroup surround_funk
    autocmd!
    autocmd FileType python let b:surround_funk_default_parens = '('
    autocmd FileType python let b:surround_funk_default_hot_switch = 1

    autocmd FileType tex let b:surround_funk_default_parens = '{'
    autocmd FileType tex let b:surround_funk_legal_func_name_chars = ['[0-9]', '[A-Z]', '[a-z]', '_', '\.', '\\']

    autocmd FileType R,r,rmd,Rmd let b:surround_funk_legal_func_name_chars = ['[0-9]', '[A-Z]', '[a-z]', '_', '\.', ':']
augroup END
"}}}---------------------------------------------------------------------------
"{{{- vim-tmux-navigator ------------------------------------------------------
" disable tmux navigator when zooming the vim pane
let g:tmux_navigator_disable_when_zoomed = 1
"}}}---------------------------------------------------------------------------
"{{{- winresizer --------------------------------------------------------------
" the default is 'ctrl-e'... which is useful for scrolling down in normal mode
let g:winresizer_start_key = '<LEADER>w'
let g:winresizer_vert_resize=5
let g:winresizer_horiz_resize=3
"}}}---------------------------------------------------------------------------
"{{{- vim-auto-popmenu --------------------------------------------------------
" enable this plugin for filetypes, '*' for all files.
" {<str>:<int>}
" <str>: filetype
" <int>: number of letters to trigger autocomplete
let g:apc_enable_ft = {'*':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

" don't select the first item.
set completeopt+=menu,menuone,noselect

" suppress annoying messages.
set shortmess+=c

" function to toggle autocomplete of all words in spelling dictionary
function ToggleSpellDict()
    if &dictionary =~ 'spell'
        set dictionary-=spell
    else
        set dictionary+=spell
    endif
endfunction
nnoremap <silent> <LEADER>c :call ToggleSpellDict()<CR>
"}}}---------------------------------------------------------------------------
"{{{- complete-common-words.vim -----------------------------------------------
let username = trim(system('whoami'))
let g:common_words_dicts_dir = '/home/'.username.'/.vim/bundle/complete-common-words.vim/dicts'
"}}}---------------------------------------------------------------------------
"==============================================================================

"==== FUNCTIONS ===============================================================
"{{{- helper functions (for use in other functions) ---------------------------
"{{{- get character under the cursor ------------------------------------------
function! GetCharUnderCursor()
     return getline(".")[col(".")-1]
endfunction
"}}}---------------------------------------------------------------------------
"{{{- wipe buffer if exists ---------------------------------------------------
function! WipeBufferIfExists(buffer)
    if bufexists(a:buffer)
        execute ':bwipeout 'a:buffer
    endif
endfunction                             
"}}}---------------------------------------------------------------------------
"{{{- apply the repeat plugin to any mapping ----------------------------------
" (commands with a quote single will likely cause problems...)
function! Repeat(mapname, map, command)
    execute 'nnoremap <silent> <Plug>'.a:mapname.' '.a:command.
                \' :call repeat#set("\<Plug>'.a:mapname.'")<CR>'
    execute 'nmap '.a:map.' <Plug>'.a:mapname
endfunction
"}}}---------------------------------------------------------------------------
"{{{- display tmux pane indices for N milliseconds-----------------------------
function! DisplayTmuxPaneIndices(duration)
    " bring up the pane numbers as a background job
    call job_start(["tmux", "display-pane", "-d", a:duration])
endfunction                             
"}}}---------------------------------------------------------------------------
"}}}---------------------------------------------------------------------------
"{{{- toggle between light and dark colorscheme -------------------------------
function! SetColorScheme(focus)
    " check if tmux colorscheme is light or dark, and pick for vim accordingly
    if system('tmux show-environment THEME')[0:9] ==# 'THEME=dark'
        colorscheme zenburn
        let $BAT_THEME=''
        if a:focus == 0
            highlight Normal ctermbg=none
        endif
    else
        colorscheme seoul256-light
        let $BAT_THEME='Monokai Extended Light'
        if a:focus == 1
            highlight Normal ctermbg=white
            highlight LineNr ctermbg=lightgrey
        endif
    endif
endfunction

function! ToggleLightDarkColorscheme()
    if system('tmux show-environment THEME')[0:9] ==# 'THEME=dark'
        :silent :!tmux set-environment THEME 'light'
        :silent :!tmux source-file ~/.tmux_light.conf
    else
        :silent :!tmux set-environment THEME 'dark'
        :silent :!tmux source-file ~/.tmux_dark.conf
    endif
    :call SetColorScheme(1)
endfunction
"}}}---------------------------------------------------------------------------
""{{{- handle w3m_scratch file and toggle split to use it ---------------------
"function! WriteW3MToScratch()
"    " only if the file matches this highly specific reg exp will we do anything
"    "(e.g. a file that looks like: .w3m/w3mtmp{some numbers}-{number})
"    if match(@%, "\.w3m/w3mtmp\\d\\+-\\d") !=# -1
"        :silent! wq! /tmp/w3m_scratch
"    endif
"endfunction

"function! ToggleW3M()
"    if bufexists("/tmp/w3m_scratch")
"        :bwipeout! /tmp/w3m_scratch
"    else
"        :silent! split /tmp/w3m_scratch
"    endif
"endfunction
""}}}--------------------------------------------------------------------------
"{{{- if vim was initiated by <Esc-v> in bash, take evasive action ------------
function! CheckBashEdit()
    " if the file matches this highly specific reg exp, comment the line
    "(e.g. a file that looks like: /tmp/bash-fc.xxxxxx)
    if match(@%, "\/tmp\/bash-fc\.......") !=# -1
        " comment out the command
        silent! execute ":%normal! I# "
        write
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
"{{{- restore cursor position -------------------------------------------------
" run a command, but put the cursor back when it's done
function! Preserve(command, is_func)
    " save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    if a:is_func ==# 1
        execute a:command()
    else
        execute a:command
    endif
    " restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
"}}}---------------------------------------------------------------------------
"{{{- create/delete space around cursor/current line --------------------------
function! CreateBlankLineAboveAndBelow()
    call append(line('.')-1, '')
    call append('.', '')
endfunction

function! DeleteLineAbove()
    call deletebufline('', line('.')-1, line('.')-1)
endfunction

function! DeleteLineBelow()
    call deletebufline('', line('.')+1, line('.')+1)
endfunction

function! DeleteBlankLineAboveAndBelow()
    call DeleteLineAbove()
    call DeleteLineBelow()
endfunction

function! CreateSurroundingSpace()
    silent! execute "normal! i \<ESC>la \<ESC>hh"
endfunction

function! DeleteSurroundingSpace()
    let original_line_length = strlen(getline('.'))
    let c = col('.')
    if GetCharUnderCursor() ==# ' '
        silent! execute 'normal! w'
    endif
    if search('[^ ] ', 'be', line('.'))
        silent! execute 'normal! dw'
    endif
    if search(' ', '', line('.'))
        silent! execute 'normal! dw'
    endif
    let new_line_length= strlen(getline('.'))
    let shrink = original_line_length - new_line_length
    call cursor(line('.'), c-shrink+1)
endfunction
"}}}---------------------------------------------------------------------------
"{{{- paste at above/below/end of line ----------------------------------------
function! PasteAtEndOfLine(motion)
    let to_paste = getreg('"')
    execute 'normal! '.a:motion
    let l = line(".")
    let c = col(".")
    let left = a:motion == '^'
    let right = a:motion == '$'
    call append(l-left, to_paste)
    call cursor(l, c)
    execute ':join'
    execute ':substitute/[\x0]//e'
    call cursor(l, c - left + right)
endfunction

function! PasteUnammedLinewise(motion)
    if a:motion ==# 'j'
        :put
    elseif a:motion ==# 'k'
        :-put
    endif
    execute 'normal! =='
    execute 'normal! ^h'
endfunction

" function! TrimWhiteSpace(str, where)
"     if a:where == 'lead' || a:where == 'both'
"         let pattern = '^\s*\(.*\)\s*'
"     elseif a:where == 'lead'
"         let pattern = '^\s*\(.*\)'
"     elseif a:where == 'end'
"         let pattern = '\(.*\)\s*'
"     endif
"     let str = substitute(a:str, pattern, '\1', 'g')
"     return str
" endfunction
"}}}---------------------------------------------------------------------------
"{{{- calculate remaining jumps -----------------------------------------------
if v:version > 801
    function! RemainingJumps()
      let [l:jumplist, l:pos] = getjumplist()
      return max([0, len(l:jumplist) - l:pos - 1])
    endfunction
endif
"}}}---------------------------------------------------------------------------
"{{{- search the help docs with ag and fzf ------------------------------------
function! Help_AG()
    let orig_file = expand(@%)
    let v1 = v:version[0]
    let v2 = v:version[2]
    " search in the help docs with ag-silver-search and fzf and open file
    execute "normal! :Ag /usr/share/vim/vim".v1.v2."/doc/\<CR>"
    " " if we opened a help doc
    " if orig_file !=# expand(@%)
    "     set nomodifiable
    "     " for some reason not all the tags work unless I open the 'real' help
    "     " so get whichever help was found and open it through Ag
    "     let help_doc=expand("%:t")
    "     " open and close that help doc - now the tags will work
    "     execute "normal! :tab :help " help_doc "\<CR>:q\<CR>"
    " endif
endfunction

" get some help
command! H :call Help_AG()
"}}}---------------------------------------------------------------------------
"{{{- move halfway along line (ignore whitespaces) ----------------------------
function! BetterGmNormalMode()
    execute 'normal! ^'
    let first_col = virtcol('.')
    execute 'normal! g_'
    let last_col  = virtcol('.')
    execute 'normal! ' . (first_col + last_col) / 2 . '|'
endfunction
"}}}---------------------------------------------------------------------------
"{{{- contiguously scroll left right along a line -----------------------------
function! HorizontalScrollMode(call_char)
    if &wrap
        return
    endif
    echohl Title
    let typed_char = a:call_char
    while index(['h', 'l', 'H', 'L'], typed_char) != -1
        execute 'normal! z'.typed_char
        redraws
        echon '-- Horizontal scrolling mode (h/l/H/L)'
        let typed_char = nr2char(getchar())
    endwhile
    echohl None | echo '' | redraws
endfunction
"}}}---------------------------------------------------------------------------
""{{{- text object for visual number ------------------------------------------
"function! VisualNumber(direction)
"    " find the end of a number (we assume a decimal means it's not the end)
"    call search('\d\([^0-9\.]\|$\)', a:direction.'W')
"    normal! v
"    " find the beggininng of that number (again, we don't stop for a decimal)
"    call search('\(^\|[^0-9\.]\d\)', 'becW')
"endfunction
""}}}--------------------------------------------------------------------------
"{{{- text object for backtick defined code -----------------------------------
function! BacktickCodeBlock(inner)
    let l = line('.')
    let c = col('.')
    normal! $

    let start_row = searchpos('^\s*```', 'bnW')
    let end_row = searchpos('^\s*```', 'nW')

    " if a match was found
    if start_row !=# [0, 0] && end_row !=# [0, 0]
        call setpos("'<", [bufnr(), start_row[0] + a:inner, 1, 0])
        call setpos("'>", [bufnr(), end_row[0] - a:inner, 1, 0])
        execute 'normal! `<V`>'
    else
        call cursor(l, c)
    endif
endfunction   
"}}}---------------------------------------------------------------------------
"{{{- motion for backtick defined code ----------------------------------------
function! MoveToBacktickCodeBlock(opts)
    call search('^\s*```{', a:opts)
    " put the code in the center of the screen
    normal! zz
endfunction
"}}}---------------------------------------------------------------------------
"{{{- paste to and from system clipboard --------------------------------------
function! PasteFromClipboard(clipboard, above_or_below, before_after)
    execute "normal! mx"
    if a:above_or_below ==# 'above'
        execute "normal! k"
    endif
    silent! execute ':r! xclip -out -selection ' . a:clipboard
    if a:above_or_below ==# 'inline'
        execute "normal dil"
        if a:before_after ==# 'after'
            execute "normal `xp"
        elseif a:before_after ==# 'before'
            execute "normal `xP"
        endif
    else
        execute 'normal! =='
    endif
endfunction

function! YankToClipBoard(type)
    execute "normal! `[v`]:! xclip -filter -selection clipboard"
    echo 'copied to highlight clipboard'
endfunction
"}}}---------------------------------------------------------------------------
"{{{- change slime target pane mid-session ------------------------------------
function! ChangeBufferSlimeConfig(...)
    " 1st arg (optional) is the display duration of tmux pane indices
    " 2nd arg (optional) is the target_pane
    let duration = get(a:, 1, 200)
    let target_pane = get(a:, 2, 0)
    if target_pane == 0
        call DisplayTmuxPaneIndices(duration)
        let target_pane = input("target_pane:")
    endif
    let b:slime_config = {"socket_name": "default"}
    let b:slime_config["target_pane"] = target_pane
endfunction
"}}}---------------------------------------------------------------------------
"{{{- slime apply function to word under cursor -------------------------------
function! SlimeApplyFunctionToWordUnderCursor(fn, args, word, use_parens)
    let fn_call = 'SlimeSend1 ' . a:fn
    if a:word ==# ''
        let word = a:word
    else 
        let word = expand('<c' . a:word . '>')
    endif
    if a:use_parens ==# 'no_parens'
        :execute fn_call . word
    else
        :execute fn_call . '(' . word . a:args . ')'
    endif
endfunction

" get date range of df under cursor
function! GetDateRange()
    let fn_call = 'SlimeSend1 '
    let word = expand('<cword>')
    :execute fn_call . 'range(' . word . '$date)'
endfunction

" get date range of df under cursor
function! SearchNames(space)
    let fn_call = 'SlimeSend1 '
    let to_search = input('search pattern: ')
    if a:space ==# 'names'
        let word = expand('<cword>')
    else 
        let word = ''
    endif
    :execute fn_call . a:space . '(' . word . ')[grep("' . to_search . '", ' . a:space .'(' . word .'))]'
endfunction

" get date range of df under cursor
function! ShowUnique()
    let fn_call = 'SlimeSend1 '
    let to_search = input('column name: ')
    let word = expand('<cword>')
    :execute fn_call . 'unique(' . word . '$' . to_search . ')'
endfunction

"}}}---------------------------------------------------------------------------
"{{{- copy from tmux panes to buffer ------------------------------------------
function! AllTmuxPanesToBuffer()
    edit .tmux | %!sh ~/dotfiles/bin/tmuxcomplete.sh -s lines -e -n
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    buffer #
endfunction                             
"}}}---------------------------------------------------------------------------
"==============================================================================

"==== CUSTOM CONFIGURATIONS ===================================================
"{{{- general settings --------------------------------------------------------
" keep all the annoying files in one place
set backupdir=~/dotfiles/.vim/backup//
set directory=~/dotfiles/.vim/swap//
set undodir=~/dotfiles/.vim/undo//
set encoding=utf-8
set path+=** " let vim search recursively in the current directory
set number " put line number where the cursor is
set relativenumber " number all other lines relative to current line
set hidden " when switching buffers, don't complain about unsaved changes
set undofile " remember changes from previous vim session (so I can still undo)
set splitbelow " where new vim pane splits are positioned
set splitright " where new vim pane splits are positioned
set noequalalways " don't resize windows when I close a split
set diffopt+=vertical " when using diff mode (fugitive) have a vertical split
set virtualedit=all " allow cursor to be positioned where there are no chars
set nostartofline " keep cursor on the same column even when no chars are there
set colorcolumn=80 " show vertical bar at 80 columns
set textwidth=79 " at 79 columns, wrap text
set linebreak " wrap long lines at char in 'breakat' (default " ^I!@*-+;:,./?")
set nowrap " don't wrap lines by default
set completeopt+=noinsert " don't insert text automatically
set pumheight=5 " keep the autocomplete suggestion menu small
set wildmenu " list completion options when typing in command line mode
set wildmode=list,full
" set wildmode=longest,list " behave like bash autocomplete rather than zsh
set wildignorecase " ignore case when completing file names
set expandtab " expand tabs into spaces
set tabstop=4 " a tab is the same as 4 spaces
set softtabstop=4 " when I hit <TAB> in insert mode, put 4 spaces
set shiftwidth=4 " when auto-indenting, use 4 spaces per tab
set autoindent " when creating a new line, copy indent from line above
if has("patch-8.2.2454")
    set listchars=lead:· " show leading whitespace as grey middledots
    set list " show leading whitespace as grey dots
endif
set nojoinspaces " don't join with double spaces when line ens with ./!/?
set showmatch " show the matching part of the pair for [] {} and ()
set incsearch " show matches for patterns while they are being typed
set hlsearch | noh " highlight matches for searched (turn off when sourcing)
set showcmd " display incomplete command in lower right corner of Vim window
set shortmess-=S " show the number of search results (up to 99)
set smartcase " with both on, searches with no capitals are case insensitive...
set ignorecase " ...while searches with capital characters are case sensitive.
set nrformats= " don't interpret 007 as octal (<C-a/x> will make 008, not 010)
set spell spelllang=en
set nospell " don't highlight misspellings unless I say so
set lazyredraw " don't redraw screen during macros (let them complete faster)
set foldlevel=1 " when opening new files, start with only top folds open
set t_Co=256 " use full colours
syntax enable " highlight special words to aid readability

" make the highlighted searched words less distracting
highlight Search term=reverse ctermfg=230 ctermbg=8 cterm=underline
" check if we're on a light or dark colorscheme in tmux, and pick accordingly
call SetColorScheme(1)

let g:netrw_banner=1 " hide that huge banner
"}}}---------------------------------------------------------------------------
"{{{- general remaps ----------------------------------------------------------
augroup general
    autocmd!
    " if we ended up in vim by pressing <ESC-v>, put a # at the beggining of
    " the line to prevent accidental execution (since bash will execute no
    " matter what! Imagine if rm -rf <forward slash> was there...)
    autocmd BufReadPost * :call CheckBashEdit()

    " exit insert mode with the jk/kj
    inoremap jk <esc>
    inoremap kj <esc>

    "{{{- colorscheme switches ------------------------------------------------
    " If the syntax highlighting goes weird, F12 to redo it
    nnoremap <F12> :syntax sync fromstart<CR>
    nnoremap <LEADER>o :call ToggleLightDarkColorscheme()<CR>
    autocmd FocusGained * :call SetColorScheme(1)
    autocmd FocusLost * :call SetColorScheme(0)
    "}}}-----------------------------------------------------------------------
    "{{{- movements and text objects ------------------------------------------
    " let g modify insert/append to work on wrapped lines, in the same way as
    " it modifies motions like 0 and $
    nnoremap gI g0i
    nnoremap gA g$i

    " move to halfway between first and last non-whitespace characters on line
    nnoremap <silent> gm :call BetterGmNormalMode()<CR>
    onoremap <silent> gm :call BetterGmNormalMode()<CR>

    " contiguously scroll left right along a line
    nnoremap <silent> zh :call HorizontalScrollMode('h')<CR>
    nnoremap <silent> zl :call HorizontalScrollMode('l')<CR>
    nnoremap <silent> zH :call HorizontalScrollMode('H')<CR>
    nnoremap <silent> zL :call HorizontalScrollMode('L')<CR>

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
    xnoremap <silent> ie <ESC>gg0VG
    xnoremap <silent> ae <ESC>gg0VG
    " operator pending mode
    onoremap <silent> ie :<C-u>normal! gg0VG<CR>
    onoremap <silent> ae :<C-u>normal! gg0VG<CR>

    " inner/around backtick code block text objects
    " visual mode
    xnoremap <silent> ic :<C-U>call BacktickCodeBlock(1)<CR>
    xnoremap <silent> ac :<C-U>call BacktickCodeBlock(0)<CR>
    " operator mode     
    onoremap <silent> ic :<C-U>call BacktickCodeBlock(1)<CR>
    onoremap <silent> ac :<C-U>call BacktickCodeBlock(0)<CR>

    " move to next/prev backtick code block
    nnoremap <silent> ]c :call MoveToBacktickCodeBlock('W')<CR>
    nnoremap <silent> [c :call MoveToBacktickCodeBlock('bW')<CR>

    " execute backtick code block and move to next block
    nmap ]]c sic]c

    " nummber text object (n=forwards, N=backwards)
    xnoremap in :<C-u>call VisualNumber('c')<CR>
    onoremap in :<C-u>normal vin<CR>
    xnoremap iN :<C-u>call VisualNumber('b')<CR>
    onoremap iN :<C-u>normal viN<CR>

    " use [w and ]w and [W and ]W to exchange a word/WORD under the cursor with
    " the prev/next one
    call Repeat('WordForward', ']w', 'mx$ox<ESC>kJ`xdawhelphmx$"_daw`xh')
    call Repeat('WORDForward', ']W', 'mx$ox<ESC>kJ`xdaWElphmx$"_daw`xh')
    call Repeat('WordBackward', '[w', 'mx$ox<ESC>kJ`xdawbPhmx$"_daw`xh')
    call Repeat('WORDBackward', '[W', 'mx$ox<ESC>kJ`xdaWBPhmx$"_daw`xh')

    " paste at end of line, with an automatic space
    call Repeat('PasteToRightOfLine1', '>p', ':call PasteAtEndOfLine("$")<CR>') 
    call Repeat('PasteToRightOfLine2', '>P', ':call PasteAtEndOfLine("$")<CR>') 
    " paste at start of line, with an automatic space
    call Repeat('PasteToLeftOfLine1', '<p', ':call PasteAtEndOfLine("^")<CR>') 
    call Repeat('PasteToLeftOfLine2', '<P', ':call PasteAtEndOfLine("^")<CR>') 

    " past below/above line, regardless whether it was yanked linewise or not
    call Repeat('PasteBelowLine', '<LEADER>jp', ':call PasteUnammedLinewise("j")<CR>') 
    call Repeat('PasteAboveLine', '<LEADER>kp', ':call PasteUnammedLinewise("k")<CR>') 

    " delete line, but leave it blank
    call Repeat('EmptyLine', '<LEADER>dd', 'cc<Esc>')

    " create line above and below a line
    call Repeat('CreateBlankLineAboveAndBelow1', ']]<SPACE>', ':call CreateBlankLineAboveAndBelow()<CR>')
    call Repeat('CreateBlankLineAboveAndBelow2', '[[<SPACE>', ':call CreateBlankLineAboveAndBelow()<CR>')

    " delete line above and below a line
    call Repeat('DeleteBlankLineAboveAndBelow1', 'd]]<SPACE>', ':call DeleteBlankLineAboveAndBelow()<CR>')
    call Repeat('DeleteBlankLineAboveAndBelow2', 'd[[<SPACE>', ':call DeleteBlankLineAboveAndBelow()<CR>')

    " create some space either side of a character
    call Repeat('CreateSurroundingSpace', 'cs<SPACE>', ':call CreateSurroundingSpace()<CR>')

    " delete all space adjacent to contiguous non-whitespace under cursor
    call Repeat('DeleteSurroundingSpace', 'ds<SPACE>', ':call DeleteSurroundingSpace()<CR>')

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
    nnoremap <LEADER>x :buffer# \| bdelete #<CR>

    " turn on indent foldmethod
    nnoremap <LEADER>i :set foldmethod=indent<CR>

    " send a ctrl+c to pane
    nnoremap <LEADER>sc :SlimeSend0 "\x03"<CR> 

    " " open/close horizontal split containing w3m_scratch
    " nnoremap <LEADER>W :call ToggleW3M()<CR>

    " " anytime we read in a buffer, if it came from w3m then write to scratch
    " autocmd BufReadPost * :call WriteW3MToScratch()
    "}}}-----------------------------------------------------------------------
    "{{{- searching and substitution ------------------------------------------
    " autocenter search results with zvzz,
    " always have n go down, N go up
    nnoremap <expr> n (v:searchforward ? 'nzvzz' : 'Nzvzz')
    nnoremap <expr> N (v:searchforward ? 'Nzvzz' : 'nzvzz')

    " toggle highlighted searches
    nnoremap <silent> <expr> <LEADER>/ 
                \ (v:hlsearch ? ':nohls' : ':set hls')."\n"

    " substitute word under the cursor
    nnoremap <LEADER>* :%s/\<<C-r><C-w>\>/

    " count the number of matched patterns
    nnoremap <LEADER>n :%s///gn<CR>

    " increment all numbers in visual selection
    xnoremap <silent> <C-a> :<C-u>let vcount = v:count ? v:count : 1 \|
                \ '<,'>s/\%V-\zs\<\d\+\>/\=submatch(0) - vcount/ge \|
                \ '<,'>s/\%V[-.]\@<!\<\d\+\>/\=submatch(0) + vcount/ge \|
                \ '<,'>s/\%V-0/0/ge \|
                \<CR>gv

    " decrement all numbers in visual selection
    xnoremap <silent> <C-x> :<C-u>let vcount = v:count ? v:count : 1 \|
                \ '<,'>s/\%V-\zs\d\+/\=submatch(0) + vcount/ge \|
                \ '<,'>s/\%V[-.]\@<!\<\d\+\>/\=submatch(0) - vcount/ge \|
                \<CR>gv
    "}}}-----------------------------------------------------------------------
    "{{{- common files to edit/source -----------------------------------------
    " edit common files
    nnoremap <LEADER>ev :vsplit $MYVIMRC<CR>
    nnoremap <LEADER>eb :vsplit
                \ /home/mattb/dotfiles/bashrc_multihost/base<CR>
    nnoremap <LEADER>ea :vsplit
                \ /home/mattb/dotfiles/aliases_multihost/base<CR>
    nnoremap <LEADER>ef :vsplit
                \ /home/mattb/dotfiles/functions_multihost/base<CR>
    nnoremap <LEADER>et :vsplit
                \ /home/mattb/dotfiles/tmux.conf<CR>

    " source common things
    nnoremap <LEADER>sv :source $MYVIMRC<CR>
    " run current vimrc line as a command (useful when modifying vimrc)
    nnoremap <silent> <LEADER>sl :execute getline(line('.'))<cr>
    " source any yanked block of text
    nnoremap <silent> <LEADER>sy :@"<CR>

    " force write a readonly file with root privileges (for : but not / or ?)
    cnoreabbrev <expr> w!! !(getcmdtype() == ":" &&
                \getcmdline() == "w!!") ? 'w!!' : 'w !sudo tee %'
    "}}}-----------------------------------------------------------------------
    "{{{- copy and paste with clipboard ---------------------------------------

    " paste from system CTRL-C clipboard
    nnoremap <LEADER>p          :call PasteFromClipboard('clipboard', 'inline', 'after')<CR>
    nnoremap <LEADER>P          :call PasteFromClipboard('clipboard', 'inline', 'before')<CR>
    nnoremap <LEADER>]p         :call PasteFromClipboard('clipboard', 'below',  'NA')<CR>
    nnoremap <LEADER>[p         :call PasteFromClipboard('clipboard', 'above',   'NA')<CR>
    nnoremap <LEADER><LEADER>p  :call PasteFromClipboard('primary',   'inline', 'after')<CR>
    nnoremap <LEADER><LEADER>P  :call PasteFromClipboard('primary',   'inline', 'before')<CR>
    nnoremap <LEADER><LEADER>]p :call PasteFromClipboard('primary',   'below',  'NA')<CR>
    nnoremap <LEADER><LEADER>[p :call PasteFromClipboard('primary',   'above',  'NA')<CR>

    " copy visual/motion selection to clipboard
    xnoremap <silent> <LEADER>y :!xclip -f -sel clip<CR>
    nnoremap <silent> <LEADER>y :set operatorfunc=YankToClipBoard<CR>g@

    " format and yank buffer in a good way for pasting outside of vim
    command! Format execute 'normal! :1,$!fmt --width=2500<CR>"+yGu'

    "}}}-----------------------------------------------------------------------
    "{{{- spelling and abbreviations-------------------------------------------
    " instantly go with first spelling suggestion
    nnoremap [s [sa<C-x>s<DOWN><CR><ESC>
    nnoremap ]s ]sa<C-x>s<DOWN><CR><ESC>

    " common mispellings
    iabbrev keybaord keyboard
    iabbrev laod load
    iabbrev hte the
    iabbrev teh the
    iabbrev gaurd guard
    iabbrev acutal actual 
    iabbrev acutals actuals 
    iabbrev appearence appearance

    " emails
    iabbrev @g bennettmatt4@gmail.com
    iabbrev @u matthew.bennett@uclouvain.be
    iabbrev @n matthew.bennett16@nhs.net
    "}}}-----------------------------------------------------------------------
augroup END
"}}}---------------------------------------------------------------------------
"{{{- file specific settings --------------------------------------------------
augroup vim "{{{---------------------------------------------------------------
    autocmd!
    " start out with everything folded away
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
augroup END
"}}}---------------------------------------------------------------------------
augroup vim help "{{{----------------------------------------------------------
    autocmd!
    autocmd FileType help setlocal number
    autocmd FileType help setlocal relativenumber
    autocmd FileType help setlocal nolist " don't show leading whitespace
"}}}---------------------------------------------------------------------------
augroup python "{{{------------------------------------------------------------
    autocmd!
    " avoid conversion issues when checking into github and/or sharing with
    " other users.
    autocmd FileType python setlocal fileformat=unix
    " enable all Python syntax highlighting features
    autocmd FileType python let python_highlight_all=1
    autocmd FileType python setlocal foldmethod=indent

    " common imports
    autocmd FileType python abbreviate implt import matplotlib.pyplot as plt
    autocmd FileType python abbreviate imnp import numpy as np
augroup END
"}}}---------------------------------------------------------------------------
augroup r "{{{-----------------------------------------------------------------
    autocmd!
    " avoid conversion issues when checking into github and/or sharing with
    " other users.
    autocmd FileType R,r,rmd,Rmd setlocal fileformat=unix
    autocmd FileType R,r,rmd,Rmd setlocal foldmethod=indent
    autocmd FileType R,r,rmd,Rmd setlocal nofoldenable

    " in R, a tab is the same as 2 spaces
    autocmd FileType R,r,rmd,Rmd setlocal tabstop=2
    autocmd FileType R,r,rmd,Rmd setlocal softtabstop=2
    autocmd FileType R,r,rmd,Rmd setlocal shiftwidth=2

    " easier to type assignment
    autocmd FileType R,r,rmd,Rmd inoremap <buffer> << <-
    autocmd FileType R,r,rmd,Rmd inoremap <buffer> >> \|>
    autocmd FileType R,r,rmd,Rmd iabbrev lib library("")
    autocmd FileType R,r,rmd,Rmd iabbrev ins install.packages("")
    autocmd FileType R,r,rmd,Rmd iabbrev gg2 ggplot(df, aes()) +
    autocmd FileType R,r,rmd,Rmd iabbrev ggl geom_line()
    autocmd FileType R,r,rmd,Rmd iabbrev ggp geom_point()
   
    " don't consider dots part of words (i.e. keep acting like normal vim)
    autocmd FileType R,r,rmd,Rmd set iskeyword-=.

    " compile the R markdown document
    autocmd FileType rmd nnoremap <buffer> <LEADER>m :silent !echo 'rmarkdown::render("%")' \| R --slave<CR>

    " common mispellings
    autocmd FileType R,r,rmd,Rmd iabbrev fliter filter
    autocmd FileType R,r,rmd,Rmd iabbrev fitler filter

    " snips
    " create a new function
    autocmd FileType R,r,rmd,Rmd nnoremap <buffer> <LEADER>sf :put = readfile(expand('~/dotfiles/snips/function.r'))<CR>k%0
    " create a ggplot
    autocmd FileType R,r,rmd,Rmd nnoremap <buffer> <LEADER>sg :put = readfile(expand('~/dotfiles/snips/ggplot.r'))<CR>3k0fd
    " create a call to add_cols
    autocmd FileType R,r,rmd,Rmd nnoremap <buffer> <LEADER>sa :put = readfile(expand('~/dotfiles/snips/add_cols.r'))<CR>kf"

    " query object:
    " help
    noremap <silent> <Leader>q? :call SlimeApplyFunctionToWordUnderCursor('?', '', 'word', 'no_parens')<CR>
    noremap <silent> <Leader>Q? :call SlimeApplyFunctionToWordUnderCursor('?', '', 'WORD', 'no_parens')<CR>
    " exit help
    noremap <silent> <Leader>? :call SlimeApplyFunctionToWordUnderCursor('q', '', '', 'no_parens')<CR>
    " clear console
    noremap <silent> <Leader>cl :call SlimeApplyFunctionToWordUnderCursor('cl', '', '', '')<CR>
    " names
    noremap <silent> <Leader>qn :call SlimeApplyFunctionToWordUnderCursor('names', '', 'word', '')<CR>
    noremap <silent> <Leader>Qn :call SlimeApplyFunctionToWordUnderCursor('names', '', 'WORD', '')<CR>
    " length
    noremap <silent> <Leader>ql :call SlimeApplyFunctionToWordUnderCursor('length', '', 'word', '')<CR>
    noremap <silent> <Leader>Ql :call SlimeApplyFunctionToWordUnderCursor('length', '', 'WORD', '')<CR>
    " summary
    noremap <silent> <Leader>qs :call SlimeApplyFunctionToWordUnderCursor('summary', '', 'word', '')<CR>
    noremap <silent> <Leader>Qs :call SlimeApplyFunctionToWordUnderCursor('summary', '', 'WORD', '')<CR>
    " nrow
    noremap <silent> <Leader>qr :call SlimeApplyFunctionToWordUnderCursor('nrow', '', 'word', '')<CR>
    noremap <silent> <Leader>Qr :call SlimeApplyFunctionToWordUnderCursor('nrow', '', 'WORD', '')<CR>
    " histogram
    noremap <silent> <Leader>qH :call SlimeApplyFunctionToWordUnderCursor('hist', ', breaks = 100', 'word', '')<CR>
    noremap <silent> <Leader>Qh :call SlimeApplyFunctionToWordUnderCursor('hist', ', breaks = 100', 'WORD', '')<CR>

    " get date range of df under cursor
    noremap <silent> <Leader>qd :call GetDateRange()<CR>
                                      
    " grep for pattern among columns names of df under curser
    noremap <silent> <Leader>qgn :call SearchNames('names')<CR>
    " grep for pattern among variables in workspace
    noremap <silent> <Leader>qgl :call SearchNames('ls')<CR>

    " show unique entires of column
    noremap <silent> <Leader>qu :call ShowUnique()<CR>
   
    " install packages which I don't yet have
    nnoremap <LEADER>qi ^ct(install.packages<ESC>
    " use library that has been installed
    " nnoremap <LEADER>ql ^ct(library<ESC>
   
    " toggle figure window
    nnoremap <LEADER>qf :execute 'silent !source ~/dotfiles/functions_multihost/fntstrkylnx01 && ff &'<CR>

augroup END
"}}}---------------------------------------------------------------------------
augroup markdown "{{{----------------------------------------------------------
    autocmd!
    autocmd FileType markdown setlocal spell

    " all lines under a section heading are folded
    autocmd FileType markdown setlocal foldmethod=expr 
    autocmd FileType markdown setlocal foldexpr=getline(v:lnum)=~'^[^#]\\\|^\\s*$'
    autocmd FileType markdown setlocal foldlevel=0

    " inside headed title:
    autocmd FileType markdown onoremap <buffer> iht :<C-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rwvg_"<CR>
    " around headed title:
    autocmd FileType markdown onoremap <buffer> aht :<C-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rvg_"<CR>
    " inside headed body:
    autocmd FileType markdown onoremap <buffer> ihb :<C-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rjv/^#\\+ \\w\\+.*$\rk"<CR>
    " around headed body:
    autocmd FileType markdown onoremap <buffer> ahb :<C-u>execute "normal!
                \ ?^#\\+ \\w\\+.*$\rv/^#\\+ \\w\\+.*$\rk"<CR>

    "note taking
    autocmd FileType markdown iabbrev <buffer> -- - [ ]
augroup END
"}}}---------------------------------------------------------------------------
augroup tex "{{{---------------------------------------------------------------
    autocmd!
    autocmd FileType tex setlocal foldmethod=indent
    " start out with everything folded away
    autocmd FileType tex setlocal foldlevel=0

    " <LEADER>m to compile the doc - errors go to quickfix list
    autocmd FileType tex :let b:tex_flavor = 'pdflatex'
    autocmd FileType tex :compiler tex
    autocmd FileType tex nnoremap <buffer> <LEADER>m :silent make % <CR>
augroup END
"}}}---------------------------------------------------------------------------
augroup tmux "{{{--------------------------------------------------------------
    autocmd!
    autocmd FileType tmux setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType tmux setlocal foldlevel=0
augroup END
"}}}---------------------------------------------------------------------------
augroup tidy_code_python "{{{---------------------------------------
    autocmd!
    " remove trailing whitespace and perform auto indent when writing
    autocmd BufWritePre *.py :call Preserve("%s/\\s\\+$//e", 0)
augroup END
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
"}}}---------------------------------------------------------------------------
"{{{- status line -------------------------------------------------------------
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
"==============================================================================
"
