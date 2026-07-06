{ lib, ... }: {
  options.username = lib.mkOption { type = lib.types.str; };

  # Keeping track of unfree packages to hopefully find free alternatives.
  options.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };
}
