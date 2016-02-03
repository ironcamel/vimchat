" regex related s: variables {{{
let s:emoticons = readfile(expand('<sfile>:p:h:h') . '/resources/emoticons')
let s:bashCmds = readfile(expand('<sfile>:p:h:h') . '/resources/bash-cmds')
"}}}

func! s:EscapeRegex(li) abort "{{{
  return map(a:li, 'vimchat#parseFormatters#EscapeRegexTokens(v:val)')
endfunc "}}}

func! s:Or(li) abort "{{{
  return '\('.join(a:li, '\|').'\)'
endfunc "}}}

" basic vimchat settings {{{
let [dateTimePattern, datePattern, timePattern] = vimchat#parseFormatters#getPatterns()

exe 'syn match vimChatMsg 	/^'.dateTimePattern.'.\{-}:/	contains=vimChatDateTime,vimChatMe'
exe 'syn match vimChatDateTime  	/'.dateTimePattern.'/   contained contains=vimChatDate,vimChatTime nextgroup=vimChatMe'
exe 'syn match vimChatDate  	/'.datePattern.'/			containedin=vimChatDateTime nextgroup=vimChatTime'
exe 'syn match vimChatTime  	/'.timePattern.'/			containedin=vimChatDateTime'
syn match vimChatMe  	/Me:/		 			contained

exe 'hi link vimChatMsg '.g:vimchat_hiLinkMsg
exe 'hi link vimChatDateTime '.g:vimchat_hiLinkDateTime
exe 'hi link vimChatDate '.g:vimchat_hiLinkDate
exe 'hi link vimChatTime '.g:vimchat_hiLinkTime
exe 'hi link vimChatMe '.g:vimchat_hiLinkMe
"}}}

if !g:vimchat_extendedHighlighting | finish | endif

" shell commands {{{
if g:vimchat_highlightShellcmds
  exe 'syn match vimChatShellCmd /[ (]\@<='.s:Or(s:bashCmds).'\>/'
  exe 'hi link vimChatShellCmd '.g:vimchat_hiLinkShellCmd
endif
"}}}

" emphasis {{{
if g:vimchat_highlightEmphasis
  syn match vimChatEmphasis '\*[^*]*\*' contains=vimChatAsterisk
  syn match vimChatAsterisk '\*' contained conceal
  exe 'hi link vimChatEmphasis '.g:vimchat_hiLinkEmphasis
endif
""}}}

" strings {{{
if g:vimchat_highlightStrings
  syn match vimChatString1 "'[^']*'" contains=vimChatApostrophe1
  syn match vimChatApostrophe1 "'" contained conceal
  hi link vimChatString1 Identifier

  syn match vimChatString2 '"[^"]*"' contains=vimChatApostrophe2
  syn match vimChatApostrophe2 '"' contained conceal
  hi link vimChatString2 Identifier
endif
""}}}

" emoticons {{{
if g:vimchat_highlightEmoticons
  exe 'syn match vimChatEmoticon /'.s:Or(s:EscapeRegex(s:emoticons)).'/'
  exe 'hi link vimChatEmoticon '.g:vimchat_hiLinkEmoticon
endif
"}}}

" addressess {{{
if g:vimchat_highlightAddresses
  syn match vimChatAddress /[^a-zA-Z0-9_-]\@<=@[a-zA-Z0-9_-]*\>/
  exe 'hi link vimChatAddress '.g:vimchat_hiLinkAddress
endif
"}}}

" links {{{
if g:vimchat_highlightLinks
  syn match vimChatLink /\s\@<=\(http[s]\?:\/\/\)\?[a-zA-Z0-9-_\.%]\+\.[a-z]\{2,10}\([?#\/%][^\t ]*\)\?\($\|\s\@=\)/
  exe 'hi link vimChatLink '.g:vimchat_hiLinkLink
endif
"}}}

" paths {{{
if g:vimchat_highlightPaths
  syn match vimChatPath /[^a-zA-Z0-9_\/-]\@<=\/[a-zA-Z0-9_@:-][*a-zA-Z0-9_@:\/-]*/
  exe 'hi link vimChatPath '.g:vimchat_hiLinkPath
endif
"}}}

" mail and similar {{{
if g:vimchat_highlightMail
  syn match vimChatMail /\<[a-zA-Z0-9_.-]\+@[a-zA-Z0-9_.-]\+\(:[^ \t]*\)\?/
  exe 'hi link vimChatMail '.g:vimchat_hiLinkMail
endif
"}}}
