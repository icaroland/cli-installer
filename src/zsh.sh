#!/bin/sh

if [ -z "${ICARO_HOME}" ]; then
   printf "\n" >> .zshrc
   echo "export ICARO_HOME=\"~/icaro\""   
fi


mkdir -p ~/icaro/cli

if [ "$(find ~/icaro/cli | wc -l)" -eq 0 ]
then
   # shellcheck disable=SC2154
   lastTag=${curl "https://api.github.com/repos/icarolang/cli/releases/latest" | awk "FNR == 28 {print $2}" | tr -d '",'}
   wget -P ~/icaro/cli
   wget https://github.com/icarolang/cli/releases/download/"${lastTag}"/cli-"${lastTag}".jar

   printf "\n" >> .zshrc
   echo "alias icaro="java -jar ~/icaro/cli.jar"" >> .zshrc
 
   . ~/.zshrc
fi


mkdir -p ~/icaro/lang

if [ "$(find ~/icaro/lang | wc -l)" -eq 0 ]
then
   lastTag=${curl "https://api.github.com/repos/icarolang/lang/releases/latest" | awk "FNR == 28 {print $2}" | tr -d '",'}
   wget -P ~/icaro/lang
   wget https://github.com/icarolang/lang/releases/download/"${lastTag}"/lang-"${lastTag}".jar
fi