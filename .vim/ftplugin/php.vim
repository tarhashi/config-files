
""
" PHPLint
"
" @author halt feits <halt.feits at gmail.com>
"
function! PHPLint()
  let result = system( &ft . ' -l ' . bufname(""))
  echo result
endfunction

""
" PHP Lint
nmap ,l :call PHPLint()<CR>

""let php_folding=1
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1

:set dictionary=~/.vim/dict/PHP.dict

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
