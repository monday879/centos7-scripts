#!/bin/sh -u
PATH=/bin:/usr/bin ; export PATH
umask 022

# Assignment 12
# 4.3.3 symtype.sh
# Qichen Jia 040914732 jia00025@algonquinlive.com
# KEY: symtype.sh /fFOx0yNwIDOUN1Q/PTO1Mz/1IDMwATYpp2/oNnLlBXe01Wez9PM1ATO0UzMyUTMW
# This script classifies a symlink target according to whether it points to
# an absolute or a relative pathname.

if [ $# -ne 1 ] ; then
    echo 1>&2 "$0: Expecting 1 symlink pathname; found $# ($*)"
    echo 1>&2 "Usage: $0 'symlink pathname'"
    exit 2
fi

if [ "$1" = "" ] ; then
    echo 1>&2 "$0: Expecting 1 symlink pathname; found $# ($*)"
    echo 1>&2 "Usage: $0 'symlink pathname'"
    exit 2
fi

if [ ! -h "$1" ] ; then
    echo 1>&2 "$0: The following pathname is not a symlink: '$1'"
    echo 1>&2 "Usage: $0 'symlink pathname'"
    exit 2
fi

targ=$(ls -l "$1" | awk '{ print $NF }')


if [ "$targ" = "" ] ; then
    echo 1>&2 "$0: The following symlink has no target: '$1'"
    exit 3
fi

case "$targ" in
/* )       type='Absolute symlink' ;;
* )      type='Relative symlink' ;;
esac

echo "$type: '$1' -> '$targ'"
