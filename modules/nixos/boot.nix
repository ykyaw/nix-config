{ inputs, lib, ... }: {
  flake.modules.nixos.boot = {
    imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

    boot = {
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
        autoGenerateKeys.enable = true;
      };
      loader = {
        systemd-boot.enable = lib.mkForce false;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
