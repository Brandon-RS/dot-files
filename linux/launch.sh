#!/bin/bash

DIR=$(pwd)

ALACRITTY_DIR="$HOME/.config/alacritty"
BSPWM_DIR="$HOME/.config/bspwm"
DUNST_DIR="$HOME/.config/dunst"
FONTS_DIR="$HOME/.local/share/fonts"
NEOFETCH_DIR="$HOME/.config/neofetch"
PICOM_DIR="$HOME/.config/picom"
POLYBAR_DIR="$HOME/.config/polybar"
REDSHIFT_DIR="$HOME/.config/redshift"
ROFI_DIR="$HOME/.config/rofi"
SXHKD_DIR="$HOME/.config/sxhkd"
ZATHURA_DIR="$HOME/.config/zathura"

install_fonts() {
  echo -e "\n[*] Installing fonts ..."

  if [[ -d "$FONTS_DIR" ]]; then
    cp -rf $DIR/fonts/* "$FONTS_DIR"
  else
    mkdir -p "$FONTS_DIR"
    cp -rf $DIR/fonts/* "$FONTS_DIR"
  fi
}

install_dotfile() {
  if [[ -d "$1" ]]; then
    echo -e "[*] Creating a backup of your $2 configs..."
    mv "$1" "$1.previous"

    mkdir -p "$1"
    cp -rf $DIR/$2/* "$1"
  else
    mkdir -p "$1"
    cp -rf $DIR/$2/* "$1"
  fi
}

main() {
  clear

  OPTIONS_VALUES=("ALACRITTY" "BSPWM" "DUNST" "NEOFETCH" "PICOM" "POLYBAR" "REDSHIFT" "ROFI" "SXHKD" "ZATHURA")

  VARS=($ALACRITTY_DIR $BSPWM_DIR $DUNST_DIR $NEOFETCH_DIR $PICOM_DIR $POLYBAR_DIR $REDSHIFT_DIR $ROFI_DIR $SXHKD_DIR $ZATHURA_DIR)
  dirs=(alacritty bspwm dunst neofetch picom polybar redshift rofi sxhkd zathura)

  if [[ $1 == '--all' ]]; then
    echo -e 'Installing all files\n'
    install_fonts
    # install_dotfile $ALACRITTY_DIR alacritty

    for i in "${!VARS[@]}"; do
      install_dotfile ${VARS[$i]} ${dirs[$i]}
      echo "${OPTIONS_VALUES[$i]} config file installed :)"
    done
    echo "Done ..."

  else
    # from SO: https://stackoverflow.com/a/54261882/317605 (by https://stackoverflow.com/users/8207842/dols3m)

    function prompt_for_multiselect {

      ESC=$(printf "\033")
      cursor_blink_on() { printf "$ESC[?25h"; }
      cursor_blink_off() { printf "$ESC[?25l"; }
      cursor_to() { printf "$ESC[$1;${2:-1}H"; }
      print_inactive() { printf "$2   $1 "; }
      print_active() { printf "$2  $ESC[7m $1 $ESC[27m"; }
      get_cursor_row() {
        IFS=';' read -sdR -p $'\E[6n' ROW COL
        echo ${ROW#*[}
      }
      key_input() {
        local key
        IFS= read -rsn1 key 2>/dev/null >&2
        if [[ $key = "" ]]; then echo enter; fi
        if [[ $key = $'\x20' ]]; then echo space; fi
        if [[ $key = $'\x1b' ]]; then
          read -rsn2 key
          if [[ $key = [A ]]; then echo up; fi
          if [[ $key = [B ]]; then echo down; fi
        fi
      }
      toggle_option() {
        local arr_name=$1
        eval "local arr=(\"\${${arr_name}[@]}\")"
        local option=$2
        if [[ ${arr[option]} == true ]]; then
          arr[option]=
        else
          arr[option]=true
        fi
        eval $arr_name='("${arr[@]}")'
      }

      local retval=$1
      local options
      local defaults

      IFS=';' read -r -a options <<<"$2"
      if [[ -z $3 ]]; then
        defaults=()
      else
        IFS=';' read -r -a defaults <<<"$3"
      fi
      local selected=()

      for ((i = 0; i < ${#options[@]}; i++)); do
        selected+=("${defaults[i]}")
        printf "\n"
      done

      # determine current screen position for overwriting the options
      local lastrow=$(get_cursor_row)
      local startrow=$(($lastrow - ${#options[@]}))

      # ensure cursor and input echoing back on upon a ctrl+c during read -s
      trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
      cursor_blink_off

      local active=0
      while true; do
        # print options by overwriting the last lines
        local idx=0
        for option in "${options[@]}"; do
          local prefix="[ ]"
          if [[ ${selected[idx]} == true ]]; then
            prefix="[x]"
          fi

          cursor_to $(($startrow + $idx))
          if [ $idx -eq $active ]; then
            print_active "$option" "$prefix"
          else
            print_inactive "$option" "$prefix"
          fi
          ((idx++))
        done

        # user key control
        case $(key_input) in
        space) toggle_option selected $active ;;
        enter) break ;;
        up)
          ((active--))
          if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi
          ;;
        down)
          ((active++))
          if [ $active -ge ${#options[@]} ]; then active=0; fi
          ;;
        esac
      done

      # cursor position back to normal
      cursor_to $lastrow
      printf "\n"
      cursor_blink_on

      eval $retval='("${selected[@]}")'
    }

    for i in "${!OPTIONS_VALUES[@]}"; do
      OPTIONS_STRING+="${OPTIONS_VALUES[$i]} (::);"
    done

    prompt_for_multiselect SELECTED "$OPTIONS_STRING"

    for i in "${!SELECTED[@]}"; do
      if [ "${SELECTED[$i]}" == "true" ]; then
        install_dotfile ${VARS[$i]} ${dirs[$i]}

        if [[ ${VARS[$i]} == $POLYBAR_DIR ]]; then
          install_fonts
        fi

        echo "${OPTIONS_VALUES[$i]} config file installed :)"
      fi
    done

  fi

}

main $1
