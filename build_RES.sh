#!/bin/bash

ROOT=/Users/andytuba/Code/Reddit-Enhancement-Suite
SRC=$ROOT/temp/ext
BUILD=$ROOT/temp/build
PATH=$PATH:/usr/local/bin

JETPACK=$ROOT/../addon-sdk
FIREFOXSRC=$SRC/XPI
FFEXTENSION=/Users/andytuba/Library/Application\ Support/Firefox/Profiles/06kw1qxd.default/extensions/jid1-xUfzOsOFlzSOXg@jetpack.xpi

OPERASRC=$SRC/Opera
OPERAEXTENSION=/Users/andytuba/Library/Application\ Support/Opera/widgets/reddit-enhancement-suite-2-4.1.5-1.oex

SAFARISRC=$SRC/RES.safariextension

#/Users/andytuba/Documents/Work/RES/Reddit-Enhancement-Suite
echo "Deploying RES to dev browsers from $SRC"

cd $ROOT

rm -rf $BUILD
mkdir -p $BUILD

#echo "Re-linking files from extension folders to lib/"
#./makelinks.sh
echo "Running grunt build"
grunt

sleep .5


open -a Google\ Chrome http://reload.extensions
echo "Copied to Chrome"
echo ""


#Clean
rm $BUILD/opera.oex &> /dev/null
if false; then
	#Build
	cd $OPERASRC
	zip -r $BUILD/opera.oex . -x '*.git/*' -x '*.DS_Store'
	# Deploy
	cp $BUILD/opera.oex "$OPERAEXTENSION"
	echo "Copied to Opera"
	echo ""
fi

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
