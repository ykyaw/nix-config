{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.gaming ];

  den.aspects.gaming = {
    includes = [
      (den.batteries.unfree [
        "steam"
        "steam-unwrapped"
        "xone-dongle-firmware"
      ])
    ];

    nixos = { pkgs, ... }: {
      programs.steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      hardware.xone.enable = true;

      environment.systemPackages = [ pkgs.xclicker ];
    };
  };
}
