#!/bin/zsh

set -uo pipefail

cd /linux_setup

# ------------------------ core system setup ------------------------

# ------------------------ Load config ------------------------
echo "Loading config"
if [ -f ./config.zsh ]; then
    source ./config.zsh
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
localectl set-x11-keymap de

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

# networkmanager
pacman -S --quiet --noprogressbar --noconfirm networkmanager
systemctl enable NetworkManager

# colorful output
sed -i 's/#Color/Color/g' /etc/pacman.conf

# activate multilib
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# grant su permissions to wheel group
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

pacman -Syyu --quiet --noprogressbar --noconfirm

# zsh
pacman -S --quiet --noprogressbar --noconfirm zsh zsh-completions

# terminal
pacman -S --quiet --noprogressbar --noconfirm youtube-dl ripgrep fzf rsync parallel ranger unzip unrar htop arch-audit android-tools jq bat exa hyperfine tokei reflector sd bottom

# xD
pacman -S --quiet --noprogressbar --noconfirm cmatrix lolcat neofetch sl

# development
pacman -S --quiet --noprogressbar --noconfirm git make gcc neovim nodejs npm python-pynvim xclip

# ssh
pacman -S --quiet --noprogressbar --noconfirm openssh

# pacman hooks
mkdir -p /etc/pacman.d/hooks/
cp ./pacman-hooks/grub.hook /etc/pacman.d/hooks/grub.hook
cp ./pacman-hooks/cleanup.hook /etc/pacman.d/hooks/cleanup.hook
ln -s /usr/share/arch-audit/arch-audit.hook /etc/pacman.d/hooks/arch-audit.hook

# create dirs for user
mkdir -p /home/$user/Projects
mkdir -p /home/$user/Notes
cp -R . /home/$user/Projects/linux_setup

# nvim
mkdir -p /home/$user/.config/nvim
mkdir -p /home/$user/.local/share/nvim/site/autoload
curl -fLo /home/$user/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln -sf /home/$user/Projects/linux_setup/dotfiles/vimrc /home/$user/.config/nvim/init.vim
ln -sf /home/$user/Projects/linux_setup/dotfiles/coc-settings.json /home/$user/.config/nvim/coc-settings.json

# zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/$user/.oh-my-zsh
curl -fsSL https://starship.rs/install.sh | bash -s -- -y
ln -sf /home/$user/Projects/linux_setup/zsh/zshrc /home/$user/.zshrc
ln -sf /home/$user/Projects/linux_setup/zsh/starship.toml /home/$user/.starship.toml

# ranger config
mkdir /home/$user/.config/ranger
ln -sf /home/$user/Projects/linux_setup/ranger/ranger.rc /home/$user/.config/ranger/rc.conf
ln -sf /home/$user/Projects/linux_setup/ranger/ranger.commands /home/$user/.config/ranger/commands.py

# todo.sh config
mkdir /home/$user/.todo
mkdir /home/$user/.todo.actions.d
cd /home/$user/.todo.actions.d
git clone https://github.com/rebeccamorgan/due.git
chmod +x due/due
cd /linux_setup

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

# install packages

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'paru-bin'
  'cava'
  'tty-clock'
  'ddgr'
  'todotxt'
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
  'ln -sf ~/Projects/linux_setup/dotfiles/todo.cfg ~/.todo/config'
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
  /bin/zsh -e -c "./modules/$module.zsh"
done

# cleanup

sed -i '$d' /etc/sudoers
usermod -d / nobody
rm -rf /home/aurBuilder
chown -R $user:$user /home/$user
su - $user -c "cd ~/Projects/linux_setup && git restore ."
