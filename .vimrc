"---- things I would like ----------------------------------------------------
"{{{
" - when pasting a line, have it match the indent level of the first
" non-whitespace line above
" - replace word under the cursor with word in register
" - matlab folds to use 'function', 'for', 'if', 'while' and go to 'end'
" - format matlab scripts (blank lines etc.) on saving
" - automatic folding for markdown sections
" - status bar to display last search term 
" - paste one space later than cursor (even if we're on at the end of the line)
"}}}
"-----------------------------------------------------------------------------

"---- required ---------------------------------------------------------------
"{{{
set nocompatible " don't try to be compatible with Vi
filetype plugin indent on "use default plugins
"}}}
"-----------------------------------------------------------------------------

"---- general settings -------------------------------------------------------
"{{{
set encoding=utf-8
set number
set history=200 " increase search history
set splitbelow " where new vim pane splits are positioned
set splitright " where new vim pane splits are positioned
set linebreak " wrap long lines at a character in 'breakat' (default " ^I!@*-+;:,./?") 
set nowrap " don't wrap lines by default
set wildmenu " list completion options when typing in command line mode
set wildmode=longest,list " behave like bash autocomplete rather than zsh
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab " expand tabs into spaces
set autoindent
set showmatch " show the matching part of the pair for [] {} and ()
set nrformats= " don't interpret 007 as an octal (<C-a> will now make 008, not 010)
set incsearch " show matches for patterns while they are being typed
set hlsearch " highlight all matches for searched pattern
set smartcase " With both on, searches with no capitals are case insensitive, while... 
set ignorecase " ...searches with capital characters are case sensitive.
set spell spelllang=en
set nospell
set lazyredraw " don't redraw screen during macros (let them complete faster)
set foldlevelstart=1 " when opening new files, start with only top folds open
set cc=80 "show vertical bar at 80 columns
set t_Co=256 " use full colours
syntax enable " highlight special words to aid readability
"}}}
"-----------------------------------------------------------------------------

"==== SETUP VUNDLE PLUGIN MANAGER ============================================
"---- paths ------------------------------------------------------------------
"{{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

"}}}
"---- plugins ----------------------------------------------------------------
"{{{
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" other plugins
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'jnurmine/Zenburn'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'jeetsukumaran/vim-indentwise'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'vim-scripts/MatlabFilesEdition'
Plugin 'jpalardy/vim-slime'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'SirVer/ultisnips'

"}}}
"---- plugins I may want to use one day --------------------------------------
"{{{
" Plugin 'honza/vim-snippets'
" Plugin 'scrooloose/nerdtree'
" Plugin 'w0rp/ale'
" Plugin 'junegunn/fzf.vim'
" Plugin 'tpope/vim-fugitive'
" IGNORANT Plugin 'sheerun/vim-polyglot'
" IGNORANT Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" IGNORANT Plugin 'vim-airline/vim-airline'
" IGNORANT Plugin 'vim-airline/vim-airline-themes'
" IGNORANT Plugin 'airblade/vim-gitgutter'
" IGNORANT Plugin 'majutsushi/tagbar'

"" All of your Plugins must be added before the following line
call vundle#end()            " required

" I want to override one of the defaults here, so load it now then overwrite
runtime! plugin/sensible.vim
colorscheme zenburn
"}}}
"-----------------------------------------------------------------------------
"=============================================================================

"---- remaps -----------------------------------------------------------------
"{{{
augroup general
    autocmd!
    " edit common file in split window
    autocmd BufNewFile,BufRead * :nnoremap <Leader>ev :split $MYVIMRC<cr>
    autocmd BufNewFile,BufRead * :nnoremap <Leader>sv :source $MYVIMRC<cr>
    autocmd BufNewFile,BufRead * :nnoremap <Leader>ea :split /home/mattb/linux_config_files/multihost_bash_aliases/base_aliases<cr>

    " resize windows (and make it repeatable with dot command)
    " widen the split
    autocmd BufNewFile,BufRead * nnoremap <Plug>WidenSplit :exe "vertical resize +5"<cr>
    \:call repeat#set("\<Plug>WidenSplit")<CR>
    nmap <Leader>h <Plug>WidenSplit
    " thin the split 
    autocmd BufNewFile,BufRead * nnoremap <Plug>ThinSplit :exe "vertical resize -5"<cr>
    \:call repeat#set("\<Plug>ThinSplit")<CR>
    nmap <Leader>l <Plug>ThinSplit
    " heighten the split
    autocmd BufNewFile,BufRead * nnoremap <Plug>HeightenSplit :exe "resize +3"<cr>
    \:call repeat#set("\<Plug>HeightenSplit")<CR>
    nmap <Leader>k <Plug>HeightenSplit
    " shorten the split 
    autocmd BufNewFile,BufRead * nnoremap <Plug>ShortenSplit :exe "resize -3"<cr>
    \:call repeat#set("\<Plug>ShortenSplit")<CR>
    nmap <Leader>j <Plug>ShortenSplit

    " instantly go with first spelling suggestion
    :nnoremap <Leader>s a<C-X>s<Esc> 

    " search and replace word under cursor
    autocmd BufNewFile,BufRead * :nnoremap <Leader>* :%s/\<<C-r><C-w>\>/

    " let g modify insert/append to work on visual  lines, in the same way as it
    " modifies motions like 0 and $
    autocmd BufNewFile,BufRead * nnoremap gI g0i
    autocmd BufNewFile,BufRead * nnoremap gA g$i

    " reminder not to use arrows in insert mode
    autocmd BufNewFile,BufRead * :inoremap <Left> <esc>mm :echo "Arrows are stupid. Use normal mode to move."<cr>`m
    autocmd BufNewFile,BufRead * :inoremap <Right> <esc>mm :echo "Arrows are stupid. Use normal mode to move."<cr>`m
    autocmd BufNewFile,BufRead * :inoremap <Up> <esc>mm :echo "Arrows are stupid. Use normal mode to move."<cr>`m
    autocmd BufNewFile,BufRead * :inoremap <Down> <esc>mm :echo "Arrows are stupid. Use normal mode to move."<cr>`m

    " abbreviations
    autocmd BufNewFile,BufRead * iabbrev keybaord keyboard
    autocmd BufNewFile,BufRead * iabbrev @g bennettmatt4@gmail.com
    autocmd BufNewFile,BufRead * iabbrev @u matthew.bennett@uclouvain.be
