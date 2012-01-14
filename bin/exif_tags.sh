#!/bin/sh
#
# 2011-12/21:jeffrey.carp@gmail.com
#
#		~/bin/exif_tags.sh
#
#		Copyright 2011 Jeffrey Carpenter. All rights reserved.
#
# 	Released under the BSD license
#
#	Redistribution and use in source and binary forms, with or without modification, are
#	permitted provided that the following conditions are met:
#
#   1. Redistributions of source code must retain the above copyright notice, this list of
#      conditions and the following disclaimer.
#
#	2. Redistributions in binary form must reproduce the above copyright notice, this list
#      of conditions and the following disclaimer in the documentation and/or other materials
#      provided with the distribution.
#
#	THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY EXPRESS
#	OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#	MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
#	SHALL <COPYRIGHT HOLDER> OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
#	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
#	LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
#	PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
#	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
#	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#	ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#	The views and conclusions contained in the software and documentation are those of the
#	authors and should not be interpreted as representing official policies, either expressed
#	or implied, of Jeffrey Carpenter.
#
#	---
#
# 			TODO
#
#		a) 	confirmation dialog for writing said tags to said file
#		b) 	automatically dump (pre)-existing EXIF metadata (as per exiftool)
#		c)	dialog prompt requesting file/folder in event $SRC_FILE is empty
#		d)	expand variable scope to allow arrays; AKA support for multiple
#			files/folders
#		e)	...
#
#			REFERENCES
#
#		1.	exiftool (1)
#		2.	http://linux.byexamples.com/archives/259/a-complete-zenity-dialog-examples-1/
#		3.	http://linux.byexamples.com/archives/265/a-complete-zenity-dialog-examples-2/
#		4.	http://tldp.org/LDP/abs/html/arrays.html
#		----
#		5.	DIALOG_DISPLAY_TAGS="szAnswer=$(zenity --entry --text "where are you?" --entry-text "at home"); echo $szAnswer"
#		6.	gksudo lsof | zenity --text-info --width 530
#		7.	exiftool -Keywords+=$word -o $dest_file $src_file
#		---
#		[*]	Search for images containing a particular keyword:
#		---
#			a)	exiftool -if '$keywords =~ /boobies/i' -filename pathdir
DEBUG=true

ZENITY_BIN=/usr/bin/zenity
EXIFTOOL_BIN=/usr/bin/vendor_perl/exiftool

PROGNAME=$(basename "$0")
SRC_FILE=$1
DEST_FILE="$SRC_FILE".bck
DIALOG_USAGE='--info --title="Usage" --text="Usage: $PROGNAME <file> ..."'

function usage()
{
	# FIXME

	echo -e "Usage: $PROGNAME <file> ..."

	command "$ZENITY_BIN" "$DIALOG_USAGE"

	return 0
}

function add_tags()
{
	# TODO

	return 0
}

function display_tags()
{
	# TODO

	return 0
}

function confirm_write()
{
	# TODO

	return 0
}

function write_tags()
{
	# FIXME

	command "$EXIFTOOL_BIN" -Keywords+="$TAGS" -o "$SRC_FILE" "$DEST_FILE"
}

function main()
{
	# TODO/FIXME

	return 0
}

EXIF_TAGS="[Keyword*][Caption*][Comment*]"

DIALOG_DISPLAY_TAGS="--text-info --width 530 --height 400"
DIALOG_ADD_TAGS='--entry --title="Tag A Photo" --text="Tags"'

#DIALOG_ADD_TAGS='--entry --title="Tag A Photo" --text="Tags"'
#DIALOG_ADD_EXISTING='--entry-text'

DIALOG_ADD_EXISTING='--text="Tags"'

if [[ -z "$SRC_FILE" ]]; then
	usage
	exit -1
else
	if [[ -f "$SRC_FILE" ]]; then

		# Input the existing tags; in particular, Keywords & Caption-Abstracts
		EXISTING_TAGS=$("$EXIFTOOL_BIN" "$SRC_FILE" | grep "$EXIF_TAGS")

		if [[ "$DEBUG" == "true" ]]; then
			echo -e "$EXISTING_TAGS"
		fi

		if [[ -n "$EXISTING_TAGS" ]]; then

			DIALOG_ADD_TAGS=$DIALOG_ADD_TAGS:$DIALOG_ADD_EXISTING:$EXISTING_TAGS

			if [[ "$DEBUG" == "true" ]]; then
				echo -e "$DIALOG_ADD_TAGS"
			fi

			result=$("$ZENITY_BIN" "$DIALOG_DISPLAY_TAGS" "$EXISTING_TAGS"); echo $result
		else
			TAGS=$("$ZENITY_BIN" "$DIALOG_ADD_TAGS")
			#write_tags
		fi
	fi
fi
