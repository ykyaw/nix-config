{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.firefox ];

  den.aspects.firefox.nixos = {
    programs.firefox.enable = true;
  };
}
