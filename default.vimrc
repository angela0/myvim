"Vundle Plugin
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'The-NERD-tree'
Plugin 'taglist.vim'
Plugin 'Auto-Pairs'
Plugin 'L9'
Plugin 'https://github.com/wincent/command-t.git'
Plugin 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plugin 'tagbar'
Plugin 'https://github.com/scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-commentary'

"Plugin 'ultisnips'

call vundle#end()
filetype plugin indent on


"General Setting

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2	    	" allow backspacing over everything in insert mode
set history=1000	" keep 50 lines of command line history
set ruler		    " show the cursor position all the time
set autoread		" auto read when file is changed from outside
set hlsearch		" search highlighting
set wildmenu        "命令行模式智能补全
set wildmode=longest:full

filetype off          " necessary to make ftdetect work on Linux
syntax enable
syntax on
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins


" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc


if has("gui_running")	" GUI color and font settings
    set guifont=Osaka-Mono:h20
    set background=dark 
    set t_Co=256          " 256 color mode
    set cursorline        " highlight current line
    colors molokai
    highlight CursorLine          guibg=#003853 ctermbg=24
    gui=none cterm=none
else
    " terminal color settings
    colors molokai
endif


" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set smartindent
set autoindent		" auto indentation
set incsearch		" incremental search
set ignorecase      " ignorecase search
set nobackup		" no *~ backup files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context
set nu
set ruler           "显示标尺
set cul             "高亮光标所在行
set shortmess=atI
set showcmd         "显示输入的命令
set scrolloff=3     "光标距离buffer顶部或底部3行

if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

set cmdheight=1     "命令行行高

set viminfo+=!      " 保存全局变量
set iskeyword+=_,$,@,%,#,-  " 带有如下符号的单词不要被换行分割


" Editing related
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,]
set mouse=a
set selectmode=
set mousemodel=popup
set keymodel=
set selection=inclusive

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" TAB setting{
set expandtab        "replace <TAB> with spaces
set softtabstop=4 
set tabstop=4
set shiftwidth=4 
set smarttab

au FileType Makefile set noexpandtab
"} 

"Line setting
"set nowrap  "禁止折行
set tw=130  "超过80字符折行
set lbr     "不再单词中间折行
set fo+=mB  "断行模块对亚洲语言的支持


" status line {
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ 
set statusline+=[POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}


" C/C++ specific settings
autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^0,:0,bs,g0,h1s,p2,t0,+2,(2,)20,*30

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

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

"去空行  
nnoremap <F4> :g/^\s*$/d<CR> 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func! SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "	> File Name: ".expand("%")) 
        call append(line(".")+1, "	> Author: Angela") 
        call append(line(".")+2, "	> Mail: zuchuang1@gmail.com") 
        call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
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
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
endfunc 

"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G


"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python2.7 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    elseif &filetype == 'javascript'
        exec "!time node %"
    endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc



"代码格式优化化

map <F6> :call FormartSrc()<CR><CR>

"定义FormartSrc()
func! FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc


"""""""实用设置

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

let mapleader=';'



"NERD-tree Plugin
"
let NERDTreeWinSize=20

"vim-indent-guides Plugin
" 随 vim 自启动
let g:indent_guides_enable_on_vim_startup=1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level=2
" 色块宽度
let g:indent_guides_guide_size=1
" 快捷键 i 开/关缩进可视化
:nmap <silent> <Leader>i <Plug>IndentGuidesToggle"


"tagbar Plugin
autocmd vimenter * Tagbar
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


"ultisnips Plugin
let g:UltiSnipsSnippetDirectories=["~/.vim/bundle/ultisnips/mysnippets"] 

"YCM Plugin
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<F2>'
"map <F3> :YcmCompleter GoToDeclaration <CR>
map <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>
set completeopt-=preview

"列出当前目录文件  
map <F9> :NERDTreeToggle<CR>
imap <F9> <ESC> :NERDTreeToggle<CR>
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif




