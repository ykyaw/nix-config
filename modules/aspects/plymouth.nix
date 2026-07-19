{
  flake.modules.nixos.workstation = {
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
