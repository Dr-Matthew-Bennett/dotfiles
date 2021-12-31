"{{{- wish list ---------------------------------------------------------------

" For vim-tmux-focus-events not to throw error on switching external windows:
" Error detected while processing function <SNR>39_do_autocmd[3]..FocusGained
" Autocommands for "*"..function tmux_focus_events#focus_gained:
"
" Update: this plugin is now obsolete and no longer needed as both neovim and
" vim (since version 8.2.2345) have native support for this functionality.

" Create a funtion like Preserve() that preserves the unnamed register
"}}}---------------------------------------------------------------------------

"==== PLUGINS AND ASSOCIATED CONFIGURATIONS AND REMAPS ========================
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
Plugin 'vim-scripts/ReplaceWithRegister'

" other plugins that do more exotic things
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'jpalardy/vim-slime'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

Plugin 'markonm/traces.vim'
" g/^ and :v/^ hangs... I should probably raise an issue on the repo

Plugin 'Matt-A-Bennett/vim-indent-object'
Plugin 'simnalamburt/vim-mundo'
Plugin 'simeji/winresizer'
Plugin 'SirVer/ultisnips'
Plugin 'tmux-plugins/vim-tmux-focus-events'
" Update: vim-tmux-focus-events is now obsolete and no longer needed as both
" neovim and vim (since version 8.2.2345) have native support for this
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-scripts/MatlabFilesEdition'
Plugin 'wellle/targets.vim'
Plugin 'ycm-core/YouCompleteMe'
"}}}---------------------------------------------------------------------------
"{{{- plugins I'm trying out---------------------------------------------------
Plugin 'bronson/vim-visual-star-search'
Plugin 'junegunn/vim-peekaboo'
Plugin 'wellle/context.vim'
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
" Plugin 'wellle/tmux-complete.vim'
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
"{{{- context -----------------------------------------------------------------
" don't run plugin by default
let g:context_enabled = 0
" I want results shown in a split (not a floating window)
let g:context_presenter = 'preview'
let g:context_border_char = '▬'
augroup context
    autocmd!
    " when I close a window, also close the context window
    autocmd BufHidden * :ContextDisableWindow
    nnoremap <LEADER>c :ContextToggleWindow<CR>
augroup END
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

" remove the config for preview window (I prefer vim's default behaviour)
let fzf1 = "--height 80% -m --layout=reverse --marker=o"
let fzf2 = ""
let fzf3 = "--bind ctrl-a:select-all,ctrl-d:deselect-all"
let fzf4 = "--bind ctrl-y:preview-up,ctrl-e:preview-down"
let $FZF_DEFAULT_OPTS = fzf1.' '.fzf2.' '.fzf3.' '.fzf4

" Change CTRL-X to CTRL-V to open file from fzf in vertical split
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
"{{{- vim-peekaboo ------------------------------------------------------------
let g:peekaboo_window = 'vertical botright 80 new'
let g:peekaboo_delay = 1000
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

" function to change slime target pane mid-session
function SlimeOverrideConfig()
    " bring up the pane numbers as a background job
    call job_start(["tmux", "display-pane", "-d", "350"])
    " get the input from user
    let input = input("target_pane:")
    " set the new pane target (if any was given)
    if input
        let g:slime_default_config["target_pane"] = input
    endif
endfunction
nnoremap <LEADER>ss :call SlimeOverrideConfig()<CR>

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
nmap S <Plug>SlimeLineSend
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
"{{{- helper functions (for use in other functions) ---------------------------
function! GetCharUnderCursor()
     return getline(".")[col(".")-1]
endfunction

function! MoveToStartOfFunction(word_size, pasting)
    " move forward to one of function's parentheses (unless already on one)
    call search('(\|)', 'c', line('.'))
    " if we're on the closing parenthsis, move to other side
    if GetCharUnderCursor() ==# ')'
        silent! execute 'normal! %'
    endif
    " move onto function name 
    silent! execute 'normal! b'
    if a:word_size ==# 'big'
        " if we've pasted in a function, then there will be a ')' right before
        " the one we need to move inside - so we can go to the start easily
        if a:pasting
            silent! execute 'normal! F)l'
        else
            " find first boundary before function that we don't want to cross
            call search(' \|,\|;\|(\|^', 'b', line('.'))
            " If we're not at the start of the line, or if we're on whitespace
            if col('.') > 1 || GetCharUnderCursor() ==# ' '
                silent! execute 'normal! l'
            endif
        endif
    endif
