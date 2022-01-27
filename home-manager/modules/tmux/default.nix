{ config, lib, pkgs, ... }:
let
  cfg = config.homecfg.tmux;
  colors = config.homecfg.colors;
in
{
  options.homecfg.tmux.enable = lib.mkEnableOption "Manage tmux with home-manager";

  config = lib.mkIf (cfg.enable) {

    programs.tmux = {
      enable = true;
      sensibleOnTop = false;
      baseIndex = 1;
      escapeTime = 0;
      historyLimit = 15000;
      terminal = "xterm-256color";
      prefix = "C-y";
      plugins = with pkgs; [
        tmuxPlugins.resurrect
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '15' # minutes
          '';
        }
      ];
      extraConfig = ''
        set-window-option -g xterm-keys on
        setw -g mode-keys vi

        bind-key y send-prefix

        set-option -sa terminal-overrides ",xterm*:Tc"
        set-option -g -w automatic-rename on
        set-option -g renumber-windows on
        set-option -g bell-action none

        bind-key o split-window -v -c "#{pane_current_path}"
        bind-key O split-window -h -c "#{pane_current_path}"
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        bind -n M-, swap-pane -U
        bind -n M-. swap-pane -D
        bind -n M-h previous-window
        bind -n M-l next-window

        # Enter copy mode
        bind-key -n M-v copy-mode

        # Select
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi V send-keys -X select-line
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle

        # Copy
        bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel ${if pkgs.stdenv.isLinux then "\"xclip -i -sel clip > /dev/null\"" else "\"pbcopy\""}
        bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel ${if pkgs.stdenv.isLinux then "\"xclip -in -selection clipboard\"" else "\"pbcopy\""}

        # Cancel
        bind-key -T copy-mode-vi Escape send-keys -X cancel

        # Paste
        bind-key p paste-buffer -s ""
        bind-key P choose-buffer "paste-buffer -b '%%' -s '''"

        # enable mouse
        set -g mouse on

        # Make mouse drag end behavior configurable
        unbind-key -T copy-mode-vi MouseDragEnd1Pane
        bind-key -T copy-mode-vi WheelUpPane select-pane \; send-keys -t '{mouse}' -X clear-selection \; send-keys -t '{mouse}' -X -N 3 scroll-up
        bind-key -T copy-mode-vi WheelDownPane select-pane \; send-keys -t '{mouse}' -X clear-selection \; send-keys -t '{mouse}' -X -N 3 scroll-down

        # Jump search mode with prefix
        bind-key '/' copy-mode \; send-keys "/"
        bind-key '?' copy-mode \; send-keys "?"

        # theme
        set -g mode-style "fg=${colors.fg},bg=${colors.bg-light}"

        set -g message-style "fg=${colors.fg},bg=${colors.bg-darker}"
        set -g message-command-style "fg=${colors.fg},bg=${colors.bg-darker}"

        set -g pane-border-style "fg=${colors.bg-light}"
        set -g pane-active-border-style "fg=${colors.bg-light}"

        set -g status on
        set -g status-interval 5
        set -g status-position top
        set -g status-justify "left"

        set -g status-style "fg=${colors.ansi.color4},bg=default"

        set -g status-left-length "100"
        set -g status-right-length "100"

        set -g status-left-style NONE
        set -g status-right-style NONE

        set -g status-left "#[fg=${colors.bg},bg=${colors.ansi.color4},bold] #S "
        set -g status-right ""

        setw -g window-status-activity-style "underscore,fg=${colors.fg},bg=${colors.bg}"
        setw -g window-status-separator "|"
        setw -g window-status-style "NONE,fg=${colors.fg},bg=${colors.bg-darker}"
        setw -g window-status-format " #I: #W#F "
        setw -g window-status-current-format "#[fg=${colors.bg},bg=${colors.fg},bold] #I: #W#F "
      '';
    };


    programs.zsh.shellAliases = builtins.listToAttrs (
      [
        { name = "trwp"; value = "tmux rename-window '#{b:pane_current_path}'"; }
      ]
    );
  };
}
