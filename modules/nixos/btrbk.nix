{
  services.btrbk.instances.btrbk.settings = {
    transaction_log = "/var/log/btrbk.log";

    snapshot_preserve_min = "2d";
    snapshot_preserve = "14d";

    target_preserve_min = "no";
    target_preserve = "14d 8w 6m";

    volume = {
      "/mnt/btr_root" = {
        snapshot_dir = ".snapshots";
        target = "/mnt/btr_data/.snapshots";
        subvolume = {
          home = { };
          persist = { };
        };
      };
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
    "/mnt/btr_data" = {
      device = "/dev/disk/by-label/DATA";
      fsType = "btrfs";
      options = [
        "subvolid=5"
        "noatime"
        "nofail"
      ];
    };
  };
}
