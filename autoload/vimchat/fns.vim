" autoload only once {{{
if exists('g:autoloaded_vimchat_fns')
  finish
endif
let g:autoloaded_vimchat_fns = 1
" save starttime, so that offsets are calculated accordingly
let s:startTime = reltime()[0]
"}}}

" script local definitions {{{
let s:offsetMap = {}
let s:spaces =  '                   '
let s:separator = [
      \ '',
      \ '----------------------------------------------------------',
      \ '']

let s:states = {
      \ 'on': g:vimchat_on_cmd,
      \ 'xa': g:vimchat_xa_cmd,
      \ 'away': g:vimchat_away_cmd,
      \ 'dnd': g:vimchat_dnd_cmd
      \ }
let s:link_pattern = '^\(http[s]\?:\/\/\)\?[a-zA-Z0-9-_\.%]\+[a-z]\{2,10}\([?#\/%][^\s]*\)\?$'
"}}}

func! s:Capitalize(str) "{{{
  if !len(a:str)
    let ret = ''
  else
    let ret = toupper(strpart(a:str, 0, 1))
          \   . strpart(a:str, 1)
  endif
  return ret
endfunc "}}}

func! s:DefineStateCommands() "{{{
  for [state, command] in items(s:states)
    exe 'command! -nargs=0 -buffer '.s:Capitalize(command).' :silent py VimChat.setStatus("'.state.'")'
  endfor
endfunc "}}}

func! s:GetVimchatPath() "{{{
  return fnamemodify(g:vimchat_logpath, 'p').'/'.b:account
endfunc "}}}

func! s:GetChatPartner() "{{{
  "let fileName = expand("%")
  "" remove prefix chat:
  "return strpart(fileName, 5)
  return b:buddyId
endfunc "}}}

func! s:GetDate(offset) "{{{
  let secsPerDay = 86400
  let dateFormat = '%F'
  return strftime(dateFormat, s:startTime - a:offset*secsPerDay)
endfunc "}}}

func! vimchat#fns#ConvertIsoDate(date, format) "{{{
" iso date format is YYYY-mm-dd
" log files on disk are all saved iso compliant
" thus we don't need any further checking here

py << EOF
import datetime

date_as_string = vim.eval('a:date')
year = int(date_as_string[:4])
month = int(date_as_string[5:7])
day = int(date_as_string[-2:])
format = vim.eval('a:format')

vim.command('let ret =  '+repr(datetime.date(year, month, day).strftime(format)))
EOF
  return ret
endfunc "}}}

func! s:GetProtocolDir() "{{{
  let chatPartner = s:GetChatPartner()
  let path = s:GetVimchatPath()
  return join([path, chatPartner], '/')
endfunc "}}}

func! s:GetProtocolPath(offset) "{{{
  let date = s:GetDate(a:offset)
  let path = s:GetVimchatPath()
  return join([s:GetProtocolDir(), chatPartner], '/').'-'.date
endfunc "}}}

func! s:GetLinePattern(enclosers, timePattern) abort "{{{
  let pattern = '^\('.a:enclosers[0].'\)\('.a:timePattern.'\)\('.a:enclosers[1].'\)'
  return pattern
endfunc "}}}

func! s:GetReplacement(date) abort "{{{
  let subst = '\1'.a:date.' '.'\2\3'
  return subst
endfunc "}}}

func! s:ProcessLine(line, date) "{{{
  if a:date != s:GetDate(0)
    let dateFormat = vimchat#parseFormatters#RemoveEnclosers(get(g:, 'vimchat_dateformat', '%F'))
    let date = vimchat#fns#ConvertIsoDate(a:date, dateFormat)
    let timePattern = vimchat#parseFormatters#GetDatelikeRegex(g:vimchat_timestampformat)
    let enclosers = vimchat#parseFormatters#GetEnclosers(g:vimchat_timestampformat)
    let subst = join(enclosers, timePattern)
    let pattern = s:GetLinePattern(enclosers, timePattern)
    let subst = s:GetReplacement(date)
    let line = substitute(a:line, pattern, subst, '')
  else
    let line = a:line
  endif
  return substitute(line, '^\t', s:spaces, '')
endfunc "}}}

func! s:PrependProtocol(path, date) "{{{
  if filereadable(a:path)
    let cursor = getpos('.')
    let file = readfile(a:path)
    let separator = a:date != s:GetDate(0)
          \         ? s:separator
          \         : []

    let numNewLines = len(file) + len(separator)
    for line in reverse(copy(separator))
      0put = line
    endfor
    for line in reverse(copy(file))
      0put = s:ProcessLine(line, a:date)
    endfor
    let newCursor = copy(cursor)
    let newCursor[1] += numNewLines
    call setpos('.', newCursor)
  else
    echoerr 'no log found for '.a:date
  endif
