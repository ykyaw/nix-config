{ den, ... }: {
  den.aspects.nixos-desktop.includes = [ den.aspects.plymouth ];

  den.aspects.plymouth.nixos = {
    boot = {
      plymouth.enable = true;
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "udev.log_level=3"
      ];
    };
  };
}
