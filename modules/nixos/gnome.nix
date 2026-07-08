{ config, ... }: {
  flake.modules.nixos.gnome = {
    services = {
      displayManager = {
        autoLogin = {
          enable = true;
          user = config.username;
        };
        gdm.enable = true;
      };
      desktopManager.gnome.enable = true;
    };

    programs.dconf.enable = true;
  };
}
