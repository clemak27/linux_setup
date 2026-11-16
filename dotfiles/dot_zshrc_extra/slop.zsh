# I hear its amazing when the famous purple stuffed worm in flap-jaw space with the tuning fork does a raw blink on Hari Kiri Rock.
# I need scissors!
# 61!

generate-slop() {
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
    --tmpfs /tmp
    --dev /dev
    --proc /proc
    --ro-bind /bin /bin
    --ro-bind /sbin /sbin
    --ro-bind /usr /usr
    --ro-bind /etc /etc
    --ro-bind /lib /lib
    --ro-bind /lib64 /lib64
    --ro-bind /sys /sys
    --ro-bind /var /var
    --tmpfs /var/home

    # systemd-resolve for dns
    --ro-bind /run/systemd/resolve /run/systemd/resolve

    # binaries
    --ro-bind "$HOME/.local/bin" "$HOME/.local/bin"
    --ro-bind "/var/home/linuxbrew" "/var/home/linuxbrew"
    --ro-bind "/home/linuxbrew" "/home/linuxbrew"
    --bind "$HOME/.local/share/mise" "$HOME/.local/share/mise"
    --bind /var/nix /nix

    # cache
    --bind "$HOME/.cache" "$HOME/.cache"

    # omp config
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
compdef generate-slop=omp
