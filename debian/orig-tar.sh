#!/bin/bash

REVISION=21
DIRECTORY=androidsystemcore

if [ -d $DIRECTORY -o -f $DIRECTORY ]
then
    echo "The file/directory '$DIRECTORY' exists .. aborting."
    exit
fi


git clone -b tools_r$REVISION https://android.googlesource.com/platform/system/core/ $DIRECTORY

VERSION=`git --git-dir=$DIRECTORY/.git log -1 --format=%cd~%h --date=short | sed s/-//g`

echo "Version $VERSION"

# now we delete the files that we dont intend to use
echo "Deleting not needed files ..."
rm -fr `find $DIRECTORY -maxdepth 1 -type d ! -name $DIRECTORY ! -name liblog ! -name libcutils ! -name include`
rm -fr `find $DIRECTORY/include -maxdepth 1 -type d ! -name include ! -name cutils ! -name android`


echo "Packaging archive into ../${DIRECTORY}_$REVISION+git$VERSION.orig.tar.gz ..."
tar -czf ../${DIRECTORY}_$REVISION+git$VERSION.orig.tar.gz $DIRECTORY
echo "Deleting folder '$DIRECTORY'"
rm -Ir $DIRECTORY

