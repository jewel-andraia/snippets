#!/bin/bash

ROOT=/Users/andytuba/Code
SRC=$ROOT/Reddit-Enhancement-Suite 
BUILD=$ROOT/RES_build

JETPACK=$ROOT/addon-sdk
FIREFOXSRC=$SRC/XPI
FFEXTENSION=/Users/andytuba/Library/Application\ Support/Firefox/Profiles/06kw1qxd.default/extensions/jid1-xUfzOsOFlzSOXg@jetpack.xpi

OPERASRC=$SRC/Opera
OPERAEXTENSION=/Users/andytuba/Library/Application\ Support/Opera/widgets/reddit-enhancement-suite-2-4.1.5-1.oex

SAFARISRC=$SRC/RES.safariextension

#/Users/andytuba/Documents/Work/RES/Reddit-Enhancement-Suite
echo "Deploying $SRC/lib/r_e_s.user.js to dev browsers"

cd $SRC
./makelinks.sh

sleep .5

open -a Google\ Chrome http://reload.extensions
echo "Copied to Chrome"
echo ""


#Clean
rm $BUILD/opera.oex
#Build
cd $OPERASRC
zip -r $BUILD/opera.oex . -x '*.git/*' -x '*.DS_Store'
# Deploy
cp $BUILD/opera.oex "$OPERAEXTENSION"
echo "Copied to Opera"
echo ""


# Clean
rm -f $FIREFOXSRC/reddit_res.xpi
rm -f $BUILD/reddit_res.xpi
cd $JETPACK
#Build
source bin/activate
cd $FIREFOXSRC
cfx xpi
cp reddit_res.xpi $BUILD 
#Deploy
cp $BUILD/reddit_res.xpi "$FFEXTENSION"
echo "Copied to Firefox"
echo ""


killall firefox
killall firefox-bin
cfx run
