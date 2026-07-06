{ config, lib, ... }: {
  flake.modules.nixos.unfree = {
    nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) config.allowedUnfreePackages;
  };
}
