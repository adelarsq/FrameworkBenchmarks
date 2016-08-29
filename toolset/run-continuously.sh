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
while true
do
  # Tear down the environment
  # Note: we tear down first so that we can
  # know the state of the environment regardless
  # of the outcome of prior runs.
  echo Copying lifecycle files
  cp $REPOPARENT$REPONAME/toolset/lifecycle/*.sh /tmp/ 
  cp $REPOPARENT$REPONAME/benchmark.cfg /tmp/
  echo ls of /tmp
  ls /tmp
  echo Tearing down previous environment
  /tmp/tear-down-environment.sh
  # Rebuild environment
  echo Returning bencharmk configuration file
  cp /tmp/benchmark.cfg $REPOPARENT$REPONAME/
  ls $REPOPARENT$REPONAME
  echo Rebuilding environment
  /tmp/rebuild-environment.sh
  # Handle any preprocessing (e.g. send metadata)
  echo Running pre-test tasks
  tmp/pre-run-tests.sh	
  # Run the benchmarks
  echo Change to benchmark root
  cd /private/FrameworkBenchmarks
  echo Run tests
  toolset/run-tests.py --mode verify --test gemini 
  # Handle any postprocessing
  echo Running post-test tasks
  /tmp/post-run-tests.sh
  sleep 5
done
