" extended ascii letters between 0 and 255 "{{{
" only alphabetical characters, no digits or other tokens
" one could increase range if needed
let s:allChars = '\\Z[\\d65-\\d90\\d97-\\d122\\d184-\\d246\\d248-\\d255]'
" specifiers for locale dependent formatters are only educated guesses {{{
let s:dateRegExes = {
      \ 'a': s:allChars.'\\{3}',
      \ 'A': s:allChars.'*',
      \ 'b': s:allChars.'\\{3}',
      \ 'B': s:allChars.'*',
      \ 'c': '[^\\[]',
      \ 'C': '\\d\\d',
      \ 'd': '\\d\\d',
      \ 'D': '\\d\\d\\/\\d\\d\\/\\d\\{4}',
      \ 'e': '[0-9 ]\\{2}\\/[0-9 ]\\{2}\\/\\d\\{4}',
      \ 'F': '\\d\\{4}-\\d\\d-\\d\\d',
      \ 'g': '\\d\\{2}',
      \ 'G': '\\d\\{4}',
      \ 'h': '\\a\\a\\a',
      \ 'H': '\\d\\d',
      \ 'I': '\\d\\d',
      \ 'j': '\\d\\d\\d',
      \ 'k': '\\d\\d',
      \ 'l': '[ 0-9]\\{2}',
      \ 'm': '\\d\\d',
      \ 'M': '\\d\\d',
      \ 'n': '\\n',
      \ 'N': '\\d\\{9}',
      \ 'p': s:allChars.'*',
      \ 'P': s:allChars.'*',
      \ 'r': '\\d\\d.\\d\\d\\(.\\d\\d\\)\\? '.s:allChars.'*',
      \ 'R': '\\d\\d:\\d\\d',
      \ 's': '\\d*',
      \ 'S': '\\d\\d',
      \ 't': '\\t',
      \ 'T': '\\d\\d:\\d\\d:\\d\\d',
      \ 'u': '\\d',
      \ 'U': '\\d\\d',
      \ 'V': '\\d\\d',
      \ 'w': '\\d',
      \ 'W': '\\d\\d',
      \ 'x': '[^ \\t]*',
      \ 'X': '[^ \\t]*',
      \ 'y': '\\d\\d',
      \ 'Y': '\\d\\{4}',
      \ 'z': '.\\?\\d\\{4}',
      \ 'Z': '\\a*'
      \ } "}}}
"}}}

func! vimchat#parseFormatters#GetEnclosers(formatString) abort "{{{
  let enclosers = ['', '']
  for pair in [['\[', '\]'], ['(', ')'], ['{', '}']]
    if match(a:formatString, '^'.pair[0].'.*'.pair[1].'$') > -1
      let enclosers = pair
      break
    endif
  endfor
  return enclosers
endfunc "}}}

func! s:GetDateTimeRegex(dateFormat, timeFormat) abort "{{{
  let enclosers = vimchat#parseFormatters#GetEnclosers(a:timeFormat)
  let dateRegex = vimchat#parseFormatters#GetDatelikeRegex(a:dateFormat)
  let timeRegex = vimchat#parseFormatters#GetDatelikeRegex(a:timeFormat)
  let pattern = join(enclosers,
        \            join(['\('.dateRegex.' *\)\?', timeRegex],
        \                 ' '))
  return pattern
endfunc "}}}

func! vimchat#parseFormatters#GetDatelikeRegex(formatString) abort "{{{
  let formatter = vimchat#parseFormatters#EscapeRegexTokens(vimchat#parseFormatters#RemoveEnclosers(a:formatString))
  for [k, v] in items(s:dateRegExes)
    let formatter = substitute(formatter, '%'.k, v, 'g')
  endfor
  return formatter
endfunc "}}}

func! vimchat#parseFormatters#RemoveEnclosers(string, ...) abort "{{{
  let pattern = '^[({\[]'.'\|'.'[)}\]]$'
  return substitute(a:string, pattern, '', 'g')
endfunc "}}}

func! vimchat#parseFormatters#getPatterns() abort "{{{
  let dateTimePattern = s:GetDateTimeRegex(g:vimchat_dateformat, g:vimchat_timestampformat)
  let datePattern = vimchat#parseFormatters#GetDatelikeRegex(g:vimchat_dateformat)
  let timePattern = vimchat#parseFormatters#GetDatelikeRegex(g:vimchat_timestampformat)
  return [dateTimePattern, datePattern, timePattern]
endfunc "}}}

func! vimchat#parseFormatters#EscapeRegexTokens(string) abort "{{{
  return substitute(a:string, '[/\\*$^.*~\]\[&]', '\\&', 'g')
endfunc "}}}
