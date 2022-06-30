# linux-post-install
Set of notes to facilitate the post install process

## General
 - Add SSH keys to SSH Agent
```
# Fix SSH key permissions
sudo chown -R zaca:zaca ~/.ssh/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*

eval $(ssh-agent)
ssh-add ~/.ssh/{id_rsa,id_ed25519}
```

## Fedora

 - Enable the RPM Fusion Repository, AppStream Metadata and enable Multimedia Codecs
```
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate -y core
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
```

### Software

#### From RPMs
 - Telegram
 - Kee Pass XC
 - Inkscape
 - The Gimp
 - Gnome Extensions
 - Gutenprint CUPS
 - Foomatic

```
sudo dnf install -y telegram-desktop
sudo dnf install -y keepassxc
sudo dnf install -y inkscape
sudo dnf install -y gimp
sudo dnf install -y gnome-extensions-app
sudo dnf install -y gutenprint-cups
sudo dnf install -y foomatic
sudo dnf install -y crontabs
sudo dnf install -y rclone
```

#### From Flathub (🤮)
 - Element Desktop
 
```
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --enable flathub
sudo flatpak install flathub im.riot.Riot
```

### Fonts
```
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig fontforge
# Microsoft Windows Core fonts
sudo dnf install -y mscore-fonts-all
sudo dnf install -y sudo https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
# Microsoft ClearType Fonts
wget -q -O - https://gist.githubusercontent.com/Blastoise/72e10b8af5ca359772ee64b6dba33c91/raw/2d7ab3caa27faa61beca9fbf7d3aca6ce9a25916/clearType.sh | bash
# Tahoma and Segoe UI
wget -q -O - https://gist.githubusercontent.com/Blastoise/b74e06f739610c4a867cf94b27637a56/raw/96926e732a38d3da860624114990121d71c08ea1/tahoma.sh | bash
wget -q -O - https://gist.githubusercontent.com/Blastoise/64ba4acc55047a53b680c1b3072dd985/raw/6bdf69384da4783cc6dafcb51d281cb3ddcb7ca0/segoeUI.sh | bash
# Other essential fonts (MT Extra, Symbol, Windings...)
wget -q -O - https://gist.githubusercontent.com/Blastoise/d959d3196fb3937b36969013d96740e0/raw/429d8882b7c34e5dbd7b9cbc9d0079de5bd9e3aa/otherFonts.sh | bash
```

### LaTeX from TU Braunschweig
```
sudo dnf install -y texlive-scheme-full
sudo dnf install -y BibTool

```
 - Download the file from [here](https://www.tu-braunschweig.de/index.php?eID=dumpFile&t=f&f=116123&token=de986a15c2ede06cdc057c43fc20a539ed043265)
```
cd ~/Downloads/
tar -xvf tubslatex_installer_1.3.4.sh.tar
sh tubslatex_installer_1.3.4.sh

```
### Other Tools
```
sudo dnf copr enable -y kwizart/fedy
sudo dnf install -y fedy
sudo fedy -a colorprompt
```

## Gnome Extensions
 - https://extensions.gnome.org/extension/2890/tray-icons-reloaded/
 - https://extensions.gnome.org/extension/1653/tweaks-in-system-menu/
 
## Gnome Shortcuts
```
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Gnome Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Control><Alt>t'
```

## Set CloudStorage synchronization
TODO

## Tunning Bash
```
# Autocomplete
echo '' >> /etc/bash.bashrc
echo '# Autocompletar extra' >> /etc/bash.bashrc
echo 'if ! shopt -oq posix; then' >> /etc/bash.bashrc
echo '  if [ -f /usr/share/bash-completion/bash_completion ]; then' >> /etc/bash.bashrc
echo '    . /usr/share/bash-completion/bash_completion' >> /etc/bash.bashrc
echo '  elif [ -f /etc/bash_completion ]; then' >> /etc/bash.bashrc
echo '    . /etc/bash_completion' >> /etc/bash.bashrc
echo '  fi' >> /etc/bash.bashrc
echo 'fi' >> /etc/bash.bashrc

# Function to get BibTeX from DOI
echo '' >> ~/.bashrc
echo '# Get BibTex from DOI' >> ~/.bashrc
echo 'getdoi() {' >> ~/.bashrc
echo '    ENTRY=`/usr/bin/curl -s -L -H "Accept: text/bibliography; style=bibtex" -A "mailto:myemail@domain.com" https://doi.org/$1`' >> ~/.bashrc
echo '    echo $ENTRY' >> ~/.bashrc
echo '    echo "\n"' >> ~/.bashrc
echo '    echo $ENTRY | /usr/bin/bibtool' >> ~/.bashrc
echo '}' >> ~/.bashrc
echo '' >> ~/.bashrc
source .bashrc 
```
