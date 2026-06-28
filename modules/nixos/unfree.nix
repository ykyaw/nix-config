{
  flake.modules.nixos.unfree = { config, lib, ... }: {
    options.allowedUnfreePackages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    config.nixpkgs.config.allowUnfreePredicate =
      let
        fromUsers = lib.concatMap (user: user.allowedUnfreePackages or [ ]) (
          lib.attrValues config.home-manager.users
        );
        allowed = config.allowedUnfreePackages ++ fromUsers;
      in
      pkg: builtins.elem (lib.getName pkg) allowed;
  };
}
