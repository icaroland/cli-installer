#!/bin/sh
echo ".zshrc file" >> ~/.zshrc
sh src/unix/installer.sh
. ~/.zshrc 
icaro help