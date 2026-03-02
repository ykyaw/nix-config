{ inputs, ... }:
{
  flake.modules = {
    nixos.home-manager = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };

    homeManager.base = {
      programs.home-manager.enable = true;

      home.stateVersion = "25.11";
    };
  };
}
