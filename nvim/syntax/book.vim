" Vim syntax file
" Language: book manuscript (markdown-ish)

if exists("b:current_syntax")
  finish
endif

syn spell toplevel

syn region bookItalic matchgroup=bookItalicMark start=/\*/ end=/\*/ oneline contains=@Spell
syn region bookQuote matchgroup=bookQuoteMark start=/"/ end=/"/ oneline contains=bookItalic,@Spell
syn match  bookHeading /^#.*$/ contains=bookItalic,@Spell
syn region bookComment start=/</ end=/>/ keepend containedin=ALLBUT,bookComment
syn match  bookVar /\$[A-Za-z_][A-Za-z0-9_]*/ containedin=ALL

hi bookItalic gui=italic cterm=italic
hi link bookItalicMark Conceal
hi link bookQuoteMark Operator
hi link bookHeading Title
hi link bookComment String
hi link bookVar     Identifier

let b:current_syntax = "book"
