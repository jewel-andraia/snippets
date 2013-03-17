#!/bin/bash

if [ $# -lt 1 ]
    then
      echo "usage: $0 issue_num [branch]"
      exit
    fi  

CODE=/Users/andytuba/Code/Reddit-Enhancement-Suite
OWNER="honestbleeps"
ME="andytuba"
REPO="Reddit-Enhancement-Suite"

issue=$1
url="https://github.com/$OWNER/$REPO/issues/$issue"

upstream="$OWNER:master"
if [ $# -lt 2 ]
    then
	branch="issue_$issue"
    else
        branch=$2
    fi
my="$ME:$branch"

cd $CODE
pwd
hub pull-request -b $upstream -h $my $url
