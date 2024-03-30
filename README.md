# Installation

1. 
```bash
cd ~
git clone https://github.com/aramis-matos/dotfiles.git
stow .
```
2. Download rofi themes and change their font
```bash
git clone https://github.com/adi1090x/rofi.git
cd ~/.config/rofi/launchers/type-X/shared/
vim fonts.rasi
```

```
/**
 *
 * Author : Aditya Shakya (adi1090x)
 * Github : @adi1090x
 * 
 * Fonts
 *
 **/

* {
    font: "Cousine Nerd Font 12";
}
```
3. If you get a syntax error in `.config/rofi/config.rasi`, go to line 54 and delete `run,`

4. 
- If NixOS, run `sudo cp -rf ~/dotfiles/nixos /etc/`
- To update `sudo nixos-rebuild switch --flake /etc/nixos#default`

