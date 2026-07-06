{
  flake.modules.nixos.gnome = {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.dconf.enable = true;
  };
}
