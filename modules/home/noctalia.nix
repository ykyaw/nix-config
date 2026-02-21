{
  constants,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = rec {
    enable = true;
    systemd.enable = true;
    settings = {
      bar = {
        position = "left";
        showCapsule = false;
        backgroundOpacity = 1;
        useSeparateOpacity = true;
        outerCorners = false;
        widgets = {
          left = [
            { id = "Launcher"; }
            {
              id = "SystemMonitor";
              diskPath = "/nix";
            }
            { id = "MediaMini"; }
          ];
          center = [ { id = "Workspace"; } ];
          right = [
            { id = "NotificationHistory"; }
            { id = "Volume"; }
            {
              id = "Clock";
              formatVertical = "dd MM - hh mm AP";
            }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };
      ui = {
        fontDefault = "Inter Display";
        fontFixed = constants.monospace;
      };
      locations = {
        name = "Singapore";
        use12hourFormat = true;
      };
      wallpaper = {
        overviewEnabled = true;
        skipStartupTransition = true;
      };
      appLauncher = {
        enableClipboardHistory = true;
        pinnedApps = [
          "org.gnome.Nautilus"
          "brave-browser"
          "com.mitchellh.ghostty"
          "code"
          "dbeaver"
          "bruno"
          "teams-for-linux"
          "discord"
          "spotify"
          "steam"
        ];
        terminalCommand = "ghostty -e";
        iconMode = "native";
      };
      controlCenter.diskPath = "/nix";
      dock = {
        size = 2;
        pinnedApps = settings.appLauncher.pinnedApps;
        pinnedStatic = true;
      };
      notifications.location = "bottom_left";
      osd.location = "bottom_left";
      colorSchemes.predefinedScheme = "Catppuccin Lavender";
    };
  };
}
