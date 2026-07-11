{ inputs, ... }: {
  flake.modules.nixos.moonflow = { modulesPath, ... }: {
    imports =
      with inputs.nixos-hardware.nixosModules;
      [
        common-pc
        common-pc-laptop
        common-pc-ssd
        common-cpu-amd
        common-cpu-amd-pstate
        common-gpu-amd
        asus-battery
      ]
      ++ [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot = {
      initrd = {
        availableKernelModules = [
          "nvme"
          "xhci_pci"
          "thunderbolt"
          "usbhid"
          "usb_storage"
          "sd_mod"
          "sdhci_pci"
        ];
        kernelModules = [ ];
        luks.devices.root.device = "/dev/disk/by-label/CRYPTROOT";
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
    };

    swapDevices = [ ];

    zramSwap.enable = true;

    hardware = {
      asus.battery.chargeUpto = 80;
      sensor.iio.enable = true;
    };

    services.fwupd.enable = true;
  };
}
