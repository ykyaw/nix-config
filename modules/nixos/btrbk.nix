{ config, lib, ... }: {
  flake.modules.nixos.btrbk = {
    services.btrbk.instances.btrbk.settings = {
      snapshot_preserve_min = "2d";
      snapshot_preserve = "14d";

      target_preserve_min = "no";
      target_preserve = "14d 8w 6m";

      volume = {
        "/mnt/btr_root" = {
          snapshot_dir = ".snapshots";
          subvolume = {
            home = { };
            persist = { };
          };
        }
        // lib.optionalAttrs config.enableDataDisk { target = "/mnt/btr_data/.snapshots"; };
      }
      // lib.optionalAttrs config.enableDataDisk {
        "/mnt/btr_data" = {
          snapshot_dir = ".snapshots";
          subvolume.data = { };
        };
      };
    };

    fileSystems = {
      "/mnt/btr_root" = {
        device = "/dev/disk/by-label/ROOT";
        fsType = "btrfs";
        options = [
          "subvolid=5"
          "noatime"
        ];
      };
      "/mnt/btr_data" = lib.mkIf config.enableDataDisk {
        device = "/dev/disk/by-label/DATA";
        fsType = "btrfs";
        options = [
          "subvolid=5"
          "noatime"
          "nofail"
        ];
      };
    };
  };
}
