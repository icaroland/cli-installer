#!/bin/sh

if ! command -v java >/dev/null; then
	echo "Error: java 11+ is required to install Icaro!"
	exit 1
fi

if [ "$(javap -verbose java.lang.String | grep "major version" | cut -d " " -f5)" -lt 55 ]; then
   echo "Error: the java version in use should be 11+"
   exit 1
fi

printf "starting to install Icaro! \n"

rm -rf ~/icaro
mkdir ~/icaro

if [ "$(grep -rnw ~/.zshrc -e 'source ~/icaro/envs.sh 2>/dev/null' | wc -l)" -eq 0 ]; then
   printf "\nsource ~/icaro/envs.sh 2>/dev/null" >> ~/.zshrc
fi

wget -qP ~/icaro https://raw.githubusercontent.com/icaroland/cli-installer/main/src/unix/envs.sh

mkdir -p ~/icaro/cli/core
mkdir -p ~/icaro/lang

last_cli_entrypoint_tag=$(curl -s "https://api.github.com/repos/icaroland/cli-entrypoint/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -qP ~/icaro/cli https://github.com/icaroland/cli-entrypoint/releases/download/"${last_cli_entrypoint_tag}"/entrypoint.jar
printf "cli-entrypoint %s installed! \n" "$last_cli_entrypoint_tag"

last_cli_core_tag=$(curl -s "https://api.github.com/repos/icaroland/cli-core/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -qP ~/icaro/cli/core https://github.com/icaroland/cli-core/releases/download/"${last_cli_core_tag}"/"${last_cli_core_tag}".jar
printf "cli-core %s installed! \n" "$last_cli_core_tag"

last_lang_tag=$(curl -s "https://api.github.com/repos/icaroland/lang/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
wget -qP ~/icaro/lang https://github.com/icaroland/lang/releases/download/"${last_lang_tag}"/"${last_lang_tag}".jar
printf "lang %s installed! \n" "$last_lang_tag"

$SHELL
. ~/.zshrc 2>/dev/null