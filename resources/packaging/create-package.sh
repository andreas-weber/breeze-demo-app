#!/bin/sh
# This shell script creates an installable package.
# ------------------------------------------------------------------
# Syntax:
#   $0 package-name package-base-dir package-destination
# ------------------------------------------------------------------
# Purpose:
#   Manage the package creation for installable software packages.
# ------------------------------------------------------------------

if [ $(dpkg-query -W -f='${Status}' dpkg 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
        echo "Debian Package Manager [dpkg] not found.";
        exit 1;
fi

if [ -z ${1+x} ];
    then
        echo "No package name as argument given.";
        exit 1;
fi

if [ -z ${2+x} ];
    then
        echo "No package base dir as argument given.";
        exit 1;
fi

if [ -z ${3+x} ];
    then
        echo "No package destination as argument given.";
        exit 1;
fi

PACKAGE_NAME=$1;
PACKAGE_BASE_DIR=$2;
PACKAGE_DESTINATION=$3;
PACKAGE_TMP_DIR=/tmp/$PACKAGE_NAME;

echo "Packaging";
echo "---------------------------------------------------";
echo "Package Name:           '$PACKAGE_NAME'";
echo "Package Base Directory: '$PACKAGE_BASE_DIR'";
echo "Package Destination:    '$PACKAGE_DESTINATION'";
echo "Package Tmp Directory:  '$PACKAGE_TMP_DIR'";
echo "---------------------------------------------------";

# remove tmp directory, if exists
if [ -d $PACKAGE_TMP_DIR ]; then
    echo "Removing old tmp directory: '$PACKAGE_TMP_DIR'";
    rm -rf $PACKAGE_TMP_DIR;
fi

# create clean tmp directory
echo "Creating clean tmp directory: '$PACKAGE_TMP_DIR'";
mkdir -p $PACKAGE_TMP_DIR;

# prepare files
echo "Creating '$PACKAGE_TMP_DIR/opt/$PACKAGE_NAME'";
mkdir -p $PACKAGE_TMP_DIR/opt/$PACKAGE_NAME;
echo "Copying files '$PACKAGE_BASE_DIR/resources/packaging/base/*' to '$PACKAGE_TMP_DIR'";
cp -R $PACKAGE_BASE_DIR/resources/packaging/base/* $PACKAGE_TMP_DIR;
echo "Copying files '$PACKAGE_BASE_DIR/*' to '$PACKAGE_TMP_DIR/opt/$PACKAGE_NAME'";
cp -R $PACKAGE_BASE_DIR/* $PACKAGE_TMP_DIR/opt/$PACKAGE_NAME;

# adjust ownerships
# fakeroot chown -R breeze:breeze $PACKAGE_TMP_DIR
# fakeroot chown -R nobody:nobody $PACKAGE_TMP_DIR/web

# building package
dpkg --build $PACKAGE_TMP_DIR $PACKAGE_DESTINATION

echo "Package creation successful!";

# exit
exit 0;
