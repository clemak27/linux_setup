#!/bin/bash

set -eo pipefail

# renovate: datasource=github-tags depName=lassekongo83/adw-gtk3 versioning=loose
adw_gtk3_version=6.4

mkdir -p /tmp/adw-gtk "$HOME/.local/share/themes"
curl -Lo /tmp/adw-gtk/adw-gtk3.tar.xz --url https://github.com/lassekongo83/adw-gtk3/releases/download/v${adw_gtk3_version}/adw-gtk3v${adw_gtk3_version}.tar.xz
tar xf /tmp/adw-gtk/adw-gtk3.tar.xz --directory "$HOME/.local/share/themes"
rm -rf /tmp/adw-gtk