augroup END
"}}}
"-----------------------------------------------------------------------------

"---- file specific settings -------------------------------------------------
"{{{
augroup filetype_vim 
    autocmd!
   autocmd FileType vim setlocal foldmethod=marker
   " this next one isn't working for some reason...
   autocmd FileType vim setlocal foldlevelstart=0
augroup END
"}}}
"{{{
augroup tidy_code
    autocmd!
    " remove trailing whitespace and perform auto indent 
    autocmd BufWritePre *.py,*.m :call Preserve("%s/\\s\\+$//e")
    autocmd BufWritePre *.m :call Preserve("normal! gg=G")
augroup END 
"}}}
"{{{
augroup python
    autocmd!
    autocmd BufNewFile,BufRead *.py set fileformat=unix " avoid conversion issues when checking into GitHub and/or sharing with other users.
    autocmd BufNewFile,BufRead *.py let python_highlight_all=1 " enable all Python syntax highlighting features
    autocmd BufNewFile,BufRead *.py setlocal foldmethod=indent
augroup END
"}}}
"{{{
augroup matlab
    autocmd!
    autocmd BufNewFile,BufRead *.m iabbrev <buffer> key keyboard
    autocmd BufNewFile,BufRead *.m setlocal foldmethod=indent

    " these next two are buggy:
    " blank lines immediately after for/if

    " inside indent block
    autocmd BufNewFile,BufRead *.m onoremap ii :<c-u>execute "normal [-j^v]-kg_"<cr>
    " around indent block
    autocmd BufNewFile,BufRead *.m onoremap ai :<c-u>execute "normal [-V]="<cr>
augroup END
"}}}
"{{{
augroup markdown
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal wrap 
    autocmd BufNewFile,BufRead *.md setlocal spell
    " inside headed title:
    autocmd BufNewFile,BufRead *.md onoremap iht :<c-u>execute "normal! ?^#\\+ \\w\\+.*$\rwvg_"<cr>
    " around headed title:
    autocmd BufNewFile,BufRead *.md onoremap aht :<c-u>execute "normal! ?^#\\+ \\w\\+.*$\rvg_"<cr>
    " inside headed body:
    autocmd BufNewFile,BufRead *.md onoremap ihb :<c-u>execute "normal! ?^#\\+ \\w\\+.*$\rjv/^#\\+ \\w\\+.*$\rk"<cr>
    " around headed body:
    autocmd BufNewFile,BufRead *.md onoremap ahb :<c-u>execute "normal! ?^#\\+ \\w\\+.*$\rv/^#\\+ \\w\\+.*$\rk"<cr>
augroup END
"}}}
"-----------------------------------------------------------------------------

"---- cursor behaviour -------------------------------------------------------
"{{{
augroup cursor_behaviour
    autocmd!  
    autocmd InsertEnter * set cursorline " highlight line when in insert mode
    autocmd InsertLeave * set nocursorline " turn off above when leaving insert mode
    " reset cursor on start:
    autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
"}}}
"{{{
let &t_SI = "\e[5 q" " cursor blinking bar on insert mode
let &t_EI = "\e[2 q" " cursor steady block on command mode
"}}}
"-----------------------------------------------------------------------------

"---- commands ---------------------------------------------------------------
"{{{
" close buffer without closing window split
command! Bd bprevious | split | bNext | bdelete
"}}}
"-----------------------------------------------------------------------------

"==== PLUGIN CONFIGS =========================================================
"---- vim-slime config -------------------------------------------------------
"{{{
" vim-slime lets me send visual selections from vim to a tmux pane of my choice. 
" You can set the target manually using hitting C-c and then v.
" ":i.j"    means the ith window, jth pane

let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
" I want the default to be to the left of the vim I'm working in
let g:slime_default_config = {"socket_name": "default", "target_pane": "{left-of}"}
" and not to ask me about it even on the first time I use it 
let g:slime_dont_ask_default = 1
" make F9 a shortcut for sending N lines to the tmux pane
:nmap <F9> V<C-c><C-c>
"}}}
"-----------------------------------------------------------------------------

"---- ultisnips config -------------------------------------------------------
"{{{
" Ultisnips trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-s>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
" where ultisnips looks for snippets (I think you can add multiple items in the list)
let g:UltiSnipsSnippetDirectories=["/home/mattb/.vim/ultisnips"]
"}}}
"-----------------------------------------------------------------------------

"---- YouCompleteMe config ---------------------------------------------------
"{{{
" YouCompleteMe has a few filetypes that it doesn't work on by default (no
" idea why). I removed markdown from this list and it seems to work just fine.
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
"}}}
"-----------------------------------------------------------------------------
"=============================================================================

"==== functions ==============================================================
"---- restore cursor postition -----------------------------------------------
"{{{
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
"}}}
"-----------------------------------------------------------------------------

"---- copy matches to register -----------------------------------------------
"{{{
" copies only the text that matches search hits. Use with :CopyMatches x 
" where x is any register (supplying no x copies to clipboard
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)
"}}}
"-----------------------------------------------------------------------------
"=============================================================================

