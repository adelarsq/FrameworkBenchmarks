#!/bin/bash
#
# rebuild-environment.sh
#
# Rebuilds the benchmarking environment.
#
cd $REPOPARENT
git clone -b 45126-continuousbenchmarking-20160826-1-asb $REPOURI
cd $REPOPARENT/$REPONAME
