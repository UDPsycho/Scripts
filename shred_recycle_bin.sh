#!/usr/bin/env bash
#
# Script to delete (shred) files in a safe way.
#
# by Psycho (@UDPsycho)
#   https://www.twitter.com/UDPsycho
#
# Dependencies: libnotify-bin (notify-send).
#

recycle_bin_folder="$HOME/Escritorio/Trash"

if [[ ! -d $recycle_bin_folder ]]; then
  mkdir -p $recycle_bin_folder
  notify-send "Base directory \"$recycle_bin_folder\" created succesfully, please run the script again."
  exit 0
fi


cd $recycle_bin_folder
echo -e "Trying to shred files...\n"

# Shred only files with extension
shred -n 24 -fuzv *.*

# Shred all the files (no directories)
#shred -n 24 -fuzv *

echo -e "\nShredding finished."
