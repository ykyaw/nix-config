{ config, inputs, lib, pkgs, ... }:

{
  imports = with inputs.nixos-hardware.nixosModules; [
    common-pc
    common-pc-ssd
    common-cpu-amd
    common-gpu-nvidia-nonprime
  ];

  boot = {
    initrd.availableKernelModules = [ "nvme" "thunderbolt" "xhci_pci" "ahci" "usbhid" "usb_storage" "uas" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
  };

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "mode=755" ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "umask=0077" ];
    };
    "/data" = {
      device = "/dev/disk/by-label/DATA";
      fsType = "btrfs";
      options = [ "subvol=@data" "noatime" "compress=zstd:1" ];
    };
    "/home" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=@home" "noatime" "compress=zstd:1" ];
    };
    "/nix" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=@nix" "noatime" "compress=zstd:1" ];
    };
    "/persist" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [ "subvol=@persist" "noatime" "compress=zstd:1" ];
    };
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = lib.mkDefault true;
}
