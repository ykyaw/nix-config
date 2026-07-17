{ den, inputs, ... }: {
  den.aspects.thatoe.includes = [ den.aspects.nix-index ];

  flake-file.inputs.nix-index-database = {
    url = "github:nix-community/nix-index-database";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.nix-index.homeManager = {
    imports = [ inputs.nix-index-database.homeModules.default ];

    programs = {
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
    };
  };
}
