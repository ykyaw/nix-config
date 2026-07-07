{ inputs, ... }: {
  enableDataDisk = true;

  flake.modules.nixos.zanarkand = { modulesPath, ... }: {
    imports =
      with inputs.nixos-hardware.nixosModules;
      [
        common-pc
        common-pc-ssd
        common-cpu-amd
        common-cpu-amd-pstate
        common-gpu-amd
      ]
      ++ [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot = {
      initrd = {
        availableKernelModules = [
          "nvme"
          "thunderbolt"
          "xhci_pci"
          "ahci"
          "usbhid"
          "usb_storage"
          "uas"
          "sd_mod"
        ];
        kernelModules = [ ];
        luks.devices = {
          root.device = "/dev/disk/by-label/CRYPTROOT";
          data.device = "/dev/disk/by-label/CRYPTDATA";
        };
      };
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    fileSystems = {
      "/" = {
        device = "none";
        fsType = "tmpfs";
        options = [ "mode=0755" ];
      };
      "/boot" = {
        device = "/dev/disk/by-label/BOOT";
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
      "/mnt/data" = {
        device = "/dev/disk/by-label/DATA";
        fsType = "btrfs";
        options = [
          "subvol=data"
          "noatime"
          "compress=zstd"
          "nofail"
        ];
      };
    };

    swapDevices = [ ];

    zramSwap.enable = true;
  };
}
