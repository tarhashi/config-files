set nocompatible

" color settings
syntax on

" filetype plugin
filetype plugin indent on

"tab settings
set tabstop=4 shiftwidth=4 softtabstop=0
set expandtab
set autoindent smartindent

"入力補助
set backspace=indent,eol,start
set formatoptions+=m

"コマンド補完
set wildmenu
set wildmode=list:full

"検索
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch

" 表示関連
set number
set showmatch
set wrap

" マウス
""set mouse=a
" screen対応
set ttymouse=xterm2

" tabs
set tags+=tags;

:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1

" Alignの設定
:let g:Align_xstrlen = 3

let g:FtEvalCommand = {
            \   'scheme' : 'system("gosh"  , "(display (begin\n" . a:expr . "\n))")', 
            \   'gauche' : 'system("gosh"  , "(display (begin\n" . a:expr . "\n))")', 
            \   'gosh'   : 'system("gosh"  , "(display (begin\n" . a:expr . "\n))")', 
            \   'perl'   : 'system("perl"  , "print eval{use Data::Dumper;$Data::Dumper::Terse = 1;$Data::Dumper::Indent = 0;Dumper " . a:expr . " }")',
            \   'python' : 'system("python", "print(" . a:expr . ")")', 
            \   'ruby'   : 'system("ruby " , "p proc {\n" . a:expr . "\n}.call")', 
            \   'vim'    : 'eval(a:expr)', 
            \ }

function g:FtEval(expr, filetype)
    unlet! g:FtEvalResult
    let g:FtEvalResult = eval(a:filetype !~ '\S' ? g:FtEvalCommand[&filetype]
                \                                      : g:FtEvalCommand[a:filetype])
    return g:FtEvalResult
endfunction

function <SID>GetVisualText()
    let p0 = getpos('''<')
    let p1 = getpos('''>')

    if p0[1] == p1[1]
        return getline(p0[1])[ p0[2] - 1 : p1[2] - 1 ]
    endif
    return join([ getline(p0[1])[ p0[2] - 1 : ] ] +  getline(p0[1] + 1, p1[1] - 1) +
                \     [ getline(p1[1])[ : p1[2] - 1 ] ] , "\n")
endfunction

command -narg=? -range FtEvalLine   echo g:FtEval(getline('.'),                <q-args>)
command -narg=? -range FtEvalBuffer echo g:FtEval(join(getline(0, '$'), "\n"), <q-args>)
command -narg=? -range FtEvalVisual echo g:FtEval(<SID>GetVisualText(),        <q-args>)

nnoremap <Space>e :FtEvalLine<CR>
nnoremap <Space>E :FtEvalBuffer<CR>
vnoremap <Space>e :FtEvalVisual<CR>
vnoremap <Space>E :FtEvalVisual vim<CR>

inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

" neocomplcache
let g:neocomplcache_enable_at_startup = 1 " 起動時に有効化

" netrw
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_alto = 1
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'


" ,is: シェルを起動
nnoremap <silent> ,is :VimShell<CR>
" ,ipy: pythonを非同期で起動
nnoremap <silent> ,ipy :VimShellInteractive python<CR>
" ,irb: irbを非同期で起動
nnoremap <silent> ,irb :VimShellInteractive irb<CR>
" ,ss: 非同期で開いたインタプリタに現在の行を評価させる
vmap <silent> ,ss :VimShellSendString<CR>
" 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>

