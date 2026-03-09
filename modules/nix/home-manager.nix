{ inputs, ... }:
let
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
in
{
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];
    inherit home-manager;
  };

  flake.modules.darwin.home-manager = {
    imports = [ inputs.home-manager.darwinModules.home-manager ];
    inherit home-manager;
  };

  flake.modules.homeManager.base = {
    programs.home-manager.enable = true;

    home.stateVersion = "25.11";
  };
}
