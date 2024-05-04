# dot-files

## Linux dot-files

Config files for some linux tools:

- [Alacritty](https://github.com/alacritty/alacritty).
- [Bspwm](https://github.com/baskerville/bspwm).
- [Dunst](https://github.com/dunst-project/dunst).
- [Neofetch](https://github.com/dylanaraps/neofetch).
- [Picom](https://github.com/yshui/picom).
- [Polybar](https://github.com/polybar/polybar).
- [Rofi](https://github.com/davatorium/rofi).
- [Sxhkd](https://github.com/baskerville/sxhkd).
- [Zathura](https://github.com/pwmt/zathura).
- [Starship](https://starship.rs).

![Desktop_test](https://user-images.githubusercontent.com/79495707/156905282-c3616471-9595-4ab7-bd9b-60e62ad6006b.png)

**Note:** Only config files, install the tools on you own!

## **Warnings:**

**Some configuration files are not installed automatically, "custom scripts" directory and "Xresources, android-studio-config, mouse-speed and profile" files are not installed.**
* The file `mouse-speed` helps to control the speed of the cursor, the file `bspwmrc` already has this configuration and you can modify it with the respective `id` of your mouse, for this you just run `xinput` in your terminal and then replace with the respective `id`.
* `.Xresources` helps to decrease the scale factor of your screen, to use it just move the file to your `$HOME` directory or copy with:
```shell
cp linux/.Xresources $HOME
```
* `android-studio-config` fiel has some configurations to avoid errors ONLY in case of altering the scale factor, if you do not modify this property it is not necessary to use it. To use it, simply open Android Studio and manually add its contents under "Edit custom VM options...", it also works with other IntelliJ IDEs.

If you want to install all the config files add `--all` parameter with `launch.sh`, e.g.
```shell
./linux/launch.sh --all 
```

Otherwise, avoid `--all` parameter and choose only the ones you wanna install with your SPACE key.

## Notes

- If you have a previous config directory, the script will rename it to `folder-name.previous`, e.g. `polybar.previous`.
- Some directories have files with another configuration examples, e.g. polybar is vased on [polybar-themes](https://github.com/adi1090x/polybar-themes) and [blue-sky/polybar](https://github.com/VaughnValle/blue-sky/tree/master/polybar).
- If you are using two or more monitors, you can find a configuration for all your displays in `bspwmrc`, to check the names of the displays you have connected, use this command:
```shell
xrandr
```
## MAC dot-files

Config files for:
- [Alacritty](https://github.com/alacritty/alacritty).
- [Yabai](https://github.com/koekeishiya/yabai).
- [Skhd](https://github.com/koekeishiya/skhd).
- [Starship](https://starship.rs).

**Note:** Only config files, install the tools on you own!

To use them just move the folders to your `$HOME/.config` folder.
