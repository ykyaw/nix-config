{
  flake.modules.homeManager.workstation = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
