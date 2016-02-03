# About

Vimchat is a chat plugin for the vim text editor. It allows you to send and receive instant messages and participate in chat rooms all inside of vim. It supports the XMPP/jabber protocol, but you can also connect to other services such as IRC, AIM, ICQ, MSN, etc. via jabber transports. It's amazing isn't it. See the screenshots:

[Screenshot 1](http://ironcamel.com/files/vimchat1.png) [Screenshot 2](http://ironcamel.com/files/vimchat2.png)

# Features

Vimchat supports encryption via OTR (off the record).

Vimchat supports status icons which will blink in the system tray when you receive new messages.
The default icons are installed at `~/.vimchat/icon*.gif`.
You can overwrite these with your own custom icons.
For example, to use a different icon for the away status, copy your custom icon to `~/.vimchat/icon_away.gif`.

# Requirements

* linux or Mac OS X
* vim >= 7.3.154
* xmpppy

Suggested libraries:

* python-gtk2
* python-notify
* python-dns
* growl (for OSX only)

This works on linux and Mac (tested with MacVim, but required a recompile against newer python libraries). You must have python support in vim, and you must have xmpppy installed (the python-xmpp package in most distros). The python-notify package is not necessary, but if it is installed, you will get pretty libnotify alerts for new messages. It also throws some warning messages if you do not have python-dns installed (though it will still work without it). The python-gtk2 package is needed if you want a status icon in your system tray that blinks when new messages arrive.

If you are running ubuntu linux, here is a command you can run to install all the dependencies:

    sudo apt-get install vim-gtk python-xmpp python-notify python-dns python-gtk2

On ubuntu the python-xmpp package seems to work fine. But on arch linux, the corrresponding package is named xmpppy, which for me was giving this error when starting vimchat:

    AttributeError: '_ssl._SSLSocket' object has no attribute 'issuer'

It is because of a bug in the xmpppy library:
https://github.com/eventlet/eventlet/issues/124#issuecomment-69775480

I got around it by installing this forked version of xmppy:
https://github.com/ArchipelProject/xmpppy

    pip install git+https://github.com/ArchipelProject/xmpppy

# Installation

Just run:

    chmod +x install.sh
    ./install.sh

The installation script is very simple.
All it does is copy a few files.

# Configuration

It is important to update the configuration file before you run vimchat for the first time.
The `install.sh` script should have created a config file `~/.vimchat/config`.
When you open this file you will see directions and examples.
Edit this file and add at least one account entry to it.

# Usage

To start using vimchat just start vim and enter `:VimChat`.
You should see a window on the left with a list of all your buddies.
Type `B` to toggle this list.
Hit enter on someone's name to open a chat buffer.

In a chat buffer, type `i` (or `a` or `o`) to open a send buffer.
Type a message and hit enter. 

# Buddy List

The buddy list can be toggled by typing `B` in normal mode from any vimchat
buffer.
Toggling the buddy list also refreshes it.
If you are not currently in a vimchat buffer, you can open it with the
`:VimChatBuddyList` command.

The buddy list is comprised of folds, and unfolding any buddy will show items like status, away message, and the groups that he or she belongs to.

Once in the buddy list, you can scroll through your buddies and hit enter when your cursor is on the buddy you want to chat with.

Pressing `<leader>l` while on a buddy entry in the buddy list will bring up the log files (if any) for that user. 

# Chat Buffers

When you enter into insert mode from a chat window (for example by typing `i`),
it will pop up a send buffer.
In the send buffer you simply type your message and hit enter.
To send multiple lines, select the lines in visual mode and then hit enter.

Typing `<leader>l` will bring up a new tab containing log files for the current
user. 

When moving up beyond the first line, the most recent logs will be prepended if found.

The user can enable extended syntax highlighting (urls, emoticons, ...) at wish.

# Chat Rooms

You can configure chat rooms in your vimchat config file.
To join a chat room type `<leader>j`.
This will display a list of rooms which you can choose from.

# Growl Integration

First install the growl notification system: http://growl.info/

Then download the growl SDK from: http://growl.info/downloads_developers.php

Finally navigate into the Bindings/python folder and run: 
    sudo python setup.py install

# Optional Settings

You can can update your `~/.vimrc` with these settings to customize vimchat. All of these settings are optional.

* let g:vimchat\_buddylistwidth = width of buddy list, default is 30
* let g:vimchat\_logpath = path to store log files, default is ~/.vimchat/logs
* let g:vimchat\_logchats = (0 or 1) default is 1 -- 0 will not log,
* let g:vimchat\_otr = (0 or 1) default is 0 -- enable otr or not
* let g:vimchat\_logotr = (0 or 1) default is 1 -- log otr convos or not
* let g:vimchat\_statusicon = (0 or 1) default is 1 -- use a gtk status icon? 
* let g:vimchat\_blinktimeout = timeout in seconds, default is -1
* let g:vimchat\_buddylistmaxwidth = max width of buddy list window, default ''
* let g:vimchat\_timestampformat = format of the message timestamp, default "[%H:%M]" 
* let g:vimchat\_dateformat = format of the message date in logs, default "[%Y-%m-%d]" 
* let g:vimchat\_showPresenceNotification = notification if buddy changed status, comma-separated list of states, default ""
* let g:vimchat\_load\_logs = (0 or 1) default is 1 -- reload logs from previous conversations when scrolling or moving beyond line 1
* let g:vimchat\_extended\_highlighting = (0 or 1) default is 0 -- some syntax highlighting in text

*Extended highlighting*, if activated, can be further customized by setting these variables:

* let g:vimchat\_highlight\_emoticons = (0 or 1) default 1
* let g:vimchat\_highlight\_shellcmds = (0 or 1) default 1
* let g:vimchat\_highlight\_emphasis = (0 or 1) default 1
* let g:vimchat\_highlight\_strings = (0 or 1) default 1
* let g:vimchat\_highlight\_addresses = (0 or 1) default 1
* let g:vimchat\_highlight\_links = (0 or 1) default 1
* let g:vimchat\_highlight\_paths = (0 or 1) default 1
* let g:vimchat\_highlight\_mail = (0 or 1) default 1

*Additional custom maps* can be defined, that will also load logs.

* let g:vimchat\_pageup = (array of strings) default [], included besides `<C-b>` and `<PageUp>`
* let g:vimchat\_halfpageup = (array of strings) default [], included besides `<C-u>`
* let g:vimchat\_moveup = (array of strings) default [], included besides `k` and `<Up>`
* let g:vimchat\_moveleft = (array of strings) default [], included besides `h` and `<Left>`
                          


# Contributing

Pull requests are welcome. Please follow the pep 8 style guidelines for the python code.

# Contributors 

* Philipp [philsmd](https://github.com/philsmd)
* Michael Dillon [michaelcdillon](https://github.com/michaelcdillon)
* Naveed Massjouni [ironcamel](https://github.com/ironcamel) (author)
* William Wolf [throughnothing](https://github.com/throughnothing) (author)
