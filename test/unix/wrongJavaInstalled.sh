#!/bin/sh

if [ "$(sh ../../src/unix/installer.sh)" != "Error: java should be at least of version 11 (current version: 10)" ]; then
   echo "test failed"
   exit 1  
fi
