#Duckshell v1.0
#Coded by @thelinuxchoice
#Github: https://github.com/thelinuxchoice/duckshell

banner() {

printf "\e[1;77m  _____             _     _____ _          _ _  \e[0m\n"
printf "\e[1;77m |  __ \           | |   / ____| |        | | | \e[0m\n"
printf "\e[1;77m | |  | |_   _  ___| | _| (___ | |__   ___| | | \e[0m\n"
printf "\e[1;77m | |  | | | | |/ __| |/ /\___ \| '_ \ / _ \ | | \e[0m\n"
printf "\e[1;77m | |__| | |_| | (__|   < ____) | | | |  __/ | | \e[0m\n"
printf "\e[1;77m |_____/ \__,_|\___|_|\_\_____/|_| |_|\___|_|_|v1.0 \e[0m\n"
printf "\n"
printf "\e[1;32m   .:.:. DuckDuckGo Instant Answer API .:.:.\e[0m\n"
printf "\e[1;93m           coded by @thelinuxchoice   \e[0m\n"
printf "\n"  

}


str="'$*'"
IFS=$'\n'
str1=$(echo $str)

if [[ $# -le 0 ]]; then
banner
printf "\e[1;92m[*] Usage:\e[0m\e[1;77m ./duckshell.sh <your search>\e[0m\n"
else

request=$(curl -s 'api.duckduckgo.com/?q='$str1'&no_html=1&format=json&pretty=1' > result)
IFS=$'\n'
abstract=$(grep -o '"AbstractText" : .*,' result | cut -d ":" -f2 | tr -d '"')
IFS=$'\n'
result=$(grep 'Result" : .*'  result | cut -d ">" -f 3 | cut -d '"' -f 1)
IFS=$'\n'
definition=$(grep 'Definition" : .*'  result | cut -d " " -f3 | cut -d "," -f1 | tr -d '"')
i=1

if [[ ! $definition = "" ]]; then
printf "%s\n" $definition > count00
count001=$(wc -l count00 | cut -d " " -f1)
i=1
while [[ $i -le $count001 ]]; do
sed_result00=$(sed -n ''$i','$i'p' count00)
printf "\e[1;92mDefinition%s:\e[0m\e[1;77m%s\e[0m\n" $i $sed_result00
let i++
done
rm -rf count00
fi

if [[ ! $abstract = " ," ]]; then
IFS=$'\n'
printf "%s\n" $abstract > count0
count01=$(wc -l count0 | cut -d " " -f1)
i=1
while [[ $i -le $count01 ]]; do
sed_result0=$(sed -n ''$i','$i'p' count0)
printf "\e[1;92mAbstract%s:\e[0m\e[1;77m%s\e[0m\n" $i $sed_result0
let i++
done
rm -rf count0
fi

if [[ ! $result = "" ]]; then

printf "%s\n" $result > count
count1=$(wc -l count | cut -d " " -f1)
i=1
while [[ $i -le $count1 ]]; do
sed_result=$(sed -n ''$i','$i'p' count)
printf "\e[1;92mResult%s:\e[0m\e[1;77m%s\e[0m\n" $i $sed_result
let i++
done
rm -rf count
fi
rm -rf result
fi

