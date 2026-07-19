{ inputs, ... }: {
  flake.modules.homeManager.workstation = {
    imports = [ inputs.nix-index-database.homeModules.default ];

    programs = {
      nix-index.enable = true;
      nix-index-database.comma.enable = true;
    };
  };
}
