#!/bin/sh

if [ -d ~/icaro ]
then
   printf 'Existent Icaro installations are detected (~/icaro folder)'
   printf '\n\nIf you keep going with this installation, the ~/icaro folder will be deleted and than recreated'
   printf '\n\nDo you want to proceed anyway (y/n)? '

   read -r answer
   
   if [ "$answer" = "n" ]; then
      exit 0
   fi
fi

rm -rf ~/icaro
mkdir ~/icaro

last_cli_tag=$(curl "https://api.github.com/repos/icarolang/cli/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)
last_lang_tag=$(curl "https://api.github.com/repos/icarolang/lang/tags" | awk "FNR == 3 {print $3}" | tr -d ' :",' | sed s/"name"//)

if [ "$(grep -rnw ~/.zshrc -e 'source ~/icaro/envs.sh 2> /dev/null' | wc -l)" -eq 0 ]; then
   printf "\nsource ~/icaro/envs.sh 2> /dev/null" >> ~/.zshrc
fi

{
  printf "#!/bin/bash\n"
  printf "\nexport ICARO_LANG_JAR=\"%s/icaro/lang/%s.jar\"" "$HOME" "$last_lang_tag"
  printf "\nalias icaro=\"java -jar ~/icaro/cli/%s.jar\"" "$last_cli_tag"
} >> ~/icaro/envs.sh

mkdir -p ~/icaro/cli
wget -P ~/icaro/cli https://github.com/icarolang/cli/releases/download/"${last_cli_tag}"/"${last_cli_tag}".jar 2> /dev/null

mkdir -p ~/icaro/lang
wget -P ~/icaro/lang https://github.com/icarolang/lang/releases/download/"${last_lang_tag}"/"${last_lang_tag}".jar 2> /dev/null

$SHELL
. ~/.zshrc 2> /dev/null