#!/bin/bash
#

# .xinitrc

xscreensaver -no-splash &
xrdb -merge $HOME/.Xdefaults

xsetroot -cursor_name left_ptr
xsetroot -solid '#80a0af'

case $(uname -n) in
    determinist)
        xsetbg $HOME/pics/wallpapers/xeno-buddha-red.jpg 
        ;;
    matisse)
        xsetbg $HOME/pics/wallpapers/laughing-man-stone.png 
        ;;
esac

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
    --expand true --transparent true --alpha 0 --tint 0x3f3f3f --width 10 --height 13 &

eval $(gpg-agent --daemon)

xset fp+ /usr/share/fonts/TTF/
xset b 100 0 0
xset r rate 150

xmodmap $HOME/.Xmodmap

emacs &
urxvt -e ncmpcpp &

exec xmonad
