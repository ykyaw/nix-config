{ inputs, ... }:
{
  flake.modules.nixos.moonflow =
    { modulesPath, ... }:
    {
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
            "thunderbolt"
            "xhci_pci"
            "ahci"
            "usb_storage"
            "usbhid"
            "sd_mod"
          ];
          kernelModules = [ ];
          luks.devices.root.device = "/dev/disk/by-label/CRYPTROOT";
          systemd.enable = true;
        };
        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
      };

      hardware.asus.battery.chargeUpto = 80;
    };
}
