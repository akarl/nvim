" set foldmethod=expr
" set foldexpr=GolangFold(v:lnum)

function! GolangFold(lnum)
	let cur_line = getline(a:lnum)
	let prev_line = getline(a:lnum-1)

	if cur_line =~? '\v^\s*$'
        return '-1'
    endif

	if prev_line =~? '\v\{$'
		return indent(a:lnum) / &shiftwidth
	endif
	if cur_line =~? '\v^\s*\}'
		return indent(a:lnum) / &shiftwidth
	endif

	return '='
endfunction
