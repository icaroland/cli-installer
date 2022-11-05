#!/bin/sh  

export ICARO_HOME="$HOME/icaro"
alias icaro="java -jar ~/icaro/cli/entrypoint.jar"

icaro deps-check