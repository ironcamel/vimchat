" VImChat Plugin for vim
" This plugin allows you to connect to jabber servers and chat with
" multiple people.
"
" It does not currently support other IM networks or group chat,
" but these are on the list to be added.
"
" It is also worth noting that you can use aim/yahoo via jabber transports,
" but the transports must be set up on another client as vimchat does not
" support setting them up yet
"
" This branchh supports multiple versions at a time, but probably still
" has a decent amount of bugs!
"
" Note: The vimchat_jid and vimchat_password variables have been *changed*
" into the vimchat_accounts dictionary.  This version of vimchat will not
" work unless you make this change!
"
" Supported ~/.vimrc Variables: {{{
"   g:vimchat_accounts = {'jabber id':'password',...}
"   g:vimchat_buddylistwidth = width of buddy list
"   g:vimchat_libnotify = (0 or 1) default is 1
"   g:vimchat_logpath = path to store log files
"   g:vimchat_logchats = (0 or 1) default is 1
"   g:vimchat_otr = (0 or 1) default is 0
"   g:vimchat_logotr = (0 or 1) default is 1
"   g:vimchat_statusicon = (0 or 1) default is 1
"   g:vimchat_blinktimeout = timeout in seconds default is -1
"   g:vimchat_buddylistmaxwidth = max width of buddy list window default ''
"   g:vimchat_timestampformat = format of the msg timestamp default "[%H:%M]"
"   g:vimchat_dateformat = format of the msg date for logs default "[%Y-%m-%d]"
"   g:vimchat_showPresenceNotification = notify if buddy changed status default ""
"   g:vimchat_loadLogs = load log file when scrolling/moving beyond line 0
"                         (0 or 1) default is 1
"   g:vimchat_pageup = custom map(s) for page up (array of strings)
"                      default []
"   g:vimchat_halfpageup = custom map(s) for half page up (array
"                          or strings) default []
"   g:vimchat_moveup = custom additional map(s) for move line up (String or
"                      array of strings) default []
"   g:vimchat_moveleft = custom additional map(s) for move char left up (String
"                        or array of strings) default []
"   g:vimchat_openlink = map for 'open link in browser' default is '<C-]>'
"   g:vimchat_browser_in_bg = (0 or 1) default is 1
"   g:vimchat_extendedHighlighting = switch extended highlighting globally on
"                                     or off
"                                     (0 or 1) default 0
"   g:vimchat_highlightEmoticons = (0 or 1) default 1
"   g:vimchat_highlightShellcmds = (0 or 1) default 1
"   g:vimchat_highlightEmphasis = (0 or 1) default 1
"   g:vimchat_highlightStrings = (0 or 1) default 1
"   g:vimchat_highlightAddresses = (0 or 1) default 1
"   g:vimchat_highlightLinks = (0 or 1) default 1
"   g:vimchat_highlightPaths = (0 or 1) default 1
"   g:vimchat_highlightMail = (0 or 1) default 1
"   g:vimchat_hiLinkMsg = (string) default 'Comment'
"   g:vimchat_hiLinkDateTime = (string) default 'String'
"   g:vimchat_hiLinkDate = (string) default 'NonText'
"   g:vimchat_hiLinkTime = (string) default 'Comment'
"   g:vimchat_hiLinkMe = (string) default 'Type'
"   g:vimchat_hiLinkShellCmd = (string) default 'Function'
"   g:vimchat_hiLinkEmphasis = (string) default 'ErrorMsg'
"   g:vimchat_hiLinkString1 = (string) default 'Identifier'
"   g:vimchat_hiLinkString2 = (string) default 'Identifier'
"   g:vimchat_hiLinkEmoticon = (string) default 'Title'
"   g:vimchat_hiLinkAddress = (string) default 'SpecialKey'
"   g:vimchat_hiLinkLink = (string) default 'Underlined'
"   g:vimchat_hiLinkPath = (string) default 'Directory'
"   g:vimchat_hiLinkMail = (string) default 'LineNr'
"}}}

" load only once {{{
if exists('g:loaded_vimchat')
  finish
endif
let g:loaded_vimchat = 1
"}}}

" VimChat command {{{
com!
      \ -nargs=*
      \ VimChat
      \ call vimchat#main#main(<f-args>)
"}}}

augroup vimchat_setup_scroll_maps "{{{
  autocmd!
  autocmd FileType vimchat call vimchat#fns#SetupLocalMapsAndCommands()
  autocmd FileType vimchat setlocal conceallevel=2
augroup END "}}}
