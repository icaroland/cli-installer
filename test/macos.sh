#!/bin/sh
touch ~/.zshrc
#sh src/unix/installer.sh

curl -s "https://api.github.com/repos/icaroland/cli-entrypoint/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//

icaro help
