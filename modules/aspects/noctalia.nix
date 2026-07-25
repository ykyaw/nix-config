{ inputs, ... }: {
  flake.modules.homeManager.nixos-desktop = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      settings = {
        bar.default = {
          end = [
            "media"
            "tray"
            "notifications"
            "volume"
          ];
          margin_ends = 0;
          radius = 0;
          start = [ "taskbar" ];
        };
        control_center = {
          calendar.show_events_card = false;
          hidden_tabs = [
            "monitor"
            "power"
            "bluetooth"
            "screen-time"
          ];
          shortcuts = [
            { type = "wifi"; }
            { type = "bluetooth"; }
            { type = "caffeine"; }
            { type = "mic_mute"; }
            { type = "notification"; }
            { type = "power_profile"; }
          ];
          sidebar_section = "none";
        };
        desktop_widgets.enabled = false;
        dock = {
          enabled = true;
          launcher_position = "end";
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
          smart_auto_hide = true;
        };
        idle = {
          behavior_order = [
            "idle-behavior"
            "screen-off"
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
          clock.tooltip_format = "{:%a %b %d %H:%M%S}";
          media.hide_when_no_media = true;
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
