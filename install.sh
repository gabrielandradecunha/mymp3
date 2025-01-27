#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "O script deve ser executado com privilégios de super usuário!"
    exit 1
fi

APP_NAME=mymp3

if command -v git >/dev/null 2>&1; then
    echo "O Git está instalado!"
else
    PACKAGE_MANAGER=""
    INSTALL_CMD=""
    CONFIGS=""
    
    function install() {
        eval $CONFIGS
        eval $INSTALL_CMD
    }
    
    if command -v apt >/dev/null; then
        PACKAGE_MANAGER="apt"
        INSTALL_CMD="sudo apt-get install -y git"
        CONFIGS="sudo apt update"
    
    elif command -v dnf >/dev/null; then
        PACKAGE_MANAGER="dnf"
        INSTALL_CMD="sudo dnf install -y git"
        CONFIGS="sudo dnf install -y dnf-plugins-core"
    
    elif command -v yum >/dev/null; then
        PACKAGE_MANAGER="yum"
        INSTALL_CMD="sudo yum install -y git"
        CONFIGS="sudo yum install -y yum-utils"
    
    elif command -v pacman >/dev/null; then
        PACKAGE_MANAGER="pacman"
        INSTALL_CMD="sudo pacman -S --noconfirm git"
        CONFIGS="sudo pacman -Sy"
    
    elif command -v zypper >/dev/null; then
        PACKAGE_MANAGER="zypper"
        INSTALL_CMD="sudo zypper install -y git"
        CONFIGS="sudo zypper refresh"
    
    else
        echo "Gerenciador de pacotes desconhecido!"
        exit 1
    fi
    
    echo "Instalando o Git com o gerenciador de pacotes $PACKAGE_MANAGER"
    install
fi

git clone https://github.com/gabrielandradecunha/$APP_NAME
cd $APP_NAME/ || exit 1

if command -v docker >/dev/null 2>&1; then
    echo "Docker está instalado!"
else
    if [ ! -f "docker_install.sh" ]; then
        echo "O script de instalação do Docker (docker_install.sh) não foi encontrado!"
        exit 1
    fi
    sudo chmod +x docker_install.sh
    sudo ./docker_install.sh
fi

docker rm -f $APP_NAME || true
docker rmi -f $APP_NAME || true
docker build -t $APP_NAME .
docker run -d -p 8080:80 --name $APP_NAME $APP_NAME
