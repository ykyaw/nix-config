{
  flake.modules.nixos.workstation = { config, pkgs, ... }: {
    programs.niri.enable = true;

    services = {
      gnome.gnome-keyring.enable = true;
      greetd = {
        enable = true;
        settings =
          let
            niriCommand = "${config.programs.niri.package}/bin/niri-session";
          in
          {
            initial_session = {
              command = niriCommand;
              user = "thatoe";
            };
            default_session = {
              command = "${pkgs.greetd}/bin/agreety --cmd ${niriCommand}";
              user = "greeter";
            };
          };
      };
      gvfs.enable = true;
    };

    security.pam.services.login.rules.session.fdeBootPassword = {
      order = config.security.pam.services.login.rules.session.gnome_keyring.order - 10;
      control = "optional";
      modulePath = "${pkgs.pam_fde_boot_pw}/lib/security/pam_fde_boot_pw.so";
      settings.inject_for = "gkr";
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  flake.modules.homeManager.workstation = { lib, pkgs, ... }: {
    wayland.windowManager.niri = {
      enable = true;
      systemd.enable = false;
      portalPackage = null;
      xwaylandSatellitePackage = null;

      settings = {
        input = {
          keyboard.numlock = { };
          mouse.accel-profile = "flat";
        };

        binds =
          let
            workspaceBinds = lib.foldl' (
              acc: n:
              acc
              // {
                "Mod+${toString n}".focus-workspace = n;
                "Mod+Ctrl+${toString n}".move-column-to-workspace = n;
              }
            ) { } (lib.range 1 9);
          in
          workspaceBinds
          // {
            "Mod+Shift+Slash".show-hotkey-overlay = { };

            "Mod+Return" = {
              _props.hotkey-overlay-title = "Open a Terminal: kitty";
              spawn = [ "kitty" ];
            };
            "Alt+Space" = {
              _props.hotkey-overlay-title = "Run an Application: noctalia";
              spawn-sh = [ "noctalia msg panel-toggle launcher" ];
            };
            "Ctrl+Alt+Q" = {
              _props.hotkey-overlay-title = "Lock the Screen: noctalia";
              spawn-sh = [ "noctalia msg session lock" ];
            };

            "XF86AudioRaiseVolume" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0" ];
            };
            "XF86AudioLowerVolume" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-" ];
            };
            "XF86AudioMute" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ];
            };
            "XF86AudioMicMute" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle" ];
            };

            "XF86AudioPlay" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "playerctl play-pause" ];
            };
            "XF86AudioPause" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "playerctl play-pause" ];
            };
            "XF86AudioStop" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "playerctl stop" ];
            };
            "XF86AudioPrev" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "playerctl previous" ];
            };
            "XF86AudioNext" = {
              _props.allow-when-locked = true;
              spawn-sh = [ "playerctl next" ];
            };

            "Mod+O" = {
              _props.repeat = false;
              toggle-overview = { };
            };

            "Mod+Q" = {
              _props.repeat = false;
              close-window = { };
            };

            "Mod+H".focus-column-left = { };
            "Mod+J".focus-window-down = { };
            "Mod+K".focus-window-up = { };
            "Mod+L".focus-column-right = { };

            "Mod+Left".move-column-left = { };
            "Mod+Down".move-window-down = { };
            "Mod+Up".move-window-up = { };
            "Mod+Right".move-column-right = { };

            "Mod+Ctrl+H".move-column-left = { };
            "Mod+Ctrl+J".move-window-down = { };
            "Mod+Ctrl+K".move-window-up = { };
            "Mod+Ctrl+L".move-column-right = { };

            "Mod+Home".focus-column-first = { };
            "Mod+End".focus-column-last = { };
            "Mod+Ctrl+Home".move-column-to-first = { };
            "Mod+Ctrl+End".move-column-to-last = { };

            "Mod+Shift+H".focus-monitor-left = { };
            "Mod+Shift+J".focus-monitor-down = { };
            "Mod+Shift+K".focus-monitor-up = { };
            "Mod+Shift+L".focus-monitor-right = { };

            "Mod+Shift+Left".move-column-to-monitor-left = { };
            "Mod+Shift+Down".move-column-to-monitor-down = { };
            "Mod+Shift+Up".move-column-to-monitor-up = { };
            "Mod+Shift+Right".move-column-to-monitor-right = { };

            "Mod+Shift+Ctrl+H".move-column-to-monitor-left = { };
            "Mod+Shift+Ctrl+J".move-column-to-monitor-down = { };
            "Mod+Shift+Ctrl+K".move-column-to-monitor-up = { };
            "Mod+Shift+Ctrl+L".move-column-to-monitor-right = { };

            "Mod+Page_Down".focus-workspace-down = { };
            "Mod+Page_Up".focus-workspace-up = { };
            "Mod+U".focus-workspace-down = { };
            "Mod+I".focus-workspace-up = { };
            "Mod+Ctrl+Page_Down".move-column-to-workspace-down = { };
            "Mod+Ctrl+Page_Up".move-column-to-workspace-up = { };
            "Mod+Ctrl+U".move-column-to-workspace-down = { };
            "Mod+Ctrl+I".move-column-to-workspace-up = { };

            "Mod+Shift+Page_Down".move-workspace-down = { };
            "Mod+Shift+Page_Up".move-workspace-up = { };
            "Mod+Shift+U".move-workspace-down = { };
            "Mod+Shift+I".move-workspace-up = { };

            "Mod+WheelScrollDown" = {
              _props.cooldown-ms = 150;
              focus-workspace-down = { };
            };
            "Mod+WheelScrollUp" = {
              _props.cooldown-ms = 150;
              focus-workspace-up = { };
            };
            "Mod+Ctrl+WheelScrollDown" = {
              _props.cooldown-ms = 150;
              move-column-to-workspace-down = { };
            };
            "Mod+Ctrl+WheelScrollUp" = {
              _props.cooldown-ms = 150;
              move-column-to-workspace-up = { };
            };

            "Mod+WheelScrollRight".focus-column-right = { };
            "Mod+WheelScrollLeft".focus-column-left = { };
            "Mod+Ctrl+WheelScrollRight".move-column-right = { };
            "Mod+Ctrl+WheelScrollLeft".move-column-left = { };

            "Mod+Shift+WheelScrollDown".focus-column-right = { };
            "Mod+Shift+WheelScrollUp".focus-column-left = { };
            "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = { };
            "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = { };

            "Mod+Tab".focus-workspace-previous = { };

            "Mod+BracketLeft".consume-or-expel-window-left = { };
            "Mod+BracketRight".consume-or-expel-window-right = { };

            "Mod+Comma".consume-window-into-column = { };
            "Mod+Period".expel-window-from-column = { };

            "Mod+R".switch-preset-column-width = { };
            "Mod+Shift+R".switch-preset-column-width-back = { };

            "Mod+Ctrl+Shift+R".switch-preset-window-height = { };
            "Mod+Ctrl+R".reset-window-height = { };

            "Mod+F".maximize-column = { };
            "Mod+Shift+F".fullscreen-window = { };

            "Mod+M".maximize-window-to-edges = { };

            "Mod+Ctrl+F".expand-column-to-available-width = { };

            "Mod+C".center-column = { };
            "Mod+Ctrl+C".center-visible-columns = { };

            "Mod+Minus".set-column-width = "-10%";
            "Mod+Equal".set-column-width = "+10%";

            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Equal".set-window-height = "+10%";

            "Mod+Ctrl+Space".toggle-window-floating = { };
            "Mod+Space".switch-focus-between-floating-and-tiling = { };

            "Mod+T".toggle-column-tabbed-display = { };

            "Print".screenshot = { };
            "Ctrl+Print".screenshot-screen = { };
            "Alt+Print".screenshot-window = { };

            "Mod+Escape".spawn-sh = [ "noctalia msg caffeine-toggle" ];

            "Mod+Shift+E".quit = { };
            "Ctrl+Alt+Delete".quit = { };

            "Mod+Shift+P".power-off-monitors = { };
          };

        layout = {
          gaps = 4;
          focus-ring.off = { };
          border = {
            width = 2;
            active-color = "#94e2d5";
            inactive-color = "#6c7086";
            urgent-color = "#f38ba8";
          };
          tab-indicator.place-within-column = { };
        };

        spawn-at-startup = [ "noctalia" ];

        prefer-no-csd = { };

        hotkey-overlay.skip-at-startup = { };

        window-rule = {
          match._props = {
            app-id = "firefox$";
            title = "^Picture-in-Picture$";
          };
          open-floating = true;
        };

        debug.honor-xdg-activation-with-invalid-serial = { };

        _children = [
          {
            output = {
              _args = [ "DP-1" ];
              mode = "3840x2160@120.000";
            };
          }
          {
            output = {
              _args = [ "DP-2" ];
              mode = "3840x2160@120.000";
              hot-corners.off = { };
            };
          }
        ];
      };
    };

    home.packages = with pkgs; [
      nautilus
      playerctl
      xwayland-satellite
    ];
  };
}
