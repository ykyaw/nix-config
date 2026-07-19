{
  flake.modules.nixos.nixos-desktop = { pkgs, ... }: {
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

    environment.persistence."/persist".directories = [ "/var/lib/sbctl" ];
  };
}
