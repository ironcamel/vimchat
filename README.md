# About

Vimchat is a vim plugin that allows you to do instant messaging from within the vim text editor. Note that this only works with vim, not gvim.

[Screenshot 1](http://ironcamel.com/files/vimchat1.png) [Screenshot 2](http://ironcamel.com/files/vimchat2.png)

# Features

Vimchat allows you to easily connect to jabber servers such as Google Talk. It is also possible to connect to other services such as IRC, AIM, ICQ, and MSN. You just need to set up jabber transports.

Vimchat supports encryption via OTR (off the record).

Vimchat can use status icons in the system tray which will blink when you receive new messages. You simply need to put any icon you would like to use at ~/.vimchat/icon[\_status].gif. 
The default icon is ~/.vimchat/icon.gif. To use a different icon for e.g. the away status put an icon at ~/.vimchat/icon\_away.gif

# Requirements

* linux or Mac OS X
* vim >= 7.3.254
* python-xmpp

Suggested libraries:

* python-gtk2
* python-notify
* python-dns
* growl (for OSX only)

This works on linux and Mac (tested with MacVim, but required a recompile against newer python libraries). You must have python support in vim, and you must have xmpppy installed (the python-xmpp package in most distros). The python-notify package is not necessary, but if it is installed, you will get pretty libnotify alerts for new messages. It also throws some warning messages if you do not have python-dns installed (though it will still work without it). The python-gtk2 package is needed if you want a status icon in your system tray that blinks when new messages arrive.

If you are running ubuntu linux, here is a command you can run to install all the dependencies:

    sudo apt-get install vim-gtk python-xmpp python-notify python-dns python-gtk2

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
* let g:vimchat\_blinktimeout = timeout in seconds, default is -1
* let g:vimchat\_buddylistmaxwidth = max width of buddy list window, default ''
* let g:vimchat\_timestampformat = format of the message timestamp, default "[%H:%M]" 
* let g:vimchat\_showPresenceNotification = notification if buddy changed status, comma-separated list of states, default ""

# Hacking
Keep all lines to 80 characters wide or less
All python code should follow pep8 guidelines
All new features should update documentation in the README


# Contributors 

* Philipp [philsmd](https://github.com/philsmd)
* Michael Dillon [michaelcdillon](https://github.com/michaelcdillon)
