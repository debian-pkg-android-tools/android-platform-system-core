#!/bin/bash

REVISION=21
gitclonedir=androidsystemcore

if [ -d $gitclonedir -o -f $gitclonedir ]
then
    echo "The file/directory '$gitclonedir' exists .. aborting."
    exit
fi


git clone -b tools_r$REVISION https://android.googlesource.com/platform/system/core/ $gitclonedir

VERSION=`git --git-dir=$gitclonedir/.git log -1 --format=%cd~%h --date=short | sed s/-//g`

echo "Version $VERSION"

# now we delete the files that we dont intend to use
echo "Deleting not needed files ..."
rm -fr `find $gitclonedir -maxdepth 1 -type d ! -name $gitclonedir ! -name liblog ! -name libcutils ! -name include ! -name libzipfile`
rm -fr `find $gitclonedir/include -maxdepth 1 -type d ! -name include ! -name cutils ! -name android ! -name zipfile`

tarballdir=$(cd `dirname $0`/../../; pwd)

echo "Packaging archive into ../${gitclonedir}_$REVISION+git$VERSION.orig.tar.gz ..."
tar -czf ${tarballdir}/${gitclonedir}_$REVISION+git$VERSION.orig.tar.gz $gitclonedir
echo "Deleting folder '$gitclonedir'"
rm -rf $gitclonedir

