{
  flake.modules.nixos.boot = {
    boot.loader = {
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
}
