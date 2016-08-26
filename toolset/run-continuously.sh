#!/bin/bash
#
# Sets up and runs the benchmarking suite
# in an infinite loop.  The intent is that 
# this script would be run by a watchdog
# like service, restarting if the scripts
# fail.
#
# The following environment variables must
# be set:
# $REPOPARENT should be set with the parent folder of the repository
# $REPONAME should be set with the name of the repository folder
#
# @author A. Shawn Bandy
#
${REPOPARENT:?Need path to parent of TFB repo}
${REPONAME:?Need name of repo folder}
${REPOURI:?Need to the URI used to clone the repo}
while true
do
  # Tear down the environment
  # Note: we tear down first so that we can
  # know the state of the environment regardless
  # of the outcome of prior runs.
  cp lifecycle/rebuild-environment.sh /tmp/ 
  cp $REPOPARENT/$REPONAME/benchmark.conf /tmp/
  lifecycle/tear-down-environment.sh
  # Rebuild environment
  /tmp/rebuild-environment.sh
  # Handle any preprocessing (e.g. send metadata)
  lifecycle/pre-run-tests.sh	
  # Run the benchmarks
  cd /private/FrameworkBenchmarks
  toolset/run-tests.py --mode verify --test gemini 
  # Handle any postprocessing
  lifecycle/post-run-tests.sh
  sleep 5
done
