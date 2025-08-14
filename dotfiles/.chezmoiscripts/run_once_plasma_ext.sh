#!/bin/bash

set -eo pipefail

mkdir -p /tmp/plasma_ext
cd /tmp/plasma_ext || :

if [ ! -d "$HOME/.local/share/plasma/plasmoids/luisbocanegra.panel.colorizer" ]; then
  panel_colorizer_version=4.3.2
  panel_colorizer_plasmoid=plasmoid-panel-colorizer-v$panel_colorizer_version.plasmoid

  curl -fLO https://github.com/luisbocanegra/plasma-panel-colorizer/releases/download/v$panel_colorizer_version/$panel_colorizer_plasmoid
  kpackagetool6 --type Plasma/Applet -i $panel_colorizer_plasmoid
fi

if [ ! -d "$HOME/.local/share/plasma/plasmoids/luisbocanegra.panelspacer.extended" ]; then
  panelspacer_extended_version=1.11.1
  panelspacer_extended_plasmoid=plasmoid-spacer-extended-v$panelspacer_extended_version.plasmoid

  curl -fLO https://github.com/luisbocanegra/plasma-panel-spacer-extended/releases/download/v$panelspacer_extended_version/$panelspacer_extended_plasmoid
  kpackagetool6 --type Plasma/Applet -i $panelspacer_extended_plasmoid
fi

if [ ! -d "$HOME/.local/share/plasma/plasmoids/org.dhruv8sh.kara" ]; then
  kara_version=0.7.3

  curl -fLO https://github.com/dhruv8sh/kara/archive/refs/tags/v$kara_version.tar.gz
  tar xzf v$kara_version.tar.gz
  mkdir -p "$HOME/.local/share/plasma/plasmoids"
  mv kara-$kara_version "$HOME/.local/share/plasma/plasmoids/org.dhruv8sh.kara"
fi

if [ ! -d "$HOME/.local/share/kwin/scripts/krohnkite" ]; then
  krohnkite_version=0.9.9.2

  curl -fLO https://github.com/anametologin/krohnkite/releases/download/$krohnkite_version/krohnkite.kwinscript
  kpackagetool6 --type KWin/Script -i krohnkite.kwinscript
fi

if [ ! -f "/etc/yum.repos.d/home_paul4us.repo" ]; then
  curl -fL -o home_paul4us.repo https://download.opensuse.org/repositories/home:paul4us/Fedora_42/home:paul4us.repo
  sudo cp home_paul4us.repo /etc/yum.repos.d
  sudo restorecon /etc/yum.repos.d/home_paul4us.repo
  rpm-ostree install --idempotent klassy
fi

if [ ! -d "$HOME/.local/share/kwin/effects/kwin4_effect_geometry_change" ]; then
  geometry_version=1.5
  geometry_tar=kwin4_effect_geometry_change_1_5.tar.gz

  curl -fLO https://github.com/peterfajdiga/kwin4_effect_geometry_change/releases/download/v$geometry_version/$geometry_tar
  tar xzf $geometry_tar
  mkdir -p "$HOME/.local/share/kwin/effects"
  mv kwin4_effect_geometry_change "$HOME/.local/share/kwin/effects/kwin4_effect_geometry_change"
fi
