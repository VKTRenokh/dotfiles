## Hyprland

![Screenshot of my desktop](./assets/screenshot-hyprland-1.png)
![Screenshot of my desktop](./assets/screenshot-hyprland-2.png)

## Sway (old)

![Screenshot of my desktop](./assets/screenshot-1.png)
![Screenshot of my desktop](./assets/screenshot-2.png)
![Screenshot of my desktop](./assets/screenshot-3.png)
![Screenshot of my desktop](./assets/screenshot-4.png)
![Screenshot of my desktop](./assets/screenshot-5.png)

## Artix Optimisations

https://gist.github.com/themagicalmammal/37276c97897d40598e975f5e563252a6

## Packages

Install all needed packages

```bash
sudo pacman -S --needed hyprland waybar dunst neovim helix lua lxappearance artix-dark-theme tmux kitty \
                        pipewire pipewire-pulse wireplumber xdg-desktop-portal-hyprland brightnessctl wpa_supplicant \
                        noto-fonts-cjk noto-fonts-emoji noto-fonts ripgrep fzy fzf zsh hyprpicker
```

Aur Packages

```bash
paru -S wofi gitmux bibata-cursor-theme swww playerctl brave exa hyprshade grimblast \
        waypaper nerd-fonts-cozette-ttf
```

Starship

```bash
curl -sS https://starship.rs/install.sh | sh
```

Eza

```bash
git clone https://github.com/eza-community/eza.git
cd eza
cargo install --path .
```

## Fonts

- Victor Mono NFM
- Iosevka Mono NFM

## Bootloader Theme

https://github.com/catppuccin/grub

## Firmware

- [qmk](https://github.com/vktrenokh/qmk_firmware)
