{ inputs, modulesPath, ... }:

{
  imports =
    with inputs.nixos-hardware.nixosModules;
    [
      common-pc
      common-pc-laptop
      common-pc-ssd
      common-cpu-amd
      common-cpu-amd-pstate
      common-cpu-amd-zenpower
      common-gpu-amd
      asus-battery
    ]
    ++ [ (modulesPath + "/installer/scan/not-detected.nix") ];

  hardware.asus.battery = {
    chargeUpto = 80;
    enableChargeUptoScript = true;
  };

  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "thunderbolt"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "uas"
        "sd_mod"
      ];
      kernelModules = [ ];
      luks.devices.root.device = "/dev/disk/by-label/CRYPTROOT";
      systemd.enable = true;
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
    };
  };

  swapDevices = [ ];

  zramSwap.enable = true;
}
