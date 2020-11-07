#!/bin/zsh

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ core ------------------------
echo "Setting up core"

# timezone
ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc

# Localization
sed -i 's/#de_AT.UTF-8 UTF-8/de_AT.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen

locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

# Network config
echo "${hostname}" > /etc/hostname

echo "" >> /etc/hosts
echo "127.0.0.1  localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1	${hostname}.localdomain	${hostname}" >> /etc/hosts

# base packages
pacman -S --noconfirm b43-fwcutter broadcom-wl crda darkhttpd ddrescue dhclient dialog dnsutils elinks ethtool exfat-utils f2fs-tools fsarchiver hdparm ipw2100-fw ipw2200-fw irssi iwd lftp lsscsi mc mtools ndisc6 nfs-utils nilfs-utils nmap ntp openconnect openvpn partclone partimage pptpclient rp-pppoe sdparm sg3_utils tcpdump testdisk usb_modeswitch vpnc wireless-regdb wireless_tools wvdial xl2tpd man

# some important stuff
pacman -S --noconfirm xorg-server fakeroot xdg-user-dirs sudo pkg-config wget ntfs-3g pacman-contrib

# networkmanager
pacman -S --noconfirm networkmanager
systemctl enable NetworkManager

# colorful output
sed -i 's/#Color/Color/g' /etc/pacman.conf

# activate multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# grant su permissions to wheel group
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

pacman -Syyu --noconfirm

# zsh
pacman -S --noconfirm zsh zsh-completions

# terminal
pacman -S --noconfirm youtube-dl ripgrep fzf rsync parallel ranger unrar htop arch-audit android-tools jq bat exa hyperfine tokei reflector sd

# xD
pacman -S --noconfirm cmatrix lolcat neofetch sl

# development
pacman -S --noconfirm git make gcc neovim nodejs npm python-pynvim xclip

# ssh
pacman -S --noconfirm openssh

# pacman hooks
mkdir -p /etc/pacman.d/hooks/
cp ./pacman-hooks/grub.hook /etc/pacman.d/hooks/grub.hook
cp ./pacman-hooks/cleanup.hook /etc/pacman.d/hooks/cleanup.hook
ln -s /usr/share/arch-audit/arch-audit.hook /etc/pacman.d/hooks/arch-audit.hook

# nvim
mkdir -p /home/$user/.config/nvim
mkdir -p /home/$user/.local/share/nvim/site/autoload
cp ./dotfiles/vimrc /home/$user/.config/nvim/init.vim
curl -fLo /home/$user/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh
cp ./dotfiles/starship.toml /home/$user/.starship.toml
cp ./dotfiles/zshrc /home/$user/.zshrc
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/$user/.oh-my-zsh
curl -fsSL https://starship.rs/install.sh -y | bash

# ssh
mkdir -p /home/$user/.config/systemd/user
cp ./systemd-units/ssh-agent.service /home/$user/.config/systemd/user/ssh-agent.service
echo 'SSH_AUTH_SOCK DEFAULT="${XDG_RUNTIME_DIR}/ssh-agent.socket"' >> /home/$user/.pam_environment

# add user and set groups
useradd -M $user
chown -R $user:$user /home/$user
usermod -d /home/$user $user
usermod -aG wheel $user
usermod --shell /usr/bin/zsh $user

localectl set-keymap de

# set password
echo "$user:$password" | chpasswd
echo "root:$password" | chpasswd

# ------------------------ AUR ------------------------

# setup

cd /
mkdir /home/aurBuilder
chgrp nobody /home/aurBuilder
chmod g+ws /home/aurBuilder
setfacl -m u::rwx,g::rwx /home/aurBuilder
setfacl -d --set u::rwx,g::rwx,o::- /home/aurBuilder
usermod -d /home/aurBuilder nobody
echo '%nobody ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
cd /home/aurBuilder

# install packages

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'paru-bin'
  'cava'
  'tty-clock'
  'ddgr'
)

declare -r aur_packages
IFS=$SAVEIFS

for package in "${aur_packages[@]}"
do
  git clone https://aur.archlinux.org/$package.git
  chmod -R g+w $package
  cd $package
  sudo -u nobody makepkg -sri --noconfirm
  cd ..
done

# cleanup

sed -i '$d' /etc/sudoers
cd /
usermod -d / nobody
rm -rf /home/aurBuilder

# ------------------------ user ------------------------

declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

user_commands=(
  'xdg-user-dirs-update'
  'mkdir -p ~/Projects'
  'git config --global user.name "clemak27"'
  'git config --global user.email clemak27@mailbox.org'
  'git config --global alias.lol "log --graph --decorate --oneline --all"'
  'git config --global core.autocrlf input'
  'git config --global pull.rebase false'
  'git config --global credential.helper cache --timeout=86400'
# 'systemctl --user enable ssh-agent.service'
)

declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ modules ------------------------

for module in "${system_modules[@]}"
do
  echo "Setting up module $module"
  chmod +x "./modules/$module.zsh"
  /bin/zsh -i -c  "./modules/$module.zsh"
done
