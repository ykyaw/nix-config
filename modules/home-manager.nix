{ lib, ... }: {
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  den.default = {
    nixos.home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };

    homeManager = {
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    };
  };
}
