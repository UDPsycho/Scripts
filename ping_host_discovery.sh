#!/usr/bin/env bash
#
# Script to perform ICMP type 8 (ping) requests to discover active hosts on the network.
#
# by Psycho (@UDPsycho)
#   https://www.twitter.com/UDPsycho
#
# Dependencies: inetutils-ping (ping) & grep.
#

if [[ $# -ne 1 ]]; then
  echo "  Usage:   $0 X[XX].X[XX].X[XX].X[-XX]"
  echo "  Example: $0 192.168.1.1-10"
  echo -e "\n  Note: The script only iterates over the last octet (/24 networks)."

else

  # Required for color output
  RED="\033[1;91m"
  GREEN="\033[1;92m"
  RESET="\033[0m"

  net=$(echo $1 | cut -d '.' -f 1,2,3)
  first_ip=$(echo $1 | cut -d '.' -f 4 | cut -d '-' -f 1)
  last_ip=$(echo $1 | cut -d '.' -f 4 | cut -d '-' -f 2)


  for i in $(seq $first_ip $last_ip)
    do
      target="$net.$i"
      echo -ne "$RED$target$RESET\r"

      if [[ -n $(ping -4 -c 1 -W 1 $target | grep -F from) ]]; then
        echo -e $GREEN$target$RESET;
      fi
    done

fi
