#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# The MIT License
#
# Copyright (c) 2011 by Sorin Ionescu
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

"""Sends Growl notications on behalf of Pianobar."""

# Notify when a song starts.
NOTIFY_SONG_START = True

# Notify when a song ends.
NOTIFY_SONG_END = False

# Notify when a song is loved.
NOTIFY_SONG_LOVE = True

# Notify when a song is banned.
NOTIFY_SONG_BAN = True

# Notify when a song is shelved.
NOTIFY_SONG_SHELVE = True

# Notify when a song is bookmarked.
NOTIFY_SONG_BOOKMARK = True

# Notify when an artist is bookmarked.
NOTIFY_ARTIST_BOOKMARK = True

# Notify on program error.
NOTIFY_PROGRAM_ERROR = True

# Notify on network error.
NOTIFY_NETWORK_ERROR = True

# Imports
from gntp.notifier import GrowlNotifier
import socket
import os
import sys

# Script Arguments
argv = os.sys.argv
argc = len(argv)

# Stores Pianobar information.
info = {}

# Initalize a new Growl object (localhost does not require a password).
growl = GrowlNotifier(
    applicationName=u'Pianobar',
    notifications=[
        u'Song Start',
        u'Song End',
        u'Song Love',
        u'Song Ban',
        u'Song Shelve',
        u'Song Bookmark',
        u'Artist Bookmark',
        u'Program Error',
        u'Network Error'])

# Register Pianobar with Growl.
try:
    growl.register()
except socket.error:
    # Be silent.
    pass

# Parse stdin into the dictionary.
for line in sys.stdin:
    key, delimiter, value = unicode(line).strip().partition(u'=')
    if value.isdigit():
        info[key] = int(value)
    else:
        info[key] = value

# The icon will be used when song cover art is missing.
info[u'programIcon'] = u'file://{0}/pandora.png'.format(
    os.path.dirname(argv[0]))

# Show a heart next to a loved song title.
if info[u'rating'] == 1:
    info[u'lovedIcon'] = u' ♥'
else:
    info[u'lovedIcon'] = u''

# Set the cover art to the program icon when it's missing.
if len(info[u'coverArt']) == 0:
    info[u'coverArt'] = info[u'programIcon']

try:
    if argc < 1:
        sys.exit(1)
    elif argv[1] == u'songstart' and NOTIFY_SONG_START:
        growl.notify(
            noteType=u'Song Start',
            icon=info[u'coverArt'],
            title=u'{0}{1}'.format(
                info[u'title'],
                info[u'lovedIcon']),
            description=u'{0}\n{1}'.format(
                info[u'artist'],
                info[u'album']))
    elif argv[1] == u'songfinish' and NOTIFY_SONG_END:
        growl.notify(
            noteType=u'Song End',
            icon=info[u'coverArt'],
            title=u'{0}{1}'.format(
                info[u'title'],
                info[u'lovedIcon']),
            description=u'{0}\n{1}'.format(
                info[u'artist'],
                info[u'album']))
    elif argv[1] == u'songlove' and NOTIFY_SONG_LOVE:
        growl.notify(
            noteType='Song Love',
            icon=info[u'coverArt'],
            title=u'Song Loved',
            description=u'{0}\n{1}\n{2}'.format(
                info[u'title'],
                info[u'artist'],
                info[u'album']))
    elif argv[1] == u'songban' and NOTIFY_SONG_BAN:
        growl.notify(
            noteType='Song Ban',
            icon=info[u'coverArt'],
            title=u'Song Banned',
            description=u'{0}\n{1}\n{2}'.format(
                info[u'title'],
                info[u'artist'],
                info[u'album']))
    elif argv[1] == u'songshelf' and NOTIFY_SONG_SHELVE:
        growl.notify(
            noteType='Song Shelve',
            icon=info[u'coverArt'],
            title=u'Song Shelved',
            description=u'{0}\n{1}\n{2}'.format(
                info[u'title'],
                info[u'artist'],
                info[u'album']))
    elif argv[1] == u'songbookmark' and NOTIFY_SONG_BOOKMARK:
        growl.notify(
            noteType='Song Bookmark',
            icon=info[u'coverArt'],
            title=u'Song Bookmarked',
            description=u'{0}\n{1}\n{2}'.format(
                info[u'title'],
                info[u'artist'],
                info[u'album']))
    elif argv[1] == u'artistbookmark' and NOTIFY_ARTIST_BOOKMARK:
        growl.notify(
            noteType='Artist Bookmark',
            icon=info[u'coverArt'],
            title=u'Artist Bookmarked',
            description=info[u'artist'])
    elif info[u'pRet'] != 1 and NOTIFY_PROGRAM_ERROR:
        growl.notify(
            noteType=u'Program Error',
            icon=info[u'programIcon'],
            title=u'Pianobar Failed',
            description=info[u'pRetStr'])
    elif info[u'wRet'] != 1 and NOTIFY_NETWORK_ERROR:
        growl.notify(
            noteType=u'Network Error',
            icon=info[u'programIcon'],
            title=u'Network Failed',
            description=info[u'wRetStr'])
except socket.error:
    # Be silent.
    pass
