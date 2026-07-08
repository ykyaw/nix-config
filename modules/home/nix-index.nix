{ inputs, ... }: {
  flake.modules.homeManager.nix-index = {
    imports = [ inputs.nix-index-database.homeModules.default ];

    programs = {
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
    };
  };
}
