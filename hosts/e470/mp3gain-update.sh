#!/bin/sh

tree /home/clemens/data/docker/navidrome/music > /tmp/tree_new

DIFF=$(cmp /tmp/tree_old /tmp/tree_new)
if [ "$DIFF" != "" ]
then
  readarray -d '' FOLDER < <(find "/home/clemens/data/docker/navidrome/music/" -type d -print0)

  for i in "${FOLDER[@]}"
  do
    cd "$i"
    fd mp3 . -d 1 -X mp3gain -a -p -k
    cd /home/clemens/
  done
  curl -X POST -H "Content-Type: application/json" -d '{"text": "mp3gain update finished."}'  --url localhost:8525/message
fi

mv /tmp/tree_new /tmp/tree_old
