{
  flake.modules.nixos.boot = { pkgs, ... }: {
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
