#!/bin/sh
wget -qP https://github.com/icaroland/cli-installer/releases/latest/download/cli-installer.jar
java -jar cli-installer.jar
rm cli-installer.jar
. ~/.zshrc 2>/dev/null
icaro help