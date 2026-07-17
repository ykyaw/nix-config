{ den, ... }: {
  den.aspects.thatoe = {
    includes = [ den.batteries.primary-user ];

    provides.to-hosts.nixos = { config, ... }: {
      users = {
        mutableUsers = false;
        users.thatoe.hashedPasswordFile = config.sops.secrets.user-password.path;
      };

      security.sudo.configFile = ''
        Defaults insults
        Defaults lecture=never
      '';
    };
  };
}
