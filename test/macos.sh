#!/bin/sh
touch ~/.zshrc

last_cli_entrypoint_tag=$(curl -s "https://api.github.com/repos/icaroland/cli-entrypoint/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -qP ~/icaro/cli https://github.com/icaroland/cli-entrypoint/releases/download/"${last_cli_entrypoint_tag}"/entrypoint.jar
ls
#sh src/unix/installer.sh

#icaro help
