# Post Install Procedures
Set of notes to facilitate the post install process

## General

### Add SSH keys to SSH Agent
```
# Fix SSH key permissions
sudo chown -R zaca:zaca ~/.ssh/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*

eval $(ssh-agent)
ssh-add ~/.ssh/{id_rsa,id_ed25519}
```

### Coloring the shell prompt
```
cat <<EOF | sudo tee /etc/profile.d/color_prompt.sh > /dev/null 2>&1
# Colors in Terminal (Bash)
if [[ ! -z \$BASH ]]; then
    if [[ \$EUID -eq 0 ]]; then
        PS1="\[\033[33m\][\[\033[m\]\[\033[31m\]\u@\h\[\033[m\] \[\033[33m\]\W\[\033[m\]\[\033[33m\]]\[\033[m\] # "
    else
        PS1="\[\033[36m\][\[\033[m\]\[\033[34m\]\u@\h\[\033[m\] \[\033[32m\]\W\[\033[m\]\[\033[36m\]]\[\033[m\] \$ "
    fi
fi
EOF
```

### Gnome Extensions
 - [Tray Icons Reloaded](https://extensions.gnome.org/extension/2890/tray-icons-reloaded/)
 - [Tweaks in System Menu](https://extensions.gnome.org/extension/1653/tweaks-in-system-menu/)
 - [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
 - [UI Improvements](https://extensions.gnome.org/extension/4158/gnome-40-ui-improvements/)
 - [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)
 - [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)
 
### Gnome Shortcuts
```
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Gnome Terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Control><Alt>t'
```

### Tunning Bash
```
# Autocomplete
echo '' >> /etc/bash.bashrc
echo '# Extra autocomplete' >> /etc/bash.bashrc
echo 'if ! shopt -oq posix; then' >> /etc/bash.bashrc
echo '  if [ -f /usr/share/bash-completion/bash_completion ]; then' >> /etc/bash.bashrc
echo '    . /usr/share/bash-completion/bash_completion' >> /etc/bash.bashrc
echo '  elif [ -f /etc/bash_completion ]; then' >> /etc/bash.bashrc
echo '    . /etc/bash_completion' >> /etc/bash.bashrc
echo '  fi' >> /etc/bash.bashrc
echo 'fi' >> /etc/bash.bashrc

# Function to get BibTeX from DOI
echo '' >> ~/.bashrc.d/getdoi.conf
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

### Installing Meslo Fonts
```
mkdir -p ~/Downloads/Fonts && cd ~/Downloads/Fonts/
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.tar.xz
tar -xf Meslo.tar.xz -C ./meslo
sudo mv meslo /usr/share/fonts/
sudo chown -R root:root /usr/share/fonts/meslo
sudo chmod 755 /usr/share/fonts/meslo
sudo chmod 644 /usr/share/fonts/meslo/*.ttf 
```

## Java

### OpenJDK
```
URL=https://download.java.net/java/GA/jdk20.0.1/b4887098932d415489976708ad6d1a4b/9/GPL/openjdk-20.0.1_linux-x64_bin.tar.gz
FILENAME=jdk-last.tar.gz
mkdir -p ~/Downloads/software && cd ~/Downloads/software
wget -c $URL -O jdk-last.tar.gz
sudo tar -xzvf $FILENAME -C /opt
sudo ln -s /opt/jdk-20.0.1 /opt/java
```
#### Update alternatives to include new Java package
```
sudo alternatives --install /usr/bin/java java /opt/jdk-20.0.1/bin/java 0
sudo alternatives --config java
# Select the new JAVA alternative to be used as default java version
```

### Maven
```
cd ~/Downloads/software
URL=https://dlcdn.apache.org/maven/maven-3/3.9.4/source/apache-maven-3.9.4-src.tar.gz
wget -c $URL -O maven-last.tar.gz
sudo tar -xzvf maven-last.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.8.6 /opt/maven
```

## GO
```
cd ~/Downloads/software
wget -c https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
sudo tar -xzvf go1.19.2.linux-amd64.tar.gz -C /opt
```

## Gurobi
```
cd ~/Downloads/software
wget -c https://packages.gurobi.com/10.0/gurobi10.0.2_linux64.tar.gz -O gurobi-last.tar.gz
sudo tar -xzvf gurobi-last.tar.gz -C /opt
sudo ln -s /opt/gurobi952 /opt/gurobi
sudo chcon -t textrel_shlib_t /opt/gurobi/linux64/lib/libgurobi95.so
```
To test the installation, simply type `gurobi.sh`.

## Distro Specific Notes

 - [Fedora](Fedora.md)
