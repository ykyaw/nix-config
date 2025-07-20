{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../modules/home/home.nix
  ];

  home.packages = with pkgs; [
    android-studio
    bruno
    sbctl
    teams-for-linux
    xdg-utils
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      assigns = {
        "1" = [ { class = "^Brave-browser$"; } ];
        "2" = [ { class = "^Code$"; } ];
        "3" = [
          { class = "^net.novade.novade_lite$"; }
          { app_id = "^DBeaver$"; }
          { class = "^bruno$"; }
        ];
        "4" = [
          { class = "^teams-for-linux$"; }
          { class = "^discord$"; }
        ];
        "5" = [ { class = "^Spotify$"; } ];
        "6" = [ { class = "^steam$"; } ];
      };
      defaultWorkspace = "workspace number 1";
      fonts = {
        names = [ "Fira Code" ];
        size = 11.0;
      };
      input = {
        "type:pointer".accel_profile = "flat";
        "type:keyboard" = {
          xkb_numlock = "on";
          xkb_options = "ctrl:nocaps";
        };
      };
      keybindings =
        let
          alt = "Mod1";
          super = "Mod4";
        in
        lib.mkOptionDefault {
          "${alt}+Space" = "exec ${pkgs.rofi-wayland}/bin/rofi -show drun";
          "${alt}+Tab" = "exec ${pkgs.rofi-wayland}/bin/rofi -show window";
          "${super}+Tab" = "workspace back_and_forth";
          "${super}+b" = "exec ${pkgs.brave}/bin/brave";
          "${super}+c" = "exec ${pkgs.vscode}/bin/code";
          "--locked XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "--locked XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "--locked XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
          "Print" = ''
            exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.wl-clipboard}/bin/wl-copy
          '';
        };
      menu = "${pkgs.rofi-wayland}/bin/rofi -show run";
      modifier = "Mod4";
      output.DP-2.resolution = "3440x1440@120Hz";
      terminal = "${pkgs.ghostty}/bin/ghostty";
      window.commands = [
        {
          command = "floating enable, sticky enable";
          criteria = {
            title = "^Picture in picture$";
          };
        }
        {
          command = "floating enable";
          criteria = {
            class = "^Emulator$";
            instance = "^qemu-system-x86_64$";
          };
        }
      ];
    };
  };

  programs = {
    bash = {
      enable = true;
      profileExtra = ''
        [ "$(tty)" = "/dev/tty1" ] && exec sway
      '';
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Fira Code 12";
      theme = "gruvbox-dark-hard";
      extraConfig = {
        show-icons = true;
        icon-theme = config.gtk.iconTheme.name;
      };
    };
    zoxide.enable = true;
  };

  services = {
    dunst.enable = true;
    swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
        }
      ];
    };
    udiskie.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };
}
