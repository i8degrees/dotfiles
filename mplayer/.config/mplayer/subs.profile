#     Mplayer profile defaults for authoring subtitles with Jubler
#
#   To use, add "-profile subs" argument to the Advanced Argument List input box
# inside Jubler's 'Player" Preferences tab like so,
#
# %p -profile subs -subs %s -ss %t -geometry +%x+%y %(-audiofile %a%) -font %j/lib/freesans.ttf %v
#
[subs]
profile-desc="Jubler subtitles playback"
osd-fractions=1 # osd-fractions=2 is potentially inaccurate
osdlevel=3
#framedrop=false
noautosub=true
noquiet=true
nofs=true
slave=true
idle=true
ontop=false
utf8=true
#embeddedfonts=true
volume=100
font=/System/Library/Fonts/Helvetica.dfont

ass=true
#subfont-text-scale=3
