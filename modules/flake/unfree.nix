{ config, lib, ... }: {
  # Keeping track of unfree packages to hopefully find free alternatives.
  options.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config.flake.modules.nixos.nixos-desktop = {
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) config.allowedUnfreePackages;
  };
}
