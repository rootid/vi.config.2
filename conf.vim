"https://github.com/dougblack/dotfiles/blob/master/.vimrc
"
if has('vim_starting')
  if exists('$SRC')
    set runtimepath^=$SRC/vim runtimepath+=$SRC/vim/after
  elseif isdirectory(expand('~/Code'))
    set runtimepath^=~/Code/vim runtimepath+=~/Code/vim/after
  elseif isdirectory(expand('~/src'))
    set runtimepath^=~/src/vim runtimepath+=~/src/vim/after
  endif
  "runtime! bundle/vim-pathogen/autoload/pathogen.vim
  execute pathogen#infect("bundle/{}")
  execute pathogen#infect("testbundle/{}")
endif

""TODO : need to fix above code

" Section: Defaults  {{{
" ---------------------
:so ${HOME}/.vim/vim.addons/default.vim
:so ${HOME}/.vim/vim.addons/my.custom.vim
:so ${HOME}/.vim/vim.addons/ctrpl.conf.vim

:set efm="%f:%l: %m,%f:%l %m,%f:%l:      %m"

:so ${HOME}/.vim/vim.addons/load.pathogen.vim
":so ${HOME}/.vim/vim.addons/neocomplete.conf.vim
:so ${HOME}/.vim/vim.addons/ctrpl.conf.vim
":so ${HOME}/.vim/vim.addons/filetype.conf.vim
:so ${HOME}/.vim/vim.addons/indexed.search.vim
":so ${HOME}/.vim/vim.addons/tern.conf.vim
:so ${HOME}/.vim/vim.addons/fold.vim

"" set alignment
:so ${HOME}/.vim/vim.addons/tabularize.conf.vim

"code-navigation
":so ${HOME}/.vim/vim.addons/omnicomplete.conf.vim
":so ${HOME}/.vim/vim.addons/cscope.conf.vim
":so ${HOME}/.vim/vim.addons/ctags.conf.vim
":so ${HOME}/.vim/vim.addons/tlist.conf.vim
":so ${HOME}/.vim/vim.addons/spell.check.vim
":so ${HOME}/.vim/vim.addons/hard.reset.vim

"ln -sf ${PWD}/vim_config  ${HOME}/.vimrc
":so ${HOME}/.vim/vim.addons/dev.null.vim
":so ${HOME}/.vim/vim.addons/solarized.color.vim
":so ${HOME}/.vim/vim.addons/nerdtree.conf.vim
":so ${HOME}/.vim/vim.addons/filetype.conf.vim
"}}}

" Section: Custom Functions {{{1
" ---------------------
function! ToggleNumber()
    if(&relativenumber == 1)
        set number
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

nnoremap <C-n> :call ToggleNumber()<cr>
"nnoremap <C-l> :call s:toggle_list()<cr>
"}}}
"

" Section: Mappings {{{1
" ----------------------
"nmap <C-s> :w<cr>
"imap <C-s> <Esc>:w<cr>a

inoremap <C-s> <C-o>:mksession! ~/sessions/test.vim<CR>
noremap <C-S> :mksession! ~/sessions/test.vim<CR>


"colorscheme cake
"colorscheme github

set t_Co=256
let g:solarized_termcolors=256
syntax enable
set background=light
colorscheme solarized

set diffopt+=vertical
filetype plugin on



augroup configgroup
    autocmd!
    "autocmd VimEnter * highlight clear SignColumn
    "autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
    "            \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal nolist
    "autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    "autocmd FileType java setlocal formatprg=par\ -w120\ -T4
    autocmd FileType java setlocal sts=2
    autocmd FileType java setlocal sw=2
    autocmd FileType java setlocal ts=2
    autocmd FileType java setlocal tw=120
    autocmd FileType java setlocal expandtab
    autocmd FileType java setlocal nu
    autocmd FileType java setlocal spell
    autocmd FileType javascript setlocal expandtab
    autocmd FileType javascript setlocal nolist
    autocmd FileType javascript setlocal sts=2
    autocmd FileType javascript setlocal sw=2
    autocmd FileType javascript setlocal ts=2
    autocmd FileType javascript setlocal tw=120
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    "autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
"function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
"    let _s=@/
"    let l = line(".")
"    let c = col(".")
"    %s/\s\+$//e
"    let @/=_s
"    call cursor(l, c)
"endfunction


" CtrlP settings
"let g:ctrlp_match_window = 'bottom,order:ttb'
"let g:ctrlp_switch_buffer = 0
"let g:ctrlp_working_path_mode = 0
"let g:ctrlp_user_command = 'ack %s -l --nocolor --hidden -g ""

"
"

" highlight last inserted text
nnoremap gV `[v`]
set lazyredraw          " redraw only when we need to.
set showcmd             " show command in bottom bar
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set laststatus=2
set nolist
