# Prerequisites

You'll need a nerd font. My config files use ComicShanns by default because it is my favourite.

Some packages will be needed in order for things to function properly
```bash
sudo apt install -y gcc stow zsh git i3 alacritty qt5ct \
    qt6ct feh rofi polybar tmux neovim picom fzf zoxide \
    lsd bat fd-find

# I use the following from a fresh arch installation, btw
sudo pacman -S xorg xorg-xinit mesa gcc stow zsh git i3 \
    alacritty qt5ct qt6ct feh rofi polybar tmux neovim picom fzf \
    zoxide lightdm lightdm-gtk-greeter otf-comicshanns-nerd \
    lsd bat
# Some more basics
sudo pacman -S \
  pulseaudio pulseaudio-alsa pavucontrol \
  networkmanager network-manager-applet \
  firefox-esr \
  thunar
```

Install Starship:
```bash
curl -sS https://starship.rs/install.sh | sh
```
