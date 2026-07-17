{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.boot ];

  den.aspects.boot.nixos = { pkgs, ... }: {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        limine = {
          enable = true;
          secureBoot = {
            enable = true;
            autoGenerateKeys = true;
            autoEnrollKeys.enable = true;
          };
        };
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
