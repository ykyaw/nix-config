{ den, ... }: {
  den.aspects = {
    nixos-desktop.includes = [ den.aspects.btrbk ];
    zanarkand.includes = [ den.aspects.btrbk-data ];
  };

  den.aspects.btrbk.nixos = {
    services.btrbk.instances.btrbk.settings = {
      snapshot_preserve_min = "2d";
      snapshot_preserve = "14d";

      target_preserve_min = "no";
      target_preserve = "14d 8w 6m";

      volume."/mnt/btr_root" = {
        snapshot_dir = ".snapshots";
        subvolume = {
          home = { };
          persist = { };
        };
      };
    };

    fileSystems."/mnt/btr_root" = {
      device = "/dev/disk/by-label/ROOT";
      fsType = "btrfs";
      options = [
        "subvolid=5"
        "noatime"
      ];
    };
  };

  den.aspects.btrbk-data.nixos = {
    services.btrbk.instances.btrbk.settings.volume = {
      "/mnt/btr_root".target = "/mnt/btr_data/.snapshots";
      "/mnt/btr_data" = {
        snapshot_dir = ".snapshots";
        subvolume.data = { };
      };
    };

    fileSystems."/mnt/btr_data" = {
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
