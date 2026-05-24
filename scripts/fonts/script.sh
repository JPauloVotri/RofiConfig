#!/bin/bash

fontes=$(fc-list -f '%{family}\n' :lang=pt | sort -u | sed 's/^.*,//g' | awk '!seen[$0]++')  # Limita a 100 fontes
dir="$HOME/.config/rofi/scripts/fonts"
theme='theme'

lista=""
while IFS= read -r fonte; do
    if [ -n "$lista" ]; then
        lista+="\n"
    fi

    lista+="<span font='$fonte 14'>$fonte</span>"
done <<< "$fontes"

# Exibe no Rofi com suporte a Pango markup
escolha=$(echo -e "$lista" | rofi -hover-select -me-select-entry '' -no-config \
                                  -me-accept-entry MousePrimary -dmenu \
                                  -markup-rows -i -theme ${dir}/${theme}.rasi)

# Extrai o nome da fonte (remove tags HTML)
fonte_limpa=$(echo "$escolha" | sed 's/<[^>]*>//g')

if [ -n "$fonte_limpa" ]; then
    echo -n "$fonte_limpa" | wl-copy
    notify-send "Fonte copiada" "$fonte_limpa"
fi