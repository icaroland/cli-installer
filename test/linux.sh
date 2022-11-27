#!/bin/sh

java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1

#if [ "$(sh src/unix/installer.sh)" != "Error: java should be at least of version 11 (current version: 8)" ]; then
#   echo "test failed"
#   exit 1  
#fi
