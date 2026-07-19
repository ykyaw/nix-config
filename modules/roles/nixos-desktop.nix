{
  flake.modules.nixos.nixos-desktop = {
    system.stateVersion = "26.05";
  };

  flake.modules.homeManager.nixos-desktop = { };
}
