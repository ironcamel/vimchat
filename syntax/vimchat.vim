let s:emoticons = readfile(expand('<sfile>:p:h:h') . '/resources/emoticons')
let s:bashCmds = readfile(expand('<sfile>:p:h:h') . '/resources/bash-cmds')

func! s:EscapeRegexTokens(text)  "{{{
  return substitute(a:text, '[/\\*$^.*~\]\[&]', '\\&', 'g')
endfunc "}}}

func! s:EscapeRegex(li) "{{{
  return map(a:li, 's:EscapeRegexTokens(v:val)')
endfunc "}}}

func! s:AllHeads(li) "{{{
  return map(a:li, 'split(v:val, "\\s\\+")[0]')
endfunc "}}}

func! s:Or(li) "{{{
  return '\('.join(a:li, '\|').'\)'
endfunc "}}}

" basic vimchat settings {{{
syn match vimChatMsg 	/^\[[-0-9: ]*\].\{-}:/	contains=vimChatDateTime,vimChatMe
syn match vimChatDateTime  	/\[[-0-9: ]*\]/   contained contains=vimChatDate,vimChatTime nextgroup=vimChatMe
syn match vimChatDate  	/\(\d\d\d\d-\d\d-\d\d \)\?/			contained nextgroup=vimChatTime
syn match vimChatTime  	/[\[ ]\@=\d\d\(:\d\d\)\{0,2\}/			contained
syn match vimChatMe  	/Me:/		 			contained

hi link vimChatMsg		Comment
hi link vimChatDateTime		String
hi link vimChatDate		NonText
hi link vimChatTime		Comment
hi link vimChatMe		Type
"}}}

" shell commands {{{
exe 'syn match vimChatShellCmd /[ (]\@<='.s:Or(s:bashCmds).'\>/'
hi link vimChatShellCmd Function
"}}}

" emphasis {{{
syn match vimChatEmphasis '\*[^*]*\*' contains=vimChatAsterisk
syn match vimChatAsterisk '\*' contained conceal
hi link vimChatEmphasis ErrorMsg
""}}}

" strings {{{
syn match vimChatString1 "'[^']*'" contains=vimChatApostrophe1
syn match vimChatApostrophe1 "'" contained conceal
hi link vimChatString1 Identifier

syn match vimChatString2 '"[^"]*"' contains=vimChatApostrophe2
syn match vimChatApostrophe2 '"' contained conceal
hi link vimChatString2 Identifier
""}}}


" emoticons {{{
exe 'syn match vimChatEmoticon /'.s:Or(s:EscapeRegex(s:emoticons)).'/'
hi link vimChatEmoticon Title
"}}}

" addressess {{{
syn match vimChatAddress /[^a-zA-Z0-9_-]\@<=@[a-zA-Z0-9_-]*\>/
hi link vimChatAddress SpecialKey
"}}}

" links {{{
syn match vimChatLink /\s\@<=\(http[s]\?:\/\/\)\?[a-zA-Z0-9-_\.%]\+\.[a-z]\{2,10}\([?#\/%][^\t ]*\)\?\($\|\s\@=\)/
hi link vimChatLink		Underlined
"}}}

" paths {{{
syn match vimChatPath /[^a-zA-Z0-9_\/-]\@<=\/[a-zA-Z0-9_@:-][*a-zA-Z0-9_@:\/-]*/
hi link vimChatPath Directory
"}}}

" mail and similar {{{
syn match vimChatMail /\<[a-zA-Z0-9_.-]\+@[a-zA-Z0-9_.-]\+\(:[^ \t]*\)\?/
hi link vimChatMail LineNr
"}}}
