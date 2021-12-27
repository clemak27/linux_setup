#!/bin/sh

readarray -d '' FOLDER < <(find "docker-data/navidrome/music/" -type d -print0)

for i in "${FOLDER[@]}"
do
  cd "$i"
  fd mp3 . -d 1 -X mp3gain -a -p -k
  cd $HOME
done
