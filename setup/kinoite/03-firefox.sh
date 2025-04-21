#!/bin/bash

set -xueo pipefail

# remove default
# https://github.com/fedora-silverblue/silverblue-docs/blob/master/modules/ROOT/pages/tips-and-tricks.adoc#hiding-the-default-browser-firefox
sudo mkdir -p /usr/local/share/applications/
sudo cp /usr/share/applications/org.mozilla.firefox.desktop /usr/local/share/applications/
sudo sed -i "2a\\NotShowIn=GNOME;KDE" /usr/local/share/applications/org.mozilla.firefox.desktop
sudo update-desktop-database /usr/local/share/applications/

# install flatpak
flatpak install -y flathub \
  org.freedesktop.Platform.ffmpeg-full//24.08 \
  org.mozilla.firefox
flatpak override --user --socket=wayland --env=MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
echo 'flatpak run org.mozilla.firefox "$@"' > "$HOME/.local/bin/firefox"
chmod +x "$HOME/.local/bin/firefox"
mkdir -p "$HOME/.local/share/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies"

cat << EOF > "$HOME/.local/share/flatpak/extension/org.mozilla.firefox.systemconfig/x86_64/stable/policies/policies.json"
{
  "policies": {
    "AppAutoUpdate": false,
    "BackgroundAppUpdate": false,
    "DisableAppUpdate": true,
    "DisableFirefoxAccounts": false,
    "DisableFirefoxStudies": true,
    "DisableFormHistory": true,
    "DisablePasswordReveal": true,
    "DisablePocket": true,
    "DisableProfileRefresh": true,
    "DisableSetDesktopBackground": true,
    "DisableTelemetry": true,
    "DisplayMenuBar": "default-off",
    "ExtensionUpdate": true,
    "FirefoxHome": {
      "Highlights": false,
      "Locked": true,
      "Pocket": false,
      "Search": true,
      "Snippets": false,
      "SponsoredPocket": false,
      "SponsoredTopSites": false,
      "TopSites": false
    },
    "FirefoxSuggest": {
      "ImproveSuggest": false,
      "Locked": true,
      "SponsoredSuggestions": false,
      "WebSuggestions": false
    },
    "OfferToSaveLogins": false,
    "Preferences": {
      "browser.compactmode.show": true,
      "browser.newtabpage.activity-stream.feeds.telemetry": false,
      "browser.newtabpage.activity-stream.telemetry": false,
      "browser.ping-centre.telemetry": false,
      "datareporting.healthreport.service.enabled": false,
      "datareporting.healthreport.uploadEnabled": false,
      "datareporting.policy.dataSubmissionEnabled": false,
      "datareporting.sessions.current.clean": true,
      "devtools.onboarding.telemetry.logged": false,
      "toolkit.telemetry.archive.enabled": false,
      "toolkit.telemetry.bhrPing.enabled": false,
      "toolkit.telemetry.enabled": false,
      "toolkit.telemetry.firstShutdownPing.enabled": false,
      "toolkit.telemetry.hybridContent.enabled": false,
      "toolkit.telemetry.newProfilePing.enabled": false,
      "toolkit.telemetry.prompted": 2,
      "toolkit.telemetry.rejected": true,
      "toolkit.telemetry.reportingpolicy.firstRun": false,
      "toolkit.telemetry.server": "",
      "toolkit.telemetry.shutdownPingSender.enabled": false,
      "toolkit.telemetry.unified": false,
      "toolkit.telemetry.unifiedIsOptIn": false,
      "toolkit.telemetry.updatePing.enabled": false
    },
    "PromptForDownloadLocation": false,
    "ShowHomeButton": false,
    "UserMessaging": {
      "ExtensionRecommendations": false,
      "FeatureRecommendations": false,
      "Locked": true,
      "MoreFromMozilla": false,
      "SkipOnboarding": true,
      "UrlbarInterventions": true,
      "WhatsNew": true
    }
  }
}
EOF
