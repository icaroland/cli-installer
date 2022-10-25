#!/bin/sh

if [ "$(grep -rnw ~/.zshrc -e 'export ICARO_HOME' | wc -l)" -eq 0 ]; then
   printf "\n" >> ~/.zshrc
   echo "export ICARO_HOME=\"~/icaro\"" >> ~/.zshrc
fi


if [ "$(grep -rnw ~/.zshrc -e 'alias icaro' | wc -l)" -eq 0 ]; then
   printf "\n" >> ~/.zshrc
   echo "alias icaro=\"java -jar ~/icaro/cli/cli-${last_tag}.jar\"" >> ~/.zshrc
fi


mkdir -p ~/icaro/cli

if [ "$(find ~/icaro/cli | wc -l)" -eq 1 ]
then
   last_tag=$(curl "https://api.github.com/repos/icarolang/cli/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
   wget -P ~/icaro/cli https://github.com/icarolang/cli/releases/download/"${last_tag}"/cli-"${last_tag}".jar
fi


mkdir -p ~/icaro/lang

if [ "$(find ~/icaro/lang | wc -l)" -eq 1 ]
then
   last_tag=$(curl "https://api.github.com/repos/icarolang/lang/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
   wget -P ~/icaro/lang https://github.com/icarolang/lang/releases/download/"${last_tag}"/lang-"${last_tag}".jar
fi

. ~/.zshrc 2> /dev/null