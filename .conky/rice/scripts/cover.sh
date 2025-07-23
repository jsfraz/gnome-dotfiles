#!/bin/bash

id_current=$(cat ~/.conky/rice/current/current.txt)
id_new=`~/.conky/rice/scripts/id.sh`
cover=
imgurl=
dbus=`busctl --user list | grep "spotify"`

if [ "$dbus" == "" ]; then
       `cp ~/.conky/rice/empty.jpg ~/.conky/rice/current/current.jpg`
	echo "" > ~/.conky/rice/current/current.txt
else
	if [ "$id_new" != "$id_current" ]; then

		echo $id_new > ~/.conky/rice/current/current.txt
		imgname=`cat ~/.conky/rice/current/current.txt | cut -d '/' -f5`

		cover=`ls ~/.conky/rice/covers | grep "$id_new"`

		if grep -q "${imgname}" <<< "$cover"
		then
			`cp ~/.conky/rice/covers/$imgname.jpg ~/.conky/rice/current/current.jpg`
		else
			imgurl=`~/.conky/rice/scripts/imgurl.sh`
			`wget -q -O ~/.conky/rice/covers/$imgname.jpg $imgurl &> /dev/null`
			`touch ~/.conky/rice/covers/$imgname.jpg`
			`cp ~/.conky/rice/covers/$imgname.jpg ~/.conky/rice/current/current.jpg`
			# clean up covers folder, keeping only the latest X amount, in below example it is 10
			rm -f `ls -t ~/.conky/rice/covers/* | awk 'NR>10'`
			rm -f wget-log #wget-logs are accumulated otherwise
		fi
	fi
fi
