{ den, ... }: {
  den.aspects.workstation.includes = [ den.aspects.nix ];

  den.aspects.nix = {
    includes = [
      ({ host, ... }: {
        ${host.class}.nix = {
          gc = {
            automatic = true;
            options = "--delete-older-than 30d";
          };
          optimise.automatic = true;
          settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      })
    ];

    nixos.programs.nix-ld.enable = true;
  };
}
