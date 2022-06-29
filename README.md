# linux-post-install
Set of notes to facilitate the post install process

## Fedora

 - Enable the RPM Fusion Repository, AppStream Metadata and enable Multimedia Codecs
```
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate -y core
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
```

## Software

### From RPMs
 - Telegram
 - Kee Pass XC
 - Inkscape
 - The Gimp

```
sudo dnf install -y telegram-desktop
sudo dnf install -y keepassxc
sudo dnf install -y inkscape
sudo dnf install -y gimp
```

### From Flathub (🤮)
 - Element Desktop
 
```
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --enable flathub
sudo flatpak install flathub im.riot.Riot
```

## Gnome Extensions
