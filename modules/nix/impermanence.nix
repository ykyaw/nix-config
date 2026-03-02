{ inputs, ... }:
{
  flake.modules.nixos.impermanence = {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections"
        "/var/lib/nixos"
        "/var/lib/sbctl"
        "/var/lib/systemd/coredump"
        "/var/lib/systemd/timers"
        "/var/log"
      ];
      files = [ "/etc/machine-id" ];
    };
  };
}