endfunction

" apply the repeat plugin to any mapping
" (commands with a single quote will likely cause problems...)
let g:map_name_count = 0
function! Repeat(map, command)
    " we need to use a unique string as a map name each time function is called
    let g:map_name_count += 1
    let mapname = string(g:map_name_count)
    execute 'nnoremap <silent> <Plug>'.mapname.' '.a:command.
                \' :call repeat#set("\<Plug>'.mapname.'")<CR>'
    execute 'nmap '.a:map.' <Plug>'.mapname
endfunction
"}}}---------------------------------------------------------------------------
"{{{- toggle between light and dark colorscheme -------------------------------
function! SetColorScheme()
    " check if tmux colorsheme is light or dark, and pick for vim accordingly
    if system('tmux show-environment THEME')[0:9] ==# 'THEME=dark'
        colorscheme zenburn
        let $BAT_THEME=''
    else
        colorscheme seoul256-light
        let $BAT_THEME='Monokai Extended Light'
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
    :call SetColorScheme()
endfunction
"}}}---------------------------------------------------------------------------
"{{{- handle w3m_scratch file and toggle split to use it ----------------------
function! WriteW3MToScratch()
    " only if the file matches this highly specific reg exp will we do anything
    "(e.g. a file that looks like: .w3m/w3mtmp{some numbers}-{number})
    if match(@%, "\.w3m/w3mtmp\\d\\+-\\d") !=# -1
        :silent! wq! /tmp/w3m_scratch
    endif
endfunction

function! ToggleW3M()
    if bufexists("/tmp/w3m_scratch")
        :bwipeout! /tmp/w3m_scratch
    else
        :silent! split /tmp/w3m_scratch
    endif
endfunction
"}}}---------------------------------------------------------------------------
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
"{{{- function to refactor code in python -------------------------------------
function! RefactorPython()
    " mark the location
    execute "normal mx"
    " search backwards for the word import at start of line
    if search("^import \| ^from ", 'b', 'W') !=# 0
        " create 2 blank lines below it
        execute "normal 2o"
        " execute "normal k"
    else
        " search for the first def or class in the file
        execute "normal gg"
        :call search("^\\<def\\> .*:\\|\\<class\\>.*:")
        " create 2 blank lines above it
        execute "normal 2O"
        execute "normal k"
    endif
    " if we found none of the above this will happen at the start of file
    " define a new function
    execute "normal Idef my_function():"
    " drop down a line to make a mark y, then go up again
    execute "normal jmyk"
    " paste the refactored lines into it and indent until end (mark y)
    execute "normal ]p>'y"
    " put a dummy return statement at end (mark y)
    execute "normal 'yIreturn None"
    " indent the return statement
    execute "normal <<........>>"
    " make a blank line below the return statement
    execute "normal o"
    " move input arguments, turn off search highlighting
    execute "normal ?^\\<def\\>.*)?e\<CR>:nohlsearch\<CR>"
endfunction
"}}}---------------------------------------------------------------------------
"{{{- delete/change/yank/paste custom function 'text objects'
function! DeleteSurroundingFunction(word_size)
    " we'll restore the f register later so it isn't clobbered here
    let l:freg = @f
    call MoveToStartOfFunction(a:word_size, 0)
    " delete function name into the f register and mark opening parenthesis 
    silent! execute 'normal! "fdt(mo'
    " yank opening parenthesis into f register
    silent! execute 'normal! "Fyl'
    " mark closing parenthesis
    silent! execute 'normal! %mc'
    " note where the function ends
    let close = col('.')
    " move back to opening paranthesis
    silent! execute 'normal! %'
    " search on the same line for an opening paren before the closing paren 
    if search("(", '', line('.')) && col('.') < close
        " move to matching paren and delete everthing up to the closing paren
        " of the original function (remark closing paren)
        silent! execute 'normal! %l"Fd`cmc'
    end
    " delete the closing and opening parens (put the closing one into register)
    silent! execute 'normal! `c"Fx`ox'
    " paste the function into unamed register
    let @"=@f
    " restore the f register
    let @f = l:freg
endfunction

