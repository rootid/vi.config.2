"switch between relno
noremap ,r  :set relativenumber!<CR>

"Switch between ic
nnoremap ic :set ignorecase! ignorecase?<CR>

"Move current line to next line
map ,n i<CR><ESC>

"Add new line below after you press Enter
nnoremap <Enter> :call append(line('.'), '')<CR>

"Add empty line below after you press ,o
nnoremap ,o o<Esc>

"Add empty line below after you press ,a with function
function! AddEmptyLineBelow()
  call append(line("."), "")
endfunction
noremap <silent> ,a :call AddEmptyLineBelow()<CR>

"Add space before the cursor
nnoremap ss i<space><esc>

map ,f :%s/\((\w\+)\)\([A-Z]\)/\1 \2/g<CR>
map ,f1 :%s/\((\w\+)\)\([a-z]\)/\1 \2/g<CR>
map ,f2 :%s/if(/if (/g<CR>
"map ,f :%s/\(^\s\{4,4}\)\}/\1}\r/g<CR>
"map ,p :%s/\(private\(\p\+\);\)/\1\r/g<CR>
"map ,s :%s/,\(\w\+\)/, \1/g<CR>
"map ,i :%s/ /    /g<CR>
"map ,o 1o<Esc>
"map ,t :%s/\n\{2,}/\r\r/e<CR>
"map ,g :%s/\s\+$//e<CR>
"map ,x :%s/\(<\/\(properties\|parent\|scm\|profiles\|dependencies\|build\)>\)/\1\r/g

"Use repeat.vim with 3 steps

"1. Write the function : NOTE this will be repeated with .
function! ChangeString()
    " Save cursor position
    let l:save = winsaveview()
    s/BaseRequestDTO/String/g
    " Move cursor to original position
    call winrestview(l:save)
    echo "changed the given line"
endfunction

"2. Create the mapping with Plugin
nmap cm <Plug>ReplaceCharacters

"3. Map function to plugin
nnoremap <silent> <Plug>ReplaceCharacters :call ChangeString()<CR>
            \:call repeat#set("\<Plug>ReplaceCharacters")<CR>


