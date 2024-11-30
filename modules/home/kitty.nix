{ pkgs, ... }:
let
  cdp = pkgs.writeShellApplication {
    name = "cdp";
    runtimeInputs = with pkgs; [
      fd
      fzf
      gnugrep
      neovim
      sd
      zellij
    ];
    text = /*bash*/ ''
      path=$(fd --type=d --hidden --no-ignore ".git" --exclude node_modules --exclude tmp --absolute-path "$HOME/Projects" | grep ".git/" | sd "/.git/" "" | fzf)
      if [ "$path" != "" ]; then
        pname=$(basename "$path")

        if [[ -n $ZELLIJ_SESSION_NAME ]]; then
          zellij action new-tab --name="$pname" --cwd="$path" --layout custom
        else
          cd "$path" || exit 1
        fi
      fi
    '';
  };
in
{
  config = {
    homecfg = {
      zellij = {
        enable = true;
        zjstatusOptions = ''{
          format_left  "#[bg=#000000] {mode}#[bg=#000000] {tabs}"
          format_right ""
          format_space "#[bg=#000000]"
          mode_normal        "#[bg=#000000,fg=green,bold]NORMAL"
          mode_locked        "#[bg=#000000,fg=red,bold] LOCKED"
          mode_resize        "#[bg=#000000,fg=#fab387,bold] RESIZE"
          mode_pane          "#[bg=#000000,fg=#fab387,bold] PANE"
          mode_tab           "#[bg=#000000,fg=#fab387,bold] TAB"
          mode_scroll        "#[bg=#000000,fg=#fab387,bold] SCROLL"
          mode_rename_tab    "#[bg=#000000,fg=#fab387,bold] RENAME TAB"
          mode_rename_pane   "#[bg=#000000,fg=#fab387,bold] RENAME PANE"
          mode_session       "#[bg=#000000,fg=#fab387,bold] SESSION"
          mode_move          "#[bg=#000000,fg=#fab387,bold] MOVE"
          tab_normal   "#[fg=#9399B2,bg=#000000] {name} "
          tab_active   "#[fg=#cdd6f4,bg=#121212,bold] {name} "
        }'';
      };
    };

    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono Nerd Font";
      font.size = 10.0;
      shellIntegration.enableZshIntegration = false;
      theme = "Catppuccin-Mocha";
      settings = {
        enable_audio_bell = false;
        update_check_interval = 0;
        disable_ligatures = "always";
        cursor_trail = 5;
        cursor_blink_interval = 0;
      };
      extraConfig = ''
        background              #121212
        cursor_shape               block
        cursor_text_color       #121212
        initial_window_width       640
        initial_window_height      400
        remember_window_size       no
        resize_in_steps            yes
        wayland_titlebar_color     system
        confirm_os_window_close    0
      '';
    };

    programs.zsh = {
      initExtra = ''
        if [[ $TERM = "xterm-kitty" ]]; then
          if [[ -z $ZELLIJ_SESSION_NAME ]]; then
            if [[ $(zellij list-sessions | grep "main.*EXITED" > /dev/null) ]]; then
              zellij attach main
            elif [[ ! $(zellij list-sessions | grep "main" > /dev/null) ]]; then
              zellij --new-session-with-layout=custom --session=main
            fi
          fi
        fi
      '';
    };

    home.packages = [ cdp ];
  };
}
