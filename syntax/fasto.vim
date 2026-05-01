" Vim syntax file
" Language: FASTO

if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword fastoKeyword fun let in if then else fn read write
syn keyword fastoType int bool char
syn keyword fastoBoolean true false
syn keyword fastoBuiltin iota length replicate map filter reduce scan ord chr not

syn match fastoNumber "\v<\d+>"
syn match fastoOperator "=="
syn match fastoOperator "&&"
syn match fastoOperator "||"
syn match fastoOperator "=>"
syn match fastoOperator "<-"
syn match fastoOperator "[+*/<~=|-]"
syn match fastoDelimiter "\v[{}()[\],;|]"

syn region fastoString start=+"+ skip=+\\\\\|\\"+ end=+"+
syn region fastoChar start=+'+ skip=+\\\\\|\\'+ end=+'+
syn match fastoComment "//.*$"

hi def link fastoKeyword Keyword
hi def link fastoType Type
hi def link fastoBoolean Boolean
hi def link fastoBuiltin Function
hi def link fastoNumber Number
hi def link fastoOperator Operator
hi def link fastoDelimiter Delimiter
hi def link fastoString String
hi def link fastoChar Character
hi def link fastoComment Comment

let b:current_syntax = "fasto"
