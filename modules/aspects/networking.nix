{
  flake.modules.nixos.nixos-desktop = {
    networking.networkmanager.enable = true;
  };
}
