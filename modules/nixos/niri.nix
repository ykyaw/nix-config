{
  flake.modules.nixos.niri = { pkgs, ... }: {
    programs = {
      dconf.enable = true;
      niri.enable = true;
    };

    environment.systemPackages = [ pkgs.xwayland-satellite ];
  };
}
