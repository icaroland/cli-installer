#!/bin/sh

if [ -d ~/icaro ]
then
   printf '\nExistent Icaro installations detected! (~/icaro)'
   printf '\n\nThe ~/icaro folder will be deleted and than created again'
   printf '\n\nDo you want to proceed anyway (y/n)?'

   read -r answer
   
   if [ "$answer" = "n" ]; then
      exit 0
   fi
fi

rm -rf ~/icaro
mkdir ~/icaro

mkdir -p ~/icaro/cli/entrypoint
mkdir -p ~/icaro/cli/core
mkdir -p ~/icaro/lang

if [ "$(grep -rnw ~/.zshrc -e 'source ~/icaro/envs.sh 2> /dev/null' | wc -l)" -eq 0 ]; then
   printf "\nsource ~/icaro/envs.sh 2> /dev/null" >> ~/.zshrc
fi

wget -P ~/icaro https://raw.githubusercontent.com/icaroland/cli-installers/main/src/envs.sh

last_cli_entrypoint_tag=$(curl "https://api.github.com/repos/cli-entrypoint/cli/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -P ~/icaro/cli/entrypoint https://github.com/icaroland/cli-entrypoint/releases/download/"${last_cli_entrypoint_tag}"/"${last_cli_entrypoint_tag}".jar 2> /dev/null

$SHELL
. ~/.zshrc 2> /dev/null

last_cli_core_tag=$(curl "https://api.github.com/repos/cli-core/cli/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -P ~/icaro/cli/core https://github.com/icaroland/cli-core/releases/download/"${last_cli_core_tag}"/"${last_cli_core_tag}".jar 2> /dev/null