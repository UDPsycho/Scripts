#!/usr/bin/env bash
#
# Script to verify and notify changes in your public IP address.
#
# by Psycho (@UDPsycho)
#   https://www.twitter.com/UDPsycho
#
# Dependencies: libnotify-bin (notify-send) & bind9-dnsutils (dig).
#

scripts_folder="$HOME/Scripts"
scripts_files="$scripts_folder/files"
iplog_file="$scripts_files/iplog.txt"

if [[ ! -d $scripts_folder ]]; then
  mkdir -p $scripts_files
  notify-send "Base directory \"$scripts_folder\" created succesfully, please run the script again."
  echo $(dig -4 +short myip.opendns.com @resolver1.opendns.com) > $iplog_file
  exit 0
fi


last_ip=$(tail -n 1 $iplog_file)
current_ip=$(dig -4 +short myip.opendns.com @resolver1.opendns.com)

if [[ $current_ip != $last_ip ]]; then
  notify-send "New public IP address detected." $current_ip
  echo $current_ip >> $iplog_file
else
  notify-send "No public IP address change detected."
fi
