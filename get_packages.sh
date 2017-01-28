#!/bin/bash
#
# get_packages.sh <directory to store files>
#
# Saves a list of all installed packages (w/ versions) to a text file in the directory passed in
# as first argument. Then checks to see if it differs from previous list and if it does not, removes
# the new list. 
#
# Requirements:
# Prime the directory with an initial list of installed packages (typically immediately after OS
# installation.
#
# Run nightly as a cronjob to have a package installation and removal history.

HIST_DIR=$1

# capture the latest installed packages
dpkg -l > $HIST_DIR/$HOSTNAME'_packages_'$(date +"%Y-%m-%d").txt

LAST_FILE=$(find $HIST_DIR -type f -name $HOSTNAME'_packages*' | sort | tail -n2 | head -n1)
NEW_FILE=$(find $HIST_DIR -type f -name $HOSTNAME'_packages*' | sort | tail -n1)

#echo $LAST_FILE
#echo $NEW_FILE

if diff $LAST_FILE $NEW_FILE >/dev/null ; then
	# files are the same, delete the new file
	rm $NEW_FILE
fi


