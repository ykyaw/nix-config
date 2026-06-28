{ inputs, ... }: {
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
          "sd_mod"
        ];
        kernelModules = [ ];
        luks.devices.root.device = "/dev/disk/by-label/CRYPTROOT";
      };
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };
  };
}
