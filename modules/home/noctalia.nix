{ inputs, ... }: {
  flake.modules.homeManager.noctalia = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      settings = {
        bar.default = {
          center = [ "active_window" ];
          end = [
            "media"
            "cpu"
            "temp"
            "ram"
            "tray"
            "privacy"
            "clipboard"
            "network"
            "volume"
            "notifications"
            "clock"
          ];
          margin_edge = 0;
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
            "monitor"
            "power"
            "bluetooth"
            "screen-time"
          ];
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
            "lock-and-suspend"
          ];
          behavior = {
            lock-and-suspend = {
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
        lockscreen.fingerprint = false;
        shell = {
          launcher.app_grid = true;
          panel.open_near_click_control_center = true;
        };
        theme = {
          builtin = "Catppuccin";
          mode = "dark";
        };
        widget = {
          clock.format = "{:%a %b %d  %H:%M}";
          cpu.display = "text";
          launcher.glyph = "snowflake";
          media.hide_when_no_media = true;
          network.show_label = false;
          notifications.hide_when_no_unread = true;
          privacy.hide_inactive = true;
          ram.display = "text";
          taskbar.group_by_workspace = true;
          temp.display = "text";
        };
      };
    };
  };
}
