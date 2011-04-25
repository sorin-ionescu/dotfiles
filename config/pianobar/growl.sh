#!/bin/bash

# create variables
while read L; do
	k="`echo "$L" | cut -d '=' -f 1`"
	v="`echo "$L" | cut -d '=' -f 2`"
	export "$k=$v"
done < <(grep -e '^\(title\|artist\|album\|stationName\|pRet\|pRetStr\|wRet\|wRetStr\|songDuration\|songPlayed\|rating\|coverArt\)=' /dev/stdin)

case "$1" in
	# React when the song changes
	songstart)
	# Since $rating is a number, we translate it into a heart if the user likes the song or
	# not.
		if [ $rating -eq 1 ]
		then
			heart=" ♥"
		else
			heart=""
		fi

		# This makes sure the directory for storing the album art exists

		if [ ! -d ~/.config/pianobar/art ]
		then
			mkdir ~/.config/pianobar/art
		fi
		# Change to the album art directory
		cd ~/.config/pianobar/art
		# Get rid of any existing album art, but don't complain if there isn't any
		rm * 2> /dev/null

		# $coverArt is a URL pointing to the album art, so download it

		[[ -n "$coverArt" ]] && curl -s -O "$coverArt" || ln -h ../pandora.png . 2>/dev/null

		# Finally, show the notification with the title, artist, album name, heart icon, and
		# album art image. We set the identifier (with the -d switch) to make all of the
		# notifications show in one bubble.
		echo -ne "${artist}\n${album}" | \
			growlnotify \
				--name "Pianobar" \
				--image * \
				--priority 0 \
				--identifier "Music" \
				--title "${title}${heart}" >> /dev/null 2>&1
	;;
esac
