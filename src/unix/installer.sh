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
   exit 1
fi

printf "starting to install Icaro! \n"

rm -rf ~/icaro
mkdir ~/icaro

if [ "$(grep -rnw ~/.zshrc -e 'source ~/icaro/envs.sh 2>/dev/null' | wc -l)" -eq 0 ]; then
   printf "\nsource ~/icaro/envs.sh 2>/dev/null" >> ~/.zshrc
fi

wget -qP ~/icaro https://raw.githubusercontent.com/icaroland/cli-installers/main/src/unix/envs.sh

mkdir -p ~/icaro/cli/core
mkdir -p ~/icaro/lang

last_cli_entrypoint_tag=$(curl -s "https://api.github.com/repos/icaroland/cli-entrypoint/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -qP ~/icaro/cli https://github.com/icaroland/cli-entrypoint/releases/download/"${last_cli_entrypoint_tag}"/"${last_cli_entrypoint_tag}".jar

last_cli_core_tag=$(curl -s "https://api.github.com/repos/icaroland/cli-core/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -qP ~/icaro/cli/core https://github.com/icaroland/cli-core/releases/download/"${last_cli_core_tag}"/"${last_cli_core_tag}".jar
printf "cli %s version installed! \n" "$last_cli_core_tag"

last_lang_tag=$(curl -s "https://api.github.com/repos/icaroland/lang/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -qP ~/icaro/cli/lang https://github.com/icaroland/lang/releases/download/"${last_lang_tag}"/"${last_lang_tag}".jar
printf "lang %s version installed! \n" "$last_lang_tag"

$SHELL
. ~/.zshrc 2>/dev/null