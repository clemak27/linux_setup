#!/bin/bash

set -eo pipefail

mkdir -p /tmp/plasma_ext
cd /tmp/plasma_ext || :

# renovate: datasource=github-tags depName=luisbocanegra/plasma-panel-colorizer versioning=loose
panel_colorizer_version=5.0.0
panel_colorizer_plasmoid=plasmoid-panel-colorizer-v$panel_colorizer_version.plasmoid
panel_colorizer_current=$(cat "$HOME/.local/share/plasma/plasmoids/luisbocanegra.panel.colorizer/metadata.json" | jq -r '.KPlugin.Version' || echo "0.0.0")

if [ "$panel_colorizer_current" != "$panel_colorizer_version" ]; then
  curl -fLO https://github.com/luisbocanegra/plasma-panel-colorizer/releases/download/v$panel_colorizer_version/$panel_colorizer_plasmoid
  kpackagetool6 --type Plasma/Applet -i $panel_colorizer_plasmoid || kpackagetool6 --type Plasma/Applet -u $panel_colorizer_plasmoid
fi

# renovate: datasource=github-tags depName=luisbocanegra/plasma-panel-spacer-extended versioning=loose
panelspacer_extended_version=1.11.1
panelspacer_extended_plasmoid=plasmoid-spacer-extended-v$panelspacer_extended_version.plasmoid
panelspacer_extended_current=$(cat "$HOME/.local/share/plasma/plasmoids/luisbocanegra.panelspacer.extended/metadata.json" | jq -r '.KPlugin.Version' || echo "0.0.0")

if [ "$panelspacer_extended_version" != "$panelspacer_extended_current" ]; then
  curl -fLO https://github.com/luisbocanegra/plasma-panel-spacer-extended/releases/download/v$panelspacer_extended_version/$panelspacer_extended_plasmoid
  kpackagetool6 --type Plasma/Applet -i $panelspacer_extended_plasmoid || kpackagetool6 --type Plasma/Applet -u $panelspacer_extended_plasmoid
fi

# renovate: datasource=github-tags depName=dhruv8sh/kara versioning=loose
kara_version=0.7.3
kara_current=$(cat "$HOME/.local/share/plasma/plasmoids/org.dhruv8sh.kara/metadata.json" | jq -r '.KPlugin.Version' || echo "0.0.0")

if [ "$kara_version" != "$kara_current" ]; then
  curl -fLO https://github.com/dhruv8sh/kara/archive/refs/tags/v$kara_version.tar.gz

  rm -rf "$HOME/.local/share/plasma/plasmoids/org.dhruv8sh.kara"
  tar xzf v$kara_version.tar.gz
  mkdir -p "$HOME/.local/share/plasma/plasmoids"
  mv kara-$kara_version "$HOME/.local/share/plasma/plasmoids/org.dhruv8sh.kara"
fi

# renovate: datasource=github-tags depName=anametologin/krohnkite versioning=loose
krohnkite_version=0.9.9.2
krohnkite_current=$(cat "$HOME/.local/share/kwin/scripts/krohnkite/metadata.json" | jq -r '.KPlugin.Version' || echo "0.0.0")

if [ "$krohnkite_version" != "$krohnkite_current" ]; then
  curl -fLO https://github.com/anametologin/krohnkite/releases/download/$krohnkite_version/krohnkite.kwinscript
  kpackagetool6 --type KWin/Script -i krohnkite.kwinscript || kpackagetool6 --type KWin/Script -u krohnkite.kwinscript
fi

# renovate: datasource=github-tags depName=peterfajdiga/kwin4_effect_geometry_change versioning=loose
geometry_version=1.5
geometry_tar=kwin4_effect_geometry_change_1_5.tar.gz
geometry_current=$(cat "$HOME/.local/share/kwin/effects/kwin4_effect_geometry_change/metadata.json" | jq -r '.KPlugin.Version' || echo "0.0.0")

if [ "$geometry_version" != "$geometry_current" ]; then
  curl -fLO https://github.com/peterfajdiga/kwin4_effect_geometry_change/releases/download/v$geometry_version/$geometry_tar
  tar xzf $geometry_tar
  mkdir -p "$HOME/.local/share/kwin/effects"
  mv kwin4_effect_geometry_change "$HOME/.local/share/kwin/effects/kwin4_effect_geometry_change"
fi

if [ ! -f "/etc/yum.repos.d/home_paul4us.repo" ]; then
  curl -fL -o home_paul4us.repo https://download.opensuse.org/repositories/home:paul4us/Fedora_42/home:paul4us.repo
  sudo mv home_paul4us.repo /etc/yum.repos.d
  sudo restorecon /etc/yum.repos.d/home_paul4us.repo
  rpm-ostree install --idempotent klassy
fi