function! ChangeSurroundingFunction(word_size)
    call DeleteSurroundingFunction(a:word_size)
    startinsert
endfunction

function! YankSurroundingFunction(word_size)
    " store the current line
    silent! execute 'normal! "lyy'
    call DeleteSurroundingFunction(a:word_size)
    " restore the current line to original state
    silent! execute 'normal! "_dd"lP'
endfunction

function! PasteFunctionAroundFunction(word_size)
    " we'll restore the unnamed register later so it isn't clobbered here
    let l:unnamed_reg = @"
    call MoveToStartOfFunction(a:word_size, 0)
    " paste just behind existing function
    silent! execute 'normal! P'
    " mark closing parenthesis
    silent! execute 'normal! f(%mc'
    " move back onto start of function name
    call MoveToStartOfFunction(a:word_size, 1)
    " delete the whole function (including last parenthesis)
    silent! execute 'normal! d`c"_x'
    " if we're not already on a last parenthesis, move back to it
    call search(')', 'bc', line('.'))
    " move to opening surrounding paren and paste original function, then add
    " surrounding parenthesis back in
    silent! execute 'normal! %pa)'
    " leave the cursor on the opening parenthesis of the surrounding function
    silent! execute 'normal! `c%'
    " restore unnamed register
    let @" = l:unnamed_reg
endfunction

function! PasteFunctionAroundWord(word_size)
    " we'll restore the unnamed register later so it isn't clobbered here
    let l:unnamed_reg = @"
    if a:word_size ==# 'small'
        " get onto start of the word
        silent! execute 'normal! lb'
        " paste the function behind and move back to the word
        silent! execute 'normal! Pl'
        " delete the word
        silent! execute 'normal! diw'
    elseif a:word_size ==# 'big'
        " find first boundary before function that we don't want to cross
        call search(' \|,\|;\|(\|^', 'b', line('.'))
        " If we're not at the start of the line, or if we're on whitespace
        if col('.') > 1 || GetCharUnderCursor() ==# ' '
            silent! execute 'normal! l'
        endif
        " paste the function behind and move back to the word
        silent! execute 'normal! Pl'
        " delete WORD
        silent! execute 'normal! dW'
    endif
    " if we're not already on a last parenthesis, move back to it
    call search(')', 'bc', line('.'))
    " move to start of funtion and mark it, paste the word, move back to start
    silent! execute 'normal! %mop`o'
    " restore unnamed register
    let @" = l:unnamed_reg
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
    " if we opened a help doc
    if orig_file !=# expand(@%)
        set nomodifiable
        " for some reason not all the tags work unless I open the 'real' help
        " so get whichever help was found and open it through Ag
        let help_doc=expand("%:t")
        " open and close that help doc - now the tags will work
        execute "normal! :tab :help " help_doc "\<CR>:q\<CR>"
    endif
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
"{{{- visual text object for number -------------------------------------------
function! VisualNumber(direction)
    " find the end of a number (we assume a decimal means it's not the end)
 	call search('\d\([^0-9\.]\|$\)', a:direction.'W')
	normal v
    " find the beggininng of that number (again, we don't stop for a decimal)
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
" hello 0 33 2 a word 30.3 yaya
"}}}---------------------------------------------------------------------------
"{{{- paste from system clipboard ---------------------------------------------
function! PasteFromRegister(reg, up_or_down, autoindent)
    set paste
    if a:up_or_down ==# 'up'
        call append(line('.')-1, '')
        execute "normal! k"
    elseif a:up_or_down ==# 'down'
        call append('.', '')
        execute "normal! j"
    endif
    execute 'normal! "'.a:reg.'p'
    if a:autoindent ==# 'autoindent'
        execute 'normal! =='
    endif
    set nopaste
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
set virtualedit=all " allow cursor to be positioned where there are no chars
set nostartofline " keep cursor on the same column even when no chars are there
set colorcolumn=80 " show vertical bar at 80 columns
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
if v:version > 801
    set listchars=lead:. " show leading whitespace as grey dots
    set list " show leading whitespace as grey dots
