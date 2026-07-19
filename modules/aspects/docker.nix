{
  flake.modules.nixos.workstation = { pkgs, ... }: {
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };

    environment.systemPackages = [ pkgs.lazydocker ];
  };
}
