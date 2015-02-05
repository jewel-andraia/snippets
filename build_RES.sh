#!/bin/bash

CHROME_BUILD=true
FIREFOX_BUILD=false
OPERA_BUILD=false


ROOT=/Users/andytuba/Code/Reddit-Enhancement-Suite
SRC=$ROOT/dist #/temp/ext
BUILD=$ROOT/temp/build
PATH=$PATH:/usr/local/bin

JETPACK=$ROOT/../addon-sdk
FIREFOXSRC=$SRC/firefox
FFEXTENSION=/Users/andytuba/Library/Application\ Support/Firefox/Profiles/06kw1qxd.default/extensions/jid1-xUfzOsOFlzSOXg@jetpack.xpi

OPERASRC=$SRC/opera  #todo: fix this yo
OPERAEXTENSION=/Users/andytuba/Library/Application\ Support/Opera/widgets/reddit-enhancement-suite-2-4.1.5-1.oex

SAFARISRC=$SRC/RES.safariextension

#/Users/andytuba/Documents/Work/RES/Reddit-Enhancement-Suite
echo "Deploying RES to dev browsers from $SRC"

cd $ROOT


#echo "Re-linking files from extension folders to lib/"
#./makelinks.sh
echo "Gulping it down"
gulp

sleep .5

if $CHROME_BUILD; then
	open -a Google\ Chrome http://reload.extensions
	echo "Copied to Chrome"
	echo ""
fi

#Clean

if $OPERA_BUILD; then
	#TODO: FIX THIS YO
	rm $OPERABUILD/opera.oex &> /dev/null
	#Build
	cd $OPERASRC
	zip -r $BUILD/opera.oex . -x '*.git/*' -x '*.DS_Store'
	# Deploy
	cp $BUILD/opera.oex "$OPERAEXTENSION"
	echo "Copied to Opera"
	echo ""
fi

if $FIREFOX_BUILD; then
	#todo: FIX THIS YO

	# Clean
	rm -f $FIREFOXSRC/reddit_res.xpi &> /dev/null
	rm -f $BUILD/reddit_res.xpi &> /dev/null
	cd $JETPACK
	#Build
	source bin/activate
	cd $FIREFOXSRC
	cfx xpi #--force-mobile
	cp reddit_res.xpi $BUILD
	echo "Copied to Firefox"
	echo ""

	killall firefox &> /dev/null
	killall firefox-bin &> /dev/null
	cfx run
fi
