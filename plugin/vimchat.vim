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
" Supported ~/.vimrc Variables:
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
"   g:vimchat_showPresenceNotification = notify if buddy changed status default ""
"   g:vimchat_scrollup = map for 'scroll one screen up' default is '<C-b>'
"   g:vimchat_scrollhalfwayup = map for 'scroll half screen up' default is <C-u>'
"   g:vimchat_moveup = map for 'move one line up' default is 'k'
"   g:vimchat_no_scrolling_maps = (0 or 1) default is 0
"   g:vimchat_openlink = map for 'open link in browser' default is '<C-]>'
"   g:vimchat_browser_in_bg = (0 or 1) default is 1
"   g:vimchat_extended_highlighting = switch extended highlighting globally on
"                                     or off(0 or 1) default 0
"   g:vimchat_highlight_emoticons = (0 or 1) default 1
"   g:vimchat_highlight_shellcmds = (0 or 1) default 1
"   g:vimchat_highlight_emphasis = (0 or 1) default 1
"   g:vimchat_highlight_strings = (0 or 1) default 1
"   g:vimchat_highlight_addresses = (0 or 1) default 1
"   g:vimchat_highlight_links = (0 or 1) default 1
"   g:vimchat_highlight_paths = (0 or 1) default 1
"   g:vimchat_highlight_mail = (0 or 1) default 1

if exists('g:loaded_vimchat')
  finish
endif
let g:loaded_vimchat = 1

com!
      \ -nargs=*
      \ VimChat
      \ call vimchat#main#main(<f-args>)

augroup vimchat_setup_scroll_maps
  autocmd!
  autocmd FileType vimchat call vimchat#fns#SetupLocalMapsAndCommands()
  autocmd FileType vimchat setlocal conceallevel=2
augroup END
