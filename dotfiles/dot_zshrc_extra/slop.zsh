# I hear its amazing when the famous purple stuffed worm in flap-jaw space with the tuning fork does a raw blink on Hari Kiri Rock.
# I need scissors!
# 61!

ask-clanker() {
  omp_bin="/var/home/linuxbrew/.linuxbrew/bin/omp"

  bwrap_arguments=(
    # no zombies
    --die-with-parent

    # network required for dependencies
    --unshare-all
    --share-net

    # create environment
    --tmpfs /
    --tmpfs /run
    --tmpfs /sys
    --tmpfs /tmp
    --dev /dev
    --proc /proc
    --ro-bind /bin /bin
    --ro-bind /sbin /sbin
    --ro-bind /usr /usr
    --ro-bind /lib /lib
    --ro-bind /lib64 /lib64

    # etc
    --tmpfs /etc
    --ro-bind /etc/NetworkManager /etc/NetworkManager
    --ro-bind /etc/default /etc/default
    --ro-bind /etc/fonts /etc/fonts
    --ro-bind /etc/host.conf /etc/host.conf
    --ro-bind /etc/hostname /etc/hostname
    --ro-bind /etc/hosts /etc/hosts
    --ro-bind /etc/ld.so.conf.d /etc/ld.so.conf.d
    --ro-bind /etc/nix /etc/nix
    --ro-bind /etc/profile.d /etc/profile.d
    --ro-bind /etc/resolv.conf /etc/resolv.conf
    --ro-bind /etc/ssl/certs /etc/ssl/certs

    # var
    # TODO --tmpfs /var
    --ro-bind /var /var
    --tmpfs /var/home

    # systemd-resolve for dns
    --ro-bind /run/systemd/resolve /run/systemd/resolve

    # binaries
    --ro-bind "$HOME/.local/bin" "$HOME/.local/bin"
    --ro-bind "/var/home/linuxbrew" "/var/home/linuxbrew"
    --ro-bind "/home/linuxbrew" "/home/linuxbrew"
    --bind "$HOME/.local/share/mise" "$HOME/.local/share/mise"
    --bind "$HOME/.nix-profile" "$HOME/.nix-profile"
    --bind /var/nix /nix

    # cache
    --bind "$HOME/.cache" "$HOME/.cache"

    # config
    --bind "$HOME/.config/bat" "$HOME/.config/bat"
    --bind "$HOME/.config/mise" "$HOME/.config/mise"
    --bind "$HOME/.config/rumdl" "$HOME/.config/rumdl"
    --bind "$HOME/.config/yamlfmt" "$HOME/.config/yamlfmt"
    --bind "$HOME/.omp" "$HOME/.omp"

    # git config
    --bind "$HOME/.omp/agent/git.ini" "$HOME/.config/git/config"

    # gradle
    --bind "$HOME/.gradle" "$HOME/.gradle"
    --bind "$HOME/.m2" "$HOME/.m2"

    # project dir
    --bind "$PWD" "$PWD"
    --chdir "$PWD"

    # llama.cpp
    --setenv LLAMA_CPP_BASE_URL "http://127.0.0.1:13370"
  )

  bwrap "${bwrap_arguments[@]}" "$omp_bin" "$@"
}
compdef ask-clanker=omp
