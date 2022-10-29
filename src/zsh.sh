#!/bin/sh

if [ "$(find ~/icaro | wc -l)" -ne 1 ]
then
   printf 'Existent Icaro installations are detected (~/icaro folder)'
   printf 'If you keep going with this installation, the ~/icaro folder will be deleted and than re-recreated'
   printf 'Do you want to proceed anyway (y/n)? '

   read -r answer
   
   if [ "$answer" = "no" ]; then
      exit 0
   fi
fi

rm -rf ~/icaro
sed 's/#ICARO LANGUAGE ENVs BEGIN.*ICARO LANGUAGE ENVs FINISH://'

last_cli_tag=$(curl "https://api.github.com/repos/icarolang/cli/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
last_lang_tag=$(curl "https://api.github.com/repos/icarolang/lang/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)

{
  printf "\n#ICARO LANGUAGE ENVs BEGIN"
  printf "\n#IF YOU WANT TO USE ICARO DO NOT DELETE THIS SECTION"
  printf "\n\nexport ICARO_CLI_VERSION=\"%s\"" "$last_cli_tag"
  printf "\nexport ICARO_LANG_VERSION=\"%s\"" "$last_lang_tag"
  printf "\nexport ICARO_LANG_JAR=\"~/icaro/lang/lang-%s.jar\"" "$last_lang_tag"
  printf "\nalias icaro=\"java -jar ~/icaro/cli/cli-%s.jar\"" "$last_cli_tag"
  printf "\n#ICARO LANGUAGE ENVs FINISH"
} >> ~/.zshrc

mkdir -p ~/icaro/cli
wget -P ~/icaro/cli https://github.com/icarolang/cli/releases/download/"${last_cli_tag}"/cli-"${last_cli_tag}".jar

mkdir -p ~/icaro/lang
wget -P ~/icaro/lang https://github.com/icarolang/lang/releases/download/"${last_lang_tag}"/lang-"${last_lang_tag}".jar

$SHELL
. ~/.zshrc 2> /dev/null