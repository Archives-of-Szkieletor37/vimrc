:set autoindent
:set shiftwidth=2
:set tabstop=2
:set relativenumber
:set number
:set background=dark
:colorscheme elflord 
:set laststatus=2 "ステータス行を常に表示
:set cmdheight=2 "メッセージ表示欄を2行確保
:set showmatch "対応するカッコを強調表示
:set helpheight=999 "ヘルプを画面一杯に表示
:imap <C-j> <esc>
:noremap! <C-j> <esc>
:set clipboard =unnamedplus
:set backspace=indent,eol,start


"dein Scripts-----------------------------
if &compatible
	set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/riel/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/riel/.cache/dein')
	call dein#begin('/home/riel/.cache/dein')

	" Let dein manage dein
	" Required:
	call dein#add('/home/riel/.cache/dein/repos/github.com/Shougo/dein.vim')

	" Add or remove your plugins here:
	call dein#add('Shougo/neocomplete')
	call dein#add('justmao945/vim-clang')
	call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
	call dein#add('Shougo/neosnippet')
	call dein#add('Shougo/neosnippet-snippets')
	call dein#add('osyo-manga/vim-stargate')
	call dein#add('vim-jp/vim-cpp')
	call dein#add('thinca/vim-quickrun')  " You can specify revision/branch/tag.
	call dein#add('itchyny/vim-haskell-indent')
	call dein#add('itchyny/lightline.vim')
	call dein#add('kana/vim-textobj-user')
	call dein#add('kana/vim-textobj-entire')
	" Required:

	call dein#end()
	call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

:set noautoindent
:set shiftwidth=2
:set relativenumber
:set number
:imap <C-j> <esc>
:noremap! <C-j> <esc>
:set clipboard =unnamedplus
:colorscheme elflord
:let g:neocomplete#enable_at_startup = 1
"neocompleteの推奨設定
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"
" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clang
let g:clang_auto = 0
" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

function! s:get_latest_clang(search_path)
    let l:filelist = split(globpath(a:search_path, 'clang-*'), '\n')
    let l:clang_exec_list = []
    for l:file in l:filelist
        if l:file =~ '^.*clang-\d\.\d$'
            call add(l:clang_exec_list, l:file)
        endif
    endfor
    if len(l:clang_exec_list)
        return reverse(l:clang_exec_list)[0]
    else
        return 'clang'
    endif
endfunction

function! s:get_latest_clang_format(search_path)
    let l:filelist = split(globpath(a:search_path, 'clang-format-*'), '\n')
    let l:clang_exec_list = []
    for l:file in l:filelist
        if l:file =~ '^.*clang-format-\d\.\d$'
            call add(l:clang_exec_list, l:file)
        endif
    endfor
    if len(l:clang_exec_list)
        return reverse(l:clang_exec_list)[0]
    else
        return 'clang-format'
    endif
endfunction

let g:clang_exec = s:get_latest_clang('/usr/bin')
let g:clang_format_exec = s:get_latest_clang_format('/usr/bin')

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'


" }}}
"
"neosnippet setting

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"set snippet file dir
let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/snippets/,~/.vim/snippets'

"neosnippet end

"vim-stargate
" Setting include paths.
let g:stargate#include_paths = {
\   "cpp" : [
\       "C:/MinGW/lib/gcc/mingw32/4.6.2/include/c++",
\       "C:/cpp/boost"
\   ]
\}

"vim-stargate ここまで
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ }

