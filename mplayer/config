alang="en"
slang="en"

cache=32768 # 32 MB

# This is all necessary to open the video on the TV, centered, in fullscreen.
# Gotchas:
# * the device_id is ignored unless you *open* in fullscreen, with -fs
# * '-vo macosx' uses CoreVideo, '-vo quartz' doesn't
# * My TV is fucked up, so I have to add an artifical 400 pixels of black at
#   the bottom of my video output.
fs=1
vo="macosx:device_id=2"
vf="expand=0:-250:0:0"

# This is to prevent 'wandering' of the audio/video sync; I'd prefer to see
# skipping than having to get up every 5 minutes to re-sync the audio/video
framedrop=1

# This should reduce the sync-wandering defined above.
autosync=30
mc=10.0
demuxer="lavf"
# correct-pts=0 # To get rid of the pts value spam

# This should help get subtitles 'right'
sub-fuzziness=1
utf8=yes
unicode=yes
subpos=100
subalign=2

lavdopts="fast=1:skiploopfilter=noref:threads=8"
