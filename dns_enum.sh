user=$USER
day=$(date +%A) #Command subtitution
domain=$2
file=$2

function main() {
  echo -e "\n\nWelcom $user ! Today is $day.\nYou are using $SHELL shell for script exicution."
  echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo -e "+ If Domain name in file eg : ./DNS_enume_with_if.sh F file_name.txt +"
  echo -e "+ If Domain name in Direct eg : ./DNS_enume_with_if.sh D domain_name +"
  echo -e "+ For HELP                 eg : ./DNS_enume_with_if.sh H             +"
  echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n"
}
function opt() {
  echo -e "\n\n  1 : CHECK IPv4"
  echo -e "  2 : CHECK IPv6"
  echo -e "  3 : CHECK CNAME"
  echo -e "  4 : CHECK Mail Server"
  echo -e "  5 : CHECK TEXT"
  echo -e "  6 : CHECK ALL"
  echo -e "  7 : EXIT"
  read -p "  Select one option : " opt
  echo $opt
}
function ipv4_file() {
  while read domain; do
    echo -e "\nDNS ENUMERATION OF " $domain
    echo "________________________"
    echo -e "\n IPv4 record of " $domain
    echo "________________________"
    dig $domain A +short
  done < $file
}

function case_stat() {
  case $opt in
    1 )
    read -p "Enter Domain Name : " domain
    ipv4=$(dig $domain A +short)
      echo -e "IPv4 of $domain is\e[31m $ipv4\e[0m";;
    2 )
    read -p "Enter Domain Name : " domain
    ipv6=$(dig $domain AAAA +short)
      echo -e "IPv6 of $domain is\e[31m $ipv6\e[0m";;
    3 )
    read -p "Enter Domain Name : " domain
    cname=$(dig $domain CNAME +short)
    if [[ -z $cname ]]; then
      echo -e "CNAME of $domain is:\n\e[31m EMPTY!\e[0m"
    else
        echo -e "CNAME of $domain is:\n\e[31m $cname\e[0m"
    fi;;
    4 )
    read -p "Enter Domain Name : " domain
    mx=$(dig $domain MX +short)
      echo -e "Mail Server of $domain is:\n\e[31m $mx\e[0m";;
    5 )
    read -p "Enter Domain Name : " domain
    txt=$(dig $domain TXT +short)
      echo -e "TEXT of $domain is:\n\e[31m $txt\e[0m";;
    6 )
    read -p "Enter Domain Name : " domain
    dns_enum;;
    7 )
    exit 0
     ;;
  esac
}
function help() {
  echo -e "\n\n  HELP"
  echo -e "================\n"
  echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo -e "+ If Domain name in file eg : ./DNS_enume_with_if.sh F file_name.txt +"
  echo -e "+ If Domain name in Direct eg : ./DNS_enume_with_if.sh D domain_name +"
  echo -e "+ For HELP                 eg : ./DNS_enume_with_if.sh H             +"
  echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n\n"
}
function dns_enum()
{
  for rec in A AAAA CNAME MX TXT ; do
    echo -e "\n $rec record of " $domain
    echo "________________________"
    dig $domain $rec +short
  done
}

file_enum(){
  while read domain; do
    echo -e "\nDNS ENUMERATION OF " $domain
    echo "________________________"
    for rec in A AAAA CNAME MX TXT ; do
      echo -e "\n $rec record of " $domain
      echo "________________________"
      dig $domain $rec +short
    done
    echo -e "\n+++++++++++++++++++++$domain compleated+++++++++++++++++++++\n"
  done < $file
}
if [[ -z $1 ]]; then
  main
  opt
  case_stat
elif [[ $1 == D ]]; then
  main
  dns_enum
elif [[ $1 == F ]]; then
  main
  file_enum
elif [[ $1 == H ]]; then
  help
else
  echo -e "\n\e[31mArgument are incorrect type\e[0m \n ./DNS_enume_with_if.sh H\n\n"
fi
