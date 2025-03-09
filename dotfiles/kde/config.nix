{ pkgs, osConfig, ... }:
let
  # move gtk.css to host config when it exists
  accents = {
    "maxwell" = "#365282";
    "newton" = "#029677";
  };
  lookupAccent = attrs: key: if attrs ? "${key}" then attrs."${key}" else "#760088";
  theme = ''
    @define-color accent_bg_color ${lookupAccent accents osConfig.networking.hostName};
  '';
in
{
  config = {
    home.packages = with pkgs; [
      feishin
      mpv
      scrcpy
    ];

    programs.plasma = {
      enable = true;
      window-rules = [
        {
          description = "Firefox PiP";
          match = {
            window-class = {
              value = "firefox";
              type = "substring";
            };
            title = "Picture-in-Picture";
            window-types = [ "normal" ];
          };
          apply = {
            above = true;
            aboverule = 2;
            desktops = "\\0";
            desktopsrule = 2;
            skippager = true;
            skippagerrule = 2;
            skipswitcher = true;
            skipswitcherrule = 2;
            skiptaskbar = true;
            skiptaskbarrule = 2;
          };
        }
      ];
    };
  };
}
