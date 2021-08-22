"""""" Plugin Setting {
""" Vundle Plugin {
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'The-NERD-tree'
Plugin 'Auto-Pairs'
Plugin 'L9'
Plugin 'Yggdroot/indentLine'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-commentary'   "comment
Plugin 'fatih/vim-go'
Plugin 'vim-airline/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'ianva/vim-youdao-translater'
Plugin 'tpope/vim-surround'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'klen/python-mode'

" Plugin 'wchargin/vim-latexsuite'
" Plugin 'mxw/vim-jsx'
call vundle#end()
""" Vundle Plugin End }

""" Other Plugin {
filetype plugin indent on
" enable built-in matchit plugin
runtime macros/matchit.vim
""" Other Plugin End }
"""""" Plugin Setting End }


"""""" General Setting {

let mapleader=' '
" set nocompatible    " not compatible with the old-fashion vi mode
set bs=2            " allow backspacing over everything in insert mode
set history=1000    " keep 50 lines of command line history
set autoread        " auto read when file is changed from outside
set hlsearch        " search highlighting
set wildmenu        "命令行模式智能补全
set wildmode=longest:full

" syntax enable
syntax on
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

let g:tex_flavor = "latex"

autocmd! bufwritepost .vimrc source %   " auto reload vimrc when editing it


if has("gui_running")       " GUI color and font settings
    set guifont=Osaka-Mono:h20
    set background=dark
    set t_Co=256            " 256 color mode
    set cursorline          " highlight current line
    colors molokai
    highlight CursorLine          guibg=#003853 ctermbg=24
    gui=none cterm=none
else
    colors phd
endif


" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set smartindent
set autoindent          " auto indentation
set incsearch           " incremental search
set ignorecase          " ignorecase search
set nobackup            " no *~ backup files
set copyindent          " copy the previous indentation on autoindenting
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab            " insert tabs on the start of a line according to context
set nu
"set ruler              "显示标尺
set cul                 "高亮光标所在行
set shortmess=atI
set showcmd             "显示输入的命令
set scrolloff=3         "光标距离buffer顶部或底部3行
set noswapfile

if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

set cmdheight=1     "命令行行高

set viminfo+=!      " 保存全局变量
set iskeyword+=_,$,@,%,#,-  " 带有如下符号的单词不要被换行分割


""" Editing Related {
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
" set mouse=a
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive
""" Editing Related End }

"disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


""" TAB Setting {
set expandtab        "replace <TAB> with spaces
set softtabstop=4
set tabstop=4
set shiftwidth=4
set smarttab
set conceallevel=3
set list lcs:tab:\¦\ 

autocmd FileType json let g:indentLine_setConceal=0

au FileType Makefile set noexpandtab
""" TAB Setting End }

""" Line Setting {
"set nowrap  "禁止折行
set tw=130  "超过130字符折行
set lbr     "不再单词中间折行
set fo+=mB  "断行模块对亚洲语言的支持
""" Line Setting End }


""" Status Line {
set laststatus=2
"status line's content controled by plugin vim-airline/vim-airline
""" Status Line End }

"""""" General Setting End }


" C/C++ specific settings
autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^0,:0,bs,g0,h1s,p2,t0,+2,(2,)20,*30

"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gb2312,gb18030,big5,latin1

fun! ViewUTF8()
    set encoding=utf-8
    set termencoding=big5
endfun

fun! UTF8()
    set encoding=utf-8
    set termencoding=big5
    set fileencoding=utf-8
    set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
    set encoding=big5
    set fileencoding=big5
endfun

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>
nnoremap <C-N> :set nohlsearch<CR>

cnoremap <C-p> <UP>
cnoremap <C-n> <Down>
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

"去行尾空白符
map <F7> :call DeleteTailSpace()<CR>
func! DeleteTailSpace()
    exec 'w'
    exec '%s/\v^(.{-})\s+$/\1/e'
    exec 'w'
    exec 'e! %'
endfun

" new generic makefile
au BufNewFile makefile,Makefile exec ":call Makefile()"
func! Makefile()
    " if filereadable("makefile") || filereadable("Makefile")
    "     echo "makefile exists"
    " else
        " vsp Makefile
    let content = ""
    let content .= "CC = gcc\nCXX = g++\n"
    let content .= "CFLAGS = -Wall -Wno-unused-result\n\n"
    let content .= "all: main\n\n"
    let content .= "%.o: %.c\n\t$(CC) -c -o $@ $< $(CFLAGS)\n"
    let content .= "%.o: %.cpp\n\t$(CXX) -c -o $@ $< $(CFLAGS)\n"
    call append(0, split(content, '\n'))
        " :w
    " endif

endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.py exec ":call SetTemplate()"
""定义函数SetTemplate
func! SetTemplate()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: Angela")
        call append(line(".")+2, "    > Mail: zuchuang1@gmail.com")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
        call append(line(".")+9, "int main(void)")
        call append(line(".")+10, "{")
        call append(line(".")+11, "")
        call append(line(".")+12, "    return 0;")
        call append(line(".")+13, "}")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+7, "#include <stdlib.h>")
        call append(line(".")+8, "")
        call append(line(".")+9, "int main(int argc, char *argv[])")
        call append(line(".")+10, "{")
        call append(line(".")+11, "")
        call append(line(".")+12, "    return 0;")
        call append(line(".")+13, "}")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
