{
  allowedUnfreePackages = [
    "steam"
    "steam-unwrapped"
    "xone-dongle-firmware"
  ];

  flake.modules.nixos.nixos-desktop = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    hardware.xone.enable = true;

    environment.systemPackages = [ pkgs.xclicker ];
  };
}
