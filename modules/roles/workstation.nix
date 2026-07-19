{
  flake.modules.nixos.workstation = {
    system.stateVersion = "26.05";
  };

  flake.modules.homeManager.workstation = {
    programs.home-manager.enable = true;
    home.stateVersion = "26.05";
  };
}
