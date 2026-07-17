{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.audio ];

  den.aspects.audio.nixos = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
