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

if !g:vimchat_extended_highlighting | finish | endif

" shell commands {{{
if g:vimchat_highlight_shellcmds
  exe 'syn match vimChatShellCmd /[ (]\@<='.s:Or(s:bashCmds).'\>/'
  hi link vimChatShellCmd Function
endif
"}}}

" emphasis {{{
if g:vimchat_highlight_emphasis
  syn match vimChatEmphasis '\*[^*]*\*' contains=vimChatAsterisk
  syn match vimChatAsterisk '\*' contained conceal
  hi link vimChatEmphasis ErrorMsg
endif
""}}}

" strings {{{
if g:vimchat_highlight_strings
  syn match vimChatString1 "'[^']*'" contains=vimChatApostrophe1
  syn match vimChatApostrophe1 "'" contained conceal
  hi link vimChatString1 Identifier

  syn match vimChatString2 '"[^"]*"' contains=vimChatApostrophe2
  syn match vimChatApostrophe2 '"' contained conceal
  hi link vimChatString2 Identifier
endif
""}}}

" emoticons {{{
if g:vimchat_highlight_emoticons
  exe 'syn match vimChatEmoticon /'.s:Or(s:EscapeRegex(s:emoticons)).'/'
  hi link vimChatEmoticon Title
endif
"}}}

" addressess {{{
if g:vimchat_highlight_addresses
  syn match vimChatAddress /[^a-zA-Z0-9_-]\@<=@[a-zA-Z0-9_-]*\>/
  hi link vimChatAddress SpecialKey
endif
"}}}

" links {{{
if g:vimchat_highlight_links
  syn match vimChatLink /\s\@<=\(http[s]\?:\/\/\)\?[a-zA-Z0-9-_\.%]\+\.[a-z]\{2,10}\([?#\/%][^\t ]*\)\?\($\|\s\@=\)/
  hi link vimChatLink		Underlined
endif
"}}}

" paths {{{
if g:vimchat_highlight_paths
  syn match vimChatPath /[^a-zA-Z0-9_\/-]\@<=\/[a-zA-Z0-9_@:-][*a-zA-Z0-9_@:\/-]*/
  hi link vimChatPath Directory
endif
"}}}

" mail and similar {{{
if g:vimchat_highlight_mail
  syn match vimChatMail /\<[a-zA-Z0-9_.-]\+@[a-zA-Z0-9_.-]\+\(:[^ \t]*\)\?/
  hi link vimChatMail LineNr
endif
"}}}
