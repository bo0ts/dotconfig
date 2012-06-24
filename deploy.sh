#!/bin/bash

for file in $(find . -maxdepth 1 -not  -regex "\(.*README\)\|\(.*.gitignore\)\|\(.*.git\)\|.\|\(.*deploy.sh\)")
do
    # remove the tailing ./
    echo "=================="
    conf="$HOME/.${file##./}"
    file=$(realpath ${file##./})
    echo "Symlinking $file to $conf"
    if [ -h $conf ]; then
        echo "$conf is already a symlink, removing"
        rm $conf
    elif [ -a $conf ]; then
        backup="$conf.bak"
        echo "$conf already exists, backing up to $backup"
        mv $conf $backup
    fi
    ln -s $file $conf
done
