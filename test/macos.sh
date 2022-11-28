#!/bin/sh
echo ".zshrc file" >> ~/.zshrc
cat ~/.zshrc
sh src/unix/installer.sh
. ~/.zshrc 
icaro help
