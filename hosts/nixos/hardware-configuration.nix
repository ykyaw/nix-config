{
  inputs,
  lib,
  modulesPath,
  ...
}:

{
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
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ ];
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
      device = "/dev/disk/by-label/ESP";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
    "/data" = {
      device = "/dev/disk/by-label/DAT";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/nix" = {
      device = "/dev/disk/by-label/NIX";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "noatime"
        "compress=zstd:1"
      ];
    };
    "/persist" = {
      device = "/dev/disk/by-label/NIX";
      fsType = "btrfs";
      options = [
        "subvol=persist"
        "noatime"
        "compress=zstd:1"
      ];
      neededForBoot = true;
    };
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
