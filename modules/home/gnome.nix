{
  dconf.settings = {
    "org/gnome/desktop/input-sources".xkb-options = [ "ctrl:nocaps" ];
    "org/gnome/desktop/interface" = {
      accent-color = "teal";
      clock-format = "12h";
      clock-show-weekday = true;
      color-scheme = "prefer-dark";
    };
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/screensaver".lock-enabled = false;
    "org/gnome/desktop/wm/preferences".resize-with-right-button = true;
    "org/gnome/GWeather4".temperature-unit = "centigrade";
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "hotedge@jonathan.jdoda.ca"
      ];
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "brave-browser.desktop"
        "com.mitchellh.ghostty.desktop"
        "code.desktop"
        "dbeaver.desktop"
        "bruno.desktop"
        "teams-for-linux.desktop"
        "discord.desktop"
        "spotify.desktop"
        "steam.desktop"
      ];
    };
    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/panel".blur = false;
    "org/gnome/shell/extensions/blur-my-shell/window-list".blur = false;
    "org/gnome/shell/extensions/caffeine" = {
      screen-blank = "always";
      show-notifications = false;
    };
    "org/gnome/system/location".enabled = true;
    "org/gtk/settings/file-chooser".clock-format = "12h";

    ## Keybindings
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
      switch-to-workspace-10 = [ "<Super>10" ];
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      move-to-workspace-5 = [ "<Super><Shift>5" ];
      move-to-workspace-6 = [ "<Super><Shift>6" ];
      move-to-workspace-7 = [ "<Super><Shift>7" ];
      move-to-workspace-8 = [ "<Super><Shift>8" ];
      move-to-workspace-9 = [ "<Super><Shift>9" ];
      move-to-workspace-10 = [ "<Super><Shift>10" ];
      switch-to-workspace-left = [
        "<Super>U"
        "<Super>Page_Up"
      ];
      switch-to-workspace-right = [
        "<Super>I"
        "<Super>Page_Down"
      ];
      move-to-workspace-left = [
        "<Super><Shift>U"
        "<Super><Shift>Page_Up"
      ];
      move-to-workspace-right = [
        "<Super><Shift>I"
        "<Super><Shift>Page_Down"
      ];
      close = [
        "<Super>Q"
        "<Alt>F4"
      ];
      toggle-maximized = [
        "<Super>F"
        "<Alt>F10"
      ];
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [
        "<Super><Shift>H"
        "<Super>Left"
      ];
      toggle-tiled-right = [
        "<Super><Shift>L"
        "<Super>Right"
      ];
    };
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ "<Super>E" ];
      switch-to-application-2 = [ "<Super>B" ];
      switch-to-application-3 = [ "<Super>Return" ];
      switch-to-application-4 = [ "<Super>C" ];
      switch-to-application-5 = [ "<Super>D" ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
      screensaver = [ "<Super><Control>Q" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "yazi";
      command = "ghostty -e yazi";
      binding = "<Super>Y";
    };
  };
}