endfunc "}}}

func! s:PrependProtocolByDate(...) "{{{
  let offset = a:0 ? a:1 : 1
  let path = s:GetProtocolPath(offset)
  let date = s:GetDate(offset)
  call s:PrependProtocolByDate(path, date)
endfunc "}}}

func! s:GetFilenameTail(filename) "{{{
  return fnamemodify(a:filename, ':t')
endfunc "}}}

func! s:GetLogFiles(dir) "{{{
  return split(globpath(a:dir, '*'))
endfunc "}}}

func! s:GetDateFromFilename(filename) "{{{
  return join(split(a:filename, '-')[1:], '-')
endfunc "}}}

func! s:PrependProtocolFromList(...) "{{{
  if exists('b:buddyId')
    let offset = a:0 ? a:1 : 1
    let path = s:GetProtocolDir()
    let files = s:GetLogFiles(path)
    if offset <= len(files)
      let file = files[-offset]
      let fileTail = s:GetFilenameTail(file)
      let date = s:GetDateFromFilename(fileTail)
      call s:PrependProtocol(file, date)
    endif
  endif
endfunc "}}}

func! s:HasReachedTheTop() "{{{
  let curLine = line('.')
  let winLine = winline()
  let ret = winLine != curLine
  if !ret
    let ret = curLine <= winheight('.')
  endif
  return ret
endfunc "}}}

func! s:GetNextOffset() "{{{
  let chatPartner = s:GetChatPartner()
  if has_key(s:offsetMap, chatPartner)
    let offset = s:offsetMap[chatPartner] + 1
  else
    let offset = 1
  endif
  let s:offsetMap[chatPartner] = offset
  return offset
endfunc "}}}

func! s:ScrollUp() "{{{
  if s:HasReachedTheTop()
    call s:PrependProtocolFromList(s:GetNextOffset())
  endif
  exe 'normal! '
endfunc "}}}

func! s:MoveUp(...) "{{{
  let command = a:0 ? a:1 : ''
  if line('.') == 1
    call s:PrependProtocolFromList(s:GetNextOffset())
  endif
  exe 'normal! '.command
endfunc "}}}

func! vimchat#fns#SetupLocalMapsAndCommands() "{{{
  command!
        \ -nargs=?
        \ -buffer
        \ Logs
        \ :call <sid>PrependProtocolFromList(<f-args>)

  command!
        \ -nargs=?
        \ -buffer
        \ LogsByDate
        \ :call <sid>PrependProtocolByDate(<f-args>)

  call s:DefineStateCommands()

  if !get(g:, 'vimchat_scrolling', 1) | return | endif

  exe 'nnoremap <silent> <buffer> '.g:vimchat_scrollup.' :call '.'<sid>ScrollUp()<CR>'
  exe 'nnoremap <silent> <buffer> '.g:vimchat_scrollhalfwayup.' :call <sid>MoveUp()<CR>'
  exe 'nnoremap <silent> <buffer> '.g:vimchat_moveup.' :call <sid>MoveUp("k")<CR>'
  exe 'nnoremap <silent> <buffer> '.g:vimchat_openlink.' :call <SID>OpenLink(expand("<cWORD>"))<CR>'

endfunc "}}}

func! s:IsLink(text) "{{{
  return match(a:text, s:link_pattern) > -1
endfunc "}}}

func! s:OpenLink(text) "{{{
  if !exists('g:vimchat_browser_cmd')
    echoerr 'no browser command defined. please set variable g:vimchat_browser_cmd appropriately'
    return
  else
    if !s:IsLink(a:text)
      echoerr 'text under cursor is not a valid uri'
    else
      let cmd = join(
            \ ['silent',
            \  '!',
            \  shellescape(g:vimchat_browser_cmd),
            \  shellescape(expand("<cWORD>")),
            \  get(g:, 'vimchat_browser_in_bg') ? '&' : ''],
            \ ' ')
      sil exe cmd
    endif
  endif
endfunc "}}}

" vimchat global commands {{{
com! VimChatStop py VimChat.stop()
com! VimChatBuddyList py VimChat.toggleBuddyList()
com! VimChatViewLog py VimChat.openLogFromChat()
com! VimChatJoinGroupChat py VimChat.openGroupChat()
com! VimChatOtrVerifyBuddy py VimChat.otrVerifyBuddy()
com! VimChatOtrSMPRespond py VimChat.otrSmpRespond()
com! VimChatOtrGenerateKey py VimChat.otrGenerateKey()
com! -nargs=0 VimChatSetStatus py VimChat.setStatus(<args>)
com! VimChatShowStatus py VimChat.showStatus()
com! VimChatJoinChatroom py VimChat.joinChatroom()
" }}}
