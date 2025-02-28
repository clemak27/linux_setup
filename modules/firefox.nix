{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en-GB"
      "de"
    ];
    nativeMessagingHosts.packages = with pkgs; [
      firefoxpwa
      tridactyl-native
    ];
    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisplayMenuBar = "default-off";
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;
      OfferToSaveLogins = false;
      ExtensionUpdate = true;
      ExtensionSettings = {
        # Bitwarden Password Manager
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4410896/bitwarden_password_manager-2024.12.4.xpi";
          installation_mode = "force_installed";
        };
        # Buster: Captcha Solver for Humans
        "{e58d3966-3d76-4cd9-8552-1582fbc800c1}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4297951/buster_captcha_solver-3.1.0.xpi";
          installation_mode = "force_installed";
        };
        # ClearURLs
        "{74145f27-f039-47ce-a470-a662b129930a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4432106/clearurls-1.27.3.xpi";
          installation_mode = "force_installed";
        };
        # Cookie AutoDelete
        "CookieAutoDelete@kennydo.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4040738/cookie_autodelete-3.8.2.xpi";
          installation_mode = "force_installed";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4433330/darkreader-4.9.101.xpi";
          installation_mode = "force_installed";
        };
        # Firefox Color
        "FirefoxColor@mozilla.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/3643624/firefox_color-2.1.7.xpi";
          installation_mode = "force_installed";
        };
        # Firefox Multi-Account Containers
        "@testpilot-containers" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4355970/multi_account_containers-8.2.0.xpi";
          installation_mode = "force_installed";
        };
        # LibRedirect
        "7esoorv3@alefvanoon.anonaddy.me" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4429228/libredirect-3.1.0.xpi";
          installation_mode = "force_installed";
        };
        # LocalCDN
        "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4418677/localcdn_fork_of_decentraleyes-2.6.77.xpi";
          installation_mode = "force_installed";
        };
        # Old Reddit Redirect
        "{9063c2e9-e07c-4c2c-9646-cfe7ca8d0498}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4342347/old_reddit_redirect-1.8.2.xpi";
          installation_mode = "force_installed";
        };
        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4427769/privacy_badger17-2025.1.29.xpi";
          installation_mode = "force_installed";
        };
        # Progressive Web Apps for Firefox
        "firefoxpwa@filips.si" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4437768/pwas_for_firefox-2.14.1.xpi";
          installation_mode = "force_installed";
        };
        # Reddit Enhancement Suite
        "jid1-xUfzOsOFlzSOXg@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4424459/reddit_enhancement_suite-5.24.8.xpi";
          installation_mode = "force_installed";
        };
        # SponsorBlock for YouTube - Skip Sponsorships
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4424639/sponsorblock-5.11.5.xpi";
          installation_mode = "force_installed";
        };
        # Tridactyl
        "tridactyl.vim@cmcaine.co.uk" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4405615/tridactyl_vim-1.24.2.xpi";
          installation_mode = "force_installed";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4412673/ublock_origin-1.62.0.xpi";
          installation_mode = "force_installed";
        };
        # User-Agent Switcher and Manager
        "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4098688/user_agent_string_switcher-0.5.0.xpi";
          installation_mode = "force_installed";
        };
      };
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      Preferences = {
        "browser.compactmode.show" = true;
      };
      PromptForDownloadLocation = false;
      ShowHomeButton = false;
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        Locked = true;
        MoreFromMozilla = false;
        SkipOnboarding = true;
        UrlbarInterventions = true;
        WhatsNew = true;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    firefoxpwa
  ];
}
