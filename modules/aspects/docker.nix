{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.docker ];

  den.aspects.docker.nixos = { pkgs, ... }: {
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    environment.systemPackages = [ pkgs.lazydocker ];
  };
}
