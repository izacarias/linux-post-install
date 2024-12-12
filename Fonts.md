# Installing Meslo Fonts

```
mkdir -p ~/Downloads/Fonts && cd ~/Downloads/Fonts/
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.tar.xz
tar -xf Meslo.tar.xz -C ./meslo
sudo mv meslo /usr/share/fonts/
sudo chown -R root:root /usr/share/fonts/meslo
sudo chmod 755 /usr/share/fonts/meslo
sudo chmod 644 /usr/share/fonts/meslo/*.ttf 
```

# Installing Google Fonts
```
_url="https://github.com/google/fonts/archive/master.tar.gz"
_fonts="google-fonts"

echo "Downloading fonts..."
wget $_url -O $_fonts.tar.gz

echo "Extracting the archive..."
tar -xf $_fonts.tar.gz

echo "Creating the /usr/share/fonts/truetype/$_fonts folder"
sudo mkdir -p /usr/share/fonts/truetype/$_fonts

echo "Installing all .ttf fonts in /usr/share/fonts/truetype/$_fonts"
find $PWD/fonts-main/ -name "*.ttf" -exec sudo install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1

echo "Updating the font cache"
fc-cache -f > /dev/null
rm -f $_fonts.tar.gz
echo "Done"
```

# Installing Microsoft Fonts

## Pre-requirements
```
sudo dnf install -y curl cabextract xorg-x11-font-utils fontconfig fontforge
```
## Microsoft Windows Core fonts
```
sudo dnf install -y mscore-fonts-all
sudo dnf install -y sudo https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
```
## Microsoft ClearType Fonts
```
wget -q -O - https://gist.githubusercontent.com/Blastoise/72e10b8af5ca359772ee64b6dba33c91/raw/2d7ab3caa27faa61beca9fbf7d3aca6ce9a25916/clearType.sh | bash
```
## Tahoma and Segoe UI
```
wget -q -O - https://gist.githubusercontent.com/Blastoise/b74e06f739610c4a867cf94b27637a56/raw/96926e732a38d3da860624114990121d71c08ea1/tahoma.sh | bash
wget -q -O - https://gist.githubusercontent.com/Blastoise/64ba4acc55047a53b680c1b3072dd985/raw/6bdf69384da4783cc6dafcb51d281cb3ddcb7ca0/segoeUI.sh | bash
```
## Other essential fonts (MT Extra, Symbol, Windings...)
```
wget -q -O - https://gist.githubusercontent.com/Blastoise/d959d3196fb3937b36969013d96740e0/raw/429d8882b7c34e5dbd7b9cbc9d0079de5bd9e3aa/otherFonts.sh | bash
```
## Fixing bad rendering of Bitmap fonts
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
## ‼️‼️ Optional (Replace Cambria and Calibri by Caladea and Carlito)
### Cambria
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
### Calibri
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



