if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
" HTML (.shtml and .stm for server side)
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm  call s:FThtml()

" Distinguish between HTML, XHTML and Django
func! s:FThtml()
  let n = 1
  while n < 10 && n < line("$")
    if getline(n) =~ '\<DTD\s\+XHTML\s'
      setf xhtml
      return
    endif
    if getline(n) =~ '{%\s*\(extends\|block\)\>'
      setf htmljinja
      return
    endif
    let n = n + 1
  endwhile
  setf html
endfunc

augroup END

au BufNewFile,BufRead *.ini,*.conf setf dosini
