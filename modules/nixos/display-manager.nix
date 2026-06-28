{
  flake.modules.nixos.display-manager = {
    services.displayManager.ly = {
      enable = true;
      x11Support = false;
    };
  };
}
