{ den, ... }: {
  den.aspects.thatoe.includes = [ den.aspects.direnv ];

  den.aspects.direnv.homeManager = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
