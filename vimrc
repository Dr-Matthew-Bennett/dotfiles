"{{{- wish list ---------------------------------------------------------------

" when pasting a line, have it match the indent level of the first
" non-whitespace line above

" automatic folding for markdown sections

" status bar to display last search term

" paste one space later than cursor (even if we're on at the end of the line)

" mapping to make a jump twice as big in the opposite direction (for when I
" do [count]j instead of [count]k (or vice versa)

" for targets to prioritise things backwards on the line more than forwards but
" off the line

" keep folds when opening file in split

"}}}---------------------------------------------------------------------------

"==== SETUP VUNDLE PLUGIN MANAGER =============================================
"{{{- paths -------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"}}}
"{{{ - plugins I use ----------------------------------------------------------
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" plugins I would put in a new vimrc
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'vim-scripts/ReplaceWithRegister'

" other plugins that do more exotic things
" Plugin 'jnurmine/Zenburn'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-repeat'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'vim-scripts/MatlabFilesEdition'
Plugin 'jpalardy/vim-slime'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'SirVer/ultisnips'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'simnalamburt/vim-mundo'
Plugin 'Matt-A-Bennett/vim-indent-object'
"}}}
"{{{- plugins I'm trying out---------------------------------------------------
" lots more text objects! looks very good and well made
Plugin 'wellle/targets.vim'
Plugin 'markonm/traces.vim'
"}}}
"{{{ - plugins I may want to try one day --------------------------------------
" Plugin 'scrooloose/nerdtree'
" Plugin 'w0rp/ale'
" Plugin 'tpope/vim-fugitive'
" Plugin 'airblade/vim-gitgutter'
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
"}}}
"{{{ - call vundle and overide things -----------------------------------------
" All of your Plugins must be added before the following line
call vundle#end()            " required
" I want to override one of the defaults here, so load it now then overwrite
runtime! plugin/sensible.vim
"}}}---------------------------------------------------------------------------
"==============================================================================

"==== PLUGIN CONFIGURATIONS AND REMAPS ========================================
"{{{- required ----------------------------------------------------------------
set nocompatible " don't try to be compatible with Vi
filetype plugin indent on "use default plugins

"make the space bar my leader key (must be before I make <Leader> mappings)
noremap <Space> <Nop>
sunmap <Space>
let mapleader=" "
"}}}---------------------------------------------------------------------------
    " {{{- fzf.vim ------------------------------------------------------------
    " insert mode line completion
    imap ;l <Plug>(fzf-complete-line)
    " search for and open file under the fzf default directory
    nnoremap <Leader>f :Files<cr>
    " search for and jump to line in any open buffer
    nnoremap <Leader>g :Lines<cr>
    " search through and jump to buffer
    nnoremap <Leader>b :Buffers<cr>

    " Change CTRL-X to CTRL-V to open file from fzf in vertical split
    let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-h': 'split',
      \ 'ctrl-v': 'vsplit' }

    " Ag call a modified version of Ag where first arg is directory to search
    command! -bang -nargs=+ -complete=dir Ag call s:ag_in(<bang>0, <f-args>)
    "}}}-----------------------------------------------------------------------
"{{{- mundo -------------------------------------------------------------------
" to see and choose a previous state from the undo tree
nnoremap <F5> :MundoToggle<cr>
"}}}---------------------------------------------------------------------------
"{{{- targets.vim -------------------------------------------------------------
" Only consider targets fully visible on screen:
let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa'

" Only seek if next/last targets touch current line:
" let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr ll lb ar ab lB Ar aB Ab AB rb rB al Al'
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
" I want the default to be to the left of the vim I'm working in
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
" }}}-------------------------------------------------------------------------
"{{{- ultisnips --------------------------------------------------------------
" Ultisnips trigger configuration.
" Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"
let g:UltiSnipsEditSplit="vertical"
" where ultisnips looks for snippets
" (I think you can add multiple items in the list)
let g:UltiSnipsSnippetDirectories=["/home/mattb/.vim/ultisnips"]
"}}}--------------------------------------------------------------------------
"{{{- YouCompleteMe ----------------------------------------------------------
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

