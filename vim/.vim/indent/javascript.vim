" Vim indent file
" Language:	Javascript
" Maintainer:	None!  Wanna improve this?
" Last Change:	2007 Jan 22

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

" C indenting is not too bad.
" setlocal cindent
setlocal tabstop=2
setlocal expandtab
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smartindent
setlocal backspace=2

let b:undo_indent = "setl cin<"
