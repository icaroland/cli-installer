#!/bin/sh

if ! command -v unzip >/dev/null; then
	echo "Error: unzip is required to install Icaro!"
	exit 1
fi

if ! command -v java >/dev/null; then
	echo "Error: java is required to install Icaro!"
	exit 1
fi

JAVA_V="$(java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1)" 

if [ "$JAVA_V" -lt 11 ]; then
   echo "Error: java should be at least of version 11 (current version: $JAVA_V)"
fi

rm -rf ~/icaro
mkdir ~/icaro

if [ "$(grep -rnw ~/.zshrc -e 'source ~/icaro/envs.sh > /dev/null' | wc -l)" -eq 0 ]; then
   printf "\nsource ~/icaro/envs.sh > /dev/null" >> ~/.zshrc
fi

wget -P ~/icaro https://raw.githubusercontent.com/icaroland/cli-installers/main/src/unix/envs.sh > /dev/null

mkdir -p ~/icaro/cli/entrypoint
mkdir -p ~/icaro/cli/core
mkdir -p ~/icaro/lang

last_cli_entrypoint_tag=$(curl "https://api.github.com/repos/icaroland/cli-entrypoint/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -P ~/icaro/cli/entrypoint https://github.com/icaroland/cli-entrypoint/releases/download/"${last_cli_entrypoint_tag}"/"${last_cli_entrypoint_tag}".jar > /dev/null

last_cli_core_tag=$(curl "https://api.github.com/repos/icaroland/cli-core/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -P ~/icaro/cli/core https://github.com/icaroland/cli-core/releases/download/"${last_cli_core_tag}"/"${last_cli_core_tag}".jar > /dev/null

last_lang_tag=$(curl "https://api.github.com/repos/icaroland/lang/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -P ~/icaro/cli/lang https://github.com/icaroland/lang/releases/download/"${last_lang_tag}"/"${last_lang_tag}".jar > /dev/null

$SHELL
. ~/.zshrc > /dev/null