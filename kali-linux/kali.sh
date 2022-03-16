#!/bin/bash

# Custom Variables:
cleverecho="/bin/echo -e -n"

# Kali custom install script

setup() {
    sudo apt update
    sudo apt install kali-win-kex -y

}

full-install() {

    sudo apt update
    sudo apt install -y kali-linux-large
}

windows() {
    kex --esm --ip 
}

code-insiders() {
        # Installs code-insiders
            sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https  -y
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
            echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
            rm microsoft.gpg
            sudo apt update
            sudo apt install -y code-insiders
            return 0;
}

code() {
        # Installs code
            sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https -y
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
            echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
            sudo apt update
            sudo apt install -y code
            rm microsoft.gpg
            return 0;
}

gh() {
    # Installs gh
        VERSION=`curl  "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-` 
        echo $VERSION
        curl -sSL https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz -o gh_${VERSION}_linux_amd64.tar.gz
        tar xvf gh_${VERSION}_linux_amd64.tar.gz
        sudo cp gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/

    # tidy up of files
        rm gh_${VERSION}_linux_amd64.tar.gz
        rm -rf gh_${VERSION}_linux_amd64
        sudo apt update
        sudo apt install -y git
        return 0
}

swap-setup() {
    sudo fallocate -l 5G   /mnt/Roaming/swap/swapfile-5G.swp    
    sudo fallocate -l 10G  /mnt/Roaming/swap/swapfile-10G.swp    
    sudo fallocate -l 50G  /mnt/Roaming/swap/swapfile-50G.swp
    sudo fallocate -l 100G /mnt/Roaming/swap/swapfile-100G.swp
    sudo chown root.root /mnt/Roaming/swap/* && sudo chmod 600 /mnt/Roaming/swap/*
    sudo mkswap /mnt/Roaming/swap/swapfile-5G.swp
    sudo mkswap /mnt/Roaming/swap/swapfile-10G.swp
    sudo mkswap /mnt/Roaming/swap/swapfile-50G.swp
    sudo mkswap /mnt/Roaming/swap/swapfile-100G.swp     
}

swap-on() {
    sudo swapon /swap/swapfile-5G.swp
    sudo swapon /swap/swapfile-10G.swp
    sudo swapon /swap/swapfile-50G.swp
    sudo swapon /swap/swapfile-100G.swp 
}

swap-off() {
    sudo swapoff /swap/swapfile-5G.swp
    sudo swapoff /swap/swapfile-10G.swp
    sudo swapoff /swap/swapfile-50G.swp
    sudo swapoff /swap/swapfile-100G.swp 
}

help() {
    $cleverecho "Help System:\n"
    $cleverecho "\n"
    $cleverecho "\t $0 windows          - Launchs Windows Interface\n"
    $cleverecho "\t $0 full-install     - Fully Installs Kali Linux\n"
    $cleverecho "\n"
    $cleverecho "\t $0 custom-apps list - Lists all custom apps supported\n"
    $cleverecho "\n"

}


custom-apps-list() {
    $cleverecho "Supported Apps:\n"
    $cleverecho "\n"
    $cleverecho "\t gh\n"
    $cleverecho "\t git\n"
    $cleverecho "\n"
    $cleverecho "\t code\n"
    $cleverecho "\t code-insiders\n"
    $cleverecho "\n"

}

export() {
cat <<EOF > ~/bin/kali-local
#!/bin/bash

# Custom Variables:
cleverecho="/bin/echo -e -n"

# Kali custom install script

full-install() {

    sudo apt update
    sudo apt install -y kali-linux-large
}

windows() {
    kex --esm --ip 
}


code-insiders() {
        # Installs code-insiders
            sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https  -y
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
            echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
            rm microsoft.gpg
            sudo apt update
            sudo apt install -y code-insiders
            return 0;
}

code() {
        # Installs code
            sudo apt install curl gpg gnupg2 software-properties-common apt-transport-https -y
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg && sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
            echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
            sudo apt update
            sudo apt install -y code
            rm microsoft.gpg
            return 0;
}

gh() {
    # Installs gh
        VERSION=`curl  "https://api.github.com/repos/cli/cli/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c2-` 
        echo $VERSION
        curl -sSL https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_amd64.tar.gz -o gh_${VERSION}_linux_amd64.tar.gz
        tar xvf gh_${VERSION}_linux_amd64.tar.gz
        sudo cp gh_${VERSION}_linux_amd64/bin/gh /usr/local/bin/

    # tidy up of files
        rm gh_${VERSION}_linux_amd64.tar.gz
        rm -rf gh_${VERSION}_linux_amd64
        sudo apt update
        sudo apt install -y git
        return 0
}

swap-setup() {
    sudo fallocate -l 5G   /swap/swapfile-5G.swp    
    sudo fallocate -l 10G  /swap/swapfile-10G.swp    
    sudo fallocate -l 50G  /swap/swapfile-50G.swp
    sudo fallocate -l 100G /swap/swapfile-100G.swp
    sudo chmod 600 /swap/*
    sudo mkswap /swap/swapfile-5G.swp
    sudo mkswap /swap/swapfile-10G.swp
    sudo mkswap /swap/swapfile-50G.swp
    sudo mkswap /swap/swapfile-100G.swp
}
swap-on() {
    sudo swapon /swap/swapfile-5G.swp
    sudo swapon /swap/swapfile-10G.swp
    sudo swapon /swap/swapfile-50G.swp
    sudo swapon /swap/swapfile-100G.swp
}

swap-off() {
    sudo swapoff /swap/swapfile-5G.swp
    sudo swapoff /swap/swapfile-10G.swp
    sudo swapoff /swap/swapfile-50G.swp
    sudo swapoff /swap/swapfile-100G.swp
}

help() {
    $cleverecho "Help System:\n"
    $cleverecho "\n"
    $cleverecho "\t $0 windows          - Launchs Windows Interface\n"
    $cleverecho "\t $0 full-install     - Fully Installs Kali Linux\n"
    $cleverecho "\n"
    $cleverecho "\t $0 custom-apps list - Lists all custom apps supported\n"
    $cleverecho "\n"

}


custom-apps-list() {
    $cleverecho "Supported Apps:\n"
    $cleverecho "\n"
    $cleverecho "\t gh\n"
    $cleverecho "\t git\n"
    $cleverecho "\n"
    $cleverecho "\t code\n"
    $cleverecho "\t code-insiders\n"
    $cleverecho "\n"

}

# Default Options

    if [ "$1" = "" ];                           then help;          fi
    if [ "$1" = "export" ];                     then export;        fi
    if [ "$1" = "windows" ]; 	                then windows;		fi
    if [ "$1" = "full-install" ]; 	            then full-install;	fi


# Swap Management Support

    if [[ "$1" = "swap" && "$2" = "setup" ]];	then swap-setup;	fi
    if [[ "$1" = "swap" && "$2" = "on" ]];	    then swap-on;	    fi
    if [[ "$1" = "swap" && "$2" = "off" ]];	    then swap-off;	    fi

# Custom Apps support

    if [[ "$1" = "custom-apps" && "$2" = "code-insiders" ]];	then code-insiders;	    fi  
    if [[ "$1" = "custom-apps" && "$2" = "list" ]];	            then custom-apps-list;	fi  
    if [[ "$1" = "custom-apps" && "$2" = "code" ]];	            then code;	            fi
    if [[ "$1" = "custom-apps" && "$2" = "gh" ]];	            then gh;	            fi

}
EOF
}

# Default Options

    if [ "$1" = "" ];                           then help;          fi
    if [ "$1" = "export" ];                     then export;        fi
    if [ "$1" = "windows" ]; 	                then windows;		fi
    if [ "$1" = "full-install" ]; 	            then full-install;	fi


# Swap Management Support

    if [[ "$1" = "swap" && "$2" = "setup" ]];	then swap-setup;	fi
    if [[ "$1" = "swap" && "$2" = "on" ]];	    then swap-on;	    fi
    if [[ "$1" = "swap" && "$2" = "off" ]];	    then swap-off;	    fi

# Custom Apps support

    if [[ "$1" = "custom-apps" && "$2" = "code-insiders" ]];	then code-insiders;	    fi  
    if [[ "$1" = "custom-apps" && "$2" = "list" ]];	            then custom-apps-list;	fi  
    if [[ "$1" = "custom-apps" && "$2" = "code" ]];	            then code;	            fi
    if [[ "$1" = "custom-apps" && "$2" = "gh" ]];	            then gh;	            fi
