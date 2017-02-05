if exists("loaded_related") 
finish
endif
let loaded_related = 1



" Refer ':help using-<Plug>'
"SID : unique identifier for each custom script
"s: make local to script
if !hasmapto('<Plug>Related')
map <unique> <leader>r <Plug>Related
endif
noremap <unique> <script> <Plug>Related <SID>Related 
noremap <SID>Related :call <SID>Related()<CR>

" count the # of lines
" source <file_name.vim>
" invoke the function
function s:Related() 
python <<EOF
import vim
print 'Length of the current line is', len(vim.current.line)
EOF
endfunction
