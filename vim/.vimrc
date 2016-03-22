if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,gb18030
endif


let &titlestring = expand("%:p")
if &term == "screen"
    set t_ts=^[k
    set t_fs=^[\
endif
if &term == "screen" || &term == "xterm"
    set title
endif

set nocompatible	" Use Vim defaults (much better!)
set nu!
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set smartindent
set backspace=2
set guioptions-=r
set whichwrap+=<,>,h,l
set completeopt=menu
"折叠
set fdm=indent	
"文本 背景
highlight Folded ctermfg=2 ctermbg=8	
"set fillchars=vert:\ |
highlight VertSplit cterm=NONE 
"taglist
"let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的。
"let Tlist_Exit_OnlyWindow = 1 "如果 taglist 窗口是最后一个窗口，则退出 vim。
"let Tlist_Use_Right_Window = 1 "在右侧窗口中显示 taglist 窗口。
"let Tlist_Auto_Open=1 "在启动 vim 后，自动打开 taglist 窗口。
"let Tlist_File_Fold_Auto_Close=1 "taglist 只显示当前文件 tag，其它文件的tag折叠。
"let Tlist_WinHeight
"let Tlist_WinWidth= "可以设置taglist窗口的高度和宽度。
"let Tlist_Use_Horiz_Window=1 "设置taglist窗口横向显示。
"点击鼠标
set mouse=a 

set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

filetype plugin on 
autocmd FileType python set omnifunc=pythoncomplete#Complete

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
set nobackup
