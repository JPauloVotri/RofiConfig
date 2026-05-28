#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Screenshot

# Import Current Theme
theme="$HOME/.config/rofi/scripts/screenshot/theme.rasi"

dir="$HOME/Imagens/Screenshots"
prompt='Captura de Tela'

list_col='3'
list_row='1'
win_width='400px'

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1="󰍹 Capture Desktop"
	option_2="󰆞 Capture Area"
	option_3=" Capture Window"
else
	option_1="󰍹"
	option_2="󰆞"
	option_3=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-hover-select -me-select-entry '' -me-accept-entry MousePrimary -dmenu \
		-p "$prompt" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
}

# take shots
shotnow () {
  hyprshot -m output -o ${dir}
}

shotwin () {
  hyprshot -m window -o ${dir}
}

shotarea () {
  hyprshot -m region -o ${dir}
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
esac
