#!/bin/bash
#
# tear-down-environment.sh
#
# Tears down the benchmark environment in preparation for another
# run.
#
# @author A. Shawn Bandy
#
# $REPOPARENT should be set with the parent folder of the repository
# $REPONAME should be set with the name of the repository folder
sudo rm -r -f $REPOPARENT/$REPONAME
cd $REPOPARENT
