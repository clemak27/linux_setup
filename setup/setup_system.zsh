#!/bin/zsh

set -uo pipefail

cd /linux_setup

# ------------------------ core system setup ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./setup/config.zsh ]; then
    source ./setup/config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

# ------------------------ general config ------------------------

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

# ------------------------ pacman ------------------------

# base packages
pacman -S --quiet --noprogressbar --noconfirm b43-fwcutter broadcom-wl crda darkhttpd ddrescue dhclient dialog dnsutils elinks ethtool exfat-utils f2fs-tools fsarchiver hdparm ipw2100-fw ipw2200-fw irssi iwd lftp lsscsi mc mtools ndisc6 nfs-utils nilfs-utils nmap ntp openconnect openvpn partclone partimage pptpclient rp-pppoe sdparm sg3_utils tcpdump testdisk usb_modeswitch vpnc wireless-regdb wireless_tools wvdial xl2tpd man

# some important stuff
pacman -S --quiet --noprogressbar --noconfirm xorg-server fakeroot xdg-user-dirs sudo pkg-config wget ntfs-3g pacman-contrib
localectl --no-convert set-x11-keymap at pc101

# networkmanager
pacman -S --quiet --noprogressbar --noconfirm networkmanager
systemctl enable NetworkManager

# colorful output
sed -i 's/#Color/Color/g' /etc/pacman.conf

# activate multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# enable parallel downloads
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 5/g' /etc/pacman.conf

# grant su permissions to wheel group
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

pacman -Syyu --quiet --noprogressbar --noconfirm

# zsh
pacman -S --quiet --noprogressbar --noconfirm zsh zsh-completions

# terminal
pacman -S --quiet --noprogressbar --noconfirm youtube-dl ripgrep fzf rsync parallel ranger zip unzip unrar htop arch-audit android-tools jq exa hyperfine tokei reflector sd bat ncdu wireguard-tools fd bottom git-delta
cp ./other/rfv /home/$user/.local/bin

# development
pacman -S --quiet --noprogressbar --noconfirm git make gcc neovim nodejs-lts-fermium npm semver yarn python-pynvim xclip

# ssh
pacman -S --quiet --noprogressbar --noconfirm openssh

#ranger icons
git clone https://github.com/alexanderjeurissen/ranger_devicons /home/$user/.config/ranger/plugins/ranger_devicons

# pacman hooks
mkdir -p /etc/pacman.d/hooks/
cp ./other/grub.hook /etc/pacman.d/hooks/grub.hook
cp ./other/cleanup.hook /etc/pacman.d/hooks/cleanup.hook
cp ./other/tealdeer.hook /etc/pacman.d/hooks/tealdeer.hook
ln -s /usr/share/arch-audit/arch-audit.hook /etc/pacman.d/hooks/arch-audit.hook

# create dirs for user
mkdir -p /home/$user/Projects
mkdir -p /home/$user/Notes
cp -R . /home/$user/Projects/linux_setup

# zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/$user/.oh-my-zsh

cd /linux_setup

# ssh
mkdir -p /home/$user/.config/systemd/user
cp ./other/ssh-agent.service /home/$user/.config/systemd/user/ssh-agent.service
echo 'SSH_AUTH_SOCK DEFAULT="${XDG_RUNTIME_DIR}/ssh-agent.socket"' >> /home/$user/.pam_environment

# add user and set groups
useradd -M $user
chown -R $user:$user /home/$user
usermod -d /home/$user $user
usermod -aG wheel $user
usermod --shell /usr/bin/zsh $user

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

# install packages

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'starship-git'
  'paru-bin'
)

declare -r aur_packages
IFS=$SAVEIFS

for package in "${aur_packages[@]}"
do
  cd /home/aurBuilder
  git clone https://aur.archlinux.org/$package.git
  chmod -R g+w $package
  cd $package
  sudo -u nobody makepkg -sri --noconfirm
  cd /linux_setup
done

# ------------------------ user ------------------------

declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

user_commands=(
  'xdg-user-dirs-update'
  'git config --global user.name "clemak27"'
  'git config --global user.email clemak27@mailbox.org'
  'git config --global alias.lol "log --graph --decorate --oneline --all"'
  'git config --global core.autocrlf input'
  'git config --global pull.rebase false'
  'git config --global credential.helper cache --timeout=86400'
  'git config --global include.path "~/.delta.config"'
  'tldr --update'
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
  cd /linux_setup/setup
  chmod +x "./setup_module.sh"
  echo "Setting up module $module"
  /bin/zsh -e -c "./setup_module.sh $module"
done

# symlinks
sh  /home/$user/Projects/linux_setup/scripts/symlinks.zsh $user

# cleanup

sed -i '$d' /etc/sudoers
usermod -d / nobody
rm -rf /home/aurBuilder
chown -R $user:$user /home/$user
su - $user -c "cd ~/Projects/linux_setup && git restore ."
