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

# Fix YouTube videos not playing
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia --allowerasing
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
# sudo dnf install -y telegram-desktop
sudo dnf install -y flameshot
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
### Next Cloud dependency
```
sudo dnf install -y qqc2-desktop-style
```

### From Extra Official Repositories

 - Fedy

```
sudo dnf copr enable -y kwizart/fedy
sudo dnf install -y fedy
```

 - App Image Launcher
```
sudo dnf install -y https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
```

 - VS Codium
```
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo dnf install codium
```
 - VSCode Extensions
```
code --install-extension alefragnani.project-manager
code --install-extension DotJoshJohnson.xml
code --install-extension James-Yu.latex-workshop
code --install-extension Pivotal.vscode-boot-dev-pack
code --install-extension Pivotal.vscode-spring-boot
code --install-extension redhat.java
code --install-extension vscjava.vscode-java-debug
code --install-extension vscjava.vscode-java-dependency
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-java-test
code --install-extension vscjava.vscode-maven
code --install-extension vscjava.vscode-spring-boot-dashboard
code --install-extension vscjava.vscode-spring-initializr
```

### From Flathub (🤮)
 - Element Desktop
 
```
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remote-modify --enable flathub
sudo flatpak install flathub im.riot.Riot
```
#### Make Element autostart (because the software is so good that cannot manage a text file...)
```
cp /var/lib/flatpak/exports/share/applications/im.riot.Riot.desktop ~/.config/autostart/
```

### R and R-Studio
```bash
sudo dnf install R R-devel rstudio rstudio-desktop
```

### Fonts

#### Fancy font from Google (Similar to SanFrancisco)
```
sudo dnf install http://bootes.ethz.ch/fonts/rpm/fonts-inter-1.0-1.noarch.rpm
```

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
mkdir -p ~/.config/fontconfig/conf.d
cat > ~/.config/fontconfig/conf.d/20-no-embedded.conf << EOL
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
  <match target="font">
    <edit name="embeddedbitmap" mode="assign">
      <bool>false</bool>
    </edit>
  </match>
</fontconfig>
EOL
```

#### ‼️‼️ Optional (Replace Cambria and Calibri by Caladea and Carlito)

- Cambria
```
mkdir -p ~/.config/fontconfig/conf.d
cat > ~/.config/fontconfig/conf.d/30-0-google-carlito-fonts.conf << EOL
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
  <fontconfig>
    <!-- Microsoft -->
    <alias binding="same">
      <family>Cambria</family>
      <accept>
        <family>Caladea</family>
      </accept>
    </alias>
    <alias binding="same">
      <family>Caladea</family>
      <default>
        <family>Cambria</family>
      </default>
    </alias>
  </fontconfig>
EOL
```

- Calibri
```
mkdir -p ~/.config/fontconfig/conf.d
cat > ~/.config/fontconfig/conf.d/30-0-google-caladea-fonts.conf << EOL
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
  <fontconfig>
    <!-- Microsoft -->
    <alias binding="same">
      <family>Calibri</family>
      <accept>
        <family>Carlito</family>
      </accept>
    </alias>
    <alias binding="same">
      <family>Carlito</family>
      <default>
        <family>Calibri</family>
      </default>
    </alias>
  </fontconfig>
EOL
```

### Samba
Installing Samba to use a shared folder for the printer / scanner.

#### Installing Samba
```
sudo dnf install samba
FWZONE=`firewall-cmd --get-active-zones | head -n 1`
sudo firewall-cmd --permanent --zone=$FWZONE --add-service=samba
sudo firewall-cmd --reload
```

#### Sharing a folder
```
sudo smbpasswd -a $USER
mkdir -v -p ~/Public
sudo semanage fcontext --add --type "samba_share_t" "/home/zaca/Public(/.*)?"
sudo restorecon -R ~/Public
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.old

cat << EOF | sudo tee -a /etc/samba/smb.conf
[global]
        workgroup = SAMBA
        security = user
        passdb backend = tdbsam
        printing = cups
        printcap name = cups
        load printers = yes
        cups options = raw

[public]
        comment = Public
        path = /home/zaca/Public
        writeable = yes
        browseable = yes
        public = yes
        create mask = 0644
        directory mask = 0755
        write list = user

EOF
sudo systemctl restart smb
```


### LaTeX from TU Braunschweig
LaTeX classes from TU Braunschweig
```
sudo dnf install -y texlive-scheme-full
sudo dnf install -y BibTool
sudo dnf install texlive-base texlive-extra \
     texlive-collection-fontsextra texlive-collection-fontsrecommended \
     texlive-collection-genericrecommended texlive-collection-langgerman \
     texlive-collection-fontutils texlive-cm-super
```

 - Download the file from [here](https://www.tu-braunschweig.de/index.php?eID=dumpFile&t=f&f=116123&token=de986a15c2ede06cdc057c43fc20a539ed043265)
 - Install the LaTeX classes
```
cd ~/Downloads/
tar -xvf tubslatex_installer_1.3.4.sh.tar
sh tubslatex_installer_1.3.4.sh
```

# Install Flutter (Optional)

## Install dependencies
```
sudo dnf install -y clang cmake ninja-build gtk3-devel zlib.i686 ncurses-libs.i686 bzip2-libs.i686
```

### Android Studio
```
# firefox https://developer.android.com/studio
cd ~/Downloads
tar -xzvf android-studio-2022.3.1.19-linux.tar.gz
sudo mv android-studio /opt/
cd /opt/android-studio/bin/
./studio.sh
# Accept and install the suggested components
```

## Download Flutter
```
mkdir -p ~/Downloads/flutter && cd ~/Downloads/flutter 
wget -c https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.13.1-stable.tar.xz
cd ~/devel
tar -xf ~/Downloads/flutter/flutter_linux_3.13.1-stable.tar.xz
```

## Configure PATH for Flutter and set Chrome executable
```
cat << EOF > ~/.bashrc.d/flutter.conf
# Setting the path to Flutter executable
export PATH="$PATH:/home/zaca/devel/flutter/bin"

# Configure Chromium as default browser for Flutter Web
export CHROME_EXECUTABLE=/usr/bin/chromium-browser
EOF

source $HOME/.bashrc
```

## Initial setup
```
flutter precache
flutter --disable-telemetry # Optional
```
## Accept Android licenses
```
flutter doctor --android-licenses
```

## Check dependencies with Flutter doctor
```
flutter doctor
```
