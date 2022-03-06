# Linux dotfiles
Config files of some tools for linux.

- [Alacritty](https://github.com/alacritty/alacritty).
- [Bspwm](https://github.com/baskerville/bspwm).
- [Dunst](https://github.com/dunst-project/dunst).
- [Neofetch](https://github.com/dylanaraps/neofetch).
- [Picom](https://github.com/yshui/picom).
- [Polybar](https://github.com/polybar/polybar).
- [Rofi](https://github.com/davatorium/rofi).
- [Sxhkd](https://github.com/baskerville/sxhkd).
- [Zathura](https://github.com/pwmt/zathura).

**Note:** These are just the configuration files, for them to take effect you have to install the tools.

## **Warnings:**

**Some configuration files are not installed automatically, "custom scripts" directory and "Xresources, android-studio-config, mouse-speed and profile" files are not installed.**
* The file "mouse-speed" helps to control the speed of the cursor, the file bspwmrc already has this configuration and you can modify it with the respective "id" of your mouse, for this you just execute "xinput" in your terminal and then replace with the respective id.
* Xresources helps to decrease the scale factor of your screen, but you need to add the "profile" lines to the end of .profile in $HOME, and likewise Xresources should be a hidden file, for which you just need to add a period at the beginning of the name, ".Xresources".
* The file "android-studio-config" has some configurations to avoid errors ONLY in case of altering the scale factor, if you do not modify this property it is not necessary to use it. To use it, simply open Android Studio and manually add the contents of this file under "Edit custom VM options...", it also works with other IntelliJ development environments.

If you want to install all the config files add --all parameter with launch.sh, e.g. 
```
./launch.sh --all 
```

On the other hand, if you only want some files but not all of them, simply run launch.sh and select the options you want from the selection menu, for this use space bar.

```
./launch.sh
```

## Notes

- If you have a previous config directory, the script will rename with "currentname.previous", e.g. "polybar.previous".
- Some directories have files with another configuraction example, polybar for example is vased on [polybar-themes](https://github.com/adi1090x/polybar-themes) and [blue-sky/polybar](https://github.com/VaughnValle/blue-sky/tree/master/polybar).
- If you are using two or more monitors, you can find a configuration for all your displays in bspwmrc, to check the names of the displays you have connected, use this command:
``` 
xrandr
```
