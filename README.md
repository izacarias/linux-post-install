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

## Java

### OpenJDK
```
cd ~/Downloads
wget -c https://download.java.net/java/GA/jdk19/877d6127e982470ba2a7faa31cc93d04/36/GPL/openjdk-19_linux-x64_bin.tar.gz
sudo tar -xzvf openjdk-19_linux-x64_bin.tar.gz -C /opt
sudo ln -s /opt/jdk-19 /opt/java
```

### Maven
```
cd ~/Downloads
wget -c https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
sudo tar -xzvf apache-maven-3.8.6-bin.tar.gz -C /opt
sudo ln -s /opt/apache-maven-3.8.6 /opt/maven
```

## GO
```
cd ~/Downloads/
wget -c https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
sudo tar -xzvf go1.19.2.linux-amd64.tar.gz -C /opt
```

## Gurobi
```
cd ~/Downloads
wget -c https://packages.gurobi.com/9.5/gurobi9.5.2_linux64.tar.gz
sudo tar -xzvf gurobi9.5.2_linux64.tar.gz -C /opt
sudo ln -s /opt/gurobi952 /opt/gurobi
sudo chcon -t textrel_shlib_t /opt/gurobi/linux64/lib/libgurobi95.so
```
To test the installation, simply type `gurobi.sh`.

## Distro Specific Notes

 - [Fedora](Fedora.md)
