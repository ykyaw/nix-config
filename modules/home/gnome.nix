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
    "org/gnome/shell/keybindings" = {
      switch-to-application-1 = [ "<Super>E" ];
      switch-to-application-2 = [ "<Super>B" ];
      switch-to-application-3 = [ "<Super>Return" ];
      switch-to-application-4 = [ "<Super>C" ];
    };
    "org/gnome/system/location".enabled = true;
    "org/gtk/settings/file-chooser".clock-format = "12h";
  };
}
