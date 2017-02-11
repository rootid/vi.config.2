
function! EchoHHHH() 
	echo 'Hello World'
endfunction


" Append modeline after last line in buffer.
function! AppendModeline()
  let l:modeline = " vim: set ts=4 sw=4 tw=120 noet :"
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

"nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" vim: textwidth=120 wrap ts=4 sw=4 noexpandtab
" vim: foldmethod=marker
