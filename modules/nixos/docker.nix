{
  flake.modules.nixos.docker = { pkgs, ... }: {
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    environment.systemPackages = [ pkgs.lazydocker ];
  };
}
