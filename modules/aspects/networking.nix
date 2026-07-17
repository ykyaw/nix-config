{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.networking ];

  den.aspects.networking.nixos = {
    networking.networkmanager.enable = true;
  };
}
