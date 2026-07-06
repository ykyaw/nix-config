{ inputs, ... }: {
  flake.modules.nixos.impermanence = { config, ... }: {
    imports = [ inputs.impermanence.nixosModules.impermanence ];

    assertions = [
      {
        assertion = config.fileSystems ? "/persist" && config.fileSystems."/persist".neededForBoot;
        message = "impermanence persists state to /persist, so the host must mount /persist with neededForBoot = true.";
      }
    ];

    environment.persistence."/persist" = {
      hideMounts = true;
      directories = [
        {
          directory = "/etc/NetworkManager/system-connections";
          mode = "0700";
        }
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
