#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Load config
# https://stackoverflow.com/a/16349776
cd "${0%/*}"
if [ -f ../config.sh ]; then
    source ../config.sh
else
   echo "Config file could not be found!"
   exit 1
fi

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

# activate multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# grant su permissions to wheel group
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

pacman -Syyu --noconfirm

# terminal
pacman -S --noconfirm youtube-dl ripgrep fzf rsync parallel ranger unrar htop arch-audit

# zsh
pacman -S --noconfirm zsh zsh-completions

# xD
pacman -S --noconfirm cmatrix lolcat neofetch sl cloc

# development
pacman -S --noconfirm git make gcc neovim nodejs npm python-pynvim xclip

# ssh
pacman -S --noconfirm openssh

# pacman hooks
mkdir -p /etc/pacman.d/hooks/
cp ../pacman-hooks/grub.hook /etc/pacman.d/hooks/grub.hook
cp ../pacman-hooks/cleanup.hook /etc/pacman.d/hooks/cleanup.hook
ln -s /usr/share/arch-audit/arch-audit.hook /etc/pacman.d/hooks/arch-audit.hook

# add user and set groups
useradd -m $user
sudo usermod -aG wheel $user
sudo usermod --shell /usr/bin/zsh $user

localectl set-keymap de

# set password
echo "$user:$password" | chpasswd
echo "root:$password" | chpasswd

mkdir /home/${user}/dotfiles
cp -R ../dotfiles /home/${user}/dotfiles

mkdir /home/${user}/systemd-units
cp -R ../systemd-units /home/${user}/systemd-units

#------user------

cat << 'EOT' >> setup_user.sh
#!/bin/bash

xdg-user-dirs-update

# nvim config
mkdir -p ~/.config/nvim
cp dotfiles/vimrc ~/.config/nvim/init.vim

# plug-vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
cp dotfiles/p10k ~/.p10k.zsh
cp dotfiles/zshrc ~/.zshrc

# git config
git config --global user.name "clemak27"
git config --global user.email clemak27@mailbox.org
git config --global alias.lol 'log --graph --decorate --oneline --all'
git config --global core.autocrlf input
git config --global pull.rebase false
git config --global credential.helper cache --timeout=86400

mkdir -p ~/Projects

#yay
cd ~/Projects
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# aur
sudo pacman -S --noconfirm automake autoconf
yay -S --noconfirm cava tty-clock gotop-bin ddgr

# ssh
cd ~
cp systemd-units/ssh-agent.service ~/.config/systemd/user/ssh-agent.service
echo 'SSH_AUTH_SOCK DEFAULT="${XDG_RUNTIME_DIR}/ssh-agent.socket"' >> ~/.pam_environment
systemctl --user enable ssh-agent.service

EOT
