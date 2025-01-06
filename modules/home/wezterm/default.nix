{ pkgs, config, ... }:
let
  cdp = pkgs.writeShellApplication {
    name = "cdp";
    runtimeInputs = with pkgs; [
      fd
      fzf
      gnugrep
      neovim
      sd
      wezterm
    ];
    text = /*bash*/ ''
      path=$(fd --type=d --hidden --no-ignore ".git" --exclude node_modules --exclude tmp --absolute-path "$HOME/Projects" | grep ".git/" | sd "/.git/" "" | fzf)
      if [ "$path" != "" ]; then
        pname=$(basename "$path")

        if [[ -n $WEZTERM_PANE ]]; then
          new_pane=$(wezterm cli spawn --cwd "$path")
          wezterm cli set-tab-title "$pname" --pane-id "$new_pane"
          wezterm cli activate-pane --pane-id "$new_pane"
          printf "nvim\n" | wezterm cli send-text --pane-id "$new_pane" --no-paste
        else
          cd "$path" || exit 1
        fi
      fi
    '';
  };
in
{
  config = {
    homecfg.zellij.enable = false;

    programs.wezterm.enable = true;
    xdg.configFile = {
      "wezterm/bindings.lua".source = ./bindings.lua;
      "wezterm/wezterm.lua".source = ./wezterm.lua;
    };

    home.packages = [ cdp ];
  };
}
