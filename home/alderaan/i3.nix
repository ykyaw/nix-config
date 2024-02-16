{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      window = {
        titlebar = false;
        border = 3;
      };

      terminal = "kitty";

      startup = [
        {
          notification = false;
          command = "${pkgs.kwallet-pam}/libexec/pam_kwallet_init";
        }
        {
          notification = false;
          command = "xset s 60 60; xset s noblank; xsetroot -solid black";
        }
        {
          notification = false;
          command = "${pkgs.numlockx}/bin/numlockx";
        }
        {
          notification = false;
          command = "${pkgs.unclutter}/bin/unclutter";
        }
      ];

      modifier = "Mod4";
      keybindings =
        let
          Mod = config.xsession.windowManager.i3.config.modifier;
        in
        lib.mkOptionDefault {
          "${Mod}+b" = "exec firefox-devedition";
          "${Mod}+c" = "exec code";
          "${Mod}+e" = "exec dolphin";
          "${Mod}+space" = "exec rofi -show drun";
          "${Mod}+Tab" = "exec rofi -show window";
          "Print" = "exec ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

          "${Mod}+h" = "focus left";
          "${Mod}+j" = "focus down";
          "${Mod}+k" = "focus up";
          "${Mod}+l" = "focus right";

          "${Mod}+Left" = "focus left";
          "${Mod}+Down" = "focus down";
          "${Mod}+Up" = "focus up";
          "${Mod}+Right" = "focus right";

          "${Mod}+Shift+h" = "move left";
          "${Mod}+Shift+j" = "move down";
          "${Mod}+Shift+k" = "move up";
          "${Mod}+Shift+l" = "move right";

          "${Mod}+Shift+Left" = "move left";
          "${Mod}+Shift+Down" = "move down";
          "${Mod}+Shift+Up" = "move up";
          "${Mod}+Shift+Right" = "move right";
        };

      gaps = {
        inner = 10;
        smartBorders = "on";
      };

      fonts = { size = 10.0; };
      defaultWorkspace = "workspace number 1";

      bars = [
        {
          fonts = { size = 10.0; };
          hiddenState = "hide";
          mode = "hide";
          statusCommand = "${pkgs.i3status}/bin/i3status";
        }
      ];

      assigns = {
        "4" = [{ class = "^teams-for-linux$"; }];
        "5" = [{ class = "^Spotify$"; }];
        "6" = [{ class = "^Steam$"; }];
      };
    };
  };

  programs = {
    i3status.enable = true;
    rofi.enable = true;
  };
}
