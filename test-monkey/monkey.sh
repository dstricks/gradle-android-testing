#!/bin/bash

ANDROIDPACKAGE=$1
REPORTROOT=$2
REPORTNAME=monkey-log.txt
CRASHSUMMARYNAME=monkey-crash-summary.txt

# remove old report files
echo "Removing old output report file..."
rm -f $REPORTROOT/$REPORTNAME
rm -f $REPORTROOT/$CRASHSUMMARYNAME

# run monkey on the package
echo "Running Monkey on $ANDROIDPACKAGE with 500 events..."
adb shell monkey -p $ANDROIDPACKAGE -v -v -v 500 > $REPORTROOT/$REPORTNAME

# create crash summary report, if necessary
echo "Running crash summary report..."
grep -A 5 -h CRASH $REPORTROOT/$REPORTNAME > $REPORTROOT/$CRASHSUMMARYNAME
if [ ! -s $REPORTROOT/$CRASHSUMMARYNAME ]
  then
    echo "No crashes detected"
    rm -f $REPORTROOT/$CRASHSUMMARYNAME
fi
