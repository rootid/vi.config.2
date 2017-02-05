
function CheckFileType() 
	if exists("b:countCheck") == 0 
		let b:countCheck = 0 
	endif 
	let b:countCheck += 1
	" Don't start detecting until approx. 20 chars. 
	if &filetype == "" && b:countCheck > 20 
		filetype detect 
	endif
endfunction

"// vim: ts=4 sw=4 tw=0 noet
