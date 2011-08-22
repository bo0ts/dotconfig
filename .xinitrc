#!/bin/bash
#

# .xinitrc

xscreensaver -no-splash &
xrdb -merge $HOME/.Xdefaults

xsetroot -cursor_name left_ptr
xsetroot -solid '#80a0af'

xsetbg $HOME/pics/wp/orvalho-1680x1050.jpg

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
    --expand true --transparent true --alpha 0 --tint 0x3f3f3f --width 10 --height 8 &

# ssh agent
id1=$HOME/.ssh/identity
id2=$HOME/.ssh/id_dsa
id3=$HOME/.ssh/id_rsa
if [ -x /usr/bin/ssh-agent ] && [ -f $id1 -o -f $id2 -o -f $id3 ];
then
	eval `ssh-agent -s`
	ssh-add < /dev/null
fi

xset fp+ /usr/share/fonts/TTF/
xset b 100 0 0
xset r rate 150

xmodmap $HOME/.Xmodmap

syndaemon -i 1 -d
emacs &
urxvt -e ncmpcpp &

exec xmonad
