{ inputs, ... }: {
  flake.modules.nixos.nixos-desktop = {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/timers"
        "/var/log"
      ];
      files = [ "/etc/machine-id" ];
    };
  };
}
