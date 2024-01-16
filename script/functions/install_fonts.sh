#!/bin/bash

# install fonts
function install_fonts() {
    DST_DIR=$HOME/.local/share/fonts
    # install Meslo fonts
    mkdir -p ~/Downloads/Fonts && cd ~/Downloads/Fonts/
    curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.tar.xz
    tar -xf Meslo.tar.xz -C ./meslo
    sudo mv meslo $DST_DIR
    sudo chown -R $USER:$USER $DST_DIR/meslo
    sudo chmod 755 $DST_DIR/meslo
    sudo chmod 644 $DST_DIR/meslo/*.ttf 

    
}