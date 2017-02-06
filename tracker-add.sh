#!/bin/bash

torrent_hash=$1
base_url='http://torrentz2.eu'
pattern='announcelist_[0-9]+'

if [ -z "$1" ] ; then
    echo 'Usage: ./tracker-add.sh <hash>'
    exit 1
fi

announce_list=`curl -s ${base_url}/${torrent_hash} | grep -Eo "${pattern}"`

if [ -z "$announce_list" ] ; then
    echo 'No additional trackers found, sorry.'
    exit 1
fi

for tracker in $(curl -s ${base_url}/${announce_list})
do
  echo "Adding ${tracker} to torrent ${torrent_hash}"
  transmission-remote -t ${torrent_hash} -td ${tracker}
done
