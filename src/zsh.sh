#!/bin/sh

if [ -z "${ICARO_HOME}" ]; then
   printf "\n" >> ~/.zshrc
   echo "export ICARO_HOME=\"~/icaro\"" >> ~/.zshrc
fi


mkdir -p ~/icaro/cli

if [ "$(find ~/icaro/cli | wc -l)" -eq 1 ]
then
   # shellcheck disable=SC2154
   lastTag=${curl "https://api.github.com/repos/icarolang/cli/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//}
   wget -P ~/icaro/cli https://github.com/icarolang/cli/releases/download/"${lastTag}"/cli-"${lastTag}".jar

   printf "\n" >> ~/.zshrc
   echo "alias icaro="java -jar ~/icaro/cli.jar"" >> ~/.zshrc
 
   . ~/.zshrc
fi


mkdir -p ~/icaro/lang

if [ "$(find ~/icaro/lang | wc -l)" -eq 1 ]
then
   lastTag=${curl "https://api.github.com/repos/icarolang/lang/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//}
   wget -P ~/icaro/lang https://github.com/icarolang/lang/releases/download/"${lastTag}"/lang-"${lastTag}".jar
fi