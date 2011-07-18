# Features

Vimchat allows you to easily connect to jabber servers such as Google Talk. It is also possible to connect to other services such as IRC, AIM, ICQ, and MSN. You just need to set up jabber transports.

Vimchat supports encryption via OTR (off the record).

Vimchat can use a status icon in the system tray that will blink when you receive new messages. You simply need to put any icon you would like to use at ~/.vimchat/icon.gif. 

# Requirements

* linux or Mac OS X
* vim
* python-xmpp

# Suggested

* python-gtk2
* python-notify
* python-dns
* growl (for OSX only)

# Installation

    chmod +x install.sh
    ./install.sh
    This should have created a file at ~/.vimchat/config. Edit this file and add at least one account entry to it. 

# Usage

To start using vimchat just start vim and type :VimChat. You should see a window on the left with a list of all your buddies. Type B a couple times to refresh/toggle this list. Hit enter on someone's name to open a chat buffer. Type i (or a or o) to open a send buffer. Type a message and hit enter. 

# Buddy List

The buddy list can be toggled by typing B in normal mode from a vimchat buffer. Toggling the buddy list also refreshes it. If you are not currently in a vimchat buffer, you can open it with the :VimChatBuddyList command.

The buddy list is comprised of folds, and unfolding any buddy will show items like status, away message, and the groups that he or she belongs to.

Once in the buddy list, you can scroll through your buddies and hit enter when your cursor is on the buddy you want to chat with.

Pressing \l while on a buddy entry in the buddy list will bring up the log files (if any) for that user. 

# Chat Buffers

When you enter into insert mode from a chat window (for example by typing i), it will pop up a send buffer. In the send buffer you simply type your message and hit enter. Multiple lines can also be sent by typing the lines, then selecting what you want to send in visual mode and pressing enter.

Typing \l will bring up a new tab containing log files for the current user. 

# Growl Integration

First install the growl notification system: http://growl.info/

Then download the growl SDK from: http://growl.info/downloads_developers.php

Finally navigate into the Bindings/python folder and run: 
    sudo python setup.py install

# Options

__Optional ~/.vimrc Variables:__

* let g:vimchat\_buddylistwidth = width of buddy list, default is 30
* let g:vimchat\_logpath = path to store log files, default is ~/.vimchat/logs
* let g:vimchat\_logchats = (0 or 1) default is 1 -- 0 will not log,
* let g:vimchat\_otr = (0 or 1) default is 0 -- enable otr or not
* let g:vimchat\_logotr = (0 or 1) default is 1 -- log otr convos or not
* let g:vimchat\_statusicon = (0 or 1) default is 1 -- use a gtk status icon? 
* let g:vimchat\_blinktimeout = timeout in seconds default is -1
* let g:vimchat\_buddylistmaxwidth = max width of buddy list window default ''
* let g:vimchat\_timestampformat = format of the message timestamp default "[%H:%M]" 
