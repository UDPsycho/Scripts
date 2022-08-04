#!/usr/bin/env bash
#
# Script to translate the selected text using keyboard shortcuts (remember to add the shortcut manually).
#
# Dependencies: libnotify-bin (notify-send), zenity, xsel, wget, sed & 'awk'.
#

from="en"
to="es"

# v1 w/notify-send (english/spanish)
translate_text_v1() {
  notify-send --icon=info "$(xsel -o)" "$(wget -U "Mozilla/5.0" -qO - "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=t&q=$(xsel -o | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2}')"
}

# v2 w/notify-send (only spanish)
translate_text_v2() {
  notify-send --icon=info "$(wget -U "Mozilla/5.0" -qO - "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=t&q=$(xsel -o | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2}')"
}

# v3 w/zenity (english/spanish)
translate_text_v3() {
  original=$(xsel -o)
  translated=$(wget -U "Mozilla/5.0" -q -O - "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=t&q=$(echo $original | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2}')
  cat /dev/null > /tmp/notitrans
  echo -e "English: $original\n" >> /tmp/notitrans
  echo -e "Spanish: $translated" >> /tmp/notitrans
  zenity --text-info --title="Translation" --filename=/tmp/notitrans
}

# v4 w/zenity (only spanish)
translate_text_v4() {
  original=$(xsel -o)
  translated=$(wget --user-agent "Mozilla/5.0" --quiet --output-document - "https://translate.googleapis.com/translate_a/single?client=gtx&sl=$from&tl=$to&dt=t&q=$(echo $original | sed "s/[\"'<>]//g")" | sed "s/,,,0]],,.*//g" | awk -F'"' '{print $2}')
  echo $translated > /tmp/notitrans
  zenity --text-info --title="Translation" --filename=/tmp/notitrans
}


translate_text_v4
