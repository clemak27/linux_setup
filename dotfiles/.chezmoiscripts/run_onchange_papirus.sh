#!/bin/bash

set -eo pipefail

# renovate: datasource=github-tags depName=PapirusDevelopmentTeam/papirus-icon-theme versioning=loose
papirus_version=20250501

wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.local/share/icons" EXTRA_THEMES="Papirus-Dark" TAG=$papirus_version sh
