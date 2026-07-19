{
  flake.modules.nixos.nixos-desktop = { pkgs, ... }: {
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    environment.systemPackages = [ pkgs.lazydocker ];
  };
}