endfunc
command! LoadTemplate call SetTemplate()

"新建文件后，自动定位到文件末尾，之前光标依然在 0:0
autocmd BufNewFile * normal G


""""""" Custom Keybind {

" F2    YCM complete hint
" F3    YCM goto declaration
" F4
" F5    Compile and Run
" F6    Format
" F7    Delete Line-Tail space
" F8    Run GDB
" F9    Open or Close NerdTree Window
" F10   TagBar
" F11
" F12   pastetoggle

"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %< -std=gnu99"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!time go run *.go"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    elseif &filetype == 'javascript'
        exec "!time node %"
    endif
endfunc


"代码格式优化化

map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func! FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -p -H --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -p -H -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc


""" highlight all current world
map <silent> <F4> :call Match_cword()<CR>
func! Match_cword()
exe printf('match IncSearch /\V\<%s\>/', GetCurWord())
endfun
"""

inoremap <c-]> <esc>viwUea
inoremap <c-c><c-c> <esc>:q<cr>
noremap <c-c><c-c> <esc>:q<cr>

nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>] viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader>} viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>) viw<esc>a)<esc>hbi(<esc>lel

nnoremap <c-w> <c-w>w
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l


" nmap <silent> <C-m> :nohlsearch<CR>

inoremap <c-j> <esc>o

set clipboard+=unnamed  "共享剪贴板
set autowrite           "自动保存
set confirm             "处理未保存和只读文件时确认

set fillchars=vert:\ ,stl:\ ,stlnc:\    "分割窗口之间为空白
set showmatch           " 高亮显示匹配的括号
set matchtime=1         " 匹配括号高亮的时间（单位是十分之一秒）

set foldmethod=syntax   "按语法折叠代码 za zR zM"
set nofoldenable

"记忆退出时光标的位置
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

""" Man Page {
function! ManFun(...)
    let cmd = "man "
    if a:0 == 1
        let cmd .= a:1
    elseif a:0 == 2
        let cmd .= a:1 . " " . a:2
    else
        echo "Arg err"
        return
    endif

    let manpage = system(cmd)

    pclose
    sp __Manpage
    normal! gg
    setlocal buftype=nofile bufhidden=delete noswapfile nowrap previewwindow
    call append(0, split(manpage, '\n'))
    setlocal nomodifiable
    setlocal nomodified
    setlocal filetype=man
    normal! gg

endfunction

function! GetCurWord()
    return expand("<cword>")
endfunction

command! -nargs=* Man call ManFun(<f-args>)
nnoremap K <esc>:call ManFun(GetCurWord())<cr>
""" Man Page End }

""""""" Custom Keybind End }

"------ Plugin tagbar
autocmd vimenter * Tagbar
noremap <F10> :Tagbar<CR>
inoremap <F10> <esc>:Tagbar<CR>a
let g:tagbar_width=20
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }



"------ Plugin ultisnips
"绝对路径
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/bundle/ultisnips/mysnippets/"]
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


"------ Plugin YCM
let g:ycm_key_invoke_completion = '<F2>'
let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_auto_hover = ""
let g:ycm_enable_diagnostic_highlighting = 0
"map <F3> :YcmCompleter GoToDeclaration <CR>
" map <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <F3> :YcmCompleter GoTo<CR>
"let g:ycm_key_list_select_completion = ['','']
"let g:ycm_key_list_previous_completion = ['','']
set completeopt-=preview
let g:ycm_log_level = 'debug'
let g:ycm_max_diagnostics_to_display = 0



"------ Plugin NERDTree
let NERDTreeWinSize=20

"列出当前目录文件
map <F9> :NERDTreeToggle<CR>
imap <F9> <ESC> :NERDTreeToggle<CR>

"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" autocmd bufenter * if (winnr("$") == 1) | q | endif

set pastetoggle=<F12>



"------ Plugin vim-go settings
let g:go_fmt_command = "goimports"
let g:go_template_autocreate = 0
let g:go_code_completion_enabled = 0
let g:go_metalinter_autosave = 0
let g:go_fmt_autosave = 1
let g:go_code_completion_enabled = 0
let g:go_echo_go_info = 0



"------ Plugin youdao-translate
vnoremap <silent> <C-y> :<C-u>Ydv<CR>
nnoremap <silent> <C-y> :<C-u>Ydc<CR>
noremap <leader>yd :<C-u>Yde<CR>


"------ Plugin python-mode
let g:pymode_python = 'python3'
let g:pymode_rope = 0

let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_write = 1
let g:pymode_lint_cwindow = 0
let g:pymode_options_max_line_length = 120

let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_modules = ['os', 'shutil', 'datetime', 'time']

let g:pymode_virtualenv = 1

let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

let g:pymode_folding = 0
