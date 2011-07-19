#!/bin/bash
echo "Installing vimchat ..."

mkdir -p ~/.vim/plugin 
if [ $? != 0 ]; then echo "Could not create ~/.vim/plugin"; exit 1; fi
cp plugin/vimchat.vim ~/.vim/plugin

mkdir -p ~/.vim/syntax
if [ $? != 0 ]; then echo "Could not create ~/.vim/syntax"; exit 1; fi
cp syntax/vimchat.vim ~/.vim/syntax

mkdir -p ~/.vimchat
if [ $? != 0 ]; then echo "Could not create ~/.vimchat"; exit 1; fi

if [ ! -f ~/.vimchat/icon.gif ]; then cp icon*.gif ~/.vimchat/; fi

if [ -f ~/.vimchat/config ]; then
	cp config ~/.vimchat/config.example
else
	cp config ~/.vimchat/
fi

echo "Done :)"
