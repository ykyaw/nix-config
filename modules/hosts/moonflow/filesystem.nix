{
  flake.modules.nixos.moonflow = {
    fileSystems = {
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = [ "mode=0755" ];
      };
      "/boot" = {
        device = "/dev/disk/by-label/EFI";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };
      "/home" = {
        device = "/dev/disk/by-label/ROOT";
        fsType = "btrfs";
        options = [
          "subvol=home"
          "noatime"
          "compress=zstd"
        ];
      };
      "/nix" = {
        device = "/dev/disk/by-label/ROOT";
        fsType = "btrfs";
        options = [
          "subvol=nix"
          "noatime"
          "compress=zstd"
        ];
      };
      "/persist" = {
        device = "/dev/disk/by-label/ROOT";
        fsType = "btrfs";
        options = [
          "subvol=persist"
          "noatime"
          "compress=zstd"
        ];
        neededForBoot = true;
      };
    };

    swapDevices = [ ];

    zramSwap.enable = true;
  };
}