endif
set nojoinspaces " don't join with double spaces when line ens with ./!/?
set showmatch " show the matching part of the pair for [] {} and ()
set incsearch " show matches for patterns while they are being typed
set hlsearch | noh " highlight matches for searched (turn off when sourcing)
set shortmess-=S " show the number of search results (up to 99)
set smartcase " with both on, searches with no capitals are case insensitive...
set ignorecase " ...while searches with capital characters are case sensitive.
set nrformats= " don't interpret 007 as octal (<C-a/x> will make 008, not 010)
" if v:version > 801
"     set nrformats=unsigned " ignore any minus sign when using <C-a/x>
" endif
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
"{{{- general remaps ----------------------------------------------------------
augroup general
    autocmd!

    " if we ended up in vim by pressing <ESC-v>, put a # at the beggining of
    " the line to prevent accidental execution (since bash will execute no
    " matter what! Imagine if rm -rf <forward slash> was there...)
    autocmd BufReadPost * :call CheckBashEdit()

    "{{{- colorscheme switches ------------------------------------------------
    " If the syntax highlighting goes weird, F12 to redo it
    nnoremap <F12> :syntax sync fromstart<CR>
    nnoremap <LEADER>o :call ToggleLightDarkColorscheme()<CR>
    autocmd FocusGained * :call SetColorScheme()
    "}}}-----------------------------------------------------------------------
    "{{{- movements and text objects ------------------------------------------
    " let g modify insert/append to work on wrapped lines, in the same way as
    " it modifies motions like 0 and $
    nnoremap gI g0i
    nnoremap gA g$i

    " move to halfway between first and last non-whitespace characters on line
    nnoremap <silent> gm :call BetterGmNormalMode()<CR>
    onoremap <silent> gm :call BetterGmNormalMode()<CR>

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
    xnoremap <silent> if <ESC>gg0VG
    xnoremap <silent> af <ESC>gg0VG
    " operator pending mode
    onoremap <silent> if :<C-u>normal! gg0VG<CR>
    onoremap <silent> af :<C-u>normal! gg0VG<CR>
    
    " nummber text object (n=forwards, N=backwards)
    xnoremap in :<C-u>call VisualNumber('c')<CR>
    onoremap in :<C-u>normal vin<CR>
    xnoremap iN :<C-u>call VisualNumber('b')<CR>
    onoremap iN :<C-u>normal viN<CR>

    " use [w and ]w and [W and ]W to exchange a word/WORD the under cursor with
    " the prev/next one
    call Repeat(']w', 'mx$ox<ESC>kJ`xdawhelphmx$"_daw`xh')
    call Repeat(']W', 'mx$ox<ESC>kJ`xdaWElphmx$"_daw`xh')
    call Repeat('[w', 'mx$ox<ESC>kJ`xdawbPhmx$"_daw`xh')
    call Repeat('[W', 'mx$ox<ESC>kJ`xdaWBPhmx$"_daw`xh')

    " paste at end of line, with an automatic space
    call Repeat('>p', 'o<C-r>"<ESC>kJ')
    call Repeat('>P', 'o<C-r>"<ESC>kJ')
    " paste at start of line, with an automatic space
    call Repeat('<p', 'O<C-r>"<ESC>J')
    call Repeat('<P', 'O<C-r>"<ESC>J')

    " delete line, but leave it blank
    call Repeat('<LEADER>dd', 'cc<Esc>')

    " delete line above/below current line
    call Repeat('d[<SPACE>', ':call DeleteLineAbove()<CR>')
    call Repeat('d]<SPACE>', ':call DeleteLineBelow()<CR>')

    " delete line above and below a line
    call Repeat('d<SPACE>[', ':call DeleteBlankLineAboveAndBelow()<CR>')
    call Repeat('d<SPACE>]', ':call DeleteBlankLineAboveAndBelow()<CR>')

    " create line above and below a line
    call Repeat('<SPACE>[', ':call CreateBlankLineAboveAndBelow()<CR>')
    call Repeat('<SPACE>]', ':call CreateBlankLineAboveAndBelow()<CR>')

    " create some space either side of a character
    call Repeat('cs<SPACE>', ':call CreateSurroundingSpace()<CR>')

    " delete all space adjacent to contiguous non-whitespace under cursor
    call Repeat('ds<SPACE>', ':call DeleteSurroundingSpace()<CR>')

    " delete/yank surrounding funtion
    call Repeat('dsf', ':call DeleteSurroundingFunction("small")<CR>')
    call Repeat('dsF', ':call DeleteSurroundingFunction("big")<CR>')
    call Repeat('csf', ':call ChangeSurroundingFunction("small")<CR>')
    call Repeat('csF', ':call ChangeSurroundingFunction("big")<CR>')
    call Repeat('ysf', ':call Preserve(function("YankSurroundingFunction", ["small"]), 1)<CR>')
    call Repeat('ysF', ':call Preserve(function("YankSurroundingFunction", ["big"]), 1)<CR>')
    call Repeat('gsf', ':call PasteFunctionAroundFunction("small")<CR>')
    call Repeat('gsF', ':call PasteFunctionAroundFunction("big")<CR>')
    call Repeat('gsw', ':call PasteFunctionAroundWord("small")<CR>')
    call Repeat('gsW', ':call PasteFunctionAroundWord("big")<CR>')
   
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

    " open/close horizontal split containing w3m_scratch
    nnoremap <LEADER>W :call ToggleW3M()<CR>

    " anytime we read in a buffer, if it came from w3m then write to scratch
    autocmd BufReadPost * :call WriteW3MToScratch()
    "}}}-----------------------------------------------------------------------
    "{{{- searching and substitution ------------------------------------------
    " autocenter search results 
    nnoremap n nzvzz
    nnoremap N Nzvzz

    " toggle highlighted searches
    nnoremap <silent> <expr> <LEADER>/ 
                \ (v:hlsearch ? ':nohls' : ':set hls')."\n"

    " substitute word under the cursor
    nnoremap <LEADER>* :%s/\<<C-r><C-w>\>/

    " remove blank lines
    nnoremap <silent> <LEADER>t :g/^\s*$/d<HOME>
    vnoremap <silent> <LEADER>t <ESC>:'<,'>g/^\s*$/d<CR>

    " count the number of matched patterns
    nnoremap <LEADER>n :%s///gn<CR>

    "}}}-----------------------------------------------------------------------
    "{{{- common files to edit/source -----------------------------------------
    " edit/source common file in split window
    nnoremap <LEADER>ev :vsplit $MYVIMRC<CR>
    nnoremap <LEADER>sv :source $MYVIMRC<CR>
    " run current vimrc line as a command (useful when modifying vimrc)
    nnoremap <silent> <LEADER>sl :execute getline(line('.'))<cr>

    nnoremap <LEADER>eb :vsplit
                \ /home/mattb/linux_config_files/bashrc_multihost/base<CR>
    nnoremap <LEADER>ea :vsplit
                \ /home/mattb/linux_config_files/aliases_multihost/base<CR>
    nnoremap <LEADER>ef :vsplit
                \ /home/mattb/linux_config_files/functions_multihost/base<CR>
    nnoremap <LEADER>et :vsplit
                \ /home/mattb/linux_config_files/tmux.conf<CR>

    " force write a readonly file with root privileges 
    cnoremap w!! w !sudo tee %
    "}}}-----------------------------------------------------------------------
    "{{{- copy and paste with clipboard ---------------------------------------

    " paste from system CTRL-C clipboard
    nnoremap <LEADER>p :call PasteFromRegister('+', 'same', 'noautoindent')<CR>
    nnoremap <LEADER>]p :call PasteFromRegister('+', 'down', 'autoindent')<CR>
    nnoremap <LEADER>[p :call PasteFromRegister('+', 'up', 'autoindent')<CR>
    " paste from system highlighted clipboard
    nnoremap <LEADER>P :call PasteFromRegister('*', 'same', 'noautoindent')<CR>
    nnoremap <LEADER>]P :call PasteFromRegister('*', 'down', 'autoindent')<CR>
    nnoremap <LEADER>[P :call PasteFromRegister('*', 'up', 'autoindent')<CR>

    " copy contents of unnamed register to system CTRL-C clipboard
    nnoremap <silent> <LEADER>y :call Preserve("normal! Gp\"+dGu", 0)<CR>
                \ :echo 'copied to CTRL-C clipboard'<CR>
    " copy contents of unnamed register to system highlighted clipboard
    nnoremap <silent> <LEADER>Y :call Preserve("normal! Gp\"*dGu", 0)<CR>
                \ :echo 'copied to highlight clipboard'<CR>

    " format and yank buffer in a good way for pasting outside of vim
    command! Format execute 'normal! :1,$!fmt --width=2500<CR>"+yGu'
 
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
augroup vim "{{{---------------------------------------------------------------
    autocmd!
    " start out with everything folded away
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0
    autocmd FileType vim setlocal foldlevelstart=0
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
    set completeopt-=preview "don't have preview window on python autocomplete
    " avoid conversion issues when checking into github and/or sharing with other users.
    autocmd FileType python setlocal fileformat=unix
    " enable all Python syntax highlighting features
    autocmd FileType python let python_highlight_all=1
    autocmd FileType python setlocal foldmethod=indent

    " print a variable under the cursor
    autocmd FileType python nmap <LEADER>q mxyiwO<ESC>pIprint(<ESC>A)<ESC>
                \<Plug>SlimeLineSend<ESC>ddg`xu

    " refactor visually selected lines, first leave a blank line then call func
    autocmd FileType python vnoremap <LEADER>r s<ESC>:call RefactorPython()<CR>

    " insert refactored function where lines were taken from (after func above)
    autocmd FileType python nnoremap <LEADER>r 
                \?^\<def\>.*:<CR>:noh<CR>
                \Wyt:
                \'x]p

    " common imports
    autocmd FileType python abbreviate implt import matplotlib.pyplot as plt
    autocmd FileType python abbreviate imnp import numpy as np
augroup END
"}}}---------------------------------------------------------------------------
augroup r "{{{-----------------------------------------------------------------
    autocmd!
    " avoid conversion issues when checking into github and/or sharing with other users.
    autocmd FileType r,rmd setlocal fileformat=unix
    autocmd FileType r,rmd setlocal foldmethod=indent

    " easier to type assignment
    autocmd FileType r,rmd iabbrev <buffer> << <-

    " don't consider dots part of words (i.e. keep acting like normal vim)
    autocmd FileType r,rmd set iskeyword-=.
augroup END
"}}}---------------------------------------------------------------------------
augroup matlab "{{{------------------------------------------------------------
    autocmd!
    " make gcc comment matlab correctly
    autocmd FileType matlab setlocal commentstring=%\ %s
    autocmd FileType matlab setlocal foldmethod=indent

    " abbreviations
    autocmd FileType matlab iabbrev <buffer> fig figure
    autocmd FileType matlab iabbrev <buffer> key keyboard
    autocmd FileType matlab iabbrev <buffer> dbq dbquit
    autocmd FileType matlab iabbrev <buffer> dbc dbcont

    "{{{- variables/functions under the cursor --------------------------------
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
    "{{{- function documentation ----------------------------------------------
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
"}}}---------------------------------------------------------------------------
augroup markdown "{{{----------------------------------------------------------
    autocmd!
    autocmd FileType markdown setlocal spell

    " all lines under a section heading are folded
    autocmd FileType markdown setlocal foldmethod=expr 
    autocmd FileType markdown setlocal foldexpr=getline(v:lnum)=~'^[^#]\\\|^\\s*$'
    autocmd FileType markdown setlocal foldlevel=0
    autocmd FileType markdown setlocal foldlevelstart=0

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
"}}}---------------------------------------------------------------------------
augroup tex "{{{---------------------------------------------------------------
    autocmd!
    autocmd FileType tex setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType tex setlocal foldlevel=0
    autocmd FileType tex setlocal foldlevelstart=0

    " <LEADER>m to compile the doc - errors go to quickfix list
    autocmd FileType tex :let b:tex_flavor = 'pdflatex'
    autocmd FileType tex :compiler tex
    autocmd FileType tex nnoremap <LEADER>m :silent make % <CR>
augroup END
"}}}---------------------------------------------------------------------------
augroup tmux "{{{--------------------------------------------------------------
    autocmd!
    autocmd FileType tmux setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType tmux setlocal foldlevel=0
    autocmd FileType tmux setlocal foldlevelstart=0
augroup END
"}}}---------------------------------------------------------------------------
augroup tidy_code_matlab_and_python "{{{---------------------------------------
    autocmd!
    " remove trailing whitespace and perform auto indent when writing
    autocmd BufWritePre *.py,*.m :call Preserve("%s/\\s\\+$//e", 0)
    autocmd BufWritePre *.m :call Preserve("normal! gg=G", 0)
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
"==============================================================================
"
