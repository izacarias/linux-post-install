# Fedora

## Enable faster donwloads with `dnf`
```
# Improving DNF donwload performance
echo '' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf
```
 
## Enable the RPM Fusion Repository, AppStream Metadata and enable Multimedia Codecs
```
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf groupupdate -y core
sudo dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
```

## Software
List of softwares usually installed in my computer

### From RPMs
 - Telegram
 - Kee Pass XC
 - Inkscape
 - The Gimp
 - Gnome Extensions
 - Gutenprint CUPS
 - Foomatic
 - Crontab
 - RClone
 - VIM Editor
 
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
sudo dnf install -y vim-X11
```

### From Extra Official Repositories

 - Fedy

```
sudo dnf copr enable -y kwizart/fedy
sudo dnf install -y fedy
```

### From Flathub (🤮)
 - Element Desktop
 
```
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --enable flathub
sudo flatpak install flathub im.riot.Riot
```

### Fonts

 - Required Packages
```
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig fontforge
```

 - Microsoft Windows Core fonts
```
sudo dnf install -y mscore-fonts-all
sudo dnf install -y sudo https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
```

 - Microsoft ClearType Fonts
 ```
wget -q -O - https://gist.githubusercontent.com/Blastoise/72e10b8af5ca359772ee64b6dba33c91/raw/2d7ab3caa27faa61beca9fbf7d3aca6ce9a25916/clearType.sh | bash
```

 - Tahoma and Segoe UI
```
wget -q -O - https://gist.githubusercontent.com/Blastoise/b74e06f739610c4a867cf94b27637a56/raw/96926e732a38d3da860624114990121d71c08ea1/tahoma.sh | bash
wget -q -O - https://gist.githubusercontent.com/Blastoise/64ba4acc55047a53b680c1b3072dd985/raw/6bdf69384da4783cc6dafcb51d281cb3ddcb7ca0/segoeUI.sh | bash
```

 - Other essential fonts (MT Extra, Symbol, Windings...)
```
wget -q -O - https://gist.githubusercontent.com/Blastoise/d959d3196fb3937b36969013d96740e0/raw/429d8882b7c34e5dbd7b9cbc9d0079de5bd9e3aa/otherFonts.sh | bash
```

 - Fixing bad rendering of Bitmap fonts
```
mkdir -p ~/.config/fontconfig
cat > ~/.config/fontconfig/fonts.conf << EOL
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="font">
    <edit name="embeddedbitmap" mode="assign">
      <bool>false</bool>
    </edit>
  </match>
</fontconfig>
EOL
```

### LaTeX from TU Braunschweig
LaTeX classes from TU Braunschweig
```
sudo dnf install -y texlive-scheme-full
sudo dnf install -y BibTool
```

 - Download the file from [here](https://www.tu-braunschweig.de/index.php?eID=dumpFile&t=f&f=116123&token=de986a15c2ede06cdc057c43fc20a539ed043265)
 - Install the LaTeX classes
```
cd ~/Downloads/
tar -xvf tubslatex_installer_1.3.4.sh.tar
sh tubslatex_installer_1.3.4.sh
```
