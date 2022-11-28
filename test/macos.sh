#!/bin/sh
echo ".zshrc file" >> ~/.zshrc
cat ~/.zshrc
sh src/unix/installer.sh
source ~/.zshrc 
icaro help
