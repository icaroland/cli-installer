#!/bin/sh
echo ".zshrc file" >> ~/.zshrc
sh src/unix/installer.sh
. ~/.zshrc 
icaro help

# shellcheck disable=SC2039
source 