"==== CUSTOM CONFIGURATIONS ===================================================
"{{{- general settings --------------------------------------------------------
set encoding=utf-8
set number " put line number where the cursor is
set relativenumber " number all other lines relative to current line
set hidden " when swtiching buffers, don't complain about unsaved changes
set undofile " remember changes from previous vim session (so I can still undo)
set splitbelow " where new vim pane splits are positioned
set splitright " where new vim pane splits are positioned
set cc=80 "show vertical bar at 80 columns
set textwidth=79 " at 79 columns, wrap text
set linebreak " wrap long lines at a character in 'breakat' (default " ^I!@*-+;:,./?")
set nowrap " don't wrap lines by default
set wildmenu " list completion options when typing in command line mode
set wildmode=longest,list " behave like bash autocomplete rather than zsh
set wildignorecase " ignore case when completing file names
set expandtab " expand tabs into spaces
set tabstop=4 " a tab is the same as 4 spaces
set softtabstop=4 " when I hit <tab> in insert mode, put 4 spaces
set shiftwidth=4 " when auto-indenting, use 4 spaces per tab
set autoindent " when creating a new line, copy indent from line above
set nojoinspaces " don't join with double spaces when line ending with ./!/?
set showmatch " show the matching part of the pair for [] {} and ()
set incsearch " show matches for patterns while they are being typed
set hlsearch | noh " highlight matches for searched (turn off when sourcicng)
set smartcase " with both on, searches with no capitals are case insensitive...
set ignorecase " ...while searches with capital characters are case sensitive.
set nrformats= " don't interpret 007 as octal (<C-a> will make 008, not 010)
set spell spelllang=en
set nospell " don't hightlight misspellings unles I say so
set lazyredraw " don't redraw screen during macros (let them complete faster)
set foldlevelstart=1 " when opening new files, start with only top folds open
set t_Co=256 " use full colours
colorscheme zenburn " when I moved it to the top of the this section, it failed
syntax enable " highlight special words to aid readability
"}}}---------------------------------------------------------------------------
"{{{- general remaps ----------------------------------------------------------
augroup general
    "{{{- movements -----------------------------------------------------------
    " let g modify insert/append to work on visual lines, in the same way as it
    " modifies motions like 0 and $
    nnoremap gI g0i
    nnoremap gA g$i

    " store relative line number jumps in the jumplist.
    nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
    nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
    "}}}-----------------------------------------------------------------------
    "{{{- splits --------------------------------------------------------------
    " generate new vertical split with \ (which has | on it)
    " and switch to next buffer (if there's more than one buffer)
    nnoremap <Leader>\ :vsplit<cr>:b#<cr>
    " generate new horizontal split with - and switch to next buffer (if
    " there's more than one buffer)
    nnoremap <Leader>- :split<cr>:b#<cr>

    " open current split in own tab (like zoom in tmux) and keep cursor " pos
    nnoremap <Leader>z mx:tabedit %<cr>g`x

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

    nnoremap <Leader>ea :vsplit
                \ /home/mattb/linux_config_files/aliases_multihost/base_aliases<cr>
    nnoremap <Leader>eb :vsplit
                \ /home/mattb/linux_config_files/base_bashrc<cr>
    "}}}-----------------------------------------------------------------------
    "{{{- copy and paste with clipboard ---------------------------------------
    " paste from system CTRL-C clipboard
    nnoremap <Leader>p "+p
    " paste from system highlghted clipboard
    nnoremap <Leader>P "*p
    " copy contents of unnamed register to system CTRL-C clipboard
    nnoremap <silent><Leader>y :call Preserve("normal! Gp\"+dGu")<cr>
                \ :echo 'copied to CTRL-C clipboard'<cr>
    " copy contents of unnamed register to system highlghted clipboard
    nnoremap <silent><Leader>Y :call Preserve("normal! Gp\"*dGu")<cr>
                \ :echo 'copied to highlight clipboard'<cr>
    "}}}-----------------------------------------------------------------------
    "{{{- abbreviations -------------------------------------------------------
    " emails
    iabbrev @g bennettmatt4@gmail.com
    iabbrev @u matthew.bennett@uclouvain.be
    " common mispellings
    iabbrev keybaord keyboard
    iabbrev hte the
    "}}}-----------------------------------------------------------------------
    "{{{- spelling ------------------------------------------------------------
    " instantly go with first spelling suggestion
    nnoremap <Leader>sp a<C-X>s<Esc>
    "}}}-----------------------------------------------------------------------
augroup END
"}}}---------------------------------------------------------------------------
"{{{- general commands --------------------------------------------------------
augroup general_commands
" close buffer without closing window split
command! Bd bprevious | split | bNext | bdelete
"}}}---------------------------------------------------------------------------
"{{{- file specific settings --------------------------------------------------
augroup filetype_vim "{{{
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType vim setlocal foldlevel=0
augroup END
"}}}
augroup python "{{{
    autocmd!
    " avoid conversion issues when checking into GitHub and/or sharing with other users.
    autocmd FileType python3 setlocal fileformat=unix
    " enable all Python syntax highlighting features
    autocmd FileType python3 let python_highlight_all=1
    autocmd FileType python3 setlocal foldmethod=indent

    " I want to use different remaps in indent-object.vim for python, but I'm
    " gettign errors

    " set rtp+=~/linux_config_files/vim/functions
    " runtime indent-object.vim

    " source ~/linux_config_files/vim/functions/indent-object.vim

    " " Mappings excluding line below (good for python?)
    " onoremap <silent>ai :<C-u>cal <Sid>HandleTextObjectMapping(0, 0, 0, [line("."), line("."), col("."), col(".")])<CR>
    " onoremap <silent>ii :<C-u>cal <Sid>HandleTextObjectMapping(1, 0, 0, [line("."), line("."), col("."), col(".")])<CR>
    " vnoremap <silent>ai :<C-u>cal <Sid>HandleTextObjectMapping(0, 0, 1, [line("'<"), line("'>"), col("'<"), col("'>")])<CR><Esc>gv
    " vnoremap <silent>ii :<C-u>cal <Sid>HandleTextObjectMapping(1, 0, 1, [line("'<"), line("'>"), col("'<"), col("'>")])<CR><Esc>gv

augroup END
"}}}
augroup matlab "{{{
    autocmd!

    " make gcc comment matlab correctly
    autocmd FileType matlab setlocal commentstring=%\ %s
    autocmd FileType matlab setlocal foldmethod=indent

    " abbreviations
    autocmd FileType matlab iabbrev <buffer> key keyboard

    " send the variable under the cursor to matlab
    autocmd FileType matlab nmap <Leader>q viw<Plug>SlimeRegionSend

    " the above is much more elegant
    " autocmd FileType matlab nmap <Leader>q mxyiwO<Esc>p
    "             \<Plug>SlimeLineSend<Esc>ddg`xu

    "             old slime command - can delete this once tested in matlab
    "             \V<C-c><C-c>ddg`x

    " imagesc a variable under the cursor
    autocmd FileType matlab nmap <Leader>i mxyiwO<Esc>
                \pIfigure, imagesc(<Esc>A), axis image<Esc>
                \<Plug>SlimeLineSend<Esc>ddg`xu

    " print documentation of matlab function
    autocmd FileType matlab nmap <Leader>d mxyiwO<Esc>pIhelp <Esc>
                \<Plug>SlimeLineSend<Esc>ddg`xu

    " ask whos a variable under the cursor
    autocmd FileType matlab nmap <Leader>w mxyiwO<Esc>pIwhos <Esc>
                \<Plug>SlimeLineSend<Esc>ddg`xu

    " clean up documentation after func snip (remove lines with unused arguments)
    autocmd FileType matlab nnoremap <Leader>dc
                \ :g/% arg :/norm dap <cr> :g/optional_/d <cr> :%s/arg, //g <cr>G

    " add any optional variables to the help docs LEAVE THE SPACE AT THE $!! 
    autocmd FileType matlab nnoremap <Leader>dh 
                \/set default values for optional variables<cr>j0wy}zR
                \/'\\n'],<cr>pms
                \v}k$:norm f=d$<cr>
                \}yy'sPjwv}k$
                \:norm ^i['\n<cr>
                \'sv}k$: norm $i'],...<cr>
                \'skdd=}}2ddG

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
augroup filetype_tex "{{{
    autocmd!
    autocmd FileType tex setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType tex setlocal foldlevel=0

    " gq until a line beggining with \
    " I figured out the macro (that's everything after the :), but I've
    " forgotten how to do the remap commands
    " nnoremap <Leader>g :^ms/\\k$me`sgq`en:noh
"}}}
augroup filetype_tmux "{{{
    autocmd!
    autocmd FileType tmux setlocal foldmethod=marker
    " start out with everything folded away
    autocmd FileType tmux setlocal foldlevel=0
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
    " turn off current line hightlighting when leaving insert mode
    autocmd InsertLeave * set nocursorline
augroup END
"}}}---------------------------------------------------------------------------
"{{{ - tweak zenburn colorscheme ----------------------------------------------
" make the highlighted seached words less distracting
highlight Search term=reverse ctermfg=230 ctermbg=8 cterm=underline
"}}}---------------------------------------------------------------------------
"==============================================================================

"==== FUNCTIONS ===============================================================
"{{{- if pasting at end of a word, preceed with a space -----------------------
" not working, maybe not a great idea anyway...

" nnoremap p :call Paste()<cr>

function! Paste()
    " Check if register contains newline
    if matchstr(@", '*$*') != @"
        if EndWord()
            normal p
        endif
    else
        norm p
    endif
endfunction
"}}}---------------------------------------------------------------------------
"{{{- determine if cursor is on the end of a word -----------------------------
function! EndWord() abort
    let pos = getpos('.')
    normal! gee
    if pos == getpos('.')
        return v:true
    else
        call setpos('.', pos)
        return v:false
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
  call fzf#vim#ag(join(a:000[1:], ' '), fzf#vim#with_preview({'dir': a:1}, 'right:50%', '?'), a:bang)
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
"{{{- restore cursor postition ------------------------------------------------
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
"{{{- copy matches to register ------------------------------------------------
" copies only the text that matches search hits. Use with :CopyMatches :
" where x is any register (supplying no x copies to clipboard
function! CopyMatches(reg)
    let hits = []
    %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
    let reg = empty(a:reg) ? '+' : a:reg
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
"}}}---------------------------------------------------------------------------
"==============================================================================

