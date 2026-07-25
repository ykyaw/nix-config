{ inputs, ... }: {
  flake.modules.homeManager.nixos-desktop = { pkgs, ... }: {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      settings = {
        bar.default = {
          end = [
            "media"
            "tray"
            "notifications"
            "network"
            "volume"
            "session"
          ];
          margin_ends = 0;
          radius = 0;
          start = [
            "launcher"
            "taskbar"
          ];
        };
        control_center = {
          calendar.show_events_card = false;
          hidden_tabs = [
            "power"
            "bluetooth"
            "screen-time"
          ];
          shortcuts = [
            { type = "wifi"; }
            { type = "bluetooth"; }
            { type = "audio"; }
            { type = "mic_mute"; }
            { type = "caffeine"; }
            { type = "notification"; }
          ];
          show_shortcut_labels = false;
          sidebar_section = "none";
        };
        desktop_widgets.enabled = false;
        dock = {
          auto_hide = true;
          enabled = true;
          magnification = false;
          pinned = [
            "kitty"
            "firefox"
            "codium"
            "dbeaver"
            "bruno"
            "teams-for-linux"
            "discord"
            "spotify"
            "steam"
          ];
          reserve_space = false;
        };
        idle = {
          behavior_order = [
            "screen-off"
            "idle-behavior"
          ];
          behavior = {
            idle-behavior = {
              action = "suspend";
              enabled = true;
              lock_before_suspend = false;
              timeout = 1800.0;
            };
            screen-off = {
              action = "screen_off";
              enabled = true;
              timeout = 600.0;
            };
          };
        };
        location.auto_locate = true;
        shell = {
          launcher = {
            app_grid = true;
            categories = false;
          };
          panel.open_near_click_control_center = true;
        };
        theme = {
          builtin = "Catppuccin";
          pure_black_dark = true;
          templates = {
            enable_builtin_templates = false;
            enable_community_templates = false;
          };
        };
        widget = {
          clock.tooltip_format = "{:%a %b %d %H:%M:%S}";
          launcher.custom_image = "${pkgs.nixos-icons}/share/icons/hicolor/32x32/apps/nix-snowflake.png";
          media.hide_when_no_media = true;
          network.show_label = false;
          notifications.hide_when_no_unread = true;
          taskbar = {
            group_by_workspace = true;
            hide_empty_workspaces = true;
          };
          volume.show_label = false;
        };
      };
    };
  };
}
