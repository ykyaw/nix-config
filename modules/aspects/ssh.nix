{
  flake.modules.nixos.nixos-desktop = { config, lib, ... }: {
    services.openssh = {
      enable = true;
      hostKeys = [
        {
          path = "${
            lib.optionalString (config.environment.persistence ? "/persist") "/persist"
          }/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };
}
