"============================================================================
"File:        pgsanity.vim
"Description: Syntax checking plugin for syntastic.vim
"Authors:     Duffy Tilleman <duffy dot tilleman+git at gmail dot com>
"
"============================================================================

if exists("g:loaded_syntastic_sql_pgsanity_checker")
    finish
endif
let g:loaded_syntastic_sql_pgsanity_checker = 1

let s:save_cpo = &cpo
set cpo&vim

"function! SyntaxCheckers_sql_pgsanity_GetHighlightRegex(item)
"endfunction

function! SyntaxCheckers_sql_pgsanity_GetLocList() dict
    let makeprg = self.makeprgBuild({})

    let errorformat =
        \ '%Eline %l: %m'

    let loclist = SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat })

    return SyntasticMake({
        \ 'makeprg': makeprg,
        \ 'errorformat': errorformat,
        \ 'defaults': {'bufnr': bufnr('')} })
endfunction

runtime! syntax_checkers/sql/pgsanity.vim

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'sql',
    \ 'name': 'pgsanity'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:

